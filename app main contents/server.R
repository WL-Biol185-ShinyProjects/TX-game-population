library(shiny)
library(leaflet)   # needed for renderLeaflet()

# Prepares the Four Flyways map data once and defines flyway_map(year)
source("the_four_flyways_heatmap_script.R")

# Prepares the harvest data once and defines species_base_map() and update_species_map()
source("species_population_per_state_over_time.R")

# Loads the quiz data and defines quiz_server()
source("duck_quiz_used_in_app.R")

# Loads the duck call data and defines duck_call_server()
source("duck_call_feature.R")

function(input, output, session) {
  
  # ===========================================================================
  # QUIZ TAB  (logic lives in Duck_quiz.R)
  # ===========================================================================
  quiz_server(input, output, session)
  
  # ===========================================================================
  # DUCK CALLS TAB  (logic lives in duck_call_feature.R)
  # ===========================================================================
  duck_call_server(input, output, session)
  
  # ===========================================================================
  # HOME TAB  (content comes from home_info.csv)
  # ===========================================================================
  
  # Re-reads home_info.csv automatically whenever the file changes (checks every second)
  home_info <- reactiveFileReader(1000, session, "home_info.csv", read.csv,
                                  stringsAsFactors = FALSE, na.strings = c("", "NA"),
                                  encoding = "UTF-8")
  
  output$home_content <- renderUI({
    d <- home_info()
    
    intro   <- d[d$type == "intro", ]
    flyways <- d[d$type == "flyway", ]
    facts   <- d[d$type == "fact", ]
    
    tagList(
      h3(intro$heading),
      p(intro$text),
      
      # Heatmap 1: The Four Flyways
      h4("The Four Flyways"),
      sliderInput("flyway_year", "Select a year", min = 2000, max = 2025,
                  value = 2020, step = 1, sep = "", width = "300px", animate = TRUE),
      leafletOutput("flyway_heatmap", height = 650),
      
      lapply(seq_len(nrow(flyways)),
             function(i) tagList(h4(flyways$heading[i]), p(flyways$text[i]))),
      
      hr(),
      h3(facts$heading[1]),
      tags$ul(lapply(facts$text, tags$li))
    )
  })
  
  # ===========================================================================
  # HEATMAPS
  # ===========================================================================
  
  # Heatmap on the Home tab: "The Four Flyways"
  output$flyway_heatmap <- renderLeaflet({
    flyway_map(input$flyway_year)
  })
  
  # Heatmap on its own tab: "Species Heatmap Over Time"
  # fill the Species and Season dropdowns on the Heatmap tab
  observe({
    updateSelectInput(session, "species_hm", choices = species_choices)
    updateSelectInput(session, "season_hm", choices = season_choices, selected = seasons[1])
  })
  
  # base map is drawn once...
  output$species_heatmap <- renderLeaflet(species_base_map())
  
  # ...and recolored whenever a dropdown changes
  observe({
    req(input$species_hm, input$season_hm)
    update_species_map("species_heatmap", input$species_hm, input$season_hm)
  })
  
  # ===========================================================================
  # FLYWAY TABS  (species content comes from species_info.csv)
  # ===========================================================================
  
  # Re-reads species_info.csv automatically whenever the file changes
  species_info <- reactiveFileReader(1000, session, "species_info.csv", read.csv,
                                     stringsAsFactors = FALSE, na.strings = c("", "NA"),
                                     encoding = "UTF-8")
  
  # Do the same set-up for each of the 4 flyways
  lapply(c("Pacific", "Central", "Mississippi", "Atlantic"), function(flyway) {
    k <- tolower(flyway)
    
    # species listed for this flyway
    flyway_rows <- reactive({
      d <- species_info()
      d[vapply(strsplit(d$flyways, ";\\s*"), function(f) flyway %in% f, logical(1)), ]
    })
    
    # fill this tab's dropdown
    observe(updateSelectInput(session, paste0("species_", k),
                              choices = c("Select a species" = "", sort(flyway_rows()$species))))
    
    # the one row for the species currently selected
    row <- reactive({
      req(input[[paste0("species_", k)]])
      d <- flyway_rows()
      d[d$species == input[[paste0("species_", k)]], ][1, ]
    })
    
    # title, facts
    output[[paste0("title_", k)]]    <- renderText(row()$species)
    output[[paste0("size_", k)]]     <- renderText(paste("Size:", row()$size))
    output[[paste0("wingspan_", k)]] <- renderText(paste("Wingspan:", row()$wingspan))
    output[[paste0("weight_", k)]]   <- renderText(paste("Weight:", row()$weight))
    output[[paste0("lifespan_", k)]] <- renderText(paste("Lifespan:", row()$lifespan))
    output[[paste0("diet_", k)]]     <- renderText(paste("Diet:", row()$diet))
    output[[paste0("habitat_", k)]]  <- renderText(paste("Habitat:", row()$habitat))
    output[[paste0("nesting_", k)]]  <- renderText(paste("Nesting season:", row()$nesting_season))
    output[[paste0("status_", k)]]   <- renderText(paste("Conservation status:", row()$conservation_status))
    
    # description: blank lines in the CSV cell become separate paragraphs
    output[[paste0("description_", k)]] <- renderUI(
      lapply(trimws(strsplit(row()$description, "\n\\s*\n")[[1]]), p))
    
    # images 1-3: one photo = single 400px img; two photos = Male / Female with captions
    lapply(1:3, function(i) {
      output[[paste0("image", i, "_", k)]] <- renderUI({
        r <- row(); f <- r[[paste0("image_", i)]]
        if (is.na(f)) NULL
        else if (i <= 2 && !is.na(r$image_2))
          tags$figure(img(src = f, width = "400px", height = "300px"),
                      tags$figcaption(c("Male", "Female")[i]))
        else img(src = f, width = "400px")
      })
    })
  })
}

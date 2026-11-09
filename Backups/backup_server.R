library(shiny)

function(input, output, session) {
  
  # Re-reads species_info.csv automatically whenever the file changes (checks every second)
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
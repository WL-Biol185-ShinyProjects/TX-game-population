# ============================================================================
# Migratory Waterfowl by State and Year
# Save as app.R, then click "Run App"
# ============================================================================

# ============================================================================
# Migratory Waterfowl by State and Year (2000-2026)
# Save as app.R, then click "Run App"
# ============================================================================

library(shiny)
library(leaflet)
library(sf)
library(dplyr)
library(htmltools)

# ---- Your data file ----------------------------------------------------------
default_file <- path.expand(
  "~/TX-game-population/app main contents/tidy_waterfowl_data.csv"
)

# ---- Data cleaning -----------------------------------------------------------
abb_lookup <- c(setNames(state.name, state.abb), "DC" = "District of Columbia")

clean_birds <- function(path) {
  first_line <- readLines(path, n = 1, warn = FALSE)
  has_header <- !grepl("^\\s*\"?[0-9]+\"?\\s*,", first_line)
  
  raw <- read.csv(path, header = has_header, stringsAsFactors = FALSE,
                  na.strings = c("NA", "N/A", ""))
  
  message("Columns found: ", paste(names(raw), collapse = ", "))
  
  # Pick columns by header name; fall back to position
  # (rowid, state, flyway, species, year, value)
  nm <- tolower(names(raw))
  state_idx   <- if (has_header) grep("state", nm)[1] else NA
  species_idx <- if (has_header) grep("species|common|bird", nm)[1] else NA
  year_idx    <- if (has_header) grep("year", nm)[1] else NA
  if (is.na(state_idx))   state_idx   <- 2
  if (is.na(species_idx)) species_idx <- 4
  if (is.na(year_idx))    year_idx    <- 5
  
  out <- data.frame(
    state_abb = raw[[state_idx]],
    species   = raw[[species_idx]],
    year      = suppressWarnings(as.integer(raw[[year_idx]])),
    stringsAsFactors = FALSE
  ) %>%
    mutate(
      state_abb = toupper(trimws(state_abb)),
      species   = trimws(species),
      state     = unname(abb_lookup[state_abb])
    ) %>%
    filter(!is.na(state), !is.na(species), species != "", !is.na(year)) %>%
    distinct(state, species, year)
  
  message("Clean records: ", nrow(out), " | States: ",
          length(unique(out$state)), " | Years: ",
          if (nrow(out) > 0) paste(range(out$year), collapse = "-") else "none")
  out
}

# Load at startup (NULL if the file isn't found; user can upload instead)
initial_birds <- if (file.exists(default_file)) {
  tryCatch(clean_birds(default_file), error = function(e) {
    message("Could not read default file: ", conditionMessage(e))
    NULL
  })
} else {
  message("Default file not found: ", default_file)
  NULL
}

# ---- Map data ----------------------------------------------------------------
states <- sf::read_sf("https://rstudio.github.io/leaflet/json/us-states.geojson")

atlantic <- c("Maine", "New Hampshire", "Vermont", "Massachusetts",
              "Rhode Island", "Connecticut", "New York", "New Jersey",
              "Pennsylvania", "Delaware", "Maryland", "Virginia",
              "West Virginia", "North Carolina", "South Carolina",
              "Georgia", "Florida", "District of Columbia")

mississippi <- c("Minnesota", "Wisconsin", "Michigan", "Iowa", "Illinois",
                 "Indiana", "Ohio", "Missouri", "Kentucky", "Tennessee",
                 "Arkansas", "Louisiana", "Mississippi", "Alabama")

central <- c("Montana", "Wyoming", "Colorado", "New Mexico",
             "North Dakota", "South Dakota", "Nebraska", "Kansas",
             "Oklahoma", "Texas")

pacific <- c("Washington", "Oregon", "California", "Idaho", "Nevada",
             "Utah", "Arizona", "Alaska")

flyway_colors <- c(
  "Atlantic"    = "#e41a1c",
  "Mississippi" = "#377eb8",
  "Central"     = "#4daf4a",
  "Pacific"     = "#ff7f00"
)

states <- states %>%
  mutate(
    flyway = case_when(
      name %in% atlantic    ~ "Atlantic",
      name %in% mississippi ~ "Mississippi",
      name %in% central     ~ "Central",
      name %in% pacific     ~ "Pacific",
      TRUE                  ~ NA_character_
    ),
    flyway = factor(flyway, levels = names(flyway_colors)),
    fill_col = ifelse(is.na(flyway), "#cccccc",
                      flyway_colors[as.character(flyway)])
  )

labels <- sprintf(
  "<strong>%s</strong><br/>%s Flyway",
  states$name,
  ifelse(is.na(states$flyway), "Unassigned", as.character(states$flyway))
) %>% lapply(htmltools::HTML)

# ---- UI ----------------------------------------------------------------------
ui <- fluidPage(
  titlePanel("Migratory Waterfowl by State and Year (2000\u20132026)"),
  sidebarLayout(
    sidebarPanel(
      width = 4,
      sliderInput("year", "1. Select a year",
                  min = 2000, max = 2026, value = 2020,
                  step = 1, sep = "", width = "100%",
                  animate = animationOptions(interval = 1500)),
      hr(),
      h4(textOutput("selected_title")),
      uiOutput("bird_list"),
      hr(),
      uiOutput("data_status"),
      fileInput("datafile", "Load a different CSV (optional)", accept = ".csv")
    ),
    mainPanel(
      width = 8,
      p(strong("2. Click a state on the map")),
      leafletOutput("map", height = "650px")
    )
  )
)

# ---- Server ------------------------------------------------------------------
server <- function(input, output, session) {
  
  birds <- reactive({
    if (!is.null(input$datafile)) {
      tryCatch(clean_birds(input$datafile$datapath), error = function(e) NULL)
    } else {
      initial_birds
    }
  })
  
  output$data_status <- renderUI({
    b <- birds()
    if (is.null(b) || nrow(b) == 0) {
      p(style = "color:#b00;",
        "No data loaded. Check the file path or upload your CSV below.")
    } else {
      p(style = "color:#2a7;",
        paste0("Loaded ", nrow(b), " records from ",
               length(unique(b$state)), " states (",
               min(b$year), "\u2013", max(b$year), ")."))
    }
  })
  
  output$map <- renderLeaflet({
    leaflet(states) %>%
      setView(-96, 37.8, 4) %>%
      addProviderTiles("CartoDB.Positron") %>%
      addPolygons(
        layerId = ~name,
        fillColor = ~fill_col,
        weight = 1.5,
        opacity = 1,
        color = "white",
        fillOpacity = 0.75,
        highlightOptions = highlightOptions(
          weight = 4, color = "#333", fillOpacity = 0.9, bringToFront = TRUE),
        label = labels,
        labelOptions = labelOptions(
          style = list("font-weight" = "normal", padding = "3px 8px"),
          textsize = "15px", direction = "auto")) %>%
      addLegend(
        colors = unname(flyway_colors),
        labels = paste(names(flyway_colors), "Flyway"),
        opacity = 0.85,
        title = "Migratory Bird Flyways",
        position = "bottomright")
  })
  
  selected_state <- reactiveVal(NULL)
  observeEvent(input$map_shape_click, {
    selected_state(input$map_shape_click$id)
  })
  
  state_birds <- reactive({
    req(selected_state(), input$year, birds())
    birds() %>%
      filter(state == selected_state(), year == input$year) %>%
      pull(species) %>%
      sort()
  })
  
  output$selected_title <- renderText({
    if (is.null(selected_state())) return("Click a state on the map")
    fw <- as.character(states$flyway[states$name == selected_state()])
    paste0(selected_state(),
           if (!is.na(fw)) paste0(" (", fw, " Flyway)") else "",
           " \u2013 ", input$year)
  })
  
  output$bird_list <- renderUI({
    if (is.null(selected_state())) {
      return(p("Pick a year, then click a state to see its species."))
    }
    b <- birds()
    if (is.null(b) || nrow(b) == 0) return(p("Load your data file first."))
    spp <- state_birds()
    if (length(spp) == 0) {
      return(p(paste0("No species records for ", selected_state(),
                      " in ", input$year, ".")))
    }
    tagList(
      p(strong(length(spp)), "species in", input$year),
      tags$ul(lapply(spp, tags$li))
    )
  })
}

shinyApp(ui, server)
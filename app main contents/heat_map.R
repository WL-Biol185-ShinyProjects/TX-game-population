library(shiny)
library(leaflet)
library(sf)
library(tidyverse)

geo <- st_read("https://rstudio.github.io/leaflet/json/us-states.geojson")

myTable <- read_csv("~/TX-game-population/app main contents/tidy_waterfowl_data.csv")

# convert state abbreviations from data to full state names
myTable <- myTable %>% mutate(datastate = state.name[match(datastate, state.abb)])

# labeling which states belong to which flyway                                   
flyways <- list(                                                        
  Atlantic    = c("Maine", "New Hampshire", "Vermont", "Massachusetts", "Rhode Island", "Connecticut", "New York", "New Jersey", "Pennsylvania", "Delaware", "Maryland", "Virginia", "West Virginia", "North Carolina",
                  "South Carolina", "Georgia", "Florida", "District of Columbia"),
  Mississippi = c("Minnesota", "Wisconsin", "Michigan", "Iowa", "Illinois", "Indiana", "Ohio", "Missouri", "Kentucky", "Tennessee", "Arkansas", "Louisiana", "Mississippi", "Alabama"),
  Central     = c("Montana", "Wyoming", "Colorado", "New Mexico", "North Dakota", "South Dakota", "Nebraska", "Kansas", "Oklahoma", "Texas"),
  Pacific     = c("Washington", "Oregon", "California", "Idaho", "Nevada", "Utah", "Arizona", "Alaska")
)

# the categorical column: one flyway name per state (like 'category_col' in the template)
flyway_levels <- c("Atlantic", "Mississippi", "Central", "Pacific")

# labeling the states to proper flyway; "NA_character_" ensures that states not belonging to a flyway are left out of color scheme
geo <- geo %>%
  mutate(flyway = case_when(
    name %in% flyways$Atlantic    ~ "Atlantic",
    name %in% flyways$Mississippi ~ "Mississippi",
    name %in% flyways$Central     ~ "Central",
    name %in% flyways$Pacific     ~ "Pacific",
    TRUE                  ~ NA_character_),
    flyway = factor(flyway, levels = flyway_levels))

ui <- fluidPage(
  titlePanel ("Migratory Waterfowl by State"),
  sliderInput("year", "Select a year", min = 2000, max = 2025,
              value = 2020, step = 1, sep = "", width = "300px", animate = TRUE),
  leafletOutput("map", height = 650)
)

server <- function(input, output, session) {
  # defining a color palette for the flyways 
  pal <- reactive({
    colorFactor(
      palette = c("blue", "red", "green", "purple"),  # Atlantic, Mississippi, Central, Pacific
      domain = flyway_levels,
      na.color = "grey"                            # states not in any flyway (Puerto Rico, Hawaii)
    )
  })
  output$map <- renderLeaflet({
    
    yr <- input$year
    
    # one row per state, with a species list for the click popup
    tbl <- myTable %>%
      filter(year == yr, !is.na(datastate), !species %in% c("Duck (all species)", "Goose (all species)", "Swan (all species)")) %>%
      group_by(datastate) %>%
      summarize(popup = paste0("<b>", first(datastate), " (", yr, ")</b><br>",
                               paste(sort(unique(species)), collapse = "<br>")))
    
    # let geo = g
    g <- left_join(geo, tbl, by = c("name" = "datastate"))
    
    labels <- lapply(ifelse(is.na(g$popup),
                            paste0("<b>", g$name, "</b><br>No data for ", yr),
                            g$popup),
                     htmltools::HTML)
    
    leaflet(g) %>%
      addProviderTiles("OpenStreetMap") %>%                  
      addPolygons(fillColor = ~pal()(flyway),                   
                  color = "white", weight = 1.5,              
                  fillOpacity = 0.7, popup = ~popup,            
                  highlightOptions = highlightOptions(
                    weight = 3,
                    color = "black",
                    fillOpacity = 0.9,
                    bringToFront = TRUE),
                  label = labels,
                  labelOptions = labelOptions(
                    style = list("font-weight" = "normal", padding = "3px 8px"),
                    textsize = "15px",
                    direction = "auto")) %>%
      addLegend(pal = pal(), values = flyway_levels,           
                opacity = 0.7, title = "Flyway", position = "bottomright")
  })
}

shinyApp(ui, server)

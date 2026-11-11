library(shiny)
library(leaflet)
library(sf)
library(dplyr)
library(tidyr)
library(readr)

raw <- read_csv("~/TX-game-population/aggregated_waterfowl_harvest_estimates.csv",
                show_col_types = FALSE, col_types = cols(.default = col_character()))

# excluding the flyway columns (PF, CF, MF, AF) and US in the CSV
ab <- c(setNames(state.abb, state.name), "District of Columbia" = "DC", "Puerto Rico" = "PR")
state_cols <- intersect(names(raw), ab)   # excludes flyway columns (PF, CF, MF, AF) and US

#deciding which rows are harvest tables, and extracting species name
pat <- "^Table [0-9]+\\. (.+?) harvest by season.*$"

d <- raw |>
  filter(grepl(pat, Table_Title)) |> #filtering out everything but the harvest data
  mutate(species = sub(pat, "\\1", Table_Title),
         species = trimws(species),                  # NEW: removes stray leading/trailing spaces
         species = tolower(species),                 # NEW: makes capitalization variants identical
         species = paste0(toupper(substr(species, 1, 1)), substring(species, 2)),
         species = ifelse(species == "Duck", "All ducks combined", species)) |>
  pivot_longer(all_of(state_cols), names_to = "abb", values_to = "value") |> #turning state columns into rows here
  mutate(value = suppressWarnings(as.numeric(gsub(",", "", value)))) |> #converting text in the file to numbers
  filter(!is.na(value)) #removing empty rows from the data

seasons <- sort(unique(d$Season), decreasing = TRUE)
avg_label <- "Average across all seasons"

states <- read_sf("https://rstudio.github.io/leaflet/json/us-states.geojson") |>
  mutate(abb = unname(ab[name]))

ui <- fluidPage(
  fluidRow(
    column(6, selectInput("sp", "Species", sort(unique(d$species)))),
    column(6, selectInput("se", "Season", c(seasons, avg_label), selected = seasons[1]))
  ),
  leafletOutput("map", height = 600)
)

server <- function(input, output) {
  output$map <- renderLeaflet(
    leaflet(states) |> setView(-96, 37.8, 4) |> addProviderTiles("OpenStreetMap.Mapnik") #numbers are set to where the map is focused
  )
  
  #let "sp" = species, let "se" = seasons for the sake of the dropdowns
  observe({
    x <- d |> filter(species == input$sp)
    if (input$se != avg_label) x <- filter(x, Season == input$se)
    
    #one number value per state selected
    v <- x |> group_by(abb) |> summarise(n = mean(value, na.rm = TRUE))
    
    #attaching numbers to single state, in a single year depending on dropdown selection -> one number per state
    s <- left_join(states, v, by = "abb")
    proxy <- leafletProxy("map", data = s) |> clearShapes() |> clearControls()
    if (all(is.na(s$n))) return(proxy)
    
    #turning numbeer into heat map color
    pal <- colorBin("YlOrRd", domain = s$n, bins = 5, na.color = "lightgrey")
    labels <- sprintf("<strong>%s (%s)</strong><br/>%s", s$name, s$abb,
                      ifelse(is.na(s$n), "No data", format(round(s$n), big.mark = ","))) |>
      lapply(htmltools::HTML)
    
    #state details
    proxy |>
      addPolygons(
        fillColor = ~pal(n), weight = 2, opacity = 1, color = "white",
        dashArray = "3", fillOpacity = 0.8,
        highlightOptions = highlightOptions(weight = 5, color = "black", dashArray = "",
                                            fillOpacity = 0.9, bringToFront = TRUE),
        label = labels,
        labelOptions = labelOptions(style = list("font-weight" = "normal", padding = "3px 8px"),
                                    textsize = "15px", direction = "auto")) |>
      addLegend(pal = pal, values = ~n, opacity = 0.8, title = "Harvest",
                position = "bottomright")
  })
}

shinyApp(ui, server)

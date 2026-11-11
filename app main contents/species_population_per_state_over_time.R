# species_population_per_state_over_time.R
# Loaded ONCE by server.R (source("species_population_per_state_over_time.R")).
# It prepares the harvest data and defines two functions:
#   species_base_map()                        -> the empty base map
#   update_species_map(map_id, sp, se)        -> colors the states for one species + season
# No ui, no server, no shinyApp() in here: ui.R and server.R handle those.

library(leaflet)
library(sf)
library(dplyr)
library(tidyr)
library(readr)

# relative path: put aggregated_waterfowl_harvest_estimates.csv in the same folder as ui.R / server.R
raw <- read_csv("~/TX-game-population/aggregated_waterfowl_harvest_estimates.csv",
                show_col_types = FALSE, col_types = cols(.default = col_character()))

# excluding the flyway columns (PF, CF, MF, AF) and US in the CSV
ab <- c(setNames(state.abb, state.name), "District of Columbia" = "DC", "Puerto Rico" = "PR")
state_cols <- intersect(names(raw), ab)   # excludes flyway columns (PF, CF, MF, AF) and US

# deciding which rows are harvest tables, and extracting species name
pat <- "^Table [0-9]+\\. (.+?) harvest by season.*$"

harvest <- raw |>
  filter(grepl(pat, Table_Title)) |>                       # filtering out everything but the harvest data
  mutate(species = sub(pat, "\\1", Table_Title),
         species = paste0(toupper(substr(species, 1, 1)), substring(species, 2)),
         species = ifelse(species == "Duck", "All ducks combined", species)) |>
  pivot_longer(all_of(state_cols), names_to = "abb", values_to = "value") |>   # turning state columns into rows here
  mutate(value = suppressWarnings(as.numeric(gsub(",", "", value)))) |>        # converting text in the file to numbers
  filter(!is.na(value))                                                        # removing empty rows from the data

species_choices <- sort(unique(harvest$species))
seasons         <- sort(unique(harvest$Season), decreasing = TRUE)
avg_label       <- "Average across all seasons"
season_choices  <- c(seasons, avg_label)

states <- read_sf("https://rstudio.github.io/leaflet/json/us-states.geojson") |>
  mutate(abb = unname(ab[name]))

# the empty base map (numbers are set to where the map is focused)
species_base_map <- function() {
  leaflet(states) |> setView(-96, 37.8, 4) |> addProviderTiles("OpenStreetMap.Mapnik")
}

# colors the states on the map named map_id; sp = species, se = season (or avg_label)
update_species_map <- function(map_id, sp, se) {
  x <- harvest |> filter(species == sp)
  if (se != avg_label) x <- filter(x, Season == se)
  
  # one number value per state selected
  v <- x |> group_by(abb) |> summarise(n = mean(value, na.rm = TRUE))
  
  # attaching numbers to single state, depending on dropdown selection -> one number per state
  s <- left_join(states, v, by = "abb")
  proxy <- leafletProxy(map_id, data = s) |> clearShapes() |> clearControls()
  if (all(is.na(s$n))) return(proxy)
  
  # turning number into heat map color
  pal <- colorBin("YlOrRd", domain = s$n, bins = 5, na.color = "lightgrey")
  labels <- sprintf("<strong>%s (%s)</strong><br/>%s", s$name, s$abb,
                    ifelse(is.na(s$n), "No data", format(round(s$n), big.mark = ","))) |>
    lapply(htmltools::HTML)
  
  # state details
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
}


library(leaflet)
library(sf)
library(dplyr)
library(readr)

# State names/abbreviations (US states + DC + PR)
ab <- c(setNames(state.abb, state.name),
        "District of Columbia" = "DC",
        "Puerto Rico"          = "PR")

avg_label <- "Average across all seasons"

data_file <- if (file.exists("waterfowl_harvest_all_species.csv")) {
  "waterfowl_harvest_all_species.csv"
} else {
  "app main contents/waterfowl_harvest_all_species.csv"
}
harvest <- read_csv(data_file, show_col_types = FALSE) |>
  rename(state = datastate, season = year) |>
  filter(state %in% ab, !is.na(amount)) |>
  mutate(season = as.character(season)) |>
  group_by(state, species, season) |>
  summarise(amount = sum(amount), .groups = "drop")

# Choices used by the dropdowns in ui.R
seasons        <- sort(unique(harvest$season), decreasing = TRUE)
season_choices <- c(avg_label, seasons)
species_choices <- sort(unique(harvest$species))


# 2. STATE SHAPES  (named species_geo so it does not overwrite "geo" in the Four Flyways script)
species_geo <- st_read("https://rstudio.github.io/leaflet/json/us-states.geojson", quiet = TRUE)
species_geo$abbr <- unname(ab[species_geo$name])
species_geo <- species_geo[!is.na(species_geo$abbr), ]

# 3. MAP FUNCTIONS
species_base_map <- function() {
  leaflet(options = leafletOptions(minZoom = 3)) |>
    addProviderTiles("OpenStreetMap.Mapnik") |>
    setView(lng = -96, lat = 38, zoom = 4)
}

# map_id : the leafletOutput id in ui.R (a string)
# sp     : species name (any capitalization)
# se     : a season (e.g. "2024") or the avg_label
update_species_map <- function(map_id, sp, se) {
  
  d <- harvest |> filter(tolower(species) == tolower(sp))
  
# same color scale for every season of this species, so seasons are comparable
  max_val <- suppressWarnings(max(d$amount, na.rm = TRUE))
  if (!is.finite(max_val) || max_val <= 0) max_val <- 1
  pal <- colorNumeric("YlOrRd", domain = c(0, max_val), na.color = "white")
  
  if (identical(se, avg_label)) {
    d <- d |> group_by(state) |> summarise(amount = mean(amount), .groups = "drop")
    title <- "Average harvest"
  } else {
    d <- d |> filter(season == se) |> select(state, amount)
    title <- paste("Harvest,", se)
  }
  
  shapes <- species_geo |> left_join(d, by = c("abbr" = "state"))
  
  labels <- lapply(seq_len(nrow(shapes)), function(i) {
    val <- if (is.na(shapes$amount[i])) "No data" else format(round(shapes$amount[i]), big.mark = ",")
    htmltools::HTML(sprintf("<strong>%s</strong><br/>%s", shapes$name[i], val))
  })
  
  leafletProxy(map_id) |>
    clearShapes() |>
    clearControls() |>
    addPolygons(data = shapes,
                fillColor = ~pal(amount), fillOpacity = 0.8,
                color = "black", weight = 1,
                label = labels,
                highlightOptions = highlightOptions(weight = 2, color = "#444", bringToFront = TRUE)) |>
    addLegend(position = "bottomright", pal = pal, values = c(0, max_val),
              title = title, na.label = "No data") |>
    addControl(
      html = "<div style='max-width:220px;font-size:12px;'><em>Note: Some species data is not consistently recorded until the year 2000.</em></div>",
      position = "bottomleft",
      className = "info"
    )
}

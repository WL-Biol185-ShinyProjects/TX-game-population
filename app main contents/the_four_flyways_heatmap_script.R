#the_four_flyways_heatmap_script.R
#Loaded ONCE by server.R (source("the_four_flyways_heatmap_script.R")).
#It prepares the data and defines flyway_map(yr), which returns the leaflet map for one year.
#No ui, no server, no shinyApp() in here: server.R and ui.R handle those.

library(leaflet)
library(sf)
library(tidyverse)

flyway_geo <- st_read("https://rstudio.github.io/leaflet/json/us-states.geojson")

#relative path: waterfowl_harvest_all_species.csv must be in the same folder as ui.R / server.R
myTable <- read_csv("waterfowl_harvest_all_species.csv", show_col_types = FALSE)

#convert state abbreviations from data to full state names
myTable <- myTable %>% mutate(datastate = state.name[match(datastate, state.abb)])

#labeling which states belong to which flyway
flyways <- list(
  Atlantic = c("Maine", "New Hampshire", "Vermont", "Massachusetts", "Rhode Island", "Connecticut", "New York", "New Jersey", "Pennsylvania", "Delaware", "Maryland", "Virginia", "West Virginia", "North Carolina",
               "South Carolina", "Georgia", "Florida", "District of Columbia"),
  Mississippi = c("Minnesota", "Wisconsin", "Michigan", "Iowa", "Illinois", "Indiana", "Ohio", "Missouri", "Kentucky", "Tennessee", "Arkansas", "Louisiana", "Mississippi", "Alabama"),
  Central = c("Montana", "Wyoming", "Colorado", "New Mexico", "North Dakota", "South Dakota", "Nebraska", "Kansas", "Oklahoma", "Texas"),
  Pacific = c("Washington", "Oregon", "California", "Idaho", "Nevada", "Utah", "Arizona", "Alaska")
)

#the categorical column: one flyway name per state
flyway_levels <- c("Atlantic", "Mississippi", "Central", "Pacific")

#(the shapes are named flyway_geo so no other script can overwrite them)
#labeling the states to proper flyway; NA_character_ leaves states not in a flyway out of the color scheme
flyway_geo <- flyway_geo %>%
  mutate(flyway = case_when(
    name %in% flyways$Atlantic ~ "Atlantic",
    name %in% flyways$Mississippi ~ "Mississippi",
    name %in% flyways$Central ~ "Central",
    name %in% flyways$Pacific ~ "Pacific",
    TRUE ~ NA_character_),
    flyway = factor(flyway, levels = flyway_levels))

#color palette for the flyways
pal <- colorFactor(
  palette = c("#2D4739", "#7A5C3E", "#C2A878", "#556B2F"), # Atlantic, Mississippi, Central, Pacific
  domain = flyway_levels,
  na.color = "grey" # states not in any flyway (Puerto Rico, Hawaii)
)

#builds the map for one year (server.R calls this with the slider's value)
flyway_map <- function(yr) {
  
# one row per state, with a species list for the click popup
tbl <- myTable %>%
filter(year == yr, !is.na(datastate)) %>%
group_by(datastate) %>%
summarize(popup = paste0("<b>", first(datastate), " (", yr, ")</b><br>",
paste(sort(unique(species)), collapse = "<br>")))

# let geo = g
g <- left_join(flyway_geo, tbl, by = c("name" = "datastate"))

labels <- lapply(ifelse(is.na(g$popup),
paste0("<b>", g$name, "</b><br>No data for ", yr),
g$popup),
htmltools::HTML)

leaflet(g) %>%
addProviderTiles("OpenStreetMap") %>%
addPolygons(fillColor = ~pal(flyway),
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
addLegend(pal = pal, values = flyway_levels,
opacity = 0.7, title = "Flyway", position = "bottomright")
}


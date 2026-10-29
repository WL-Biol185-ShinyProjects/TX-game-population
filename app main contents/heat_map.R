library(leaflet)
library(sf)
library(tidyverse)

geo <- st_read("states.geo.json")

myTable <- read_csv("~/TX-game-population/app main contents/tidy_waterfowl_data.csv")

# convert abbreviations to full state names
myTable <- myTable %>% mutate(datastate = state.name[match(datastate, state.abb)])

#line that is important for adding a slider later? - find instructions from syllabus tutorial
yr <- max(myTable$year, na.rm = TRUE)

# one row per state, with a species list for the click popup
myTable <- myTable %>%
  filter(year == yr, !is.na(datastate)) %>%
  group_by(datastate) %>%
  summarize(popup = paste0("<b>", first(datastate), " (", yr, ")</b><br>",
                           paste(species, collapse = "<br>")))

geo <- left_join(geo, myTable, by = c("name" = "datastate"))

labels <- lapply(ifelse(is.na(geo$popup),
                        paste0("<b>", geo$name, "</b><br>No data for ", yr),
                        geo$popup),
                 htmltools::HTML)

leaflet(geo) %>%
  addTiles() %>%
  addPolygons(color = "blue", weight = 1.5, popup = ~popup,
              highlightOptions = highlightOptions(
                weight = 3,
                color = "black",
                fillOpacity = 0.7,
                bringToFront = TRUE),
              label = labels,
              labelOptions = labelOptions(
                style = list("font-weight" = "normal", padding = "3px 8px"),
                textsize = "15px",
                direction = "auto"))


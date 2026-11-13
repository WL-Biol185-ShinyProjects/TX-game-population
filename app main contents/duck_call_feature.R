# duck_call_feature.R
# Sourced by BOTH ui.R and server.R.
# It defines the species/audio list and two functions:
#   duck_call_ui()                           -> goes inside the "Duck Calls" tabPanel in ui.R
#   duck_call_server(input, output, session) -> called once in server.R
# No ui, no server, no shinyApp() in here: ui.R and server.R handle those.

library(shiny)

# each species with its Wikipedia (Wikimedia Commons) audio file for the call
duck_call_files <- c(
  "Canada Goose"     = "Canada_Geese_(Branta_canadensis)_(W1CDR0001421_BD11).ogg",
  "Long-tailed Duck" = "Clangula_hyemalis.ogg",
  "Mallard"          = "Anas_platyrhynchos_-_Mallard_-_XC62258.ogg",
  "Mourning Dove"    = "Zenaida_macroura_vocalizations_-_pone.0027052.s009.oga",
  "Sandhill Crane"   = "Grus_canadensis_Denali_National_Park.ogg",
  "Sora"             = "Porzana_carolina_-_Sora_XC109542.mp3",
  "Trumpeter Swan"   = "Cygnus_buccinator_-_Trumpeter_Swan_XC413784.mp3",
  "Tundra Swan"      = "Bewick%27s_Swan_(Cygnus_columbianus)_(W1CDR0001383_BD2).ogg",
  "Wood Duck"        = "Aix_sponsa_-_Wood_Duck_-_XC63109.ogg"
)

# UI half: a dropdown and an empty slot where the audio player appears
duck_call_ui <- function() {
  tagList(
    h3("Duck Calls"),
    selectInput("duck_call_species", "Select a species", c("", names(duck_call_files))),
    uiOutput("duck_call_audio")
  )
}

# server half: puts the audio player for the chosen species into the slot
duck_call_server <- function(input, output, session) {
  output$duck_call_audio <- renderUI({
    if (nzchar(input$duck_call_species))
      tags$audio(
        src = paste0("https://commons.wikimedia.org/wiki/Special:FilePath/",
                     duck_call_files[[input$duck_call_species]]),
        controls = NA, autoplay = NA
      )
  })
}

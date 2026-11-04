library(shiny)

#each species with their wikipedia audio files for designated duck call
f <- c(
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

#select individual species to play their specific audio file
ui <- fluidPage(
  selectInput("s", "Select a species", c("", names(f))),
  uiOutput("a")
)

#web page needs to connect o the names above, src = allows for the connection of "s"
server <- function(input, output) {
  output$a <- renderUI({
    if (nzchar(input$s))
      tags$audio(
        src = paste0("https://commons.wikimedia.org/wiki/Special:FilePath/", f[[input$s]]),
        controls = NA, autoplay = NA
      )
  })
}

shinyApp(ui, server)

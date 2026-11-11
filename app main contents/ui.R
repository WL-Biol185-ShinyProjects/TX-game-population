library(shiny)
library(leaflet)

# One flyway tab = dropdown + empty "slots". server.R fills the slots for the chosen species.
flyway_tab <- function(flyway) {
  k <- tolower(flyway)                                    # "pacific" -> species_pacific, size_pacific, ...
  tabPanel(paste(flyway, "Flyway"), br(),
           selectInput(paste0("species_", k), "Choose a species:", choices = NULL),  # filled by server.R
           h3(textOutput(paste0("title_", k))),
           div(style = "display: flex; gap: 20px;",
               uiOutput(paste0("image1_", k)),
               uiOutput(paste0("image2_", k)),
               uiOutput(paste0("image3_", k))),
           h4("About this species"),
           uiOutput(paste0("description_", k)),
           tags$ul(
             tags$li(textOutput(paste0("size_", k))),
             tags$li(textOutput(paste0("wingspan_", k))),
             tags$li(textOutput(paste0("weight_", k))),
             tags$li(textOutput(paste0("lifespan_", k))),
             tags$li(textOutput(paste0("diet_", k))),
             tags$li(textOutput(paste0("habitat_", k))),
             tags$li(textOutput(paste0("nesting_", k))),
             tags$li(textOutput(paste0("status_", k)))
           ),
           h4("Call"),       # sound goes here later
           h4("Heat map")    # heat map goes here later
  )
}

ui <- fluidPage(
  navbarPage("US Flyway Data",                            # <- keep your own title/options
             tabPanel("Home", br(), uiOutput("home_content")),   # filled in by server.R from home_info.csv
             flyway_tab("Pacific"),
             flyway_tab("Central"),
             flyway_tab("Mississippi"),
             flyway_tab("Atlantic"),
             tabPanel("Heatmap", br(),
                      h3("Species Heatmap Over Time"),
                      fluidRow(
                        column(6, selectInput("species_hm", "Species", choices = NULL)),   # filled by server.R
                        column(6, selectInput("season_hm", "Season", choices = NULL))),    # filled by server.R
                      leafletOutput("species_heatmap", height = 600)),
             tabPanel("Quiz", p("Quiz goes here.")),
             tabPanel("Duck Calls", p("Duck Calls Section"))
  )
)
library(shiny)
library(leaflet)

# One flyway tab = dropdown + empty "slots". server.R fills the slots for the chosen species.
flyway_tab <- function(flyway) {
  k <- tolower(flyway)
  tabPanel(paste(flyway, "Flyway"), br(),
           selectInput(paste0("species_", k), "Choose a species:", choices = NULL),
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
  )
}

ui <- fluidPage(
  tags$head(tags$style(HTML("
    :root {
      --tan:       #C9B58F;   /* navbar: darker tan       */
      --tan-dark:  #B39D72;   /* navbar hover / active    */
      --cream:     #FAF6EA;   /* page background          */
      --sage:      #B7C4A0;   /* light earthy green       */
      --sage-dark: #8FA37A;   /* green borders            */
      --orange:    #FF6A13;   /* hunter orange accent     */
    }

    body { background-color: var(--cream); color: #000; }
    h3, h4, label, p, li { color: #000; }
    h4 { border-bottom: 2px solid var(--orange); padding-bottom: 4px; display: inline-block; }
    hr { border-top: 1px solid var(--tan); }

    /* Navbar */
    .navbar-default { background-color: var(--tan); border-color: var(--tan-dark); }
    .navbar-default .navbar-brand { color: #000; font-weight: bold; }
    .navbar-default .navbar-nav > li > a { color: #000; }
    .navbar-default .navbar-nav > li > a:hover,
    .navbar-default .navbar-nav > li > a:focus { background-color: var(--tan-dark); color: #000; }
    .navbar-default .navbar-nav > .active > a,
    .navbar-default .navbar-nav > .active > a:hover,
    .navbar-default .navbar-nav > .active > a:focus {
      background-color: var(--tan-dark); color: #000; border-bottom: 3px solid var(--orange);
    }

    /* Dropdowns and inputs: light green */
    .selectize-input, .form-control {
      background-color: var(--sage); border: 1px solid var(--sage-dark); color: #000;
    }
    .selectize-input.focus { border-color: var(--orange); box-shadow: 0 0 4px var(--orange); }
    .selectize-dropdown { background-color: var(--sage); border: 1px solid var(--sage-dark); color: #000; }
    .selectize-dropdown .active { background-color: var(--sage-dark); color: #000; }

    /* Slider */
    .irs--shiny .irs-bar { background: var(--orange); border-color: var(--orange); }
    .irs--shiny .irs-handle { border-color: var(--orange); background: var(--cream); }
    .irs--shiny .irs-single, .irs--shiny .irs-from, .irs--shiny .irs-to { background: var(--orange); color: #000; }

    /* Buttons (e.g., slider play button) */
    .btn, .slider-animate-button { color: #000; }
    .btn-default:hover { background-color: var(--sage); }

    /* Images: light green border */
    img { border-radius: 6px; border: 3px solid var(--sage); }
    figcaption { color: #000; font-style: italic; }
  "))),
  
  navbarPage("US Flyway Data",
             tabPanel("Home", br(), uiOutput("home_content")),
             flyway_tab("Pacific"),
             flyway_tab("Central"),
             flyway_tab("Mississippi"),
             flyway_tab("Atlantic"),
             tabPanel("Heatmap", br(),
                      h3("Species Heatmap Over Time"),
                      fluidRow(
                        column(6, selectInput("species_hm", "Species", choices = NULL)),
                        column(6, selectInput("season_hm", "Season", choices = NULL))),
                      leafletOutput("species_heatmap", height = 600)),
             tabPanel("Quiz", p("Quiz goes here.")),
             tabPanel("Duck Calls", p("Duck Calls Section"))
  )
)
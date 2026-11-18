library(shiny)
library(leaflet)   # needed for leafletOutput()

# Loads the quiz data and defines quiz_ui()
source("duck_quiz_used_in_app.R")

# Loads the duck call feature and defines duck_call_ui()
source("duck_call_feature.R")

# Flyway descriptions, looked up by lowercase flyway name
flyway_descriptions <- list(
  atlantic = r"---(Extending along the eastern coast of North America from the Arctic tundra and Atlantic Canada down through the Eastern Seaboard to the Caribbean and South America, the Atlantic Flyway is the most densely populated and geographically varied corridor on the continent. Heavily shaped by major coastal features like the Chesapeake Bay, Pamlico Sound, and extensive saltwater marshes, it serves as the primary wintering ground for the American black duck, Atlantic brant, wood ducks, and huge rafts of diving and sea ducks such as eiders, scoters, and canvasbacks. Because this corridor overlaps with major urban centers, wildlife management focuses heavily on balancing coastal development with the restoration of critical tidal wetlands, leading to more conservative bag limits and species-specific harvest restrictions. For waterfowlers, hunting in the Atlantic Flyway is uniquely defined by saltwater tides, coastal winds, and historic traditions ranging from Chesapeake Bay sinkbox and scull-boat gunning to rocky New England sea-duck shoots.)---",
  
  mississippi = r"---(Following the massive watershed of the Mississippi River and its tributaries from central Canada and the Great Lakes south to the Gulf Coast, the Mississippi Flyway is an unobstructed natural funnel with no mountain ranges to impede migration. As the most heavily used corridor in North America, it carries nearly half of the continent's migrating waterfowl, shorebirds, and songbirds each season, supporting iconic concentrations of mallards, wood ducks, Canada geese, canvasbacks, and ring-necked ducks. Characterized by vast river systems, agricultural bottomlands, and flooded timber environments like the Arkansas Delta, the region is a primary focus for large-scale wetland conservation and agricultural habitat management. From a hunting perspective, the Mississippi Flyway sees the highest harvest volume and heaviest hunting pressure in the United States, creating decoy-shy birds that challenge hunters across legendary flooded green-timber holes, river backwaters, and Louisiana coastal marshes.)---",
  
  central = r"---(Spanning the vast midsection of North America from the Canadian high Arctic across the Great Plains and Big Bend region down to the Texas Gulf Coast and interior Mexico, the Central Flyway is defined by expansive grasslands, playa lakes, key river systems like the Platte and Missouri, and the critical Prairie Pothole Region—often called North America's "duck factory." Because this treeless corridor lacks major mountain barriers, birds rely heavily on shallow, temporary wetlands and agricultural forage to refuel across long stretches of semi-arid terrain, supporting massive flocks of mallards, pintails, gadwalls, teal, sandhill cranes, and snow geese. Hunters in the Central Flyway are famous for dry-field decoy spreads targeting feeding ducks and geese in harvested wheat, corn, and barley, alongside pass-shooting over shallow prairie potholes and playa lakes. Because weather fronts sweep unimpeded across the open plains, Central Flyway waterfowling is uniquely shaped by sudden, dramatic freeze-ups that can push hundreds of thousands of birds south overnight.)---",
  
  pacific = r"---(Stretching from western Alaska and northwestern Canada down the Pacific Coast to western Mexico and South America, the Pacific Flyway covers dramatic topography bounded by the Pacific Ocean and the Rocky Mountains. It features diverse stopover environments ranging from coastal estuaries and Puget Sound to major inland agricultural and wetland basins like California's Central Valley and the Klamath Basin. Supporting roughly one-fifth of North America’s migrating waterfowl—including northern pintails, American wigeon, western Canada geese, cackling geese, and Barrow's goldeneyes—this corridor relies heavily on water allocation, drought management, and wetland restoration to sustain its critical stopover habitats. For hunters, the Pacific Flyway is unique for offering the longest seasons and most liberal daily bag limits in the United States, allowing waterfowlers to pursue birds across flooded Sacramento rice fields, coastal bays, and high-desert marshes.)---"
)

# One flyway tab = dropdown + flyway information (home screen)
# OR species details (species screen). server.R sets output$show_<flyway>
# to TRUE (species screen) or FALSE (home screen).
flyway_tab <- function(flyway) {
  k <- tolower(flyway)
  tabPanel(paste(flyway, "Flyway"), br(),
           selectInput(paste0("species_", k), "Choose a species:", choices = NULL),
           
           # HOME SCREEN: flyway description (shown when no species screen is active)
           conditionalPanel(
             condition = paste0("!output.show_", k),
             h4("Flyway Information"),
             div(style = "max-width: 900px; margin-bottom: 20px;",
                 p(flyway_descriptions[[k]]))
           ),
           
           # SPECIES SCREEN: species details + return button
           conditionalPanel(
             condition = paste0("output.show_", k),
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
             
             # Handled by observeEvent() in server.R
             actionButton(
               paste0("back_", k), "Return to Flyway Homepage",
               style = "margin-top: 15px; margin-bottom: 30px;"
             )
           )
  )
}

# One "About Us" card = photo + optional name + description
about_card <- function(photo, text, name = NULL) {
  div(class = "about-card",
      img(src = photo, alt = if (is.null(name)) "About Us photo" else name),
      div(class = "about-card-body",
          if (!is.null(name)) h4(name),
          p(text)))
}

ui <- fluidPage(
  tags$head(
    # Resets a species dropdown to "Select a species" in the browser and scrolls to the top
    tags$script(HTML("
      Shiny.addCustomMessageHandler('resetSpecies', function(id) {
        var el = document.getElementById(id);
        if (el && el.selectize) { el.selectize.setValue(''); }
        window.scrollTo(0, 0);
      });
    ")),
    tags$style(HTML("
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

    /* Accordion (Home tab: flyway descriptions + waterfowl facts) */
    .flyway-accordion { max-width: 1000px; margin: 10px 0 20px 0; }
    .flyway-accordion details {
      background-color: var(--sage); border: 1px solid var(--sage-dark);
      border-radius: 6px; margin-bottom: 8px; overflow: hidden;
    }
    .flyway-accordion summary {
      cursor: pointer; padding: 10px 40px 10px 14px; font-weight: bold;
      color: #000; list-style: none; position: relative;
    }
    .flyway-accordion summary::-webkit-details-marker { display: none; }
    .flyway-accordion summary::after {
      content: '+'; position: absolute; right: 16px; font-weight: bold;
      font-size: 18px; color: var(--orange);
    }
    .flyway-accordion details[open] > summary {
      background-color: var(--tan); border-bottom: 2px solid var(--orange);
    }
    .flyway-accordion details[open] > summary::after { content: '\\2212'; }
    .flyway-accordion details p {
      margin: 0; padding: 12px 14px; background-color: var(--cream);
    }
    .flyway-accordion details ul {
      margin: 0; padding: 12px 14px 12px 34px; background-color: var(--cream);
    }

    /* About Us page (these class names are only used on the About Us tab, so no other tab changes) */
    .about-page { max-width: 1100px; margin: 0 auto; padding: 10px 15px 40px 15px; }
    .about-page h3 { text-align: center; font-size: 32px; font-weight: bold; margin: 10px 0 40px 0; }
    .about-page h3::after {
      content: ''; display: block; width: 70px; height: 4px; margin: 12px auto 0 auto;
      background-color: var(--orange); border-radius: 2px;
    }
    .about-grid {
      display: grid; gap: 30px;
      grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    }
    .about-card {
      background-color: #fff; border: 1px solid var(--tan); border-radius: 14px;
      overflow: hidden; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.10);
      transition: transform 0.2s ease, box-shadow 0.2s ease;
    }
    .about-card:hover { transform: translateY(-5px); box-shadow: 0 10px 22px rgba(0, 0, 0, 0.18); }
    .about-card img {
      display: block; width: 100%; height: 300px; object-fit: cover;
      border: none; border-radius: 0; border-bottom: 4px solid var(--orange);
    }
    .about-card-body { padding: 18px 22px 24px 22px; }
    .about-card-body h4 {
      display: block; border-bottom: none; padding-bottom: 0; margin: 0 0 8px 0;
      font-size: 20px; font-weight: bold;
    }
    .about-card-body p { margin: 0; line-height: 1.65; font-size: 15px; }
  "))),
  
  navbarPage("US Flyway Data", id = "main_nav",
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
             tabPanel("Quiz", quiz_ui()),
             tabPanel("Duck Calls", br(), duck_call_ui()),
             tabPanel("About Us", br(),
                      div(class = "about-page",
                          h3("About Us"),
                          div(class = "about-grid",
                              about_card("RBL_photo.jpg", "Robert Light attended Washington and Lee University from 2023-2027, majoring in Neuroscience. He is from Houston, Texas and hopes to attend medical school. In his free time, he enjoys hunting, fishing, and golf. "),
                              about_card("photo2.jpg", "Description for the second person goes here."),
                              about_card("photo3.jpg", "Description for the third person goes here.")
                          )))
  )
)

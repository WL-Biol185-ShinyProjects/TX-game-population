#ui.R file
#ui.R is the layout. it says the tabs, dropdowns, text, photos, audio players, and empty spots reserved for plots. It doesn’t touch the data.

library(shiny)

fluidPage(
  titlePanel("US Waterfowl Flyways"),
  tabsetPanel(
    
    tabPanel("Home",
             br(),
             h3("The 4 North American Flyways"),
             p("A flyway is a major geographic highway used annually by migratory birds—especially waterfowl—as they 
               travel between their northern breeding grounds and southern wintering territories. Shaped by natural 
               landscape features like river basins, coastlines, and mountain ranges, these corridors provide the 
               vital wetlands and stopover habitats birds need to rest, feed, and refuel along their journeys. Beyond 
               their ecological significance, wildlife management agencies use these flight paths to define administrative 
               regions for monitoring bird populations, conducting harvest surveys, and setting sustainable hunting 
               regulations across entire migratory routes. In North America, the continent is divided into four primary
               administrative flyways: the Atlantic Flyway along the East Coast, the Mississippi Flyway spanning the 
               central river valley, the Central Flyway extending across the Great Plains, and the Pacific Flyway along 
               the West Coast."),
             
             # Map will go here in step 2
             
             h4("Atlantic Flyway"),
             p("Extending along the eastern coast of North America, the Atlantic Flyway spans from the Arctic tundra and
               Atlantic Canada all the way down through the Eastern Seaboard to the Caribbean and South America. This 
               corridor is heavily shaped by major coastal features, including the Chesapeake Bay, Pamlico Sound, and 
               extensive saltwater marshes, alongside major river networks. Because it encompasses some of the most densely 
               populated urban corridors on the continent, wildlife management in this flyway focuses heavily on balancing 
               urban development with the preservation and restoration of critical tidal wetlands and wintering coastal 
               habitats for species like diving ducks, Atlantic brant, and black ducks."),
             
             h4("Mississippi Flyway"),
             p("The Mississippi Flyway follows the massive watershed of the Mississippi River and its tributaries, 
               stretching from central Canada and the Great Lakes south to the Gulf Coast. As the most heavily used migratory
               corridor in North America, it carries nearly half of the continent's migrating waterfowl, shorebirds, and 
               songbirds each season. The region is characterized by vast river systems, agricultural bottomlands, and 
               flooded timber environments—such as the Arkansas Delta—making it a vital ecosystem for species like mallards,
               wood ducks, and Canada geese, as well as a primary focus for large-scale wetland conservation and agricultural 
               habitat management."),
             
             h4("Central Flyway"),
             p("Spanning the vast midsection of North America, the Central Flyway reaches from the Canadian high Arctic across
               the Great Plains and Big Bend region down to the Gulf Coast of Texas and interior Mexico. This corridor is 
               defined by expansive grasslands, playa lakes, prairie potholes, and key river systems like the Platte and 
               Missouri Rivers. Birds navigating this flyway rely heavily on shallow, temporary wetlands and agricultural 
               forage to refuel during their transit across long stretches of arid and semi-arid terrain, making it a critical 
               habitat route for species such as pintails, green-winged teal, sandhill cranes, and snow geese."),
             
             h4("Pacific Flyway"),
             p("Stretching from western Alaska and northwestern Canada down the Pacific Coast to Western Mexico and South
               America, the Pacific Flyway covers a diverse geography bounded by the Pacific Ocean and the Rocky Mountains. 
               It features varied stopover environments ranging from coastal estuaries and bays to major inland agricultural 
               and wetland basins like California's Central Valley and the Klamath Basin. Migratory populations—including 
               western Canada geese, pintails, cackling geese, and various shorebirds—depend on these key stopovers, where 
               water allocation, drought management, and wetland restoration remain central focus areas for regional conservation 
               efforts."),
             
             hr(),
             h3("General Waterfowl Facts"),
             tags$ul(
               tags$li("Waterfowl is the group name for ducks, geese, and swans."),
               tags$li("Wetlands are their key habitat, which is why wetland conservation matters so much to them."),
               tags$li("Their feathers are kept waterproof with oil from a gland near the tail."),
               tags$li("Many ducks molt all their flight feathers at once, leaving them unable to fly for a few weeks."),
               tags$li("Federal Duck Stamp sales help fund the protection of wetland habitat.")
             )
    ),
    
    tabPanel("Pacific Flyway",
             br(),
             selectInput("species_pacific", "Choose a species:",
                         choices = c("Select a species" = "", "American Coot", "Band-tailed Pigeon, Interior", "Band-tailed Pigeon, Pacific Coast (summer)",
                                     "Brant, Pacific (fall)", "Cackling Goose, Aleutian", "Cackling Goose, Cackling (minima)", "Cackling Goose, Taverner’s",
                                     "Canada Goose, Dusky", "Canada Goose, Lesser", "Canada Goose, Western PFP", "Common Gallinule", "Emperor Goose", 
                                     "Mourning Dove, WMU (summer)", "Ross’s Goose", "Sandhill Crane, MP", "Sandhill Crane, RMP", "Snow Goose, WIP and WAP", "Sora",
                                     "Trumpeter Swan, PP", "Trumpeter Swan, RMP Canada Segment", "Trumpeter Swan, RMP US Segment", "Tundra Swan, EP", "Tundra Swan, WP", 
                                     "Virginia Rail", "White-fronted Goose, MP", "White-fronted Goose, PP", "White-fronted Goose, Tule", "White-winged Dove, WMU", "Wilson’s Snipe")),
             h3(textOutput("title_pacific")),
             plotOutput("bar_pacific")
    ),
    
    tabPanel("Central Flyway",
             br(),
             selectInput("species_central", "Choose a species:",
                         choices = c("Select a species" = "", "American Black Duck", "American Green-winged Teal", "American Wigeon", "Black-bellied Whistling Duck",
                                     "Canada Goose", "Canvasback", "Cackling Goose", "Duck", "Fulvous Whistling Duck", "Gadwall", "Goldeneye, Common", "Goose",
                                     "Hooded Merganser", "Mallard", "Mexican Duck", "Mottled Duck", "Northern Pintail", "Northern Shoveler", "Redhead", "Ring-necked Duck",
                                     "Ross's Goose", "Ruddy Duck", "Scaup, Greater", "Scaup, Lesser", "Snow and Blue Geese", "Teal, American Green-winged",
                                     "Teal, American Green-winged Early", "Teal, American Green-winged Regular", "Teal, Blue-winged and Cinnamon", 
                                     "Teal, Blue-winged and Cinnamon Early", "Teal, Blue-winged and Cinnamon Regular", "White-fronted Goose", "Wood Duck", 
                                     "Canada-cackling Goose, Early")),
             h3(textOutput("title_central")),
             plotOutput("bar_central")
    ),
    
    tabPanel("Mississippi Flyway",
             br(),
             selectInput("species_mississippi", "Choose a species:",
                         choices = c("Select a species" = "", "American Black Duck", "American Green-winged Teal", "American Wigeon", "Black-bellied Whistling Duck",
                                     "Bufflehead", "Cackling Goose", "Canada Goose", "Canvasback", "Common Goldeneye", "Duck", "Fulvous Whistling Duck", "Gadwall",
                                     "Goose", "Long-tailed Duck", "Mallard", "Merganser, Common", "Merganser, Hooded", "Merganser, Red-breasted", "Mottled Duck",
                                     "Northern Pintail", "Northern Shoveler", "Redhead", "Ring-necked Duck", "Ross's Goose", "Ruddy Duck", "Scaup, Greater", "Scaup, Lesser",
                                     "Scoter, Black", "Scoter, Surf", "Scoter, White-winged", "Snow and Blue Goose", "Teal, American Green-winged",
                                     "Teal, American Green-winged Early", "Teal, American Green-winged Regular", "Teal, Blue-winged and Cinnamon", "Teal, Blue-winged and Cinnamon Early", 
                                     "Teal, Blue-winged and Cinnamon Regular", "White-fronted Goose", "Wood Duck", "Wood Duck, Early")),
             h3(textOutput("title_mississippi")),
             plotOutput("bar_mississippi")
    ),
    
    tabPanel("Atlantic Flyway",
             br(),
             selectInput("species_atlantic", "Choose a species:",
                         choices = c("Select a species" = "", "American Black Duck", "American Green-winged Teal", "American Wigeon", "Atlantic Brant", "Bufflehead", 
                                     "Canada Goose", "Canada-cackling Goose, Early", "Canvasback", "Common Eider", "Common Goldeneye", "Duck", "Gadwall", "Goose", 
                                     "Long-tailed Duck", "Mallard", "Mallard-Black Duck Hybrid", "Merganser, Common", "Merganser, Hooded", "Merganser, Red-breasted",
                                     "Mottled Duck", "Northern Pintail", "Northern Shoveler", "Redhead", "Ring-necked Duck", "Ruddy Duck", "Scaup, Greater", "Scaup, Lesser",
                                     "Scoter, Black", "Scoter, Surf", "Scoter, White-winged", "Snow and Blue Goose", "Teal, American Green-winged", 
                                     "Teal, American Green-winged Early", "Teal, American Green-winged Regular", "Teal, Blue-winged and Cinnamon", 
                                     "Teal, Blue-winged and Cinnamon Early", "Teal, Blue-winged and Cinnamon Regular", "Whistling Duck, Black-bellied", "Wood Duck", 
                                     "Wood Duck, Early")),
             h3(textOutput("title_atlantic")),
             plotOutput("bar_atlantic")
    ),
    
    
    
    tabPanel("Quiz", p("Quiz goes here."))
  )
)
#to put image in, go to place you want image to appear and use function img(src="myfile.png")
#do not put www before file name
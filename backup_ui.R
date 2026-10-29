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
                         choices = c("Select a species" = "", "American Coot", "Band-tailed Pigeon",
                                     "Brant, Pacific", "Cackling Goose, Aleutian", "Cackling Goose",
                                     "Canada Goose, Dusky", "Canada Goose, Lesser", "Canada Goose, Western", "Common Gallinule", "Emperor Goose", 
                                     "Mourning Dove", "Ross’s Goose", "Sandhill Crane", "Sandhill Crane", "Snow Goose", "Sora",
                                     "Trumpeter Swan", "Trumpeter Swan", "Trumpeter Swan", "Tundra Swan", "Tundra Swan", 
                                     "Virginia Rail", "White-fronted Goose", "White-fronted Goose", "White-fronted Goose", "White-winged Dove", "Wilson’s Snipe")),
             h3(textOutput("title_pacific")),
             
             #American Coot
             conditionalPanel(
               condition = "input.species_pacific == 'American Coot'",
               
               #PHOTO
               img(src="american_coot_monomorphic.jpg", width = "400px"),
               
               #DESCRIPTION
               h4("About this species"),
               p("A plump, rounded waterbird with slate-gray to dark charcoal body plumage, a black head and neck, dark red eyes, and large, greenish-gray feet equipped with broad, 
               flattened swimming lobes instead of webbing. Its bill is stark white with a tiny brown spot near the tip and a small brown frontal callus on the forehead. The tail is
               short and carried low while swimming, often giving the bird a rounded, chicken-like profile on open water. To become airborne, they require long, pattering runs across
               open water while furiously beating their short, rounded wings. In flight, they show a thin, whitish trailing edge on the secondaries and fly with rapid, labored wing 
               strokes, dragging their large feet behind their tail. They vocalize with sharp, metallic croaks and grunts, frequently chattering when gathered in large rafts. Often
               rafts in thousands on open lakes and coastal bays, feeding on submerged vegetation alongside diving ducks. They are readily distinguished from game ducks by their 
               chicken-like head-bobbing swimming motion and chalk-white bills, making early-morning identification simple. While many waterfowlers overlook them, they are traditionally 
               pursued in southern marshes for use in hearty stews and gumbos."),
               
               # ----- DESCRIPTION (bullet points) -----
               tags$ul(
                 tags$li("Size: 33-43 cm (13–17 inches)"),
                 tags$li("Wingspan: 60–70 cm (24–28 inches)"),
                 tags$li("Weight: 426 – 850 g (0.9 – 1.9 lbs)"),
                 tags$li("Lifespan: 8–9 years in the wild"),
                 tags$li("Diet: Omnivorous; aquatic vegetation, algae, seeds, insects, and small fish"),
                 tags$li("Habitat: Freshwater lakes, marshes, ponds, and slow rivers"),
                 tags$li("Nesting season: April to July"),
                 tags$li("Conservation status: Least Concern")
               ),
               
               # SOUND: SPACE RESERVED 
               h4("Call"),
               # >>> SOUND GOES HERE (audio player will replace this comment) <<<
               
               #HEAT MAP: SPACE RESERVED
               h4("Heat map")
               # >>> HEAT MAP GOES HERE (map will replace this comment) <<<
             ),
             
             #band-tailed pigeon, interior
             conditionalPanel(
               condition = "input.species_pacific == 'Band-tailed Pigeon, Interior'",
               
               #PHOTO
               img(src="band_tailed_pigeon_monomorphic.jpg", width = "400px"),
               
               #DESCRIPTION
               h4("About this species"),
               p("A large, robust woodland pigeon with a slate-blue and purplish-gray body, a long, rounded tail marked with a wide, pale gray terminal band, and a bright yellow bill tipped 
               in black. Mature birds display an iridescent bronze-green nape patch topped by a clean, narrow white crescent across the back of the neck. Legs and feet are bright yellow, 
               offering a distinct visual contrast against their dark slate plumage.
                Swift, direct, and powerful fliers that flush from high timber canopies with loud, clapping wingbeats, navigating mountain canyons and forest breaks at speeds exceeding forty-five miles per 
                hour. Their flight paths are arrow-straight and purposeful as they traverse between high roosting ridges and feeding benches. They produce deep, owl-like cooing, but they remain almost 
                completely silent while traveling on the wing.
                Found in mature oak, Douglas fir, and pine forests across western mountains, feeding heavily on wild acorns, elderberries, and cascara berries. Hunters set up along high mountain passes, 
                canyon saddles, or mineral springs, pass-shooting fast-crossing birds that require substantial forward leads and tight chokes. Shell limits are often strictly enforced in western states,
                making ammunition conservation and target selection vital.
"),
               
               # ----- DESCRIPTION (bullet points) -----
               tags$ul(
                 tags$li("Size: Length 33–40 cm (13–16 inches)"),
                 tags$li("Wingspan: 66–72 cm (26–28 inches)"),
                 tags$li("Weight: 225 – 450 g (0.5 – 1.0 lbs)"),
                 tags$li("Lifespan: Up to 14 years in the wild"),
                 tags$li("Diet: Granivorous and frugivorous; acorns, berries, pine seeds, and grain"),
                 tags$li("Habitat: Coniferous and deciduous mountain forests, oak woodlands, and forest edges"),
                 tags$li("Nesting season: April to September"),
                 tags$li("Conservation status:  Least Concern (Locally managed game bird)")
               ),
               
               # ----- SOUND: SPACE RESERVED -----
               h4("Call"),
               # >>> SOUND GOES HERE (audio player will replace this comment) <<<
               
               # ----- HEAT MAP: SPACE RESERVED -----
               h4("Heat map")
               # >>> HEAT MAP GOES HERE (map will replace this comment) <<<
             ),
             
             
             #Brant, Pacific
             conditionalPanel(
               condition = "input.species_pacific == 'Brant, Pacific'",
               
               #PHOTO
               img(src="", width = "400px"),
               
               #DESCRIPTION
               h4("About this species"),
               p("Distinguished from the Atlantic race by its much darker appearance, carrying an almost complete, broad white collar encircling the upper neck and a very dark, brownish-black breast and belly 
               that blends smoothly into the black neck. The back is dark slaty-brown, and the white undertail coverts form a sharp, clean contrast against the dark belly plumage.
Flocks skim intertidal sandbars and ocean estuaries in shifting, wave-like formations, displaying swift, synchronized turns as they approach feeding flats. They fly with stiff, shallow wingbeats, maintaining 
tight group spacing just above the breakers. They emit the same low, resonant, rolling guttural growl on the wing as their Atlantic cousins, creating a low murmur across coastal bays.
Dependent on tidal eelgrass flats along the Pacific rim from Alaska to Baja California. Successful hunting requires intercepting birds as rising tides float eelgrass leaves or as falling tides expose feeding 
shoals, setting up low blinds on exposed points. Hunters should place dark silhouette or floating brant decoys on exposed gravel spits, keeping profiles low to blend into the barren coastal environment.
"),
               
               # ----- DESCRIPTION (bullet points) -----
               tags$ul(
                 tags$li("Size: Length 55–66 cm (22–26 inches)"),
                 tags$li("Wingspan: 105–120 cm (41–47 inches)"),
                 tags$li("Weight: 1.2 – 1.8 kg (2.6 – 4.0 lbs)"),
                 tags$li("Lifespan: 10–15 years in the wild"),
                 tags$li("Diet: Herbivorous; intertidal eelgrass, marine algae, and salt-marsh plants"),
                 tags$li("Habitat: Coastal marine estuaries, sandbars, mudflats, and protected bays"),
                 tags$li("Nesting season: June to August (Arctic tundra)"),
                 tags$li("Conservation status: Least Concern")
               ),
               
               # ----- SOUND: SPACE RESERVED -----
               h4("Call"),
               # >>> SOUND GOES HERE (audio player will replace this comment) <<<
               
               # ----- HEAT MAP: SPACE RESERVED -----
               h4("Heat map")
               # >>> HEAT MAP GOES HERE (map will replace this comment) <<<
             ),
             
             #Cackling Goose, Aleutian
             conditionalPanel(
               condition = "input.species_pacific == 'Cackling Goose, Aleutian'",
               
               #PHOTO
               img(src="", width = "400px"),
               
               #DESCRIPTION
               h4("About this species"),
               p("This small cackling goose is recognized by a bold, wide white neck ring at the base of its black stocking neck, accentuated by a dark, chocolate-brown body and a steep, rounded forehead.
               Many individuals also display a distinct black line of feathers dividing the white cheek patches beneath the chin. Their overall frame is compact and stocky, resting on short black legs with 
               a small, triangular bill.
Displays swift, synchronized flock movements, flying in dense, shifting swarms over coastal pastures and river mouths with rapid, shallow wing beats. In the air, their maneuvers look remarkably nimble 
compared to larger geese, frequently side-slipping together on windy coastal approaches. Vocalizations are high-pitched, squeaking cackles delivered in rapid-fire succession that sound noticeably lighter and
higher than a standard honker.
A historic conservation success story, this subspecies recovered from near-extinction caused by introduced predators on its Aleutian nesting islands. Today, they winter in large concentrations along coastal Oregon
and northern California, where specialized harvest zones manage them while preventing overharvest on localized staging pastures. Hunters setting spreads over coastal ryegrass fields must confirm current regional 
quotas to remain compliant with designated harvest caps.
"),
               
               # ----- DESCRIPTION (bullet points) -----
               tags$ul(
                 tags$li("Size: Length 55–65 cm (22–26 inches)"),
                 tags$li("Wingspan: 105–115 cm (41–45 inches)"),
                 tags$li("Weight: 1.4 – 2.4 kg (3.1 – 5.3 lbs)"),
                 tags$li("Lifespan: 10–25 years in the wild (up to 40 years in captivity)"),
                 tags$li("Diet: Herbivorous; grasses, sedges, roots, berries, and agricultural grains"),
                 tags$li("Habitat: Coastal pastures, tidal flats, tundra, and agricultural fields"),
                 tags$li("Nesting season: May to July"),
                 tags$li("Conservation status: Recovered / Least Concern (Delisted from US Endangered Species Act)")
               ),
               # SOUND: SPACE RESERVED 
               h4("Call"),
               # >>> SOUND GOES HERE (audio player will replace this comment) <<<
               
               #HEAT MAP: SPACE RESERVED
               h4("Heat map")
               # >>> HEAT MAP GOES HERE (map will replace this comment) <<<
             ),
             
             
             #Cackling Goose
             conditionalPanel(
               condition = "input.species_pacific == 'Cackling Goose'",
               
               #PHOTO
               img(src="", width = "400px"),
               
               #DESCRIPTION
               h4("About this species"),
               p("Formerly classified as a small Canada goose subspecies, this distinct species is roughly the size of a large mallard, featuring a noticeably short neck, a steep forehead, and a tiny, stubby triangular
               bill. Plumage mimics the Canada goose pattern with a black neck, white cheek patches, and a brown body, though some individuals carry a faint white collar at the base of the neck. Their breast coloration 
               ranges from light gray to dark chocolate-brown depending on the subspecies.
Highly agile fliers that execute sudden banks, side-slips, and rolls into decoys with a high-tempo wingbeat cadence. Flocks move with a loose, erratic energy that allows them to dump out of the sky far more violently 
than large Canada geese. Instead of a deep honk, their vocalization is a high-pitched, squeaking cackle or yelp, which sounds more like a dog toy than a standard goose.
Winters in large concentrations in California, Texas, and the Pacific Northwest, often mixed in with larger geese in agricultural fields. Hunters must check regional regulations, as some areas enforce separate daily bag 
limits or closed zones specifically aimed at managing distinct cackler stocks. Decoy spreads should utilize specialized, smaller-bodied cackler decoys, and callers must tune their short-reed calls high to reproduce the 
squeaking cackle of incoming birds.
"),
               
               # ----- DESCRIPTION (bullet points) -----
               tags$ul(
                 tags$li("Size: Length 53–76 cm (21–30 inches)"),
                 tags$li("Wingspan: 105–115 cm (41–45 inches)"),
                 tags$li("Weight: 1.1 – 2.9 kg (2.4 – 6.4 lbs)"),
                 tags$li("Lifespan: Herbivorous; grasses, sedges, agricultural grains, and green shoots"),
                 tags$li("Diet: 10–20+ years in the wild"),
                 tags$li("Habitat: Tundra, agricultural stubble fields, pastures, and marshlands"),
                 tags$li("Nesting season: May to July"),
                 tags$li("Conservation status: Least Concern")
               ),
               # SOUND: SPACE RESERVED 
               h4("Call"),
               # >>> SOUND GOES HERE (audio player will replace this comment) <<<
               
               #HEAT MAP: SPACE RESERVED
               h4("Heat map")
               # >>> HEAT MAP GOES HERE (map will replace this comment) <<<
             ),
             
             
             #Canada Goose, Dusky
             conditionalPanel(
               condition = "input.species_pacific == 'Canada Goose, Dusky'",
               
               #PHOTO
               img(src="", width = "400px"),
               
               #DESCRIPTION
               h4("About this species"),
               p("A large, familiar wild goose featuring a gray-brown body, a long black stocking neck, an all-black head, and a wide white cheek patch extending beneath the chin. The bill and legs are black, and the
               tail is dark, framed by a clean white U-shaped rump patch. Size varies across subspecies, but true Canada geese are substantial, heavy-bodied birds with broad wing spans and prominent chest structures.
Flocks travel in disciplined, iconic V-formations or long, undulating lines, driven by powerful, rhythmic wingbeats. When approaching fields, they circle deliberately, locking their wide wings and backpedaling firmly 
into the wind on final descent. They are intensely vocal on the wing, communicating across long distances with deep, resonant, two-syllable honks, where the higher pitched note is given by the female and the lower note by the male.
The cornerstone of field and water goose hunting across North America, feeding heavily in harvested corn, wheat, barley, and pasture fields. Fooled using realistic full-body decoy spreads, disciplined calling routines, and layout 
or A-frame blinds that conceal hunters from overhead scrutiny. Flagging is essential for grabbing the attention of distant migrating flights, but flags should be rested once birds turn and commit to the final approach.
"),
               
               # ----- DESCRIPTION (bullet points) -----
               tags$ul(
                 tags$li("Size: Length 75–110 cm (30–43 inches)"),
                 tags$li("Wingspan: 127–185 cm (50–73 inches)"),
                 tags$li("Weight: 2.4 – 6.5 kg (5.3 – 14.3 lbs)"),
                 tags$li("Lifespan: 10–24 years in the wild (record over 30 years)"),
                 tags$li("Diet: Herbivorous; grasses, grains, roots, and aquatic plants"),
                 tags$li("Habitat: Lakes, rivers, agricultural fields, city parks, and wetlands"),
                 tags$li("Nesting season: April to June"),
                 tags$li("Conservation status: Least Concern")
               ),
               # SOUND: SPACE RESERVED 
               h4("Call"),
               # >>> SOUND GOES HERE (audio player will replace this comment) <<<
               
               #HEAT MAP: SPACE RESERVED
               h4("Heat map")
               # >>> HEAT MAP GOES HERE (map will replace this comment) <<<
             ),
             
             
             #Canada Goose, Lesser
             conditionalPanel(
               condition = "input.species_pacific == 'Canada Goose, Lesser'",
               
               #PHOTO
               img(src="", width = "400px"),
               
               #DESCRIPTION
               h4("About this species"),
               p("A proportional, intermediate-sized Canada goose showing identical plumage patterns to Western Canadas, but built on a 
               smaller frame with a shorter neck and a more compact bill. Body mass typically falls between five and seven pounds, resting 
               squarely between large honkers and smaller cackling geese. Their plumage exhibits clean white cheek patches, a dark stocking 
               neck, and light brownish-gray body feathering.
Flocks fly in fast, agile formations that shift altitude rapidly in crosswinds, beating their wings with a noticeable increase in cadence 
compared to giant Canadas. Their honks are distinctly higher-pitched and faster than the booming notes of larger races, sounding energetic 
and urgent. When approaching fields, they tend to drop in large, swirling groups rather than small, orderly pairs.
Abundant across the Central, Mississippi, and Pacific flyways, migrating in massive waves ahead of winter freezes to feed in grain stubble. 
They respond well to fast-paced short-reed calling and aggressive decoy flagging, often dumping into field spreads in large, chaotic packs. 
Hunters set out medium-sized full-body spreads mixed with windsocks to provide the volume needed to stop passing flocks.
"),
               
               # ----- DESCRIPTION (bullet points) -----
               tags$ul(
                 tags$li("Size: Length 60–75 cm (24–30 inches)"),
                 tags$li("Wingspan: 120–135 cm (47–53 inches)"),
                 tags$li("Weight:  2.0 – 3.5 kg (4.4 – 7.7 lbs)"),
                 tags$li("Lifespan: 10–20 years in the wild"),
                 tags$li("Diet: Herbivorous; grasses, agricultural grains, clover, and green shoots"),
                 tags$li("Habitat: Tundra, agricultural fields, river valleys, and wetlands"),
                 tags$li("Nesting season: May to July"),
                 tags$li("Conservation status: Least Concern")
               ),
               # SOUND: SPACE RESERVED 
               h4("Call"),
               # >>> SOUND GOES HERE (audio player will replace this comment) <<<
               
               #HEAT MAP: SPACE RESERVED
               h4("Heat map")
               # >>> HEAT MAP GOES HERE (map will replace this comment) <<<
             ),
             
             
             
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
             
             #American Black Duck
             conditionalPanel(
               condition = "input.species_central == 'American Black Duck'",
               
               #PHOTO
               img(src = "american_black_duck_female.jpg, american_black_duck_male.jpg", width = "400px"),
               
               #DESCRIPTION
               h4("About this species"),
               p("A plump, rounded waterbird with slate-gray to dark charcoal body plumage, a black head and neck, dark red eyes, and large, greenish-gray feet equipped with broad, 
               flattened swimming lobes instead of webbing. Its bill is stark white with a tiny brown spot near the tip and a small brown frontal callus on the forehead. The tail is
               short and carried low while swimming, often giving the bird a rounded, chicken-like profile on open water. To become airborne, they require long, pattering runs across
               open water while furiously beating their short, rounded wings. In flight, they show a thin, whitish trailing edge on the secondaries and fly with rapid, labored wing 
               strokes, dragging their large feet behind their tail. They vocalize with sharp, metallic croaks and grunts, frequently chattering when gathered in large rafts. Often
               rafts in thousands on open lakes and coastal bays, feeding on submerged vegetation alongside diving ducks. They are readily distinguished from game ducks by their 
               chicken-like head-bobbing swimming motion and chalk-white bills, making early-morning identification simple. While many waterfowlers overlook them, they are traditionally 
               pursued in southern marshes for use in hearty stews and gumbos."),
               
               # ----- DESCRIPTION (bullet points) -----
               tags$ul(
                 tags$li("Size: "),
                 tags$li("Wingspan: "),
                 tags$li("Weight: "),
                 tags$li("Lifespan: "),
                 tags$li("Diet: "),
                 tags$li("Habitat: "),
                 tags$li("Nesting season: "),
                 tags$li("Conservation status: ")
               ),
               
               # ----- SOUND: SPACE RESERVED -----
               h4("Call"),
               # >>> SOUND GOES HERE (audio player will replace this comment) <<<
               
               # ----- HEAT MAP: SPACE RESERVED -----
               h4("Heat map")
               # >>> HEAT MAP GOES HERE (map will replace this comment) <<<
             ),
             
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



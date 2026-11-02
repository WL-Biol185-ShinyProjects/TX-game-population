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
                                     "Mourning Dove", "Ross Goose", "Sandhill Crane", "Snow and Blue Goose", "Sora",
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
             
             
             #Canada Goose, Western
             conditionalPanel(
               condition = "input.species_pacific == 'Canada Goose, Western'",
               
               #PHOTO
               img(src="", width = "400px"),
               
               #DESCRIPTION
               h4("About this species"),
               p("Among the largest recognized subspecies of Canada goose, often weighing ten to fourteen pounds, characterized by a massive
               bill, exceptionally long neck, and pale grayish-brown flanks. The plumage displays the classic white cheek patches and jet-black 
               neck, but the overall coloration is noticeably lighter and washed-out compared to coastal races. Their large footprint and 
               heavy wing structure give them a commanding appearance on field spreads.
Flocks maintain slow, measured, and deliberate wing strokes, projecting immense power as they glide on cupped wings across western valleys and rivers. 
Their flight lines are steady and structured, rarely making the sudden erratic turns seen in smaller goose races. They voice deep, authoritative, 
booming honks that carry across wide agricultural basins, demanding respect from other approaching flocks.
A staple of western agricultural regions and major river systems, feeding in alfalfa, wheat, and corn stubble. Because of their large size and cautious 
nature, hunters rely on oversized full-body decoys, realistic flagging to grab attention at a distance, and deep, resonant short-reed calling to finish 
them within range. Laying out on field edges with dialed-in camouflage is critical, as these mature honkers will circle repeatedly to inspect blind layouts.
"),
               
               # ----- DESCRIPTION (bullet points) -----
               tags$ul(
                 tags$li("Size: Length 90–110 cm (35–43 inches)"),
                 tags$li("Wingspan: 160–185 cm (63–73 inches)"),
                 tags$li("Weight: 3.6 – 6.5 kg (8 – 14.3 lbs)"),
                 tags$li("Lifespan: 10–25 years in the wild"),
                 tags$li("Diet: Herbivorous; agricultural grains, grasses, alfalfa, and clover"),
                 tags$li("Habitat: River valleys, agricultural fields, lakes, wetlands, and suburban turf"),
                 tags$li("Nesting season: March to May"),
                 tags$li("Conservation status: Least Concern")
               ),
               # SOUND: SPACE RESERVED 
               h4("Call"),
               # >>> SOUND GOES HERE (audio player will replace this comment) <<<
               
               #HEAT MAP: SPACE RESERVED
               h4("Heat map")
               # >>> HEAT MAP GOES HERE (map will replace this comment) <<<
             ),
             
             
             #Common Gallinule
             conditionalPanel(
               condition = "input.species_pacific == 'Common Gallinule'",
               
               #PHOTO
               img(src="", width = "400px"),
               
               #DESCRIPTION
               h4("About this species"),
               p("A chicken-like wetland bird featuring dark charcoal-gray body plumage, white streaks along the flanks, white undertail coverts, and an unwebbed
               foot equipped with exceptionally long, slender green toes. It is instantly separated from the American Coot by its bright red frontal shield on the 
               forehead and a matching red bill tipped with yellow. The body is laterally compressed, allowing it to walk through dense reeds without bending stems.
Prefers swimming or walking over floating vegetation, taking to the air only when pressed by running across the water surface with rapid, shallow wing flutters. 
Once airborne, flight is labored and short, with long green legs dangling awkwardly behind the tail before the bird drops back into the weeds. They produce loud,
laughing squawks and clucks from within dense cattail cover.
Inhabits shallow freshwater marshes, swamps, and rice impoundments choked with lily pads and cattails. Harvested primarily on opportunistic passes during rail and
snipe hunts, using the bright red frontal shield to distinguish them from coots and waterhens. Poling small skiffs through emergent marsh vegetation during flood 
tides provides the most reliable way to flush these secretive birds.
"),
               
               # DESCRIPTION (bullet points)
               tags$ul(
                 tags$li("Size: Length 30–38 cm (12–15 inches)"),
                 tags$li("Wingspan: 50–60 cm (20–24 inches)"),
                 tags$li("Weight: 220 – 490 g (0.5 – 1.1 lbs)"),
                 tags$li("Lifespan: 6–8 years in the wild"),
                 tags$li("Diet: Omnivorous; seeds, leaves, aquatic insects, snails, and small fish"),
                 tags$li("Habitat: Freshwater marshes, swamps, overgrown ponds, and flooded rice fields"),
                 tags$li("Nesting season: April to August"),
                 tags$li("Conservation status: Least Concern")
               ),
               # SOUND: SPACE RESERVED 
               h4("Call"),
               # >>> SOUND GOES HERE (audio player will replace this comment) <<<
               
               #HEAT MAP: SPACE RESERVED
               h4("Heat map")
               # >>> HEAT MAP GOES HERE (map will replace this comment) <<<
             ),
             
             
             #Emperor Goose
             conditionalPanel(
               condition = "input.species_pacific == 'Emperor Goose'",
               
               #PHOTO
               img(src="", width = "400px"),
               
               #DESCRIPTION
               h4("About this species"),
               p("A stocky, compact goose featuring dense silvery-blue plumage scalloped with black and white edges, a snow-white head and hindneck, a black 
               throat, a small pinkish bill, and bright yellow-orange legs. Both sexes share identical plumage characteristics year-round, displaying a thick, 
               well-insulated body built for harsh maritime climates. The contrast between the pure white head and black throat makes them instantly recognizable 
               on coastal flats.
Low-level fliers that cruise along wave-washed rocky beaches, coastal shoals, and tidal mudflats, beating their wings with rapid, stiff strokes. Their flight 
pattern is heavy and direct, keeping them low to the water as they navigate between rocky feeding points. They vocalize with sharp, rolling, metallic calls, 
which sound noticeably harsher than the calls of other northern geese.
Restricted to the maritime fringes of coastal Alaska and the Bering Sea, feeding on intertidal seaweeds and eelgrass. Legal hunting is strictly regulated 
through a limited-entry drawing permit system for Alaska residents and subsistence hunters, with the season closing immediately when harvest quotas are 
reached. Outside of Alaska, they are fully protected, making them a rare, highly specialized game bird tied strictly to subarctic shores.
"),
               
               # DESCRIPTION (bullet points)
               tags$ul(
                 tags$li("Size:  Length 65–75 cm (26–30 inches)"),
                 tags$li("Wingspan: 115–125 cm (45–49 inches)"),
                 tags$li("Weight: 2.2 – 3.2 kg (4.8 – 7.1 lbs)"),
                 tags$li("Lifespan: 10–15 years in the wild"),
                 tags$li("Diet: Herbivorous; intertidal eelgrass, algae, salt-marsh grasses, and mollusks"),
                 tags$li("Habitat: Arctic coastal beaches, rocky marine shores, and tidal flats"),
                 tags$li("Nesting season: June to August"),
                 tags$li("Conservation status: Near Threatened (Protected across most of its range)")
               ),
               # SOUND: SPACE RESERVED 
               h4("Call"),
               # >>> SOUND GOES HERE (audio player will replace this comment) <<<
               
               #HEAT MAP: SPACE RESERVED
               h4("Heat map")
               # >>> HEAT MAP GOES HERE (map will replace this comment) <<<
             ),
             
             
             #Mourning Dove
             conditionalPanel(
               condition = "input.species_pacific == 'Mourning Dove'",
               
               #PHOTO
               img(src="", width = "400px"),
               
               #DESCRIPTION
               h4("About this species"),
               p("A slender, streamlined upland game bird with soft brownish-gray body plumage, black spots on the wing coverts, a pinkish-buff wash on the breast, 
               and a long, sharply pointed tail bordered by white outer feathers. Both sexes share similar plumage, though males exhibit an iridescent pinkish-rose 
               wash on the sides of the neck. The legs are small and coral-pink, and the bill is slender and dark.
Extremely fast and acrobatic fliers that regularly reach fifty-five miles per hour, producing a sharp whistling sound with their wings during takeoff. In flight, they 
execute sudden, erratic barrel rolls, dives, and flares that challenge gunners. On the ground, males sound a familiar, mournful five-note coo sound
though they remain silent during rapid pass-shooting flights.
The traditional opening-day quarry across North American agricultural fields, hunted over harvested sunflowers, millet, wheat stubble, and evening watering holes. 
Their small profile and erratic flight require fast swing speeds and open chokes like improved cylinder or skeet firing light target loads of #7.5 or #8 shot. Stationary
motorized decoys with spinning wings mounted on stakes are exceptionally effective at drawing passing doves into close range.
"),
               
               # DESCRIPTION (bullet points)
               tags$ul(
                 tags$li("Size: Length 22–31 cm (9–12 inches)"),
                 tags$li("Wingspan: 37–45 cm (15–18 inches)"),
                 tags$li("Weight: 96 – 170 g (3.4 – 6.0 oz)"),
                 tags$li("Lifespan: 1.5 years average in wild (max recorded over 19 years)"),
                 tags$li("Diet: Granivorous; agricultural grains, weed seeds, and occasional insects"),
                 tags$li("Habitat: Open country, agricultural fields, prairies, woodland edges, and suburban areas"),
                 tags$li("Nesting season: March to October"),
                 tags$li("Conservation status: Least Concern (Abundant game bird)")
               ),
               # SOUND: SPACE RESERVED 
               h4("Call"),
               # >>> SOUND GOES HERE (audio player will replace this comment) <<<
               
               #HEAT MAP: SPACE RESERVED
               h4("Heat map")
               # >>> HEAT MAP GOES HERE (map will replace this comment) <<<
             ),
             
             
             #Ross's Goose
             conditionalPanel(
               condition = "input.species_pacific == 'Ross Goose'",
               
               #PHOTO
               img(src="", width = "400px"),
               
               #DESCRIPTION
               h4("About this species"),
               p("Resembles a miniature white-phase Snow Goose, measuring only slightly larger than a mallard, with pure white plumage and black primary wingtips. It is separated 
                 from the Snow Goose by its short, stubby, triangular pink bill that completely lacks a black grinning patch, meeting the face in a straight, vertical line often 
                 covered in blueish-gray warty caruncles. Blue-morph Ross's geese exist but are exceptionally rare across all flyways. Highly agile fliers that use rapid, choppy 
                 wing strokes, executing remarkable aerial slips and barrel rolls into decoys among larger mixed flocks. Their wing cadence is faster than that of snow geese, 
                 allowing them to shift positions rapidly within large swirling flocks. Their call is a distinct, high-pitched squeak or grunt sounding like \"keek\" or \"kug\", 
                 which is higher and weaker than a snow goose bark. Migrates alongside snow geese through the Central and Pacific flyways, feeding on grain and short green grasses 
                 in agricultural basins. Hunters targeting light geese identify them in hand by the short bill length, lack of a smiling patch, and small body frame. During spring 
                 conservation orders, they are harvested alongside snow geese over large electronic caller spreads, decoying cleanly to realistic windsock layouts."),
               
               # DESCRIPTION (bullet points)
               tags$ul(
                 tags$li("Size: Length 53–66 cm (21–26 inches)"),
                 tags$li("Wingspan: 113–125 cm (44–49 inches)"),
                 tags$li("Weight: 1.2 – 1.8 kg (2.6 – 4.0 lbs)"),
                 tags$li("Lifespan: 8–15 years in the wild"),
                 tags$li("Diet: Herbivorous; grasses, sedges, roots, and agricultural grains"),
                 tags$li("Habitat: Arctic tundra, agricultural fields, wet meadows, and marshes"),
                 tags$li("Nesting season: June to July"),
                 tags$li("Conservation status: Least Concern (Population thriving)")
               ),
               # SOUND: SPACE RESERVED 
               h4("Call"),
               # >>> SOUND GOES HERE (audio player will replace this comment) <<<
               
               #HEAT MAP: SPACE RESERVED
               h4("Heat map")
               # >>> HEAT MAP GOES HERE (map will replace this comment) <<<
             ),
             
             
             #Sandhill Crane
             conditionalPanel(
               condition = "input.species_pacific == 'Sandhill Crane'",
               
               #PHOTO
               img(src="", width = "400px"),
               
               #DESCRIPTION
               h4("About this species"),
               p("A tall, long-legged wetland and upland game bird featuring ash-gray body plumage often stained reddish-brown from iron-rich marsh
                 mud, a bushy bustle over the tail, a long, spear-like bill, and a bare patch of crimson skin across the crown. Immature birds lack the
                 red crown and display pale buff-brown heads and necks. Standing over four feet tall, their imposing ground profile cannot be confused 
                 with any other North American quarry. Flocks cruise at high altitudes in long lines or V-formations, flying with their long necks fully 
                 extended forward and their long legs trailing straight out behind. Their wingbeat is distinctive, featuring a brisk, energetic upstroke 
                 that looks flicked upward rather than stroked downward. Flocks communicate with rolling, rattling, trumpet-like bugles that carry across 
                 multiple miles of open agricultural country. Revered as the \"ribeye of the sky\" for phenomenal meat quality that resembles prime beef 
                 tenderloin. They possess exceptional eyesight and feed in open grain fields, requiring dedicated full-body crane decoys, absolute 
                 camouflage in A-frame or layout blinds, and careful shooting at vitals. Hunters must hide blinds along natural fence lines or ditch banks, 
                 as cranes will skirt any abnormal structure placed in open stubble fields."),
               
               # DESCRIPTION (bullet points)
               tags$ul(
                 tags$li("Size: Height 80–120 cm (31–47 inches); Length 85–100 cm (33–39 inches)"),
                 tags$li("Wingspan: 165–230 cm (65–91 inches)"),
                 tags$li("Weight: 3.0 – 5.5 kg (6.6 – 12.1 lbs)"),
                 tags$li("Lifespan: 15–20 years in the wild (can exceed 20–30 years)"),
                 tags$li("Diet: Omnivorous; grains, seeds, berries, insects, small rodents, frogs, and reptiles"),
                 tags$li("Habitat: Freshwater marshes, wet meadows, bogs, and agricultural crop fields"),
                 tags$li("Nesting season: April to July"),
                 tags$li("Conservation status: Least Concern (Stable or increasing populations)")
               ),
               # SOUND: SPACE RESERVED 
               h4("Call"),
               # >>> SOUND GOES HERE (audio player will replace this comment) <<<
               
               #HEAT MAP: SPACE RESERVED
               h4("Heat map")
               # >>> HEAT MAP GOES HERE (map will replace this comment) <<<
             ),
             
             
             #Snow and Blue Goose
             conditionalPanel(
               condition = "input.species_pacific == 'Snow and Blue Goose'",
               
               #PHOTO
               img(src="", width = "400px"),
               
               #DESCRIPTION
               h4("About this species"),
               p("A dimorphic species occurring in two distinct color phases: the Snow morph is pure white with jet-black primary wingtips, while the Blue morph features a slate-gray 
               body, dark wings, and a contrasting snow-white head and neck. Both phases possess a heavy, pink bill equipped with a prominent black grinning patch along the cutting edge
               that is visible at close range. Intermediates showing varied white and slate body patches are also common in field spreads.
Travels in massive flocks comprising thousands of birds, forming towering, swirling tornadoes that drop from tremendous altitudes toward feeding grounds. Their flight is loud, chaotic,
and continuous, with birds constantly shifting positions as they circle downward. Flocks generate a deafening wall of sound consisting of high-pitched, barking yelps, screams, and 
single-syllable squawks.
Overabundant populations that damage subarctic breeding tundra have led to liberal Spring Conservation Orders featuring electronic callers, unplugged shotguns, and no bag limits. 
Success requires massive spreads of 500 to 2,000+ windsock or rotary decoys placed in agricultural fields along migration corridors. Scouting roosts and setting up on hot feeding fields 
under overcast, windy conditions yields the highest success rates.
"),
               
               # DESCRIPTION (bullet points)
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
               # SOUND: SPACE RESERVED 
               h4("Call"),
               # >>> SOUND GOES HERE (audio player will replace this comment) <<<
               
               #HEAT MAP: SPACE RESERVED
               h4("Heat map")
               # >>> HEAT MAP GOES HERE (map will replace this comment) <<<
             ),
             
             
             #Sora
             conditionalPanel(
               condition = "input.species_pacific == 'Sora'",
               
               #PHOTO
               img(src="", width = "400px"),
               
               #DESCRIPTION
               h4("About this species"),
               p("A compact, rounded marsh bird with a stubby, chicken-like bright yellow bill, an olive-brown back streaked with white 
                 lines, a slate-gray breast, and a black mask running from the bill across the face and throat. The short tail is frequently
                 cocked, showing clean white undertail coverts. Their legs are yellowish-green and equipped with long, unwebbed toes designed 
                 for walking across floating marsh grasses. Flushes only under direct pressure, rising from the emergent cover with a weak, 
                 fluttering flight pattern, dangling its yellowish-green legs before collapsing back into the vegetation after a short glide. 
                 Their flights rarely cover more than twenty or thirty yards, keeping them low to the marsh grass. Highly vocal in the marsh, 
                 producing a sharp 'keek' alarm note and a distinctive, high-pitched descending whinny. Pursued alongside Virginia Rails during 
                 early autumn flood-tide stages in wild rice marshes and coastal cordgrass flats. Because their flight is brief and erratic,
                 hunters must be ready to shoulder and shoot instantly with open-choked shotguns before the bird disappears back into the marsh 
                 canopy. Pushing flat-bottom rail skiffs through flooded marsh grass with long poles is the traditional and most effective method of harvest."),
               
               # DESCRIPTION (bullet points)
               tags$ul(
                 tags$li("Size: Length 20–25 cm (8–10 inches)"),
                 tags$li("Wingspan: 32–38 cm (13–15 inches)"),
                 tags$li("Weight: 48 – 112 g (1.7 – 4.0 oz)"),
                 tags$li("Lifespan: 3–5 years in the wild"),
                 tags$li("Diet: Omnivorous; seeds of marsh plants, aquatic insects, snails, and small crustaceans"),
                 tags$li("Habitat: Freshwater marshes, wetlands, flooded meadows, and rice paddies"),
                 tags$li("Nesting season: May to August"),
                 tags$li("Conservation status: Least Concern")
               ),
               # SOUND: SPACE RESERVED 
               h4("Call"),
               # >>> SOUND GOES HERE (audio player will replace this comment) <<<
               
               #HEAT MAP: SPACE RESERVED
               h4("Heat map")
               # >>> HEAT MAP GOES HERE (map will replace this comment) <<<
             ),
             
             
             #Trumpeter Swan
             conditionalPanel(
               condition = "input.species_pacific == 'Trumpeter Swan'",
               
               #PHOTO
               img(src="", width = "400px"),
               
               #DESCRIPTION
               h4("About this species"),
               p("North America's largest native waterfowl, weighing twenty to thirty pounds with wingspans reaching eight feet, covered entirely in pure white
  plumage. The all-black bill is long and massive, forming an unbroken, straight V-profile running from the bill tip directly into the eye and
  forehead without any notched indentation, and lacking any yellow facial markings. Immature birds are dusky gray with pinkish tones centered on
  their black-edged bills."),
               p("Majestic in flight, beating its massive wings with slow, deep, resonant power that carries long flight lines across northern waterways. Their
  long necks are held completely straight in flight, balanced by heavy, dark feet tucked under the tail. Their call is a loud, resonant,
  low-pitched brassy bugle sounding like 'ko-hoh', resembling the sound of an orchestral trumpet across the marsh."),
               p("Protected throughout almost all of its continental range following long-term restoration efforts. In states that offer legal Tundra Swan
  hunting, waterfowlers must confirm the bill profile, facial skin boundary, and vocal pitch to avoid shooting a protected Trumpeter Swan.
  Carrying quality optics to verify the straight V-line of the bill and listening for the low brassy horn call prevents accidental illegal
  harvest."),
               
               # DESCRIPTION (bullet points)
               tags$ul(
                 tags$li("Size: Length 138–180 cm (54–71 inches)"),
                 tags$li("Wingspan: 185–210 cm (73–83 inches) to over 240 cm (94 inches)"),
                 tags$li("Weight: 9.0 – 13.6 kg (20 – 30 lbs)"),
                 tags$li("Lifespan: 12–20 years in the wild (can exceed 24–30 years)"),
                 tags$li("Diet: Herbivorous; submerged aquatic vegetation, roots, tubers, and grasses"),
                 tags$li("Habitat: Large shallow lakes, ponds, slow rivers, and coastal wetlands"),
                 tags$li("Nesting season: April to June"),
                 tags$li("Conservation status: Least Concern / Recovered (Strictly protected or regulated)")
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
               div(style = "display: flex; gap: 20px;",
                   tags$figure(
                     img(src="american_black_duck_male.jpg", width = "400px", height = "300px"),
                     tags$figcaption("Male")
                   ),
                   tags$figure(
                     img(src="american_black_duck_female.jpg", width = "400px", height = "300px"),
                     tags$figcaption("Female")
                   )
               ),
               
               #DESCRIPTION
               h4("About this species"),
               p("A heavy-bodied, dark dabbler that closely matches the mallard's structural footprint, sporting soot-brown body plumage that contrasts sharply with a pale grayish-buff head and neck. In flight, the species shows brilliant, silvery-white underwings that flash against the dark body, and a deep violet-purple speculum that lacks the white border bars found on mallards, though it occasionally carries a faint black trailing edge. Drakes carry bright olive-yellow bills, while hens display duller greenish-olive bills mottled with dusky flecks.

  Highly athletic, they burst nearly straight up off salt-marsh tidal creeks and blackwater sloughs with powerful, whistling wing strokes. Their flight silhouette is identical to the mallard, but the stark contrast between the bright silver underwing lining and dark body provides instant long-range identification. The hen's vocalization is a loud, ringing quack virtually indistinguishable from a hen mallard, while the drake provides a low, reedy groan.

  Widely considered the wariest duck in eastern marshes, they circle high outside spreads for multiple passes, requiring complete blind concealment, low-profile hides, and zero calling once they begin their final swing. Decoys must be kept entirely free of frost, mud, and unnatural shine, as these birds flare at the slightest visual irregularity. Because of localized population pressures and restrictive single-bird or two-bird bag limits across the Atlantic and Mississippi flyways, careful aerial differentiation from mottled ducks and hen mallards is critical."),
               
               # DESCRIPTION (bullet points)
               tags$ul(
                 tags$li("Size: Length 53–61 cm (21–24 inches)"),
                 tags$li("Wingspan: 88–95 cm (35–37 inches)"),
                 tags$li("Weight: 720 – 1,640 g (1.6 – 3.6 lbs)"),
                 tags$li("Lifespan: 5–10 years in the wild"),
                 tags$li("Diet: Omnivorous; aquatic plants, seeds, grains, insects, mollusks, and crustaceans"),
                 tags$li("Habitat: Salt marshes, beaver ponds, forested wetlands, and coastal estuaries"),
                 tags$li("Nesting season: April to June"),
                 tags$li("Conservation status: Least Concern (Population monitored closely due to hunting and habitat loss)")
               ),
               # SOUND: SPACE RESERVED 
               h4("Call"),
               # >>> SOUND GOES HERE (audio player will replace this comment) <<<
               
               #HEAT MAP: SPACE RESERVED
               h4("Heat map")
               # >>> HEAT MAP GOES HERE (map will replace this comment) <<<
             ),
             
             #American Green-winged Teal
             conditionalPanel(
               condition = "input.species_central == 'American Green-winged Teal'",
               
               #PHOTO
               div(style = "display: flex; gap: 20px;",
                   tags$figure(
                     img(src="american_green_winged_teal_male.jpg", width = "400px", height = "300px"),
                     tags$figcaption("Male")
                   ),
                   tags$figure(
                     img(src="american_green_winged_teal_female.jpg", width = "400px", height = "300px"),
                     tags$figcaption("Female")
                   )
               ),
               
               #DESCRIPTION
               h4("About this species"),
               p("North America's smallest dabbling duck, drakes sport a rich chestnut-red head with a broad, iridescent emerald-green eye stripe, a vertical white crescent on the shoulder, and a creamy, buff-colored patch beneath the tail. The speculum on both sexes is a vivid, shimmering green bordered by buffy-tan bars, set against an overall dark, compact wing. Hens are cryptically mottled brown with small, dark bills and pale bellies.

  Flocks fly at breakneck speeds just inches above the water or marsh grass, executing breathtaking, synchronized twists, dives, and banks like a flock of sandpipers. They drop suddenly into decoy spreads without warning, pitching straight downward with wings cupped. Drakes produce a high-pitched, cricket-like bell whistle transcribed as \"krick-et\" or \"peep\", while hens deliver brief, rapid, high-pitched quacks.

  Extremely hardy early-and-late migrants that favor very shallow water, muddy edges, and ankle-deep sheetwater in flooded agricultural fields. Because their diminutive size makes them appear further away than they actually are, hunters should use open chokes such as improved cylinder or light modified paired with smaller shot sizes like #5 or #6 steel. Decoy spreads can be kept compact, and simple teal whistling calls are often enough to draw circling flocks into gun range."),
               
               # DESCRIPTION (bullet points)
               tags$ul(
                 tags$li("Size: Length 31–38 cm (12–15 inches)"),
                 tags$li("Wingspan: 58–64 cm (23–25 inches)"),
                 tags$li("Weight: 140 – 500 g (0.3 – 1.1 lbs)"),
                 tags$li("Lifespan: 5–10 years in the wild"),
                 tags$li("Diet: Herbivorous and insectivorous; seeds, aquatic plants, and aquatic insects"),
                 tags$li("Habitat: Shallow marshes, flooded agricultural fields, ponds, and mudflats"),
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
             
             #American Wigeon
             conditionalPanel(
               condition = "input.species_central == 'American Wigeon'",
               
               #PHOTO
               div(style = "display: flex; gap: 20px;",
                   tags$figure(
                     img(src="american_wigeon_male.jpg", width = "400px", height = "300px"),
                     tags$figcaption("Male")
                   ),
                   tags$figure(
                     img(src="american_wigeon_female.jpg", width = "400px", height = "300px"),
                     tags$figcaption("Female")
                   )
               ),
               
               #DESCRIPTION
               h4("About this species"),
               p("Known as the \"baldpate,\" the breeding drake features a striking white crown stripe, an iridescent dark green patch extending back from the eye, a short blue-gray bill with a black tip, and pinkish-brown flanks. In flight, both sexes show a bright white belly that contrasts sharply with a dark chest, and mature drakes show massive, snow-white forewing shoulder patches visible at great distances. Hens are warm grayish-brown with contrasting white bellies and duller gray forewing coverts.

  Flocks fly in rapid, erratic bunches that bank, pivot, and weave tightly like shorebirds, often dipping low over the marsh before climbing steeply. Their wing cadence is quick and nervous, creating a distinct visual flutter when approaching water. The flight is constantly vocal: drakes produce a distinct, breathy three-note whistle sounding like \"whee-whee-whoo\" with the accent on the middle note, while hens give a low, growling \"qurrr\".

  Aggressive feeders nicknamed \"poachers\" for stealing submerged aquatic grasses from diving canvasbacks and coots in open water. They decoy readily to dedicated wigeon whistles and large spreads placed over shallow, grassy flats, but their erratic aerial maneuvers require disciplined lead and follow-through. Placing confidence coot decoys or canvasback blocks alongside a dabbler rig is a proven way to draw wary baldpates into the pocket."),
               
               # DESCRIPTION (bullet points)
               tags$ul(
                 tags$li("Size: Length 42–56 cm (17–22 inches)"),
                 tags$li("Wingspan: 76–91 cm (30–36 inches)"),
                 tags$li("Weight: 540 – 1,330 g (1.2 – 2.9 lbs)"),
                 tags$li("Lifespan: 6–10 years in the wild"),
                 tags$li("Diet: Herbivorous; aquatic plants, algae, grasses, and agricultural crops"),
                 tags$li("Habitat: Freshwater marshes, lakes, agricultural fields, and coastal bays"),
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
             
             #Black-bellied Whistling Duck
             conditionalPanel(
               condition = "input.species_central == 'Black-bellied Whistling Duck'",
               
               #PHOTO
               tags$figure(
                 img(src="black_bellied_whistling_duck_monomorphic.jpg", width = "400px", height = "300px"),
                 tags$figcaption("Monomorphic")
               ),
               
               #DESCRIPTION
               h4("About this species"),
               p("A tall, long-legged waterfowl with an upright, goose-like posture, featuring a bright coral-pink to orange-red bill, a rich chestnut breast and back, a dark brown cap, and a stark black belly. In flight, the upper wings display an unmistakable, massive white band running the entire length of the wing coverts, contrasting against black primary and secondary flight feathers. Sexes are visually identical in plumage and bare-part coloration throughout the entire season.

  Flocks fly with slow, buoyant, shallow wing strokes, trailing their long pink legs noticeably past their short tails. Their flight posture appears somewhat hunched, with broad, rounded wings providing significant lift in heavy air. They are intensely vocal in flight, filling the air with continuous, high-pitched, multi-note whistling calls transcribed as \"pe-che-che-ne\", which makes approaching flocks audible long before they appear through the blind grass.

  Expanding steadily northward through southern agricultural landscapes, flooded rice impoundments, and stock ponds. They fly in large, noisy groups that commit eagerly to stationary puddle duck spreads without calling, often perching readily on blind frames, dead timber, or fence lines. Their meat is highly regarded for table use, featuring a mild, sweet flavor comparable to prime field-fed dabblers."),
               
               # DESCRIPTION (bullet points)
               tags$ul(
                 tags$li("Size: Length 47–54 cm (19–21 inches)"),
                 tags$li("Wingspan: 89–94 cm (35–37 inches)"),
                 tags$li("Weight: 650 – 1,020 g (1.4 – 2.2 lbs)"),
                 tags$li("Lifespan: Up to 10+ years in the wild"),
                 tags$li("Diet: Omnivorous; seeds, grains, aquatic vegetation, and insects"),
                 tags$li("Habitat: Shallow freshwater ponds, flooded agricultural fields, wooded swamps, and rice paddies"),
                 tags$li("Nesting season: April to August"),
                 tags$li("Conservation status: Least Concern")
               ),
               # SOUND: SPACE RESERVED 
               h4("Call"),
               # >>> SOUND GOES HERE (audio player will replace this comment) <<<
               
               #HEAT MAP: SPACE RESERVED
               h4("Heat map")
               # >>> HEAT MAP GOES HERE (map will replace this comment) <<<
             ),
             
             #Canada Goose
             conditionalPanel(
               condition = "input.species_central == 'Canada Goose'",
               
               #PHOTO
               tags$figure(
                 img(src="canada_goose_monomorphic.jpg", width = "400px", height = "300px"),
                 tags$figcaption("Monomorphic")
               ),
               
               #DESCRIPTION
               h4("About this species"),
               p("A large, familiar wild goose featuring a gray-brown body, a long black stocking neck, an all-black head, and a wide white cheek patch extending beneath the chin. The bill and legs are black, and the tail is dark, framed by a clean white U-shaped rump patch. Size varies across subspecies, but true Canada geese are substantial, heavy-bodied birds with broad wing spans and prominent chest structures."),
               p("Flocks travel in disciplined, iconic V-formations or long, undulating lines, driven by powerful, rhythmic wingbeats. When approaching fields, they circle deliberately, locking their wide wings and backpedaling firmly into the wind on final descent. They are intensely vocal on the wing, communicating across long distances with deep, resonant, two-syllable honks sounding like \"ah-honk\", where the higher pitched note is given by the female and the lower note by the male."),
               p("The cornerstone of field and water goose hunting across North America, feeding heavily in harvested corn, wheat, barley, and pasture fields. Fooled using realistic full-body decoy spreads, disciplined calling routines, and layout or A-frame blinds that conceal hunters from overhead scrutiny. Flagging is essential for grabbing the attention of distant migrating flights, but flags should be rested once birds turn and commit to the final approach."),
               
               # DESCRIPTION (bullet points)
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
             
             #Canvasback
             conditionalPanel(
               condition = "input.species_central == 'Canvasback'",
               
               #PHOTO
               div(style = "display: flex; gap: 20px;",
                   tags$figure(
                     img(src="canvasback_male.jpg", width = "400px", height = "300px"),
                     tags$figcaption("Male")
                   ),
                   tags$figure(
                     img(src="canvasback_female.jpg", width = "400px", height = "300px"),
                     tags$figcaption("Female")
                   )
               ),
               
               #DESCRIPTION
               h4("About this species"),
               p("The largest and fastest North American diving duck, defined by a long, heavy black bill that slopes seamlessly up into the forehead, creating a flat, wedge-shaped head profile. Breeding drakes display a rich copper-red head, red eyes, a jet-black breast, and a gleaming canvas-white back and body. Hens share the same distinctive sloping head profile but are rendered in soft grayish-brown and pale buff tones."),
               p("Renowned for raw speed, canvasbacks fly in powerful, unwavering V-formations or straight lines driven by rapid, stiff wing strokes. Their flight speed routinely exceeds fifty miles per hour, cutting across open water without the erratic banking seen in puddle ducks. Drakes produce a low, guttural croak or purr while resting on the water, but in flight, the species is predominantly silent, announced only by the distinct ripping sound of their wings cutting the air."),
               p("Bound to large open bays, lakes, and wide river channels rich in wild celery (Vallisneria americana), where their high flight speeds require aggressive forward leads and wide leads on crossing shots. Because of historical population fluctuations, they are strictly managed under restricted daily bag limits, often one or two birds, making quick profile recognition against Redheads essential. Oversized white-bodied decoys set on the upwind edge of a spread help steer these fast divers directly into the shooting lane."),
               
               # DESCRIPTION (bullet points)
               tags$ul(
                 tags$li("Size: Length 48–56 cm (19–22 inches)"),
                 tags$li("Wingspan: 79–89 cm (31–35 inches)"),
                 tags$li("Weight: 860 – 1,600 g (1.9 – 3.5 lbs)"),
                 tags$li("Lifespan: Up to 12–20 years in the wild"),
                 tags$li("Diet: Primarily herbivorous; tubers, roots, seeds of aquatic plants, and some mollusks"),
                 tags$li("Habitat: Large deep lakes, open bays, freshwater marshes, and slow rivers"),
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
             
             #Cackling Goose
             conditionalPanel(
               condition = "input.species_central == 'Cackling Goose'",
               
               #PHOTO
               tags$figure(
                 img(src="cackling_goose_monomorphic.jpg", width = "400px", height = "300px"),
                 tags$figcaption("Monomorphic")
               ),
               
               #DESCRIPTION
               h4("About this species"),
               p("Formerly classified as a small Canada goose subspecies, this distinct species is roughly the size of a large mallard, featuring a noticeably short neck, a steep forehead, and a tiny, stubby triangular bill. Plumage mimics the Canada goose pattern with a black neck, white cheek patches, and a brown body, though some individuals carry a faint white collar at the base of the neck. Their breast coloration ranges from light gray to dark chocolate-brown depending on the subspecies."),
               p("Highly agile fliers that execute sudden banks, side-slips, and rolls into decoys with a high-tempo wingbeat cadence. Flocks move with a loose, erratic energy that allows them to dump out of the sky far more violently than large Canada geese. Instead of a deep honk, their vocalization is a high-pitched, squeaking cackle or yelp sounding like \"yick-yick\" or \"cackle\", which sounds more like a dog toy than a standard goose."),
               p("Winters in large concentrations in California, Texas, and the Pacific Northwest, often mixed in with larger geese in agricultural fields. Hunters must check regional regulations, as some areas enforce separate daily bag limits or closed zones specifically aimed at managing distinct cackler stocks. Decoy spreads should utilize specialized, smaller-bodied cackler decoys, and callers must tune their short-reed calls high to reproduce the squeaking cackle of incoming birds."),
               
               # DESCRIPTION (bullet points)
               tags$ul(
                 tags$li("Size: Length 53–76 cm (21–30 inches)"),
                 tags$li("Wingspan: 105–115 cm (41–45 inches)"),
                 tags$li("Weight: 1.1 – 2.9 kg (2.4 – 6.4 lbs)"),
                 tags$li("Lifespan: 10–20+ years in the wild"),
                 tags$li("Diet: Herbivorous; grasses, sedges, agricultural grains, and green shoots"),
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
             
             #Fulvous Whistling Duck
             conditionalPanel(
               condition = "input.species_central == 'Fulvous Whistling Duck'",
               
               #PHOTO
               tags$figure(
                 img(src="fulvous_whistling_duck_monomorphic.jpg", width = "400px", height = "300px"),
                 tags$figcaption("Monomorphic")
               ),
               
               #DESCRIPTION
               h4("About this species"),
               p("A slender, long-legged whistling duck cloaked in warm, golden tawny-buff plumage, sporting a dark slate-blue bill, long blue-gray legs, and distinctive creamy-white side stripes that drape over the flanks. Unlike black-bellied whistling ducks, their wings are entirely dark blackish-brown above and below, broken only by a clean white crescent across the upper tail coverts. Both sexes share identical plumage characteristics year-round."),
               p("Maintains a slow, deliberate flight profile characterized by broad, rounded wings and long legs that extend prominently beyond the tail. Airborne birds vocalize with a clear, two-syllable squealing whistle sounding like \"k-zee\" or \"whee-ow\", which lacks the rattling chatter of the black-bellied species. They fly in loose, buoyant groups that make wide, circling approaches over agricultural fields."),
               p("Heavily tied to flooded agricultural rice prairies, coastal marshes, and shallow southern wetlands. They tend to be late migrants in the spring and early to depart in the autumn, decoy easily to gentle whistle imitations, and are celebrated for mild, high-quality table fare. Spreads set along shallow rice field checks or flooded pastures will pull them in cleanly without the need for aggressive calling."),
               
               # DESCRIPTION (bullet points)
               tags$ul(
                 tags$li("Size: Length 45–52 cm (18–20 inches)"),
                 tags$li("Wingspan: 85–93 cm (33–37 inches)"),
                 tags$li("Weight: 650 – 950 g (1.4 – 2.1 lbs)"),
                 tags$li("Lifespan: Up to 10 years in the wild"),
                 tags$li("Diet: Herbivorous; seeds, rice, grasses, and aquatic plant tubers"),
                 tags$li("Habitat: Flooded rice fields, shallow freshwater marshes, and shallow lakes"),
                 tags$li("Nesting season: May to August"),
                 tags$li("Conservation status: Least Concern")
               ),
               # SOUND: SPACE RESERVED 
               h4("Call"),
               # >>> SOUND GOES HERE (audio player will replace this comment) <<<
               
               #HEAT MAP: SPACE RESERVED
               h4("Heat map")
               # >>> HEAT MAP GOES HERE (map will replace this comment) <<<
             ),
             
             #Gadwall
             conditionalPanel(
               condition = "input.species_central == 'Gadwall'",
               
               #PHOTO
               div(style = "display: flex; gap: 20px;",
                   tags$figure(
                     img(src="gadwall_male.jpg", width = "400px", height = "300px"),
                     tags$figcaption("Male")
                   ),
                   tags$figure(
                     img(src="gadwall_female.jpg", width = "400px", height = "300px"),
                     tags$figcaption("Female")
                   )
               ),
               
               #DESCRIPTION
               h4("About this species"),
               p("A sleek, medium-sized puddle duck, the drake \"gray duck\" displays subtle, finely vermiculated gray body plumage, a steep forehead, a jet-black rump, and a dark bill. In the air, both sexes are instantly identified by a prominent, rectangular white speculum patch on the inner wing bordered by black and chestnut coverts, contrasting against a clean, snow-white belly. Hens resemble small, slim hen mallards but sport an orange-bordered bill and the diagnostic white wing speculum."),
               p("Fast and level fliers that travel in tight, compact flocks, frequently shifting altitude together and circling setups cautiously out of gun range. Drakes utter a unique, nasal, two-syllable \"kack-kack\" or reedy croak paired with a high-pitched whistle, while hens give a softer, higher-pitched, and slightly faster quack than a hen mallard. In flight, the flashing white speculum is visible even when the birds are viewed from above or behind."),
               p("Highly opportunistic vegetation feeders that frequently skirt the outside edges of decoy spreads without committing directly to the pocket. Because they do not respond well to loud, aggressive mallard hail calls, hunters find the best success using soft gadwall nasal calls, mallard feed chuckles, and wigeon whistles. Setting decoys in loose, scattered groups with plenty of open landing room helps encourage these cautious birds to slide within range."),
               
               # DESCRIPTION (bullet points)
               tags$ul(
                 tags$li("Size: Length 46–56 cm (18–22 inches)"),
                 tags$li("Wingspan: 78–90 cm (31–35 inches)"),
                 tags$li("Weight: 800 – 1,000 g (1.8 – 2.2 lbs)"),
                 tags$li("Lifespan: 5–12 years in the wild"),
                 tags$li("Diet: Herbivorous; aquatic plants, seeds, stems, and occasional aquatic insects"),
                 tags$li("Habitat: Shallow freshwater marshes, prairie potholes, lakes, and estuaries"),
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
             
             #Goldeneye, Common
             conditionalPanel(
               condition = "input.species_central == 'Goldeneye, Common'",
               
               #PHOTO
               div(style = "display: flex; gap: 20px;",
                   tags$figure(
                     img(src="common_goldeneye_male.jpg", width = "400px", height = "300px"),
                     tags$figcaption("Male")
                   ),
                   tags$figure(
                     img(src="common_goldeneye_female.jpg", width = "400px", height = "300px"),
                     tags$figcaption("Female")
                   )
               ),
               
               #DESCRIPTION
               h4("About this species"),
               p("A medium-sized, cold-hardy diving duck, the drake features a puffy, triangular dark head glossed with bottle-green, a bright yellow eye, a black back, and an immaculate white circular spot positioned between the bill and the eye. Hens sport a chocolate-brown head, slate-gray body plumage, pale yellow eyes, and a bill that develops a yellow band across the tip late in the winter. In flight, both sexes show large, solid-white inner wing patches."),
               p("Known as \"whistlers,\" their rapid, stiff wing strokes produce a distinct, high-pitched mechanical humming sound in flight that alerts hunters to their approach long before they are spotted visually. They fly in small, fast groups, cutting direct lines close to open water surfaces. In flight, they rarely vocalize, relying almost entirely on their whistling wings for flock coordination."),
               p("Among the last waterfowl to push south in the winter, moving only when northern lakes and rivers completely freeze over. They are notoriously suspicious of other duck species and decoy best to dedicated goldeneye spreads placed off windy, rocky points and deep-river breaks. Hunters must use heavy, high-contrast black-and-white decoys placed on longlines, as goldeneyes rarely commit to standard mallard or dabbler spreads."),
               
               # DESCRIPTION (bullet points)
               tags$ul(
                 tags$li("Size: Length 45–50 cm (18–20 inches)"),
                 tags$li("Wingspan: 77–83 cm (30–33 inches)"),
                 tags$li("Weight: 500 – 1,300 g (1.1 – 2.9 lbs)"),
                 tags$li("Lifespan: Up to 10–15 years in the wild"),
                 tags$li("Diet: Carnivorous; aquatic insects, crustaceans, mollusks, and small fish"),
                 tags$li("Habitat: Large lakes, rivers, coastal bays, and sheltered marine waters"),
                 tags$li("Nesting season: May to July (uses tree cavities)"),
                 tags$li("Conservation status: Least Concern")
               ),
               # SOUND: SPACE RESERVED 
               h4("Call"),
               # >>> SOUND GOES HERE (audio player will replace this comment) <<<
               
               #HEAT MAP: SPACE RESERVED
               h4("Heat map")
               # >>> HEAT MAP GOES HERE (map will replace this comment) <<<
             ),
             
             #Hooded Merganser
             conditionalPanel(
               condition = "input.species_central == 'Hooded Merganser'",
               
               #PHOTO
               div(style = "display: flex; gap: 20px;",
                   tags$figure(
                     img(src="hooded_merganser_male.jpg", width = "400px", height = "300px"),
                     tags$figcaption("Male")
                   ),
                   tags$figure(
                     img(src="hooded_merganser_female.jpg", width = "400px", height = "300px"),
                     tags$figcaption("Female")
                   )
               ),
               
               #DESCRIPTION
               h4("About this species"),
               p("A small, sleek diver, the drake is marked by an expansive, fan-shaped white crest bordered in jet-black, which can be raised or collapsed against the head. The drake's body is accented by two vertical black bars crossing a bright white breast, rich cinnamon-tawny flanks, and bright yellow eyes. Hens are small and dark brown, carrying a bushy, ragged reddish-cinnamon crest and dark brown eyes."),
               p("Lightning-fast fliers that negotiate narrow timber breaks and winding river channels with incredible maneuverability, flying with rapid, silent wingbeats. Their low-level flight allows them to dart through flooded woods without clipping tree limbs. Drakes utter a unique, frog-like rolling croak or purr during winter, while hens produce a raspy squawk when flushed."),
               p("Prefers secluded forested wetlands, beaver ponds, blackwater swamps, and quiet river oxbows alongside wood ducks. While their meat is generally not favored for the table due to a diet of small fish and aquatic bugs, fully plumaged drakes are highly prized by waterfowlers for decorative taxidermy mounts. They frequently drop into wood duck spreads, giving timber hunters fast, unexpected shooting opportunities."),
               
               # DESCRIPTION (bullet points)
               tags$ul(
                 tags$li("Size: Length 40–49 cm (16–19 inches)"),
                 tags$li("Wingspan: 60–66 cm (24–26 inches)"),
                 tags$li("Weight: 450 – 680 g (1.0 – 1.5 lbs)"),
                 tags$li("Lifespan: Up to 8–10 years in the wild"),
                 tags$li("Diet: Carnivorous; small fish, aquatic insects, crayfish, and aquatic amphibians"),
                 tags$li("Habitat: Wooded swamps, forested rivers, beaver ponds, and quiet sloughs"),
                 tags$li("Nesting season: March to May (cavity nester)"),
                 tags$li("Conservation status: Least Concern")
               ),
               # SOUND: SPACE RESERVED 
               h4("Call"),
               # >>> SOUND GOES HERE (audio player will replace this comment) <<<
               
               #HEAT MAP: SPACE RESERVED
               h4("Heat map")
               # >>> HEAT MAP GOES HERE (map will replace this comment) <<<
             ),
             
             #Mallard
             conditionalPanel(
               condition = "input.species_central == 'Mallard'",
               
               #PHOTO
               div(style = "display: flex; gap: 20px;",
                   tags$figure(
                     img(src="mallard_male.jpg", width = "400px", height = "300px"),
                     tags$figcaption("Male")
                   ),
                   tags$figure(
                     img(src="mallard_female.jpg", width = "400px", height = "300px"),
                     tags$figcaption("Female")
                   )
               ),
               
               #DESCRIPTION
               h4("About this species"),
               p("The continental benchmark for puddle ducks, drakes carry an iridescent emerald-green head, crisp white neck collar, chestnut breast, and an upward-curled central black tail feather. Both sexes display a brilliant violet-blue speculum bordered on both leading and trailing edges by clean white bars, which flashes vividly during banking turns. In early season or eclipse plumage, drakes resemble mottled-brown hens but can be separated in hand or at close range by their solid dull-yellowish bill, unlike the dark, orange-splotched bill of the hen."),
               p("Mallards launch vertically from the surface on powerful wingbeats, cruising in deliberate, wide-circling flight paths while scouting marsh openings and flooded agricultural fields. Acoustic dimorphism is stark: hens deliver the classic, loud, raspy decrescendo \"quack\" and long-distance hail calls that standard duck calls emulate, while airborne drakes emit only low, raspy, single-syllable \"kwek\" or \"yeeb\" whistles."),
               p("Wary and easily educated by hunting pressure, birds flare instantly from unnatural movement, blind shine, or off-beat calling, making spinning-wing decoys and realistic water motion critical on still mornings. In mixed-bag regions, hunters must confirm the double white wing bars and pale belly to avoid mistakenly taking darker American Black Ducks or Mottled Ducks against single-bird bag limits. Clean decoy spreads, disciplined calling cadences, and total concealment are fundamental to consistent success."),
               
               # DESCRIPTION (bullet points)
               tags$ul(
                 tags$li("Size: Length 50–65 cm (20–26 inches)"),
                 tags$li("Wingspan: 81–98 cm (32–39 inches)"),
                 tags$li("Weight: 700 – 1,600 g (1.5 – 3.5 lbs)"),
                 tags$li("Lifespan: 5–10 years in the wild (can exceed 20 years)"),
                 tags$li("Diet: Omnivorous; seeds, grains, aquatic vegetation, insects, and small fish"),
                 tags$li("Habitat: Freshwater marshes, ponds, rivers, agricultural fields, and urban parks"),
                 tags$li("Nesting season: March to July"),
                 tags$li("Conservation status: Least Concern")
               ),
               # SOUND: SPACE RESERVED 
               h4("Call"),
               # >>> SOUND GOES HERE (audio player will replace this comment) <<<
               
               #HEAT MAP: SPACE RESERVED
               h4("Heat map")
               # >>> HEAT MAP GOES HERE (map will replace this comment) <<<
             ),
             
             #Mexican Duck
             conditionalPanel(
               condition = "input.species_central == 'Mexican Duck'",
               
               #PHOTO
               tags$figure(
                 img(src="mexican_duck_male_right_female_left.jpg", width = "400px", height = "300px"),
                 tags$figcaption("Male and Female")
               ),
               
               #DESCRIPTION
               h4("About this species"),
               p("Both drakes and hens closely resemble oversized, richly saturated hen mallards, covered in dark, warm-brown scalloped plumage with a paler buff head and throat. The speculum flashes greenish-blue to deep blue, bordered by narrow black bars and only trace white tips along the trailing edge. Drakes are readily distinguished in hand and at close range by their solid olive-green to yellowish bills, while females possess pale orange bills marked with dusky splotches."),
               p("Flushes vertically from narrow desert river corridors, stock ponds, and agricultural irrigation ditches, flying with the steady, authoritative cadence of northern mallards. Their flight lines are strong and deliberate, showing pale underwings that contrast against their rich, dark body feathering. Hens produce loud, coarse quacking series, while drakes utilize the low-pitched, quiet rasp characteristic of the genus Anas."),
               p("Formerly classified as a mallard subspecies, it is now recognized as a distinct species native to the southwestern border states and northern Mexico. Hunters in the Rio Grande basin and desert southwest must exercise caution when hunting zones with aggregate hen-mallard restrictions, checking bill color and speculum borders to confirm species identity. Small spreads of mallard or pintail decoys placed on shallow desert stock tanks produce steady shooting during the winter months."),
               
               # DESCRIPTION (bullet points)
               tags$ul(
                 tags$li("Size: Length 50–58 cm (20–23 inches)"),
                 tags$li("Wingspan: 80–92 cm (31–36 inches)"),
                 tags$li("Weight: 800 – 1,200 g (1.8 – 2.6 lbs)"),
                 tags$li("Lifespan: 5–10 years in the wild"),
                 tags$li("Diet: Omnivorous; seeds, grains, aquatic plants, and aquatic invertebrates"),
                 tags$li("Habitat: Desert streams, mountain rivers, stock ponds, and agricultural marshes"),
                 tags$li("Nesting season: March to July"),
                 tags$li("Conservation status: Least Concern / Regionally Vulnerable")
               ),
               # SOUND: SPACE RESERVED 
               h4("Call"),
               # >>> SOUND GOES HERE (audio player will replace this comment) <<<
               
               #HEAT MAP: SPACE RESERVED
               h4("Heat map")
               # >>> HEAT MAP GOES HERE (map will replace this comment) <<<
             ),
             
             #Mottled Duck
             conditionalPanel(
               condition = "input.species_central == 'Mottled Duck'",
               
               #PHOTO
               div(style = "display: flex; gap: 20px;",
                   tags$figure(
                     img(src="mottled_duck_male.jpg", width = "400px", height = "300px"),
                     tags$figcaption("Male")
                   ),
                   tags$figure(
                     img(src="mottled_duck_female.jpg", width = "400px", height = "300px"),
                     tags$figcaption("Female")
                   )
               ),
               
               #DESCRIPTION
               h4("About this species"),
               p("A large, warm-buff to dark-brown dabbler resembling a pale hen mallard or a faded black duck, characterized by an unstreaked buffy throat and pale face. The speculum shines iridescent blue-green with black trailing margins and totally lacks white border bars, though a faint white line on the trailing edge can occasionally appear in worn plumage. Drakes possess a solid bright yellow-olive bill accented by a distinct black spot at the gape, while hens have duller orange-yellow bills with dark blotches."),
               p("Moves in low, watchful pairs or small family groups just above coastal cordgrass and flooded rice impoundments, seldom forming massive mixed flocks. Their flight is measured and vigilant, keeping them low to the grass as they navigate marsh systems. Vocalizations closely mirror mallards, with females delivering loud, descending quacks and males sounding soft, reedy chuckles."),
               p("Primarily non-migratory residents of Gulf Coast and southern coastal marshes. Due to declining populations and hybridization pressures, they carry tight harvest caps or total season closures in specific zones, meaning gunners must never shoot at dark-bodied ducks in low light without confirming the lack of white speculum bars and the pale buff throat. Setting small, scattered spreads in secluded marsh potholes is the most effective way to coax these resident birds within range."),
               
               # DESCRIPTION (bullet points)
               tags$ul(
                 tags$li("Size: Length 48–58 cm (19–23 inches)"),
                 tags$li("Wingspan: 80–90 cm (31–35 inches)"),
                 tags$li("Weight: 750 – 1,200 g (1.6 – 2.6 lbs)"),
                 tags$li("Lifespan: 5–10 years in the wild"),
                 tags$li("Diet: Omnivorous; seeds, aquatic vegetation, snails, insects, and small crustaceans"),
                 tags$li("Habitat: Coastal marshes, brackish estuaries, flooded rice fields, and coastal prairies"),
                 tags$li("Nesting season: March to July"),
                 tags$li("Conservation status: Least Concern / Regionally Monitored")
               ),
               # SOUND: SPACE RESERVED 
               h4("Call"),
               # >>> SOUND GOES HERE (audio player will replace this comment) <<<
               
               #HEAT MAP: SPACE RESERVED
               h4("Heat map")
               # >>> HEAT MAP GOES HERE (map will replace this comment) <<<
             ),
             
             #Northern Pintail
             conditionalPanel(
               condition = "input.species_central == 'Northern Pintail'",
               
               #PHOTO
               div(style = "display: flex; gap: 20px;",
                   tags$figure(
                     img(src="northern_pintail_male.jpg", width = "400px", height = "300px"),
                     tags$figcaption("Male")
                   ),
                   tags$figure(
                     img(src="northern_pintail_female.jpg", width = "400px", height = "300px"),
                     tags$figcaption("Female")
                   )
               ),
               
               #DESCRIPTION
               h4("About this species"),
               p("An exceptionally sleek, long-necked dabbler, the drake pintail boasts a chocolate-brown head, a bright white neck stripe extending up from a snow-white chest, and elongated, needle-like black central tail feathers. In flight, their long, slender necks and pointed wings produce a gull-like, hydrodynamic silhouette that cannot be mistaken for any other duck. The speculum is an iridescent dark greenish-bronze bordered by a rust-tan leading bar and a crisp white trailing edge."),
               p("Pintails fly high, fast, and gracefully, sliding down from altitude in long, sweeping, cautious spirals that inspect every inch of a marsh before setting their wings. Their wing strokes are narrow and swept-back, giving them a distinct dart-like appearance on long crossing passes. Drakes rarely quack, instead emitting a soft, two-note flute-like whistle sounding like \"wheet-wheet\", while hens produce a low, hoarse, dry croak."),
               p("Renowned as one of the most decoy-shy ducks in North America, often circling a spread half a dozen times before landing well outside the decoys. High-visibility sprig decoys with prominent white chests, minimal motion-decoy flash on clear days, and conservative whistling are essential to finishing them within range under strict single-bird or two-bird bag limits. Spreads deployed in open sheetwater or wide, flooded agricultural basins yield the best results."),
               
               # DESCRIPTION (bullet points)
               tags$ul(
                 tags$li("Size: Length 51–76 cm (20–30 inches including tail)"),
                 tags$li("Wingspan: 80–95 cm (31–37 inches)"),
                 tags$li("Weight: 450 – 1,360 g (1.0 – 3.0 lbs)"),
                 tags$li("Lifespan: Up to 15–20 years in the wild"),
                 tags$li("Diet: Omnivorous; seeds, aquatic plants, grains, insects, and small snails"),
                 tags$li("Habitat: Open wetlands, marshes, agricultural fields, and shallow coastal bays"),
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
             
             #Northern Shoveler
             conditionalPanel(
               condition = "input.species_central == 'Northern Shoveler'",
               
               #PHOTO
               div(style = "display: flex; gap: 20px;",
                   tags$figure(
                     img(src="northern_shoveler_male.jpg", width = "400px", height = "300px"),
                     tags$figcaption("Male")
                   ),
                   tags$figure(
                     img(src="northern_shoveler_female.jpg", width = "400px", height = "300px"),
                     tags$figcaption("Female")
                   )
               ),
               
               #DESCRIPTION
               h4("About this species"),
               p("Instantly identified by an enormous, spoon-shaped black bill that is longer than the head and lined with fine, comb-like filtering lamellae. Prime drakes are vividly marked with an iridescent dark green head, brilliant white chest, rich chestnut-red belly and flanks, and pale blue shoulder patches on the wings. Hens are mottled brown with a heavy, orange-edged spoon bill and pale blue forewing patches."),
               p("Flocks fly with steady, measured wingbeats, maintaining a distinct silhouette that appears front-heavy and down-angled due to the heavy bill. They are surprisingly nimble when banking, occasionally dropping out of the sky with sudden side-slips into shallow marsh holes. Drakes emit a low, guttural, rhythmic clucking sounding like \"thook-thook\" or \"clook\", while hens produce a muted, nasal quack."),
               p("Nicknamed \"spoonbills\" or \"bootlips,\" they feed by sweeping their bills across the water surface to filter micro-invertebrates and seeds from stagnant marsh pools and mudflats. They decoy very readily into almost any puddle duck spread without requiring calling, though their table quality varies widely depending on whether they have been feeding on seeds or aquatic invertebrates. They provide excellent shooting practice over shallow impoundments, dropping willingly into standard decoy layouts."),
               
               # DESCRIPTION (bullet points)
               tags$ul(
                 tags$li("Size: Length 43–52 cm (17–20 inches)"),
                 tags$li("Wingspan: 73–82 cm (29–32 inches)"),
                 tags$li("Weight: 470 – 1,100 g (1.0 – 2.4 lbs)"),
                 tags$li("Lifespan: Up to 10–15 years in the wild"),
                 tags$li("Diet: Omnivorous; zooplankton, micro-invertebrates, seeds, and aquatic plants"),
                 tags$li("Habitat: Shallow freshwater marshes, prairie ponds, mudflats, and estuaries"),
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



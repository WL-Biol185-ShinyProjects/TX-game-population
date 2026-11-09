library(shiny)
library(httr)
library(jsonlite)

#Each bird: code = c(display name, Wikipedia page title)
birds <- list(
  wood  = c("Wood Duck", "Wood_duck"),
  shov  = c("Northern Shoveler", "Northern_shoveler"),
  ruddy = c("Ruddy Duck", "Ruddy_duck"),
  crane = c("Sandhill Crane", "Sandhill_crane"),
  snipe = c("Wilson's Snipe", "Wilson%27s_snipe"),
  swan  = c("Trumpeter Swan", "Trumpeter_swan"),
  ltd   = c("Long-tailed Duck", "Long-tailed_duck"),
  hood  = c("Hooded Merganser", "Hooded_merganser"),
  whis  = c("Black-bellied Whistling Duck", "Black-bellied_whistling_duck"),
  pin   = c("Northern Pintail", "Northern_pintail")
)
#Each question: list(question, c("answer text" = "birds that get a point"))
questions <- list(
  list("It's Saturday. What's your ideal plan?", c(
    "Dress to impress and strut into the party like I own the place" = "wood hood",
    "Slip away to my own quiet corner where nobody will ever find me" = "snipe ruddy",
    "Pack the car and chase the horizon on a spontaneous road trip" = "pin ltd",
    "Gather my favorite people for dancing, laughing, and way too much noise" = "crane whis")),
  list("In a group, you're usually...", c(
    "The natural leader whose voice carries across the whole room" = "swan crane",
    "The social butterfly with a never-ending stream of chatter" = "whis ltd",
    "The lovable goofball who gets everyone laughing without even trying" = "ruddy shov",
    "The quiet observer taking it all in from the sidelines" = "snipe hood")),
  list("Pick your signature look.", c(
    "Bold colors, flashy details, and a little drama" = "wood hood",
    "Sleek, polished, and effortlessly sharp" = "pin swan",
    "One oversized statement piece that everyone remembers" = "shov ruddy",
    "Rugged, weatherproof layers that can handle anything" = "ltd snipe")),
  list("What's for dinner?", c(
    "An all-you-can-eat buffet where I sample everything and keep the best bits" = "shov whis",
    "Something fresh from the water, caught and cooked right away" = "hood ltd",
    "A big, hearty, farm-fresh feast with the whole crew" = "crane whis",
    "Something earthy and adventurous that I foraged myself" = "snipe wood")),
  list("Which climate feels like home?", c(
    "Icy, wild, and windswept, where the cold is part of the fun" = "ltd swan",
    "Warm, humid, and sunny, with palm trees swaying nearby" = "whis wood",
    "Wide-open skies with plenty of room to roam" = "pin crane",
    "A cool, shady woodland creek with dappled sunlight" = "wood hood")),
  list("What's your dream home?", c(
    "A cozy hideaway perched up high with a view" = "wood whis",
    "A big, peaceful space shared with my partner for life" = "swan crane",
    "A secret spot so well hidden that no one ever finds it" = "snipe ruddy",
    "Anywhere with good water and a relaxed, go-with-the-flow vibe" = "ruddy shov")),
  list("When stress hits, you...", c(
    "Take a deep breath, dive right in, and push through" = "ltd ruddy",
    "Put on a confident face and show off a little" = "hood wood",
    "Zigzag out of there as fast as possible" = "snipe pin",
    "Call out loudly and rally everyone to help" = "crane swan")),
  list("Your friends would describe you as...", c(
    "Graceful and elegant, always keeping it classy" = "pin swan",
    "Quirky and unforgettable, in the best way" = "ruddy shov",
    "Fiercely loyal, a friend for life" = "crane whis",
    "A fearless adventurer who's up for anything" = "ltd pin"))
)

ui <- fluidPage(
  titlePanel("Which Waterfowl Are You?"),
  uiOutput("screen")
)

server <- function(input, output) {
  n <- reactiveVal(0)        # 0 = start screen, 1-8 = questions, 9 = result
  scores <- reactiveVal(NULL)
  
#Decide what to show based on n
  output$screen <- renderUI({
    i <- n()
    if (i == 0) {
      return(tagList(p("8 questions, 10 possible birds."), actionButton("go", "Start")))
    }
    if (i <= length(questions)) {
      q <- questions[[i]]
      return(tagList(
        h4(paste(i, "of 8:", q[[1]])),
        radioButtons("choice", NULL, choices = q[[2]], selected = character(0)),
        actionButton("next_btn", "Next")
      ))
    }
    
#Result screen: find the bird with the highest score
    winner <- names(which.max(scores()))
    
#This is where data is pulled from - Wikipedia
    url <- paste0("https://en.wikipedia.org/api/rest_v1/page/summary/", birds[[winner]][2])
    info <- tryCatch(
      fromJSON(content(GET(url, user_agent("waterfowl-quiz")), "text", encoding = "UTF-8"))$extract,
      error = function(e) NULL
    )
    if (is.null(info)) info <- "Couldn't reach Wikipedia."
    tagList(
      h2(paste0("You are a ", birds[[winner]][1], "!")),
      p(info),
      actionButton("again", "Take it again")
    )
  })
  
#Start: every bird begins with 0 points
  observeEvent(input$go, {
    scores(setNames(rep(0, length(birds)), names(birds)))
    n(1)
  })
  
#Next: add a point to each bird in the chosen answer, then move on
  observeEvent(input$next_btn, {
    req(input$choice)
    s <- scores()
    for (b in strsplit(input$choice, " ")[[1]]) s[b] <- s[b] + 1
    scores(s)
    n(n() + 1)
  })
  
#Restart
  observeEvent(input$again, n(0))
}

shinyApp(ui, server)

load("~/Desktop/project4-team 10/movie_data.RData")
library(shiny)
shinyUI(fluidPage(
  titlePanel("Movie Recommendation"),
  fluidRow(
    column(3,
           wellPanel(
             h4("Filter"),
             sliderInput("tomatoReviews", "Minimum number of reviews on Rotten Tomatoes",
                         5, 330, 80, step = 5),
             sliderInput("year", "Year released", 1940, 2014, value = c(1970, 2014)),
             sliderInput("tomatoRating", "Minimum tomatoRating",
                         0, 10, 8.1, step = 0.1),
             sliderInput("tomatoUserRating", "Minimum tomatoUserRating",
                         0, 10, 8.1, step = 0.1),
             sliderInput("imdbRating", "Minimum imdbRating",
                         0, 10, 8.1, step = 0.1),
             sliderInput("PReview_ave","Minimum average of Product Review",0, 5, 4.3,step=0.1),
             selectInput("Genre", "Genre (a movie can have multiple genres)",
                         c("All", "Action", "Adventure", "Animation", "Biography", "Comedy",
                           "Crime", "Documentary", "Drama", "Family", "Fantasy", "History",
                           "Horror", "Music", "Musical", "Mystery", "Romance", "Sci-Fi",
                           "Short", "Sport", "Thriller", "War", "Western")
             ),
            textInput("Userid","Userid(e.g.)")，
            textInput("Director", "Director name contains (e.g. Tom Hanks)"),
             textInput("Production", "Production name contains (e.g. 20th Century Fox)")
           ),
           
    ),
    column(7,
           h3("You Might Like These Too!"),
           tableOutput("table"))
  )
))
#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  genre <- read.csv("genre.csv")
  test <- read.csv("test.csv")
  production <- read.csv("production.csv", sep="")
  year <- read.csv("year.csv")
  output$distplot1 <- renderPlotly(
    if (input$Plot >0){
      if (input$Plot =="Year"){
        plot_ly(year, x = Year, y = count) %>% layout(title = "number of movies")
      }
      else if (input$Plot == "Awards"){
        plot_ly(data = test, x = Year, y = PReview_ave, color = awards, text=paste("Title:", test$Movie_Name), mode = "markers")
      }
      else if (input$Plot == "Production"){
        plot_ly(production, labels = x, values = freq, type = "pie", domain = list(x = c(0, 0.4), y = c(0.4, 1)), name = "Cut", showlegend = T)
      }
    })
 
    output$distplot2 <- renderPlotly(
      if(input$genre >0){
        genre$Genre <- as.character(genre$Genre)
        drama <- genre[which(genre$Genre == as.character(input$genre)),]
        plot_ly(drama, x = Year, y =PReview_ave,color = awards,text=paste("Title:", drama$Movie_Name), mode = "markers" ,colors=c("#f03b20","#7fcdbb")) 
        
      }
      
    )
  
})

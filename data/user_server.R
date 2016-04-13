#server.R
library(shiny)
library(proxy)
library(recommenderlab)
library(reshape2)

shinyServer(function(input, output) {
  
  output$table <- renderTable({
    movie_recommendation(input)
  })
  }
)
###movie_recommendation


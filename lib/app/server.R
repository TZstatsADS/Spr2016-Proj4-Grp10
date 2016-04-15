#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
load("results.RData")
load("matrix1.RData")
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
  output$view <- renderUI({
        recursivefunction<-function(c1,b,n=5,j=1,movie){
          c2<-matrix1[which(rownames(matrix1)==b[1]),]
          for(i in 1:length(c1)){
            if (c1[i]==0 & c2[i]>1){
              if(!(names(c1)[i] %in% movie)){
                movie[j]=names(c1)[i]
                j=j+1
              }
            }
          }
          if(j<n+1){
            if(length(b)==0){
              return(movie)
            }
            else{
              b<-b[-1]
              recursivefunction(c1,b,n=5,j,movie)
            }
          }
          else{
            return(movie)
          }
        } 
        movie<-rep("no movie found",5)
        find_similarity_movie<-function(myid,n=5){
          similar <- subset(results, user1==myid)
          similar <- similar[order(-similar$sim),]
          b<-similar[,2]
          c1<-matrix1[which(rownames(matrix1)==myid),]
          recursivefunction(c1,b,n=5,j=1,movie)
        }
        mymovie<-paste("http://www.amazon.com/exec/obidos/ASIN/",find_similarity_movie(input$myid))
        return(list(a(href=mymovie[1], target="_blank", mymovie[1]),
                    a(href=mymovie[2], target="_blank", mymovie[2]),
                    a(href=mymovie[3], target="_blank", mymovie[3]),
                    a(href=mymovie[4], target="_blank", mymovie[4]),
                    a(href=mymovie[5], target="_blank", mymovie[5])))
        #a(href=mymovie[2], target="_blank", mymovie[2])
      })
  
})

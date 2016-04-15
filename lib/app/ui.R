#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
library(plyr)
library(reshape2)
library(shiny)
library(plotly)
library(splitstackshape)
library(ggplot2)
library(shinydashboard)
# Define UI for application that draws a histogram
shinyUI(fluidPage(titlePanel("Movie Movie Movie"),
                    
                            # Sidebar with a selector input for neighborhood
                            sidebarLayout(position="left",
                                          sidebarPanel(
                                            conditionalPanel(condition="input.Panels==1",
                                                             helpText("Give the overall analysis"),
                                                             br(),
                                                             selectInput("Plot", "Analysis",
                                                                         c("Year", "Awards","Production"))
                                            ),
                                            conditionalPanel(condition="input.Panels==2",
                                                             helpText("Choose the genre"),
                                                             hr(),
                                                             selectInput("genre", "Genre (a movie can have multiple genres)",
                                                                         c( "Action", "Adventure", "Animation", "Biography", "Comedy",
                                                                            "Crime", "Documentary", "Drama", "Family", "Fantasy", "History",
                                                                            "Horror", "Music", "Musical", "Mystery", "Romance", "Sci-Fi",
                                                                            "Short", "Sport", "Thriller", "War", "Western"))
                                                             
                                            ),
                                            conditionalPanel(condition="input.Panels==3",
                                                             helpText("When you select an id, we recommend 5 movies with the html link given to you"),
                                                             hr(),
                                                             selectInput("myid","Select an id to start",
                                                                         c("A100JCBNALJFAW","A102B8D74H64TO","A103KNDW8GN92L","A103QX7NUHBOUF","A103W7ZPKGOCC9","A105YVLAZNYQUU"))
                                            )
                                          ),
                                          mainPanel(
                                            tabsetPanel(type="pill",
                                                        
                                                        tabPanel("Analysis", br(),plotlyOutput("distplot1") , value=1), 
                                                        
                                                        tabPanel("Genre Analysis", br(), plotlyOutput("distplot2"), value=2),
                                                        tabPanel("Engine", br(), helpText("movies recommended to you"), uiOutput("view"),value=3),
                                                        id = "Panels"
                                            )
                                          )
                            
                            
                            
                   )
))
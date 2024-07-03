library(shiny)
library(tidyverse)

setwd("/Users/stanislavsergeevich/Rstudio/Homework/4")
tit <- read.csv("Titanic.csv")

ui <- fluidPage(
  titlePanel("Titanic passengers stats"),
  fluidRow(
    splitLayout(cellWidths = c("50%", "50%"), 
                column(width=6, selectInput("q_tit", 
                                            "Titanic Passengers non numeric", 
                                            choice=c("Survived", "PClass", "Sex"))
                  ), 
                column(width=6, selectInput("n_tit", 
                                            "Titanic Passengers numeric stats", 
                                            choice=c("Age", "Fare"))))
    ), 
  fluidRow(
    splitLayout(cellWidths = c("50%", "50%"), 
                column(6, selectInput("color1", 
                                      "Choose color for 1 plot", 
                                      choices = c("Red"="red", 
                                                 "Aquamarine"="aquamarine", 
                                                 "Pink"="hotpink"))), 
                column(6,selectInput("color2", 
                                     "Choose color for 2 plot",
                                     choices = c("Red"="red", 
                                                 "Aquamarine"="aquamarine", 
                                                 "Pink"="hotpink"))))
    ),
  
  mainPanel(fluidRow(
    splitLayout(cellWidths = c("50%", "50%"),
                plotOutput("distPlot1"), 
                plotOutput("distPlot2")))
    )
  )


server <- function(input, output) {
  temp1 <- tit$input$q_tit
  temp2 <- tit$input$n_tit
  output$distPlot1 <- renderPlot({
    barplot(table(temp1), col=input$color1)
  })
  output$distPlot2 <- renderPlot({
    hist(temp2, col=input$color2)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
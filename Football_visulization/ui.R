#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyWidgets)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("European football data visulization (Season 2021-2022)"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            awesomeRadio(
              inputId = "type", label = h3("Choose type of statistics:"), 
              choices = list("Player Statistics"=1, "Team Statistics"=2,"Signing Suggestion"=3),
              selected = 1,
            ),
            
            uiOutput("detail"),
            
        ),

        # Show a plot of the generated distribution
        mainPanel(
          uiOutput("main_header"),
          uiOutput("main_selector"),
          uiOutput("main_searcher"),
          plotOutput("main_plotter"),
        )
    )
))

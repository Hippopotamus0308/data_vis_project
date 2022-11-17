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
library(shinycssloaders)
library(plotly)
options(spinner.color="#0275D8", spinner.color.background="#ffffff", spinner.size=2)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("European football data visulization (Season 2021-2022)"),

    # Sidebar with a slider input for number of bins
    fluidRow(
        column(3,
            awesomeRadio(
              inputId = "type", label = h3("Choose type of statistics:"), 
              choices = list("Introduction"=4,"Player Statistics"=1, "Team Statistics"=2,"Signing Suggestion"=3),
              selected = 4,
            ),
            
            uiOutput("detail"),
            
        ),

        # Show a plot of the generated distribution
        column(8,
          withSpinner(uiOutput("main_header"), type = 2),
          withSpinner(uiOutput("main_selector"), type = 2),
          withSpinner(uiOutput("main_searcher"), type = 2),
          #uiOutput("main_header"),
          #uiOutput("main_selector"),
          #uiOutput("main_searcher"),
          ## modified plot's sequence
          column(12,withSpinner(plotOutput("plotter_radar"),type = 2)),
          # simpleNetworkOutput(
          #   "network", width = "100%", height = "700px"
          # ),
          column(12,
                 column(6,align='center',withSpinner(plotOutput("plotter_main_res"),type=2)),
                 column(6,withSpinner(plotOutput("plotter_addition"),type=2))),
          column(12,
                 column(6,withSpinner(plotOutput("plotter_addition2"),type=2)),
                 column(6,withSpinner(plotOutput("plotter_discipline"),type=2))),
        )
    )
))

#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyWidgets)
library(ggplot2)
library(shinycssloaders)

source("data.R")
source("plot_func.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
    output$detail <- renderUI({
      if (input$type == 1) {
        awesomeRadio("mode",h3("Select the statistics"),
                     choices = list("Player statistics in UCL"=1,"Statistics comparation"=3),
                     selected = 1)
      }else if (input$type == 2){
        awesomeRadio("mode",h3("Select the statistics"),
                     choices = list("Team statistics in Serie A"=4,"Team statistics in La Liga"=5),
                     selected = 4)
      }else if (input$type == 3){
        awesomeRadio("mode",h3("Select the statistics"),
                     choices = list("Signing suggestion for Serie A"=6,"Signing suggest for La Liga"=7),
                     selected = 6)
      }else if(input$type == 4){
        awesomeRadio("mode",h3("Select the content"),
                     choices = list("Introduction to purpose"=8,"Data description"=9),
                     selected = 8)
      }
    })
    
    output$main_header <- renderUI({h3(main_plot_header_set[as.numeric(input$mode)])})
    
    output$main_selector <- renderUI({
      m <- as.numeric(input$mode)
      if (m%in%c(1,2,3)){
        tabsetPanel(
          id = "player_data_mode",
          tabPanel("Attacker",value = 1), 
          tabPanel("Midfielder",value = 2), 
          tabPanel("Defender",value = 3),
          tabPanel("Goalkeeper",value = 4)
        )
      }else if(m%in%c(4,5)){
        tabsetPanel(
          id = "team_data_mode",
          tabPanel("Total Teams",value = 1),
          tabPanel("Single Team Statistics",value = 2), 
        )
      }else if(m%in%c(8,9)){
        p(h4("-----------------"),h4(main_description[as.numeric(input$mode)-7]),h4("-----------------"))
      }else if(m%in%c(6,7)){
        p(h4("----------------------------------"))
      }
    })
    
    output$main_searcher <- renderUI({
      if (as.numeric(input$type)==2){
        if(!(as.numeric(input$type)==2&as.numeric(input$team_data_mode==1))){
          s_team_input(as.numeric(input$mode)) 
        }
      }else if(as.numeric(input$type)==1){
        if(as.numeric(input$mode!=3)){
          s_player_input(as.numeric(input$player_data_mode))
        }else{
          s_multi_input(as.numeric(input$player_data_mode))
        }
      }else if(as.numeric(input$type)==4){
        h4(main_summary[as.numeric(input$mode)-7])
      }else if (as.numeric(input$type)==3){
        s_team_input(as.numeric(input$mode)) 
      }
    })
    
    
    output$plotter_radar<-renderPlot({
      if (as.numeric(input$type)==1){
        if(as.numeric(input$mode!=3)){
          player_plotter_radar(input$player_data_mode, input$player_name)
        }else{
          multiplayer_plotter_radar(input$player_data_mode, input$multiplayers)
        }
      }else if (as.numeric(input$type)==2){
        team_plotter_radar(input$mode, input$team_data_mode, input$team_name)
      }else if (as.numeric(input$type)==3){
        team_plotter_radar(input$mode, 2, input$team_name)
      }
    })
    
    output$plotter_main_res<-renderPlot({
      if (as.numeric(input$type)==1){
        if(as.numeric(input$mode!=3)){
          player_plotter_main_res(input$player_data_mode, input$player_name)
        }else{
          multiplayer_plotter_main_res(input$player_data_mode, input$multiplayers)
        }
      }else if (as.numeric(input$type)==2){
        team_plotter_attack(input$mode, input$team_data_mode, input$team_name)
      }else if (as.numeric(input$type)==3){
        team_plotter_signing1(input$mode, input$team_name)
      }
    })
    
    output$plotter_addition<-renderPlot({
      if (as.numeric(input$type)==1){
        if(as.numeric(input$mode!=3)){
          player_plotter_addition(input$player_data_mode, input$player_name)
        }else{
          multiplayer_plotter_addition(input$player_data_mode, input$multiplayers)
        }
      }else if (as.numeric(input$type)==2){
        team_plotter_pass(input$mode, input$team_data_mode, input$team_name)
      }else if (as.numeric(input$type)==3){
        team_plotter_signing2(input$mode, input$team_name)
      }
    })
    
    output$plotter_addition2<-renderPlot({
      if (as.numeric(input$type)==1){
        if(as.numeric(input$mode!=3)){
          player_plotter_addition2(input$player_data_mode, input$player_name)
        }else{
          multiplayer_plotter_addition2(input$player_data_mode, input$multiplayers)
        }
      }else if (as.numeric(input$type)==2){
        team_plotter_possess(input$mode, input$team_data_mode, input$team_name)
      }else if (as.numeric(input$type)==3){
        team_plotter_signing3(input$mode, input$team_name)
      }
    })
    
    output$plotter_discipline<-renderPlot({
      if (as.numeric(input$type)==1){
        if(as.numeric(input$mode!=3)){
          player_plotter_discipline(input$player_data_mode, input$player_name)
        }else{
          multiplayer_plotter_discipline(input$player_data_mode, input$multiplayers)
        }
      }else if (as.numeric(input$type)==2){
        team_plotter_defense(input$mode, input$team_data_mode, input$team_name)
      }else if (as.numeric(input$type)==3){
        team_plotter_signing4(input$mode, input$team_name)
      }
    })
    
})


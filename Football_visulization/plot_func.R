library(ggplot2)
source('data.R')

player_plotter <- function(type){
  if (type==1){
    ggplot(ucl_attacking, aes(x=match_played, y=assists, label=player_name)) +
      geom_point() + 
      geom_label()
  }else if(type==2){
    
  }else if(type==3){
    
  }else if(type==4){
    
  }
}

s_team_input <- function(num){
  if(num==6||num==8){
    pholder <- "AC Milan"
  }else if (num==4||num==5||num==7){
    pholder <- "Real Madrid"
  }
  
  searchInput(
    inputId = 'team_name',
    label = "Search for a team, click search icon to update or hit 'Enter'",
    placeholder = pholder,
    btnSearch = icon("search"),
    btnReset = icon('remove'),
    width = '100%'
  )
}

s_player_input <- function(num){
  if(num==1){
    pholder <- "De Bruyne"
  }else if (num==2){
    pholder <- "Robertson"
  }else if (num==3){
    pholder <- "De Bruyne"
  }else if (num==4){
    pholder <- "De Gea"
  }
  
  searchInput(
    inputId = 'team_name',
    label = "Search for a player, click search icon to update or hit 'Enter'",
    placeholder = pholder,
    btnSearch = icon("search"),
    btnReset = icon('remove'),
    width = '100%'
  )
}

s_multi_input <- function(){
  pickerInput(
    inputId = 'players',
    label = 'choose players',
    choices = as.list(ucl_key_stats[1])$player_name,
    multiple = TRUE
  )
}

plotter <- function(num){
  sInput(num)
}

suggest_plot <- function(num){
  if(num==7){
    sInput(num)
  }
}

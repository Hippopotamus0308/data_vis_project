library(ggplot2)
source('data.R')
library(fmsb)

# radar chart for a certain player / average data
player_plotter_radar <- function(type, player_name){
  if (type==1){
    if(player_name==''){
      par(mar=c(5, 1, 5, 1), xpd=TRUE)
      football_radarchart(ucl_forward_radar[c("Max","Min","Average"),],"Attacker radar chart", color = c("blue","red"))
      legend(
        x = "bottom", legend = c("Average"), horiz = TRUE,
        bty = "n", pch = 20 , col = c("blue", "red"), text.col = "black",
        inset=c(0,-0.1),
        xpd = TRUE
      )
    }else{
      par(mar=c(5, 1, 5, 1), xpd=TRUE)
      football_radarchart(ucl_forward_radar[c("Max","Min","Average",player_name),],"Attacker radar chart", color = c("blue","red"))
      legend(
        x = "bottom", legend = c("Average",player_name), horiz = TRUE,
        bty = "n", pch = 20 , col = c("blue", "red"), text.col = "black",
        inset=c(0,-0.1),
        xpd = TRUE
      )
    }
  }else if(type==2){
    if(player_name==''){
      par(mar=c(5, 1, 5, 1), xpd=TRUE)
      football_radarchart(ucl_midfielder_radar[c("Max","Min","Average"),],"Midfielder radar chart", color = c("blue","red"))
      legend(
        x = "bottom", legend = c("Average"), horiz = TRUE,
        bty = "n", pch = 20 , col = c("blue", "red"), text.col = "black",
        inset=c(0,-0.1),
        xpd = TRUE
      )
    }else{
      par(mar=c(5, 1, 5, 1), xpd=TRUE)
      football_radarchart(ucl_midfielder_radar[c("Max","Min","Average",player_name),],"Midfielder radar chart", color = c("blue","red"))
      legend(
        x = "bottom", legend = c("Average",player_name), horiz = TRUE,
        bty = "n", pch = 20 , col = c("blue", "red"), text.col = "black",
        inset=c(0,-0.1),
        xpd = TRUE
      )
    }
  }else if(type==3){
    if(player_name==''){
      par(mar=c(5, 1, 5, 1), xpd=TRUE)
      football_radarchart(ucl_defender_radar[c("Max","Min","Average"),],"Defender radar chart", color = c("blue","red"))
      legend(
        x = "bottom", legend = c("Average",), horiz = TRUE,
        bty = "n", pch = 20 , col = c("blue", "red"), text.col = "black",
        inset=c(0,-0.1),
        xpd = TRUE
      )
    }else{
      par(mar=c(5, 1, 5, 1), xpd=TRUE)
      football_radarchart(ucl_defender_radar[c("Max","Min","Average",player_name),],"Defender radar chart", color = c("blue","red"))
      legend(
        x = "bottom", legend = c("Average",player_name), horiz = TRUE,
        bty = "n", pch = 20 , col = c("blue", "red"), text.col = "black",
        inset=c(0,-0.1),
        xpd = TRUE
      )
    }
  }else if(type==4){
    if(player_name==""){
      par(mar=c(4, 1, 1, 1), xpd=TRUE)
      football_radarchart(ucl_goalkeeping_radar[c("Max","Min","Average"),],"Goalkeeper radar chart")
      legend(
        x = "bottom", legend = c("Average"), horiz = TRUE,
        bty = "n", pch = 20 , col = c("blue"), text.col = "black",
        inset=c(0,-0.1),
        xpd = TRUE
      )
    }else{
      par(mar=c(4, 1, 1, 1), xpd=TRUE)
      football_radarchart(ucl_goalkeeping_radar[c("Max","Min","Average",player_name),],"Goalkeeper radar chart", color = c("blue","red"))
      legend(
        x = "bottom", legend = c("Average",player_name), horiz = TRUE,
        bty = "n", pch = 20 , col = c("blue", "red"), text.col = "black",
        inset=c(0,-0.1),
        xpd = TRUE
      )
    }
    
  }
}

# radar chart for certain team
team_plotter_radar <- function(mode, team_data_mode, team_name){
  if (mode==4 || mode==5 || mode==6){
    if(team_data_mode==1){
      if(team_name==""){
        par(mar=c(4, 1, 1, 1), xpd=TRUE)
        football_radarchart(laliga_radar[c("Max","Min","Average"),],"Goalkeeper radar chart")
        legend(
          x = "bottom", legend = c("Average"), horiz = TRUE,
          bty = "n", pch = 20 , col = c("blue"), text.col = "black",
          inset=c(0,-0.1),
          xpd = TRUE
        )
      }else{
        par(mar=c(4, 1, 1, 1), xpd=TRUE)
        football_radarchart(laliga_radar[c("Max","Min","Average",team_name),],"Goalkeeper radar chart", color = c("blue","red"))
        legend(
          x = "bottom", legend = c("Average",team_name), horiz = TRUE,
          bty = "n", pch = 20 , col = c("blue", "red"), text.col = "black",
          inset=c(0,-0.1),
          xpd = TRUE
        )
      }
    }else{
      
    }
  }else{
    if(team_data_mode==1){
      if(team_name==""){
        par(mar=c(4, 1, 1, 1), xpd=TRUE)
        football_radarchart(laliga_radar[c("Max","Min","Average"),],"Goalkeeper radar chart")
        legend(
          x = "bottom", legend = c("Average"), horiz = TRUE,
          bty = "n", pch = 20 , col = c("blue"), text.col = "black",
          inset=c(0,-0.1),
          xpd = TRUE
        )
      }else{
        par(mar=c(4, 1, 1, 1), xpd=TRUE)
        football_radarchart(laliga_radar[c("Max","Min","Average",team_name),],"Goalkeeper radar chart", color = c("blue","red"))
        legend(
          x = "bottom", legend = c("Average",team_name), horiz = TRUE,
          bty = "n", pch = 20 , col = c("blue", "red"), text.col = "black",
          inset=c(0,-0.1),
          xpd = TRUE
        )
      }
    }else{
      
    }
  }
}

# modified radar chart
football_radarchart <- function(data, title, color="blue", label = colnames(data)){
  radarchart(data, pcol = color, pfcol = alpha(color, 0.5), plty = 1, cglcol = "grey",
             vlabels = label, title = title, axislabcol = "grey")
}


# plot main responsibility of a category
# goalkeeper-save defender-defense midfielder-assist&keypass attacker-score
player_plotter_main_res <- function(type,pname){
  if (type==1){
    ucl_forward_final %>% ggplot(aes(x=total_attempts/minutes_played*90,y=goals/minutes_played*90))+
      ggtitle("Forward's scoring statistics",)+geom_point()+
      scale_x_continuous("mean shooting(/90min)",limits = c(0,6.9))+scale_y_continuous("score(/90min)",limits = c(0,1.5))+
      geom_hline(yintercept = 0.34,col = "blue") + geom_vline(xintercept = 2.38, col = "blue") +
      theme(plot.title = element_text(size = 15, face = "bold"),
            axis.title = element_text(size = 15, face = "bold"))+
      geom_label(data=ucl_forward_final %>% filter(player_name==pname),
                 nudge_x = 0.1, nudge_y = 0.1,
                 aes(label=player_name))+
      geom_point(data=ucl_forward_final %>% filter(player_name==pname),
                 aes(x=total_attempts/minutes_played*90,y=goals/minutes_played*90), color="red",size=3)
  }else if(type==2){
    ucl_midfielder_final %>% ggplot(aes(y=pass_accuracy,x=pass_attempted/minutes_played*90,label=player_name))+
      ggtitle("Midfielder's key statistics",)+geom_point()+
      scale_x_continuous("mean pass(/90min)",limits = c(10,100))+scale_y_continuous("passing accuracy(%)",limits = c(30,100))+
      geom_hline(yintercept = 82.1,col = "blue") + geom_vline(xintercept = 45.8, col = "blue") +
      theme(plot.title = element_text(size = 15, face = "bold"),
            axis.title = element_text(size = 15, face = "bold"))+
      geom_label(data=ucl_midfielder_final %>% filter(player_name==pname),
                 nudge_x = 1, nudge_y = 1,
                 aes(label=player_name))+
      geom_point(data=ucl_midfielder_final %>% filter(player_name==pname),
                 aes(y=pass_accuracy,x=pass_attempted/minutes_played*90), color="red",size=3)
  }else if(type==3){
    ucl_defender_final %>% ggplot(aes(y=tackles/minutes_played*90,x=(t_won+0.001)/(tackles+0.01)*100,label=player_name))+
      ggtitle("Defender's key statistics",)+geom_point()+
      scale_x_continuous("tackle win rate(%)",limits = c(0,100))+scale_y_continuous("average tackles(/90min)",limits = c(0,5))+
      geom_hline(yintercept = 1.18,col = "blue") + geom_vline(xintercept = 45.57, col = "blue") +
      theme(plot.title = element_text(size = 15, face = "bold"),
            axis.title = element_text(size = 15, face = "bold"))+
      geom_label(data=ucl_defender_final %>% filter(player_name==pname),
                 nudge_x = 2, nudge_y = 0.2,
                 aes(label=player_name))+
      geom_point(data=ucl_defender_final %>% filter(player_name==pname),
                 aes(y=tackles/minutes_played*90,x=(t_won+0.001)/(tackles+0.01)*100), color="red",size=3)
  }else if(type==4){
    ucl_goalkeeping_key_stat %>% ggplot(aes(x=save_rate,y=mean_save,label=player_name))+
      ggtitle("Goalkeeper's key statistics",)+geom_point()+
      scale_x_continuous("save rate(%)",limits = c(0.35,1.2))+scale_y_continuous("mean save(/90min)",limits = c(0,7))+
      geom_hline(yintercept = 3.125,col = "blue") + geom_vline(xintercept = 0.661, col = "blue") +
      theme(plot.title = element_text(size = 15, face = "bold"),
            axis.title = element_text(size = 15, face = "bold"))+
      geom_label(data=ucl_goalkeeping_key_stat %>% filter(player_name==pname),
                 nudge_x = 0.05, nudge_y = 0.5,
                 aes(label=player_name))+
      geom_point(data=ucl_goalkeeping_key_stat %>% filter(player_name==pname),
                 aes(x=save_rate,y=mean_save), color="red",size=3)
  }
}


# plot additional distribution of a category
# goalkeeper-passing defender-recover & clearance midfielder-covering+defence attacker-passing
player_plotter_addition <- function(type,pname){
  if (type==1){
    ucl_forward_final %>% ggplot(aes(x=pass_attempted/minutes_played*90,y=pass_accuracy))+
      ggtitle("Forward's passing statistics",)+geom_point()+
      scale_x_continuous("mean pass(/90min)",limits = c(5,80))+scale_y_continuous("pass accuracy(%)",limits = c(35,95))+
      geom_hline(yintercept = 75.2,col = "blue") + geom_vline(xintercept = 30, col = "blue") +
      theme(plot.title = element_text(size = 15, face = "bold"),
            axis.title = element_text(size = 15, face = "bold"))+
      geom_label(data=ucl_forward_final %>% filter(player_name==pname),
                 nudge_x = 1, nudge_y = 1,
                 aes(label=player_name))+
      geom_point(data=ucl_forward_final %>% filter(player_name==pname),
                 aes(x=pass_attempted/minutes_played*90,y=pass_accuracy), color="red",size=3)
  }else if(type==2){
    ucl_midfielder_final %>% ggplot(aes(y=balls_recoverd/minutes_played*90,x=distance_covered/minutes_played*90,label=player_name))+
      ggtitle("Midfielder's distance covering & defence",)+geom_point()+
      scale_x_continuous("distance covered(km/90min)",limits = c(7.5,14))+scale_y_continuous("balls recovered(/90min)",limits = c(0,9.5))+
      geom_hline(yintercept = 3.87,col = "blue") + geom_vline(xintercept = 11.5, col = "blue") +
      theme(plot.title = element_text(size = 15, face = "bold"),
            axis.title = element_text(size = 15, face = "bold"))+
      geom_label(data=ucl_midfielder_final %>% filter(player_name==pname),
                 nudge_x = 0.2, nudge_y = 0.2,
                 aes(label=player_name))+
      geom_point(data=ucl_midfielder_final %>% filter(player_name==pname),
                 aes(y=balls_recoverd/minutes_played*90,x=distance_covered/minutes_played*90), color="red",size=3)
  }else if(type==3){
    ucl_defender_final %>% ggplot(aes(x=balls_recoverd/minutes_played*90,y=clearance_attempted/minutes_played*90))+
      ggtitle("Defender's recover & clearance",)+geom_point()+
      scale_x_continuous("win balls(/90min)",limits = c(0.5,11.5))+
      scale_y_continuous("attempts to clear the ball(/90min)",limits = c(0,10))+
      geom_hline(yintercept = 2.83,col = "blue") + geom_vline(xintercept = 5.41, col = "blue") +
      theme(plot.title = element_text(size = 15, face = "bold"),
            axis.title = element_text(size = 15, face = "bold"))+
      geom_label(data=ucl_defender_final %>% filter(player_name==pname),
                 nudge_x = 0.5, nudge_y = 0.5,
                 aes(label=player_name))+
      geom_point(data=ucl_defender_final %>% filter(player_name==pname),
                 aes(x=balls_recoverd/minutes_played*90,y=clearance_attempted/minutes_played*90), color="red",size=3)
  }else if(type==4){
    ucl_goalkeeping_final %>% ggplot(aes(x=mean_pass,y=pass_accuracy))+
      ggtitle("Goalkeeper's passing statistics",)+geom_point()+
      scale_x_continuous("mean pass(/90min)",limits = c(10,50))+scale_y_continuous("pass accuracy(%)",limits = c(45,100))+
      geom_hline(yintercept = 77.1,col = "blue") + geom_vline(xintercept = 31.05, col = "blue") +
      theme(plot.title = element_text(size = 15, face = "bold"),
            axis.title = element_text(size = 15, face = "bold"))+
      geom_label(data=ucl_goalkeeping_final %>% filter(player_name==pname),
                 nudge_x = 1, nudge_y = 3,
                 aes(label=player_name))+
      geom_point(data=ucl_goalkeeping_final %>% filter(player_name==pname),
                 aes(x=mean_pass,y=pass_accuracy), color="red",size=3)
  }
}

# plot additional distribution of a category
# goalkeeper-punch defender-passing midfielder-defend attacker-crossing&goals
player_plotter_addition2 <- function(type,pname){
  if (type==1){
    ucl_forward_final %>% ggplot(aes(x=cross_attempted/minutes_played*90,y=(goals+assists)/minutes_played*90))+
      ggtitle("Forward's crossing statistics",)+geom_point()+
      scale_x_continuous("mean cross(/90min)",limits = c(0,7.5))+scale_y_continuous("create goals(/90min)",limits = c(0,2.3))+
      geom_hline(yintercept = 0.75,col = "blue") + geom_vline(xintercept = 1.54, col = "blue") +
      theme(plot.title = element_text(size = 15, face = "bold"),
            axis.title = element_text(size = 15, face = "bold"))+
      geom_label(data=ucl_forward_final %>% filter(player_name==pname),
                 nudge_x = 0.2, nudge_y = 0.2,
                 aes(label=player_name))+
      geom_point(data=ucl_forward_final %>% filter(player_name==pname),
                 aes(x=cross_attempted/minutes_played*90,y=(goals+assists)/minutes_played*90), color="red",size=3)
  }else if(type==2){
    ucl_midfielder_final %>% ggplot(aes(y=(goals+assists)/minutes_played*90,x=distance_covered/minutes_played*90,label=player_name))+
      ggtitle("Midfielder's distance covering & attack",)+geom_point()+
      scale_x_continuous("distance covered(km/90min)",limits = c(7.5,14))+scale_y_continuous("create goals(/90min)",limits = c(0,1.7))+
      geom_hline(yintercept = 0.25,col = "blue") + geom_vline(xintercept = 11.5, col = "blue") +
      theme(plot.title = element_text(size = 15, face = "bold"),
            axis.title = element_text(size = 15, face = "bold"))+
      geom_label(data=ucl_midfielder_final %>% filter(player_name==pname),
                 nudge_x = 0.2, nudge_y = 0.1,
                 aes(label=player_name))+
      geom_point(data=ucl_midfielder_final %>% filter(player_name==pname),
                 aes(y=(goals+assists)/minutes_played*90,x=distance_covered/minutes_played*90), color="red",size=3)
  }else if(type==3){
    ucl_defender_final %>% ggplot(aes(x=pass_attempted/minutes_played*90,y=pass_accuracy))+
      ggtitle("Defender's passing statistics",)+geom_point()+
      scale_x_continuous("mean pass(/90min)",limits = c(0,110))+scale_y_continuous("pass accuracy(%)",limits = c(40,100))+
      geom_hline(yintercept = 83.81,col = "blue") + geom_vline(xintercept = 50.27, col = "blue") +
      theme(plot.title = element_text(size = 15, face = "bold"),
            axis.title = element_text(size = 15, face = "bold"))+
      geom_label(data=ucl_defender_final %>% filter(player_name==pname),
                 nudge_x = 1, nudge_y = 3,
                 aes(label=player_name))+
      geom_point(data=ucl_defender_final %>% filter(player_name==pname),
                 aes(x=pass_attempted/minutes_played*90,y=pass_accuracy), color="red",size=3)
  }else if(type==4){
    ucl_goalkeeping_final %>% ggplot(aes(x=punches.made))+
      ggtitle("Goalkeeper's punches tendency",)+
      geom_density(fill='blue',alpha=0.5)+
      scale_x_continuous("punches made",limits = c(-3,15))+scale_y_continuous("propotion(%)",limits = c(0,0.25))+
      theme(plot.title = element_text(size = 15, face = "bold"),
            axis.title = element_text(size = 15, face = "bold"))+
      geom_vline(xintercept = (ucl_goalkeeping_final %>% filter(player_name==pname))[,9],col = "red") +
      geom_label(data=ucl_goalkeeping_final %>% filter(player_name==pname),
                 aes(y=0.25,label=player_name))
  }
}

# plot player's discipline
player_plotter_discipline <- function(type,pname){
  posi <- "Goalkeeper"
  if (type==1){
    posi <- "Forward"
  }else if(type==2){
    posi <- "Midfielder"
  }else if(type==3){
    posi <- "Defender"
  }else if(type==4){
    posi <- "Goalkeeper"
  }
  if(nrow(ucl_disciplinary %>% filter(player_name==pname))!=0){
    ucl_disciplinary %>% filter(position==posi) %>% ggplot(aes(x=fouls_committed/match_played,y=fouls_suffered/match_played))+
      ggtitle(paste(posi,"'s ","disciplinary data"))+geom_point()+
      scale_x_continuous("foulscommitted(/match)",limits = c(0,4))+scale_y_continuous("fouls suffered(/match)",limits = c(0,3.5))+
      geom_hline(yintercept = 0.7588,col = "blue") + geom_vline(xintercept = 0.8747, col = "blue") +
      theme(plot.title = element_text(size = 15, face = "bold"),
            axis.title = element_text(size = 15, face = "bold"))+
      geom_label(data=ucl_disciplinary %>% filter(player_name==pname),
                 nudge_x = 0.2, nudge_y = 0.2,
                 aes(label=player_name))+
      geom_point(data=ucl_disciplinary %>% filter(player_name==pname),
                 aes(x=fouls_committed/match_played,y=fouls_suffered/match_played), color="red",size=3)
  }else{
    ept_data <- data.frame(x=c(2),y=c(1.75))
    ggplot(ept_data,aes(x,y))+ggtitle(paste(posi,"'s ","disciplinary data"))+
      scale_x_continuous("foulscommitted(/match)",limits = c(0,4))+scale_y_continuous("fouls suffered(/match)",limits = c(0,3.5))+
      geom_text(aes(label="This player had no foul-related data.",size=10))+
      theme(plot.title = element_text(size = 15, face = "bold"),
            axis.title = element_text(size = 15, face = "bold"),
            legend.position = 'none')
  }
}

s_team_input <- function(num){
  if(num==6||num==8){
    cho <- laliga_team[,1]
  }else if (num==4||num==5||num==7){
    cho <- laliga_team[,1]
  }
  
  pickerInput(
    inputId = "team_name",
    label = "Search for a team, click to choose",
    choices = cho,
    options = list(`live-search`=TRUE)
  )
  
  # searchInput(
  #   inputId = 'team_name',
  #   label = "Search for a team, click search icon to update or hit 'Enter'",
  #   placeholder = pholder,
  #   btnSearch = icon("search"),
  #   btnReset = icon('remove'),
  #   width = '100%'
  # )
}

s_player_input <- function(num){
  if(num==1){
    cho <- ucl_forward_final[,1]
  }else if (num==2){
    cho <- ucl_midfielder_final[,1]
  }else if (num==3){
    cho <- ucl_defender_final[,1]
  }else if (num==4){
    cho <- ucl_goalkeeping[,2]
  }
  
  pickerInput(
    inputId = "player_name",
    label = "Search for a player, click to choose",
    choices = cho,
    options = list(`live-search`=TRUE)
  )
  
  # searchInput(
  #   inputId = 'player_name',
  #   label = "Search for a player, click search icon to update or hit 'Enter'",
  #   placeholder = pholder,
  #   btnSearch = icon("search"),
  #   btnReset = icon('remove'),
  #   width = '100%'
  # )
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

library(ggplot2)
source('data.R')
library(fmsb)

# radar chart for a certain player / average data
player_plotter1 <- function(type, player_name){
  if (type==1){
    
  }else if(type==2){
    
  }else if(type==3){
    
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

# modified radar chart
football_radarchart <- function(data, title, color="blue", label = colnames(data)){
  radarchart(data, pcol = color, pfcol = alpha(color, 0.5), plty = 1, cglcol = "grey",
             vlabels = label, title = title, axislabcol = "grey")
}


# plot main responsibility of a category
# goalkeeper-save defender-defense midfielder-assist&keypass attacker-score
player_plotter2 <- function(type,pname){
  if (type==1){
    
  }else if(type==2){
    
  }else if(type==3){
    
  }else if(type==4){
    ucl_goalkeeping_key_stat %>% ggplot(aes(x=save_rate,y=mean_save,label=player_name))+
      ggtitle("Goalkeeper's key statistics",)+geom_point()+
      scale_x_continuous("save rate(%)",limits = c(0.35,1.2))+scale_y_continuous("mean save(/90min)",limits = c(0,7))+
      geom_hline(yintercept = 3.125,col = "blue") + geom_vline(xintercept = 0.661, col = "blue") +
      theme(plot.title = element_text(size = 15, face = "bold"),
            axis.title = element_text(size = 15, face = "bold"))+
      geom_label(data=ucl_goalkeeping_key_stat %>% filter(player_name==pname),
                 nudge_x = 0.05, nudge_y = 0.5,
                 aes(label=paste(player_name,", ", club)))+
      geom_point(data=ucl_goalkeeping_key_stat %>% filter(player_name==pname),
                 aes(x=save_rate,y=mean_save), color="red",size=3)
  }
}


# plot additional distribution of a category
# goalkeeper-passing defender-passing midfielder-attacking attacker-passing
player_plotter3 <- function(type,pname){
  if (type==1){
    
  }else if(type==2){
    
  }else if(type==3){
    
  }else if(type==4){
    ucl_goalkeeping_final %>% ggplot(aes(x=mean_pass,y=pass_accuracy))+
      ggtitle("Goalkeeper's passing statistics",)+geom_point()+
      scale_x_continuous("mean pass(/90min)",limits = c(10,50))+scale_y_continuous("pass accuracy(%)",limits = c(45,100))+
      geom_hline(yintercept = 77.1,col = "blue") + geom_vline(xintercept = 31.05, col = "blue") +
      theme(plot.title = element_text(size = 15, face = "bold"),
            axis.title = element_text(size = 15, face = "bold"))+
      geom_label(data=ucl_goalkeeping_final %>% filter(player_name==pname),
                 nudge_x = 1, nudge_y = 3,
                 aes(label=paste(player_name,", ", club)))+
      geom_point(data=ucl_goalkeeping_final %>% filter(player_name==pname),
                 aes(x=mean_pass,y=pass_accuracy), color="red",size=3)
  }
}

# plot additional distribution of a category
# goalkeeper-punch defender-attacking midfielder-defend attacker-defend
player_plotter4 <- function(type,pname){
  if (type==1){
    
  }else if(type==2){
    
  }else if(type==3){
    
  }else if(type==4){
    ucl_goalkeeping_final %>% ggplot(aes(x=punches.made))+
      ggtitle("Goalkeeper's punches tendency",)+
      geom_density(fill='blue',alpha=0.5)+
      scale_x_continuous("punches made",limits = c(-3,15))+scale_y_continuous("propotion(%)",limits = c(0,0.25))+
      theme(plot.title = element_text(size = 15, face = "bold"),
            axis.title = element_text(size = 15, face = "bold"))+
      geom_vline(xintercept = (ucl_goalkeeping_final %>% filter(player_name==pname))[,9],col = "red") +
      geom_label(data=ucl_goalkeeping_final %>% filter(player_name==pname),
                 aes(x=punches.made,y=0.25,label=player_name))
  }
}

# plot player's discipline
player_plotter5 <- function(type,pname){
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
                 aes(label=paste(player_name)))+
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
  if(num!=4){
    cho <- ucl_key_stats[,1]
  }else{
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

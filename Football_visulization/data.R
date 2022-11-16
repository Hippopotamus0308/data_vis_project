library(tidyverse)
library(tidyr)
library(dplyr)

main_plot_header_set <- c("Player statistics in UCL","Player statistics in EPL","Player statistics comparation",
                          "Team statistics in Serie A","Team statistics in La Liga",
                          "Signing suggestion for Serie A","Signing suggest for La Liga", 
                          "Introduction-Purpose","Introduction-Data")
main_description <- c("This project try to visulize players performance in UCL last season, as well as La Liga & Serie A's team statistics. Apart from visulization, this project also offers some signing advices towards La Liga & Serie A teams.",
                      "I collected season 2021-2022's UCL player data, and 2021-2022's La Liga & Serie A's team data. Data includes player/team's attacking, defense, possesion and passing statistics.")

main_summary <- c("All code and data can be found on github: ",
                  "Raw data is on kaggle, data is cleaned to be used in this project.")

ucl_attacking <- read.csv('./data/UCL/attacking.csv')
ucl_attempts <- read.csv('./data/UCL/attempts.csv')
ucl_defend <- read.csv('./data/UCL/defending.csv')
ucl_disciplinary <- read.csv('./data/UCL/disciplinary.csv')
ucl_distribution <- read.csv('./data/UCL/distributon.csv')
ucl_goalkeeping <- read.csv('./data/UCL/goalkeeping.csv')
ucl_goals <- read.csv('./data/UCL/goals.csv')
ucl_key_stats <- read.csv('./data/UCL/key_stats.csv')

# deal with goalkeeper data
mean_save <- ucl_goalkeeping[5]/ucl_goalkeeping[10]
mean_conceded <- ucl_goalkeeping[6]/ucl_goalkeeping[10]
cleansheet_rate <- ucl_goalkeeping[8]/ucl_goalkeeping[10]
ucl_goalkeeping_pass <- ucl_distribution %>% filter(position=='Goalkeeper')
mean_pass <- ucl_goalkeeping_pass[6]/ucl_goalkeeping_pass[12]
ucl_goalkeeping_pass <- cbind(ucl_goalkeeping_pass[2],ucl_goalkeeping_pass[5:7],mean_pass)
colnames(ucl_goalkeeping_pass)[5] <- c('mean_pass')
ucl_goalkeeping_final <- cbind(ucl_goalkeeping,mean_save,mean_conceded,cleansheet_rate)
colnames(ucl_goalkeeping_final)[11:13] <-c('mean_save','mean_conceded','cleansheet_rate')
ucl_goalkeeping_final <- merge(ucl_goalkeeping_final,ucl_goalkeeping_pass,by='player_name')

## goalkeeper radar data
ucl_goalkeeping_max_min_average <- data.frame(
  punches.made = c(12, 0, 2.18), mean_save = c(6, 0, 3.12), mean_conceded = c(4, 0, 1.64),
  cleansheet_rate = c(1, 0, 0.24), pass_accuracy = c(97, 0, 77.09), mean_pass = c(44.84, 0, 31.05)
)
rownames(ucl_goalkeeping_max_min_average) <- c("Max", "Min", "Average")
ucl_goalkeeping_radar <- cbind(ucl_goalkeeping_final[1],ucl_goalkeeping_final[9],ucl_goalkeeping_final[11:14],ucl_goalkeeping_final[17])
rownames(ucl_goalkeeping_radar) <- ucl_goalkeeping_radar$player_name
ucl_goalkeeping_radar <- rbind(ucl_goalkeeping_max_min_average, ucl_goalkeeping_radar[2:7])

## goalkeeper key stat
### mean save_rate 0.661 save 3.12; min 0.449 1.00; max 1 6
ucl_goalkeeping_key_stat <- cbind(ucl_goalkeeping_final[1],ucl_goalkeeping_final[3],
                                  ucl_goalkeeping_final[5]/(ucl_goalkeeping_final[5]+ucl_goalkeeping_final[6]),
                                  ucl_goalkeeping_final[11])
colnames(ucl_goalkeeping_key_stat)[3] <- c("save_rate")


# deal with defender data
ucl_defender_passing <- (ucl_distribution %>% filter(position=='Defender'))[c(2,5,6,12)]
ucl_defender_defend <- (ucl_defend %>% filter(position=='Defender'))[c(2,5,6,7,8,9)]
ucl_defender_final <- ucl_key_stats %>% filter(position=='Defender')
ucl_defender_final <- merge(ucl_defender_final,ucl_defender_defend, by="player_name")
ucl_defender_final <- merge(ucl_defender_final,ucl_defender_passing, by="player_name")
ucl_defender_final[is.na(ucl_defender_final)] <- 0

ucl_defender_final <- distinct(ucl_defender_final,player_name,.keep_all = T)

ucl_defender_key_stat <- ucl_defender_final[c(1,4,8,9,10,11,13,14,15)]

## defender radar data
### balls_recovered / tackle / tackle won / clearance / distance_cover / pass / pass_accuracy every 90 minutes

ucl_defender_radar <- cbind(ucl_defender_key_stat[1],apply(ucl_defender_key_stat[3],2,as.numeric)/ucl_defender_key_stat[2]*90,
                            ucl_defender_key_stat[4]/ucl_defender_key_stat[2]*90,
                            ucl_defender_key_stat[5]/ucl_defender_key_stat[2]*90,
                            ucl_defender_key_stat[6]/ucl_defender_key_stat[2]*90,
                            ucl_defender_key_stat[7]/ucl_defender_key_stat[2]*90,
                            ucl_defender_key_stat[8],
                            ucl_defender_key_stat[9]/ucl_defender_key_stat[2]*90)
rownames(ucl_defender_radar) <- ucl_defender_radar$player_name
ucl_defender_radar <- ucl_defender_radar[c(2,3,4,5,6,7,8)]
colnames(ucl_defender_radar)[1] <- c("distance_covered")
colnames(ucl_defender_radar)[4] <- c("tackle_won")
ucl_defender_max_min_average <- data.frame(
  distance_covered = c(12.74, 5, 10.43), balls_recoverd = c(10.73, 0, 5.41), tackles = c(4.12, 0, 1.18),
  tackle_won = c(2.69, 0, 0.59), clearance_attempted = c(10, 0, 2.83), pass_accuracy = c(97.5, 30, 83.81),
  pass_attempted = c(105, 0, 50.27)
)
rownames(ucl_defender_max_min_average) <- c("Max", "Min", "Average")
ucl_defender_radar <- rbind(ucl_defender_max_min_average, ucl_defender_radar)

# deal with midfielder data
ucl_midfielder_passing <- (ucl_distribution %>% filter(position=='Midfielder'))[c(2,5,6,12)]
ucl_midfielder_defend <- (ucl_defend %>% filter(position=='Midfielder'))[c(2,5,6,7,8,9)]
ucl_midfielder_final <- ucl_key_stats %>% filter(position=='Midfielder')
ucl_midfielder_final <- merge(ucl_midfielder_final,ucl_midfielder_defend, by="player_name")
ucl_midfielder_final <- merge(ucl_midfielder_final,ucl_midfielder_passing, by="player_name")
ucl_midfielder_final[is.na(ucl_midfielder_final)] <- 0

ucl_midfielder_final[,8] <- as.numeric(unlist(ucl_midfielder_final[,8]))

ucl_midfielder_final <- distinct(ucl_midfielder_final,player_name,.keep_all = T)

ucl_midfielder_key_stat <- ucl_midfielder_final[c(1,4,6,7,8,9,10,11,13,14,15)]

## midfielder radar data
### pass_accuracy, pass_attempted, distance_covered, balls_recovered, tackles won, goal+assist per 90 minutes
ucl_midfielder_radar <- cbind(ucl_midfielder_key_stat[1],
                              (ucl_midfielder_key_stat[3]+ucl_midfielder_key_stat[4])/ucl_midfielder_key_stat[2]*90,
                              apply(ucl_midfielder_key_stat[5],2,as.numeric)/ucl_midfielder_key_stat[2]*90,
                              ucl_midfielder_key_stat[6]/ucl_midfielder_key_stat[2]*90,
                              ucl_midfielder_key_stat[8]/ucl_midfielder_key_stat[2]*90,ucl_midfielder_key_stat[10],
                              ucl_midfielder_key_stat[11]/ucl_midfielder_key_stat[2]*90)
rownames(ucl_midfielder_radar) <- ucl_midfielder_radar$player_name
ucl_midfielder_radar <- ucl_midfielder_radar[c(2,3,4,5,6,7)]
colnames(ucl_midfielder_radar)[1] <- c("create_goals")
colnames(ucl_midfielder_radar)[2] <- c("distance_covered")
colnames(ucl_midfielder_radar)[4] <- c("tackle_won")

ucl_midfielder_max_min_average <- data.frame(
  create_goals = c(1.64, 0, 0.25), distance_covered = c(13.8,7.8,11.5), balls_recoverd = c(9.08, 0.3, 3.87),
  tackle_won = c(3.76, 0, 0.61), pass_accuracy = c(98, 35.70, 82.19), pass_attempted = c(99.89, 12.83, 45.78)
)

rownames(ucl_midfielder_max_min_average) <- c("Max", "Min", "Average")
ucl_midfielder_radar <- rbind(ucl_midfielder_max_min_average, ucl_midfielder_radar)


# deal with attacker data
ucl_forward_passing <- (ucl_distribution %>% filter(position=='Forward'))[c(2,5,6,9,10)]
ucl_forward_attack1 <- (ucl_attempts %>% filter(position=='Forward'))[c(2,5,6,7,8)]
ucl_forward_final <- ucl_key_stats %>% filter(position=='Forward')
ucl_forward_final <- merge(ucl_forward_final,ucl_forward_passing, by="player_name")
ucl_forward_final <- merge(ucl_forward_final,ucl_forward_attack1, by="player_name")
ucl_forward_final[is.na(ucl_forward_final)] <- 0

ucl_forward_final <- distinct(ucl_forward_final,player_name,.keep_all = T)

ucl_forward_key_stat <- ucl_forward_final[c(1,4,6,7,8,9,10,11,12,13,14)]

## Forward radar data
### pass_accuracy, pass_attempted, distance_covered, attempts, attempts_on_target, cross, goal+assist per 90 minutes
ucl_forward_radar <- cbind(ucl_forward_key_stat[1],
                              (ucl_forward_key_stat[3]+ucl_forward_key_stat[4])/ucl_forward_key_stat[2]*90,
                              apply(ucl_forward_key_stat[5],2,as.numeric)/ucl_forward_key_stat[2]*90,
                              ucl_forward_key_stat[7]/ucl_forward_key_stat[2]*90,ucl_forward_key_stat[6],
                              ucl_forward_key_stat[8]/ucl_forward_key_stat[2]*90,
                              ucl_forward_key_stat[10]/ucl_forward_key_stat[2]*90,
                              ucl_forward_key_stat[11]/ucl_forward_key_stat[2]*90)
rownames(ucl_forward_radar) <- ucl_forward_radar$player_name
ucl_forward_radar <- ucl_forward_radar[c(2,3,4,5,6,7,8)]
colnames(ucl_forward_radar)[1] <- c("create_goals")
colnames(ucl_forward_radar)[2] <- c("distance_covered")
colnames(ucl_forward_radar)[6] <- c("total_shoots")
colnames(ucl_forward_radar)[7] <- c("shoots_on_target")

ucl_forward_max_min_average <- data.frame(
  create_goals = c(2.2, 0, 0.75), distance_covered = c(12.7, 8.39, 10.92), pass_attempted = c(79.7, 9, 29.56),
  pass_accuracy = c(93.6, 36.5, 75.16), cross_attempted = c(7.38, 0, 1.54), total_shoots = c(6.78, 0.3, 2.38),
  shoots_on_target = c(3.1, 0, 0.9)
)

rownames(ucl_forward_max_min_average) <- c("Max", "Min", "Average")
ucl_forward_radar <- rbind(ucl_forward_max_min_average, ucl_forward_radar)


## La liga Teams data
laliga_team <-  read.csv('./data/LL/laliga21-22.csv')
laliga_team <- laliga_team[,-1]

laliga_res <- laliga_team[c('Squad','W','D','L','Pts')]
colnames(laliga_res) <- c('Squad','Win','Draw','Lose','Pts')
laliga_res_long <- laliga_res %>% pivot_longer(Win:Lose,names_to = 'result',values_to = 'number')

laliga_all_attack <- rbind(c('average',1.23,1.23,0.82,31.7),laliga_team[c('Squad','GP90','XG90','XA90','shots.per')])
laliga_all_attack[,c(2,3,4,5)] <- as.numeric(unlist(laliga_all_attack[,c(2,3,4,5)]))
colnames(laliga_all_attack) <- c('Squad','goal','ex.goal','ex.assist','conversion.rate')
laliga_all_attack[,5] <- laliga_all_attack[,5]/100
laliga_attack_long <- laliga_all_attack %>% pivot_longer(goal:conversion.rate,names_to = 'type',values_to = 'value')

laliga_all_pass <- rbind(c('average',77.8,96080),laliga_team[c('Squad','pass.completion','prog.dist')])
laliga_all_pass[,c(2,3)] <- as.numeric(unlist(laliga_all_pass[,c(2,3)]))

laliga_all_possess <- rbind(c('average',50.1,96080),laliga_team[c('Squad','poss','prog.dist')])
laliga_all_possess[,c(2,3)] <- as.numeric(unlist(laliga_all_possess[,c(2,3)]))

laliga_all_defense <- rbind(c('average',48.2,47.4,69.9,576.7,50),laliga_team[c('Squad','GA','xGA','Save.per','fouls','aerial.per')])
laliga_all_defense[,c(2,3,4,5,6)] <- as.numeric(unlist(laliga_all_defense[,c(2,3,4,5,6)]))
colnames(laliga_all_defense) <- c('Squad','scored','ex.scored','save.per','fouls/game','aerial.per')
laliga_all_defense[,5] <- laliga_all_defense[,5]/38
laliga_defense_long <- laliga_all_defense %>% pivot_longer(scored:aerial.per,names_to = 'type',values_to = 'value')

### laliga radar
laliga_radar <- laliga_team[c('Squad','GF','GD','age','poss','XG90','Save.per','pass.completion')]
rownames(laliga_radar)<-laliga_radar$Squad
laliga_radar <- laliga_radar[,-1]

laliga_max_min_average <- data.frame(
  GF = c(80,31,47.8), GD = c(49,-34,0), age = c(29.1,24.8,27.7),
  poss = c(64.8,40.9,50.2), XG90 =c(1.96,0.78,1.23), Save.per = c(77.2,60.1,69.9),
  pass.completion = c(87.7,69.7,77.8)
)

rownames(laliga_max_min_average) <- c('Max','Min','Average')
laliga_radar <- rbind(laliga_max_min_average,laliga_radar)

colnames(laliga_radar)<-c('Goal scored','Goal difference','age','possession %','expeced goals/90min','save %','pass %')


## Serie A Teams data
serieA_general <- read.delim('./data/SA/SerieA-Team-Standard-Stats.csv',sep = ';')
serieA_general <- serieA_general[c('Squad','Age','Poss','PerAst','CrdY','CrdR','PerxA')]
serieA_league <- read.delim('./data/SA/SerieA-Team-League-Stats.csv',sep = ';')
serieA_league <- serieA_league[c('Squad','W','D','L','Pts','GF','GD','xG','xGA','xGD.90')]
serieA_defense <- read.delim('./data/SA/SerieA-Team-Defensive-Actions.csv',sep = ';')
serieA_defense <- serieA_defense[c('Squad','TotTkl','TotTklW','PressTot','PressRt')]
serieA_score <- read.delim('./data/SA/SerieA-Team-Shooting-Stats.csv',sep = ';')
serieA_score <- serieA_score[c('Squad','Gls','Shd90','SoTd90','xG')]
serieA_pass <- read.delim('./data/SA/SerieA-Team-Passing-Stats.csv',sep = ';')
serieA_pass <- serieA_pass[c('Squad','AttTot','TotCmpRt','Ast','xA','KP','ProgPs')]
serieA_possess <- read.delim('./data/SA/SerieA-Team-Possession-Stats.csv',sep = ';')
serieA_possess <- serieA_possess[c('Squad','Poss','TotTouc','SuccDrib','AttDrib','ProgCarr','ProgRec')]

serieA_res <- serieA_league[c('Squad','W','D','L','Pts')]
colnames(serieA_res) <- c('Squad','Win','Draw','Lose','Pts')
serieA_res_long <- serieA_res %>% pivot_longer(Win:Lose,names_to = 'result',values_to = 'number')

serieA_all_attack <- rbind(c('average',52.6,13,4.2,51.4),serieA_score)
serieA_all_attack[,c(2,3,4,5)] <- as.numeric(unlist(serieA_all_attack[,c(2,3,4,5)]))
colnames(serieA_all_attack) <- c('Squad','goal','shoots.90min','on.target.90min','ex.goal')
serieA_attack_long <- serieA_all_attack %>% pivot_longer(goal:ex.goal,names_to = 'type',values_to = 'value')

serieA_all_defense <- rbind(c('average',636.7,390.7,5540,29.8),serieA_defense)
serieA_all_defense[,c(2,3,4,5)] <- as.numeric(unlist(serieA_all_defense[,c(2,3,4,5)]))
colnames(serieA_all_defense) <- c('Squad','tackle','tackle.win','press','press.rate')
serieA_defense_long <- serieA_all_defense %>% pivot_longer(tackle:press.rate,names_to = 'type',values_to = 'value')

serieA_all_pass <- rbind(c('average',18363,79.7,34.4,360,1191),serieA_pass[c('Squad','AttTot','TotCmpRt','Ast','KP','ProgPs')])
serieA_all_pass[,c(2,3,4,5,6)] <- as.numeric(unlist(serieA_all_pass[,c(2,3,4,5,6)]))
colnames(serieA_all_pass) <- c('Squad','Pass','Pass.rate','Assist','Key.pass','Progressive.pass')
serieA_pass_long <- serieA_all_pass %>% pivot_longer(Pass:Key.pass,names_to = 'type',values_to = 'value')

serieA_all_possess <- rbind(c('average',50,22672,297.3,557,1509),serieA_possess[c('Squad','Poss','TotTouc','SuccDrib','AttDrib','ProgCarr')])
serieA_all_possess[,c(2,3,4,5,6)] <- as.numeric(unlist(serieA_all_possess[,c(2,3,4,5,6)]))
colnames(serieA_all_possess) <- c('Squad','Possession','Touch.ball','Dribble.success','Total.dribble','Progressive.carry')


## Serie A radar 
serieA_radar <- cbind(serieA_general[c('Squad','Age')],
                      serieA_defense[c('TotTklW','PressRt')],serieA_score[c('Gls','xG')],serieA_pass['Ast'],
                      serieA_possess['Poss'])
rownames(serieA_radar) <- serieA_radar$Squad
serieA_radar <- serieA_radar[,-1]
serieA_max_min_average <- data.frame(
  Age = c(29,24.4,26.8), TotTklW = c(489,306,390.7), PressRt = c(32.3,26.7, 29.8),
  Gls = c(83,26,52.6), xG =c(81.4,36.1,51.4), Ast = c(57,19, 34.4),
  Poss = c(58.5,41,50)
)
rownames(serieA_max_min_average) <- c('Max','Min','Average')
serieA_radar <- rbind(serieA_max_min_average,serieA_radar)
colnames(serieA_radar)<- c('Age','Tackle won','Press rate','Goals','Expect Goal','Assist','Possesion')
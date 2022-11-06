library(tidyverse)
library(tidyr)
library(dplyr)

main_plot_header_set <- c("Player statistics in UCL","Player statistics in EPL","Player statistics comparation",
                          "Team statistics in UCL","Team statistics in La Liga","Team statistics in Serie A",
                          "Signing suggest for La Liga", "Signing suggestion for Serie A")

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


# deal with attacker data
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


# deal with midfielder data


# deal with attacker data
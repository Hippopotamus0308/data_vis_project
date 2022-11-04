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

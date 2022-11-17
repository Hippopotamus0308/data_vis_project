### data_vis_project

#### Introduction

##### 1) Code & data

All code and data can be found on https://github.com/Hippopotamus0308/data_vis_project , in a public repository.

##### 2) Summary of major files and folders

This repo/ZIP files contains the README.md(this file) for instruction, project proposal, final report, and the folder **Football_visulization**(which contains the code) and folder **Screenshot** which contains some of the screenshots of shiny app.

In Football_visulization folder, server.R and ui.R are the main files for shiny app. data.R is used for prepossess data, and plot_func.R stored plot function used in shiny app.

Apart from above four R files, the **data** folder stores data used in this project. In data folder, **LL** folder contains 2021-2022 Spanish La Liga team statistics, **SA** folder contains 2021-2022 Italian Serie A team statistics, **UCL** folder contains 2021-2022 European Champion League player statistics. **All the data are .csv files**

##### 3) Instruction to run it

You can download all files by

```
git clone https://github.com/Hippopotamus0308/data_vis_project.git
```

These packages should be installed before running:

- shiny
- shinyWidgets
- ggplot2
- shinycssloaders
- plotly
- fmsb
- ggrepel
- tidyverse
- tidyr
- dplyr

You can install them using following script. (It's from Lab materials)

```R
required_packages <- c("shiny", "shinyWidgets","ggplot2","shinycssloaders","plotly","fmsb","ggrepel","tidyverse","tidyr","dplyr")
installed_packages <- rownames(installed.packages()) 
to_install <- setdiff(required_packages, installed_packages)  
install.packages(to_install)
```

After that, you can open ui.R and server.R in RStudio, directly click 'Run App' button to run it. (You don't have to run plot_func.R or data.R manually) Or you can use `runApp()` in Console to start it.

##### 3) Data source

- La Liga data: https://www.kaggle.com/datasets/asifsyed1310/la-liga-202122-season-stats
- Serie A data: https://www.kaggle.com/datasets/mechatronixs/20212022-season-italy-seriea-team-datasets?select=SerieA-Team-Standard-Stats.csv
- UCL data: https://www.kaggle.com/datasets/azminetoushikwasi/ucl-202122-uefa-champions-league?select=goals.csv


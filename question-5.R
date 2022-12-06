#delfina's question
library(nflfastR)
library(ggplot2)
library(dplyr)
pbp_2021 <- load_pbp(2021)
run_plays <- pbp_2021 %>%
  filter(play_type == "run")
df_summary <- run_plays %>%
  group_by(posteam) %>%
  summarise(avg_yard=mean(yards_gained, na.rm=TRUE))



#we want to use to posteam variable to group the data, use yards_gained for the summary 
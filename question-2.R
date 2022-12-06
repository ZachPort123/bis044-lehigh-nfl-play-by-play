# Zach's Question; Question 2
# Are run or pass plays more successful in converting third downs?
library(nflfastR)
library(ggplot2)
library(dplyr)
library(ggplotgui)
pbp_2021 <- load_pbp(2021) # Loading in data

# Filtering for run and pass plays on third down, selecting a bunch of variables
run_pass_third_downs <- pbp_2021 %>%
  filter(play_type == "run" | play_type == "pass", down == 3) %>%
  select(play_type, ydstogo, first_down, first_down_rush, first_down_pass, third_down_converted, third_down_failed)

# Finding conversion rates for rush and pass plays by yards to go
conversion_rates <- run_pass_third_downs %>%
  group_by(play_type, ydstogo) %>%
  mutate(conversion_rate = mean(first_down)) %>%
  select(play_type, ydstogo, conversion_rate)



ggplot_shiny(conversion_rates)

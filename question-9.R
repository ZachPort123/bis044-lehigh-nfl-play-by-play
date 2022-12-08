# Zach's Question; Question 9
# What is the distribution of win probability added among quarterbacks?
library(nflfastR)
library(ggplot2)
library(dplyr)
library(ggplotgui)
pbp_2021 <- load_pbp(2021) # Loading in data

# Creating stats for quarterbacks with a minimum 250 dropbacks
qbs_2021 <- pbp_2021 %>%
  group_by(id,name) %>%
  summarize(
    year = 2021,
    team = last(posteam),
    plays = n(),
    dropbacks = sum(pass, na.rm = TRUE),
    total_wpa = sum(wpa, na.rm = TRUE),
    wpa_per_play = sum(wpa, na.rm = TRUE)/n(),
    total_epa = sum(qb_epa, na.rm = TRUE),
    epa_per_play = sum(qb_epa, na.rm = TRUE)/n(),
  ) %>%
  ungroup() %>%
  filter(dropbacks>250)

# Creating summary statistics for each of the stats
summary(qbs_2021)

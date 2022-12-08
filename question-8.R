# Alex's Question; Question 1
# Do teams run or pass more in the postseason compared to the regular season?
library(nflfastR)
library(ggplot2)
library(dplyr)
library(ggplotgui)
pbp_2021 <- load_pbp(2021) # Loading in data

# Filtering for run and pass plays and selecting play type and season type
run_pass_plays <- pbp_2021 %>%
  filter(play_type == "run" | play_type == "pass") %>%
  select(play_type, season_type)


# Finding total number of plays in post season and regular season
run_pass_plays_total <- run_pass_plays %>%
  group_by(season_type) %>%
  summarise(plays = n())

# Creating variables to store the totals
regular_season_plays <- run_pass_plays_total$plays[2]
post_season_plays <- run_pass_plays_total$plays[1]


# Finding the percentage of run and pass plays in the regular and post season
run_pass_plays_freq <- run_pass_plays %>%
  group_by(season_type, play_type) %>%
  summarise(plays = n()) %>%
  mutate(prob = if_else(season_type == "REG", plays/regular_season_plays, plays/post_season_plays))

# Creating a bar plot to display the data
bp <- ggplot(run_pass_plays_freq, aes(x=season_type, y=prob, fill=play_type)) +
  geom_bar(width = 0.6, stat = "identity") +
  labs(title = "Percentage of Play Types Related to Season Type",
       subtitle = "2021 NFL Season",
       caption = "source: nflfastr",
       x = "Season Type",
       y = "Percentage of Plays",
       color = "Play Type") +
  theme_bw()
bp

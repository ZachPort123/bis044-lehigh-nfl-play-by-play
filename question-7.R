# Question 7
# Does offense get better in the postseason compared to the regular season?
library(nflfastR)
library(ggplot2)
library(dplyr)
library(ggplotgui)
pbp_2021 <- load_pbp(2021) # Loading in data

# Generating summary statistics for per play data
summary_play_data <- pbp_2021 %>%
  group_by(season_type) %>%
  filter(special == 0) %>%
  mutate(passing_yards_real = if_else(incomplete_pass == 1, 0, passing_yards)) %>%
  summarise(plays = n(),
            yards_per_play = mean(yards_gained, na.rm = TRUE),
            yards_per_pass_play = mean(passing_yards_real, na.rm = TRUE),
            yards_per_rush_play = mean(rushing_yards, na.rm = TRUE),
            avg_epa = mean(epa, na.rm = TRUE),
            avg_wpa = mean(wpa, na.rm = TRUE),
            success_rate = mean(success, na.rm = TRUE))

# Generating statistics for individual games
game_data <- pbp_2021 %>%
  group_by(game_id, posteam, season_type) %>%
  filter(special == 0, !is.na(posteam)) %>%
  summarise(game_yards = sum(yards_gained, na.rm = TRUE),
            game_pass_yards = sum(passing_yards, na.rm = TRUE),
            game_rush_yards = sum(rushing_yards, na.rm = TRUE),
            game_total_epa = sum(epa, na.rm = TRUE),
            game_total_wpa = sum(wpa, na.rm = TRUE))

# Generating summary statistics for per game data
summary_game_data <- game_data %>%
  group_by(season_type) %>%
  summarise(games = n(),
            yards_per_game = mean(game_yards),
            pass_yards_per_game = mean(game_pass_yards),
            rush_yards_per_game = mean(game_rush_yards),
            total_epa_per_game = mean(game_total_epa),
            total_wpa_per_game = mean(game_total_wpa))

# Zach's Question
# Are teams more likely to run or pass when they are losing?
library(nflfastR)
library(ggplot2)
library(dplyr)
library(ggplotgui)
pbp_2021 <- load_pbp(2021) # Loading in data

# Filtering for run and pass plays, adding a winning or losing column, and selecting play type and winning or losing
run_pass_plays <- pbp_2021 %>%
  filter(play_type == "run" | play_type == "pass") %>%
  mutate(winning_or_losing = if_else(score_differential < 0, "losing",if_else(score_differential > 0, "winning", "tied"))) %>%
  select(play_type, winning_or_losing)

# Finding total number of plays when winning, losing, or tied
run_pass_plays_total <- run_pass_plays %>%
  group_by(winning_or_losing) %>%
  summarise(plays = n())

# Creating variables to store the totals
losing_plays <- run_pass_plays_total$plays[1]
tied_plays <- run_pass_plays_total$plays[2]
winning_plays <- run_pass_plays_total$plays[3]

# Finding the percentage of run and pass plays while winning, losing, and tied
run_pass_plays_freq <- run_pass_plays %>%
  group_by(winning_or_losing, play_type) %>%
  summarise(plays = n()) %>%
  mutate(prob = if_else(winning_or_losing == "losing", plays/losing_plays, if_else(winning_or_losing == "winning", plays/winning_plays, plays/tied_plays)))

# Creating a bar plot to display the data
bp <- ggplot(run_pass_plays_freq, aes(x=winning_or_losing, y=prob, fill=play_type)) +
  geom_bar(width = 0.6, stat = "identity") +
  labs(title = "Percentage of Play Types Related to Winning",
       subtitle = "2021 NFL Season",
       caption = "source: nflfastr",
       x = "Winning or Losing",
       y = "Percentage of Plays",
       color = "Play Type")
bp

#Are teams more likely to punt or field goal kick if they are winning or losing?

library(nflfastR)
library(ggplot2)
library(dplyr)
library(ggplotgui)
pbp_2021 <- load_pbp(2021) # Loading in data

run_pass_plays <- pbp_2021 %>%
  filter(play_type == "punt" | play_type == "field_goal") %>%
  mutate(winning_or_losing = if_else(score_differential < 0, "losing",if_else(score_differential > 0, "winning"))) %>%
  select(play_type, winning_or_losing)

run_pass_plays_total <- run_pass_plays %>%
  group_by(winning_or_losing) %>%
  summarise(plays = n())

losing_plays <- run_pass_plays_total$plays[1]
tied_plays <- run_pass_plays_total$plays[2]
winning_plays <- run_pass_plays_total$plays[3]

run_pass_plays_freq <- run_pass_plays %>%
  group_by(winning_or_losing, play_type) %>%
  summarise(plays = n()) %>%
  mutate(prob = if_else(winning_or_losing == "losing", plays/losing_plays, if_else(winning_or_losing == "winning", plays/winning_plays, plays/tied_plays)))

bp <- ggplot(run_pass_plays_freq, aes(x=winning_or_losing, y=prob, fill=play_type)) +
  geom_bar(width = .75, stat = "identity") +
  labs(title = "Likeliness of a team to punt or kick depending on score",
       caption = "source: nflfastr",
       x = "Winning or Losing",
       y = "Plays",) +
  theme_classic()
bp

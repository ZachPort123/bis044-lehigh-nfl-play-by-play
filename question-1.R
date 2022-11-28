library(nflfastR)
library(ggplot2)
library(dplyr)
pbp_2021 <- load_pbp(2021)
run_pass_plays <- pbp_2021 %>%
  filter(play_type == "run" | play_type == "pass") %>%
  mutate(winning_or_losing = if_else(score_differential < 0, "losing", if_else(score_differential > 0, "winning", "tied"))) %>%
  select(play_type, winning_or_losing)

run_pass_plays_total <- run_pass_plays %>%
  group_by(winning_or_losing) %>%
  summarise(plays = n())

losing_plays = run_pass_plays_total$plays[1]
tied_plays = run_pass_plays_total$plays[2]
winning_plays = run_pass_plays_total$plays[3]

table <- table(run_pass_plays)
table
barplot(table, beside=True)

run_pass_plays_prob <- run_pass_plays %>%
  group_by(winning_or_losing, play_type) %>%
  summarise(prob = if_else(winning_or_losing == "losing", n()/losing_plays, if_else(winning_or_losing == "winning", n()/winning_plays, n()/tied_plays))) %>%

table_prob <- table(run_pass_plays_prob)
table_prob

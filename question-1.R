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

table <- table(run_pass_plays)
table

barplot(table, beside=True)

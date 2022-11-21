pbp_2021 <- load_pbp(2021)
run_pass_plays <- pbp_2021 %>%
  filter(play_type == "run" | play_type == "pass") %>%
  mutate(winning_or_losing = if_else(score_differential < 0, "losing", if_else(score_differential > 0, "winning", "tied")))



table(run_pass_plays$play_type)

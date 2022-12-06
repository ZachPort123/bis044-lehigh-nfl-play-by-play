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
  mutate(conversion_rate = mean(first_down), plays = n()) %>%
  select(play_type, ydstogo, conversion_rate, plays)

# Creating scatter plot relating yards to go to conversion rate for pass and run plays
graph <- ggplot(conversion_rates, aes(x = ydstogo, y = conversion_rate, color = play_type)) +
  geom_point() +
  labs(title = "3rd Down Conversion Rates by Distance",
       subtitle = "2021 NFL Season",
       caption = "source: nflfastr",
       x = "Yards To Go",
       y = "Conversion Rate",
       color = "Play Type") +
  theme_bw()
graph

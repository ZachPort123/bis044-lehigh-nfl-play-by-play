#delfina's question
library(nflfastR)
library(ggplot2)
library(dplyr)
pbp_2021 <- load_pbp(2021)
pass_plays <- pbp_2021 %>%
  filter(play_type == "pass")
df_summary <- pass_plays %>%
  group_by(posteam) %>%
  summarise(avg_yard=mean(yards_gained, na.rm=TRUE))
ggplot(data=df_summary, mapping = aes(x=posteam, y=avg_yard))+ geom_point(color="black", alpha=1, size=3)+geom_smooth(method="lm")


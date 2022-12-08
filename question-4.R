tictoc::tic("loading all games from 2021")
games_2021 <- nflfastR::load_pbp(2021) %>% dplyr::filter(season_type == "REG")
tictoc::toc()
games_2021 %>%
  dplyr::filter(!is.na(cpoe)) %>%
  dplyr::group_by(passer_player_name) %>%
  dplyr::summarize(cpoe = mean(cpoe), Atts = n()) %>%
  dplyr::filter(Atts > 400) %>%
  dplyr::arrange(-cpoe) %>%
  utils::head(5) %>%
  knitr::kable(digits = 1)

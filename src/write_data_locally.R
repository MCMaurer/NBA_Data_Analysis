source("src/data_scraping_functions.R")

write_team_names <- function(year){
  
  teams <- get_team_names(year)
  
  write_csv(teams, paste0("data/team_names_by_year/team_names_", year, ".csv"))
}

walk(1950:2022, write_team_names)

write_player_data <- function(year){
  print(year)
  pd <- get_player_data(year)
  
  write_csv(pd, paste0("data/player_data_by_year/player_data_", year, ".csv"))
}

walk(1950:2021, write_player_data)

write_team_ratings <- function(year){
  
}

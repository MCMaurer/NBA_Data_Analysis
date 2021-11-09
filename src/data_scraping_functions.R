library(tidyverse)
library(rvest)

get_team_names <- function(year = 2022){
  
  url <- paste0("https://www.basketball-reference.com/leagues/NBA_", year, "_standings.html")
  
  css_page <- '#team_vs_team'
  
  teams_mat <- url %>%
    read_html %>%
    html_nodes(xpath = '//comment()') %>%
    html_text() %>%
    paste(collapse='') %>%
    read_html() %>% 
    html_node(css_page) %>% 
    html_table()
  
  teams <- tibble(team = teams_mat$Team,
                  tm = colnames(teams_mat)[-c(1:2)])
  
  return(teams)
}

get_player_data <- function(year = 2022, totals = T, per_100 = T,
                            advanced = T, pbp = T, shooting = T,
                            adj_shooting = T){
  
  read_html_s <- possibly(read_html, otherwise = NULL)
  
  tot_page <- paste0("https://www.basketball-reference.com/leagues/NBA_", year, "_totals.html") %>% 
    read_html_s()
  
  css_page <- '#totals_stats'
  tot <- tot_page %>%
    html_nodes(css_page) %>%
    html_table(header = T) %>%
    pluck(1) %>% 
    janitor::clean_names() %>% 
    filter(tm != "TOT",
           player != "Player")
  
  if(totals){
    player_data <- tot
  } else {
    player_data <- tot %>% select(rk, player, pos, age, tm)
  }
  
  if(per_100){
    
    pos_page <- paste0("https://www.basketball-reference.com/leagues/NBA_", year, "_per_poss.html") %>% 
      read_html_s()
    
    if(!is_null(pos_page)){
      
      css_page <- '#per_poss_stats'
      
      pos <- pos_page %>%
        html_nodes(css_page) %>%
        html_table(header = T) %>%
        pluck(1) %>% 
        janitor::clean_names() %>% 
        filter(tm != "TOT",
               player != "Player") %>% 
        rename_with(.cols = -c(1:8), .fn = ~ paste0(.x, "_p100p"))
      
      player_data <- player_data %>% 
        left_join(pos) 
    }
  }
  
  if(advanced){
    
    adv_page <- paste0("https://www.basketball-reference.com/leagues/NBA_", year, "_advanced.html") %>% 
      read_html_s()
    
    if(!is_null(adv_page)){
      css_page <- '#advanced_stats'
      adv <- adv_page %>% 
        html_nodes(css_page) %>%
        html_table(header = T) %>%
        pluck(1) %>% 
        janitor::clean_names() %>% 
        filter(tm != "TOT",
               player != "Player") %>% 
        select(-starts_with("x"))
      
      player_data <- player_data %>% 
        left_join(adv) 
    }
  }
  
  if(pbp){
    pbp_page <- paste0("https://www.basketball-reference.com/leagues/NBA_", year, "_play-by-play.html") %>% 
      read_html_s()
    
    if(!is_null(pbp_page)){
      css_page <- '#pbp_stats'
      pbp <- pbp_page %>% 
      html_nodes(css_page) %>%
        html_table(header = T) %>%
        pluck(1)
      
      colnames(pbp)[str_starts(colnames(pbp), "^$")] <- pbp[1,][str_starts(colnames(pbp), "^$")]
      
      colnames(pbp)[!(colnames(pbp) == pbp[1,])] <- paste(colnames(pbp)[!(colnames(pbp) == pbp[1,])], pbp[1,][!(colnames(pbp) == pbp[1,])], sep = "_")
      
      pbp <- pbp[-1,]
      
      pbp <- pbp %>% 
        janitor::clean_names() %>% 
        filter(tm != "TOT",
               player != "Player") %>% 
        select(-starts_with("totals")) %>% 
        mutate(across(starts_with("position_"), 
                      .fns = ~ str_remove(.x, "%") %>% 
                        as.numeric() %>% `/`(100)))
      
      player_data <- player_data %>% 
        left_join(pbp) 
    }
  }
  
  if(shooting){
    shoot_page <- paste0("https://www.basketball-reference.com/leagues/NBA_", year, "_shooting.html") %>% 
      read_html_s()
    
    if(!is_null(shoot_page)){
      css_page <- '#shooting_stats'
      shoot <- shoot_page %>% 
        html_nodes(css_page) %>%
        html_table(header = T) %>%
        pluck(1) %>% 
        tibble::repair_names() %>% 
        select(where(~ !all(is.na(.x))))
      
      colnames(shoot)[str_starts(colnames(shoot), "^V")] <- shoot[1,][str_starts(colnames(shoot), "^V")]
      
      colnames(shoot)[!(colnames(shoot) == shoot[1,])] <- paste(colnames(shoot)[!(colnames(shoot) == shoot[1,])], shoot[1,][!(colnames(shoot) == shoot[1,])], sep = "_")
      
      shoot <- shoot[-1,]
      
      shoot <- shoot %>% 
        janitor::clean_names() %>% 
        filter(tm != "TOT",
               player != "Player") %>% 
        rename(mean_fga_dist = dist)
      
      player_data <- player_data %>% 
        left_join(shoot) 
    }
  }
  
  if(adj_shooting){
    
    adj_url <- paste0("https://www.basketball-reference.com/leagues/NBA_", year, "_adj_shooting.html")
    
    adj_shooting_page <- adj_url %>% 
      read_html_s()
    
    if(!is_null(adj_shooting_page)){
      css_page <- '#adj-shooting'
      
      adj <- adj_url %>% 
        read_html %>% 
        html_nodes(xpath = '//comment()') %>%
        html_text() %>%
        paste(collapse='') %>%
        read_html_s() %>% 
        html_node(css_page) %>% 
        html_table() %>%
        set_tidy_names()
      
      colnames(adj)[str_starts(colnames(adj), "\\.\\.")] <- adj[1,][str_starts(colnames(adj), "^\\.\\.")]
      
      adj <- adj %>% 
        select(!`NA`)
      
      colnames(adj) <- str_remove(colnames(adj), "\\.\\.[0-9]+")
      
      colnames(adj)[!(colnames(adj) == adj[1,])] <- paste(colnames(adj)[!(colnames(adj) == adj[1,])], adj[1,][!(colnames(adj) == adj[1,])], sep = "_")
      
      adj <- adj[-1,]
      
      adj <- adj %>% 
        janitor::clean_names() %>% 
        rename(tm = team) %>% 
        filter(tm != "TOT",
               player != "Player")
      
      player_data <- player_data %>% 
        left_join(adj) 
    }
  }
  
  player_data <- player_data %>% 
    mutate(pos_simple = case_when(
      pos %in% c("C", "C-F") ~ "C",
      pos %in% c("F", "F-C", "PF", "SF") ~ "F",
      pos %in% c("G", "PG", "SG") ~ "G"
    ),
    year = year) %>% 
    rename(player_rk = rk) %>% 
    type_convert()
  
  return(player_data)
}

get_team_ratings <- function(year = 2022){
  
  read_html_s <- possibly(read_html, otherwise = NULL)
  
  url <- paste0("https://www.basketball-reference.com/leagues/NBA_", year, "_ratings.html")
  css_page <- "#ratings"
  team_ratings <- url %>% 
    read_html_s %>%
    html_nodes(css_page) %>% 
    html_table() %>% 
    pluck(1)
  
  # column names are messed up because they're spread across two rows in the table. Here we combine them
  colnames(team_ratings)[str_starts(colnames(team_ratings), "^$")] <- team_ratings[1,][str_starts(colnames(team_ratings), "^$")]
  
  colnames(team_ratings)[str_detect(colnames(team_ratings), "justed")] <- colnames(team_ratings)[str_detect(colnames(team_ratings), "justed")] %>% 
    str_remove_all("\\.[0-9]") %>% 
    paste(team_ratings[1,][str_detect(colnames(team_ratings), "justed")], sep = "_")
  
  team_ratings <- team_ratings[-1,]
  
  team_ratings <- team_ratings %>% 
    mutate(year = year) %>% 
    janitor::clean_names() %>% 
    type_convert()
  
  return(team_ratings)
}

team_colors <- c("#E03A3E", "#008248", "black", "#1D1160", "#CE1141", "#6F2633", "#007DC5", "#5091CD", "#ED174C", "#243E90", "#CE1141", "#002D62", "#ED174C", "#552583", "#00285E", "#98002E", "#00471B", "#005083", "#002B5C", "#F58426", "#007AC1", "#0B77BD", "#006BB6", "#1D1160", "#E13A3E", "#5A2D81", "#C4CED4", "#CD1141", "#0C2340", "#002B5C")

names(team_colors) <- c("ATL", "BOS", "BRK", "CHO", 
                        "CHI", "CLE", "DAL", "DEN", 
                        "DET", "GSW", "HOU", "IND", 
                        "LAC", "LAL", "MEM", "MIA", 
                        "MIL", "MIN", "NOP", "NYK", 
                        "OKC", "ORL", "PHI", "PHO", 
                        "POR", "SAC", "SAS", "TOR", 
                        "UTA", "WAS")

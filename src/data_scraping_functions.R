library(rvest)
library(dplyr)
library(tidyr)
library(readr)
library(purrr)
library(stringr)
library(tibble)

get_team_names <- function(year = 2022){
  
  url <- paste0("https://www.basketball-reference.com/leagues/NBA_", year, "_standings.html")
  
  teams_mat <- url %>%
    read_html %>%
    html_nodes(xpath = '//comment()') %>%
    html_text() %>%
    paste(collapse='') %>%
    read_html() %>% 
    html_node('#team_vs_team') %>% 
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
  
  tot <- tot_page %>%
    html_nodes('#totals_stats') %>%
    html_table(header = T) %>%
    pluck(1) %>% 
    janitor::clean_names() %>% 
    filter(tm != "TOT",
           player != "Player") %>% 
    select(-rk)
  
  if(totals){
    player_data <- tot
  } else {
    player_data <- tot %>% select(rk, player, pos, age, tm)
  }
  
  if(per_100){
    
    pos_page <- paste0("https://www.basketball-reference.com/leagues/NBA_", year, "_per_poss.html") %>% 
      read_html_s()
    
    if(!is_null(pos_page)){
      
      pos <- pos_page %>%
        html_nodes('#per_poss_stats') %>%
        html_table(header = T) %>%
        pluck(1) %>% 
        janitor::clean_names() %>% 
        filter(tm != "TOT",
               player != "Player") %>% 
        rename_with(.cols = -c(1:8), .fn = ~ paste0(.x, "_p100p")) %>% 
        select(-rk)
      
      player_data <- player_data %>% 
        left_join(pos) 
    }
  }
  
  if(advanced){
    
    adv_page <- paste0("https://www.basketball-reference.com/leagues/NBA_", year, "_advanced.html") %>% 
      read_html_s()
    
    if(!is_null(adv_page)){

      adv <- adv_page %>% 
        html_nodes('#advanced_stats') %>%
        html_table(header = T) %>%
        pluck(1) %>% 
        janitor::clean_names() %>% 
        filter(tm != "TOT",
               player != "Player") %>% 
        select(-starts_with("x")) %>% 
        select(-rk)
      
      player_data <- player_data %>% 
        left_join(adv) 
    }
  }
  
  if(pbp){
    pbp_page <- paste0("https://www.basketball-reference.com/leagues/NBA_", year, "_play-by-play.html") %>% 
      read_html_s()
    
    if(!is_null(pbp_page)){
      
      pbp <- pbp_page %>% 
      html_nodes('#pbp_stats') %>%
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
                        as.numeric() %>% `/`(100))) %>% 
        select(-rk)
      
      player_data <- player_data %>% 
        left_join(pbp) 
    }
  }
  
  if(shooting){
    shoot_page <- paste0("https://www.basketball-reference.com/leagues/NBA_", year, "_shooting.html") %>% 
      read_html_s()
    
    if(!is_null(shoot_page)){
      
      shoot <- shoot_page %>% 
        html_nodes('#shooting_stats') %>%
        html_table(header = T) %>%
        pluck(1) %>% 
        set_tidy_names()
      
        colnames(shoot)[str_starts(colnames(shoot), "\\.\\.")] <- shoot[1,][str_starts(colnames(shoot), "^\\.\\.")]
        
        shoot <- shoot %>% 
          select(!`NA`)
        
        colnames(shoot) <- str_remove(colnames(shoot), "\\.\\.[0-9]+")
        
        colnames(shoot)[!(colnames(shoot) == shoot[1,])] <- paste(colnames(shoot)[!(colnames(shoot) == shoot[1,])], shoot[1,][!(colnames(shoot) == shoot[1,])], sep = "_")
        
        shoot <- shoot[-1,]
        
        shoot <- shoot %>% 
          janitor::clean_names() %>% 
          filter(tm != "TOT",
                 player != "Player") %>% 
          select(-rk)
      
      player_data <- player_data %>% 
        left_join(shoot) 
    }
  }
  
  if(adj_shooting){
    
    adj_url <- paste0("https://www.basketball-reference.com/leagues/NBA_", year, "_adj_shooting.html")
    
    adj_shooting_page <- adj_url %>% 
      read_html_s()
    
    if(!is_null(adj_shooting_page)){
      
      adj <- adj_url %>% 
        read_html %>% 
        html_nodes(xpath = '//comment()') %>%
        html_text() %>%
        paste(collapse='') %>%
        read_html_s() %>% 
        html_node('#adj-shooting') %>% 
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
               player != "Player") %>% 
        select(-rk)
      
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
    type_convert()
  
  return(player_data)
}

get_team_data <- function(year = 2022, totals = T, per_100 = T,
                          advanced = T, shooting = T, ratings = T){
  
  read_html_s <- possibly(read_html, otherwise = NULL)
  html_node_s <- possibly(html_node, otherwise = NULL)
  
  page <- paste0("https://www.basketball-reference.com/leagues/NBA_", 
                year, ".html") %>% 
    read_html_s()

  if(totals){
    node <- page %>% 
      html_node_s("#totals-team")
    
    if(!is_null(node)){
      team_data <- node %>% 
        html_table() %>% 
        janitor::clean_names() %>% 
        filter(team != "League Average") %>% 
        select(-rk) %>% 
        type_convert()
    }
  
  } else {
    team_data <- node %>% 
      html_table() %>% 
      janitor::clean_names() %>% 
      filter(team != "League Average") %>% 
      select(team)
  }
  
  if(per_100){
    node <- page %>% 
      html_node_s("#per_poss-team")
    
    if(!is_null(node) & !(class(node) == "xml_missing")){
      per <- node %>% 
        html_table() %>% 
        janitor::clean_names() %>% 
        filter(team != "League Average") %>% 
        select(-rk) %>% 
        rename_with(.cols = -c(1:3), .fn = ~ paste0(.x, "_p100p")) %>% 
        type_convert()
      
      team_data <- team_data %>% 
        left_join(per)
    }
  }
  
  if(advanced){
    node <- page %>% 
      html_node_s("#advanced-team")
    
    if(!is_null(node) & !(class(node) == "xml_missing")){
      adv <- node %>% 
        html_table() %>% 
        set_tidy_names()
      
      colnames(adv)[str_starts(colnames(adv), "\\.\\.")] <- adv[1,][str_starts(colnames(adv), "^\\.\\.")]
      
      adv <- adv %>% 
        select(!`NA`)
      
      colnames(adv) <- str_remove(colnames(adv), "\\.\\.[0-9]+")
      
      colnames(adv)[!(colnames(adv) == adv[1,])] <- paste(colnames(adv)[!(colnames(adv) == adv[1,])], adv[1,][!(colnames(adv) == adv[1,])], sep = "_")
      
      adv <- adv[-1,]
      
      adv <- adv %>% 
        janitor::clean_names() %>% 
        filter(team != "League Average") %>% 
        rename(mean_age = age) %>% 
        select(-rk) %>% 
        type_convert()
      
      team_data <- team_data %>% 
        left_join(adv)
    }
  }
  
  if(shooting){
    node <- page %>% 
      html_node_s("#shooting-team")
    
    if(!is_null(node) & !(class(node) == "xml_missing")){
      shoot <- node %>% 
        html_table() %>% 
        set_tidy_names()
      
      colnames(shoot)[str_starts(colnames(shoot), "\\.\\.")] <- shoot[1,][str_starts(colnames(shoot), "^\\.\\.")]
      
      shoot <- shoot %>% 
        select(!`NA`)
      
      colnames(shoot) <- str_remove(colnames(shoot), "\\.\\.[0-9]+")
      
      colnames(shoot)[!(colnames(shoot) == shoot[1,])] <- paste(colnames(shoot)[!(colnames(shoot) == shoot[1,])], shoot[1,][!(colnames(shoot) == shoot[1,])], sep = "_")
      
      shoot <- shoot[-1,]
      
      shoot <- shoot %>% 
        janitor::clean_names() %>% 
        filter(team != "League Average") %>% 
        rename(mean_dist = dist) %>% 
        select(-rk) %>% 
        type_convert()
      
      team_data <- team_data %>% 
        left_join(shoot)
    }
    
  }
  
  if(ratings){
    url <- paste0("https://www.basketball-reference.com/leagues/NBA_", year, "_ratings.html")
    
    team_ratings <- url %>% 
      read_html_s %>%
      html_nodes("#ratings") %>% 
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
    
    team_data <- team_data %>% 
      left_join(team_ratings)
  }
    
    team_data <- team_data %>% 
      type_convert() %>% 
      mutate(year = year)
  
    return(team_data)
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
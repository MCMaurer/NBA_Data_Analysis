library(tidyverse)
library(rvest)
library(ggrepel)
library(MCMsBasics)
library(slider)

source("src/data_scraping_functions.R")

theme_set(minimal_ggplot_theme())

# TODO: turn some of my standard plots into functions to clean this up a bit

pd <- get_player_data() %>% 
  left_join(get_team_names())

tr <- get_team_ratings() %>% 
  left_join(get_team_names())


# advanced stats vs. net rating -------------------------------------------

tr <- pd %>% 
  group_by(tm) %>%
  summarise(mean_vorp = mean(vorp),
            mean_bpm = mean(bpm),
            mean_ws_48 = mean(ws_48),
            mean_usg = mean(usg_percent),
            mean_mp = mean(mp)) %>% 
  left_join(tr)

tr %>% 
  select(starts_with("mean"), adjusted_n_rtg_a, tm) %>% 
  pivot_longer(starts_with("mean")) %>% 
  ggplot(aes(x = value, y = adjusted_n_rtg_a, color = tm)) +
  geom_point() +
  geom_text_repel(aes(label = tm)) +
  scale_color_manual(values = team_colors) +
  facet_wrap(vars(name), scales = "free_x") +
  theme(legend.position = "none", axis.title = element_text(size = 14),
        strip.text = element_text(size = 14),
        panel.border = element_rect(fill = NA, color = "grey90")) +
  labs(x = "",
       y = "Adjusted Net Rating")


# minutes curves ----------------------------------------------------------

dmp <- pd %>% 
  mutate(highlight = if_else(tm %in% c("DET", "SAC", "MIL", "CHI"),
                             1, 0.4)) %>% 
  select(player, tm, mp, highlight) %>% 
  group_by(tm) %>% 
  mutate(team_mp = sum(mp),
         mp_pct = (mp/team_mp)*100) %>% 
  arrange(desc(mp_pct)) %>% 
  mutate(rank = rank(desc(mp_pct), 
                     ties.method = "random")) %>% 
  arrange(rank) %>% 
  mutate(cumu_mp_pct = slide_dbl(mp_pct, sum, .before = Inf)) 

dmp %>% 
  ggplot(aes(x = rank, y = cumu_mp_pct, color = tm)) +
  geom_line(aes(alpha = highlight)) +
  ggrepel::geom_label_repel(data = dmp %>% filter(highlight == 1,
                                                 rank == 11),
                           aes(label = tm)) +
  minimal_ggplot_theme(gridlines = T) +
  theme(legend.position = "none") +
  scale_color_manual(values = team_colors)

# 2021

dmp <- get_player_data(2021) %>%
  left_join(get_team_names(2021)) %>% 
  mutate(highlight = if_else(tm %in% c("UTA", "HOU", "MIL", "ORL"),
                             1, 0.4)) %>% 
  select(player, tm, mp, highlight) %>% 
  group_by(tm) %>% 
  mutate(team_mp = sum(mp),
         mp_pct = (mp/team_mp)*100) %>% 
  arrange(desc(mp_pct)) %>% 
  mutate(rank = rank(desc(mp_pct), 
                     ties.method = "random")) %>% 
  arrange(rank) %>% 
  mutate(cumu_mp_pct = slide_dbl(mp_pct, sum, .before = Inf)) 

dmp %>% 
  ggplot(aes(x = rank, y = cumu_mp_pct, color = tm)) +
  geom_line(aes(alpha = highlight)) +
  ggrepel::geom_label_repel(data = dmp %>% filter(highlight == 1,
                                                  rank == 11),
                            aes(label = tm)) +
  minimal_ggplot_theme(gridlines = T) +
  theme(legend.position = "none") +
  scale_color_manual(values = team_colors)





pd2 <- pd %>% 
  filter(mp > 100) %>% 
  mutate(highlight = if_else(vorp > 0.52 | usg_percent > 32, 1, 0.4)) 



pd2 %>% 
  ggplot(aes(x = usg_percent, y = vorp, color = tm, alpha = highlight)) +
  geom_jitter(width = 0, height = 0.01) +
  geom_text_repel(data = pd2 %>% 
                    filter(highlight == 1),
                  aes(label = player)) +
  scale_color_manual(values = team_colors) +
  theme(legend.position = "none") +
  labs(x = "Usage %",
       y = "VORP")

pd %>% 
  filter(vorp == 0) %>% 
  arrange(desc(usg_percent)) %>% 
  select(tm, player, pos, usg_percent)

d <- get_player_data(2021)


d2 <- d %>% 
  group_by(player) %>% 
  summarise(n = n(),
            vorp = sum(vorp),
            fouls_drawn_shoot = sum(fouls_drawn_shoot),
            tm = ifelse(n == 1, tm, "MULT")) %>% 
  mutate(highlight = if_else(vorp > 3 | fouls_drawn_shoot > 170, 1, 0.4))
  

d2 %>% 
  ggplot(aes(x = fouls_drawn_shoot, y = vorp, color = tm, alpha = highlight)) +
  geom_line(stat = "smooth", group = 1, color = "black", alpha = 0.1) +
  geom_smooth(group = 1, color = "grey90", alpha = 0.1) +
  geom_point() +
  geom_text_repel(data = d2 %>% 
                    filter(highlight == 1),
                  aes(label = player)) +
  scale_color_manual(values = team_colors) +
  theme(legend.position = "none") +
  labs(x = "Shooting fouls drawn",
       y = "VORP",
       title = "Playing for fouls",
       subtitle = "2020-21 NBA Season")

ggsave("images/2021/shooting_fouls_v_vorp.jpg", width = 10, height = 8)

d2 <- d %>% 
  group_by(player) %>% 
  summarise(n = n(),
            vorp = sum(vorp),
            fouls_drawn_shoot = sum(fouls_drawn_shoot),
            d_rtg_p100p = mean(d_rtg_p100p),
            o_rtg_p100p = mean(o_rtg_p100p),
            mp = sum(mp),
            ft_percent = mean(ft_percent),
            tm = ifelse(n == 1, tm, "MULT")) %>% 
  mutate(highlight = vorp > 3 | fouls_drawn_shoot > 150)


d2 %>% 
  ggplot(aes(x = fouls_drawn_shoot, y = vorp, color = d_rtg_p100p, alpha = highlight)) +
  #geom_line(stat = "smooth", group = 1, color = "black", alpha = 0.1) +
  geom_smooth(group = 1, color = "grey90", alpha = 0.1) +
  geom_point() +
  geom_text_repel(data = d2 %>% 
                    filter(highlight),
                  aes(label = player)) +
  scale_color_viridis_c() +
  scale_alpha_manual(values = c(0.4, 1), guide = "none") +
  labs(x = "Shooting fouls drawn",
       y = "VORP",
       color = "D rating\nper 100\nposs.",
       title = "Playing for fouls",
       subtitle = "2020-21 NBA Season")

ggsave("images/2021/shooting_fouls_v_vorp_drating.jpg", width = 10, height = 8)

d3 <- d2 %>% 
  mutate(highlight = if_else(vorp > 3 | d_rtg_p100p))

d2 %>% 
  slice_max(order_by = mp, prop = .8) %>% 
  ggplot(aes(x = d_rtg_p100p, y = vorp, color = o_rtg_p100p)) +
  geom_jitter(height = 0, width = 0.1) +
  geom_smooth(method = "gam") +
  scale_color_viridis_c()

d2 %>% 
  slice_max(order_by = mp, prop = .8) %>% 
  ggplot(aes(x = o_rtg_p100p, y = vorp, color = d_rtg_p100p)) +
  geom_jitter(height = 0, width = 0.1) +
  geom_smooth(method = "gam") +
  scale_color_viridis_c()


# shooting fouls v shots in paint -----------------------------------------

d2 <- d %>% 
  group_by(player) %>% 
  summarise(n = n(),
            vorp = sum(vorp),
            fouls_drawn_shoot = sum(fouls_drawn_shoot),
            d_rtg_p100p = mean(d_rtg_p100p),
            o_rtg_p100p = mean(o_rtg_p100p),
            percent_of_fga_by_distance1_0_3 = 
              mean(percent_of_fga_by_distance1_0_3),
            fga = sum(fga),
            mp = sum(mp),
            tm = ifelse(n == 1, tm, "MULT"))

d2 <- d2 %>% 
  mutate(highlight = fouls_drawn_shoot > 150 | percent_of_fga_by_distance1_0_3 > 0.7)

d2 %>% 
  slice_max(mp, prop = 0.8) %>% 
  ggplot(aes(x = percent_of_fga_by_distance1_0_3, 
             y = fouls_drawn_shoot, color = vorp, alpha = highlight)) +
  geom_smooth(group = 1, color = "grey90", alpha = 0.2, method = "gam") +
  geom_text_repel(data = d2 %>% 
                    filter(highlight),
                  aes(label = player)) +
  geom_point() +
    scale_color_viridis_c() +
    scale_alpha_manual(values = c(0.4, 1), guide = "none") +
  labs(x = "Proportion of FGA within 0-3 ft.",
       y = "Shooting fouls drawn",
       color = "VORP")

ggsave("images/2021/shooting_fouls_in_paint.jpg", width = 10, height = 8)

d2 <- d2 %>% 
  mutate(fga_in_paint = fga*percent_of_fga_by_distance1_0_3) %>% 
  mutate(highlight = fouls_drawn_shoot > 150 | fga_in_paint > 300)

d2 %>% 
  slice_max(mp, prop = 0.8) %>% 
  ggplot(aes(x = fga_in_paint, 
             y = fouls_drawn_shoot, color = vorp, alpha = highlight)) +
  geom_smooth(group = 1, color = "grey90", alpha = 0.2, method = "gam") +
  geom_text_repel(data = d2 %>% 
                    filter(highlight),
                  aes(label = player)) +
  geom_point() +
  scale_color_viridis_c() +
  scale_alpha_manual(values = c(0.4, 1), guide = "none") +
  labs(x = "Total FGA within 0-3 ft.",
       y = "Shooting fouls drawn",
       color = "VORP")

ggsave("images/2021/shooting_fouls_in_paint_fga.jpg", width = 10, height = 8)

d2 <- d2 %>%
  mutate(highlight = fouls_drawn_shoot > 150 | vorp > 3)

d2 %>% 
  slice_max(mp, prop = 0.8) %>% 
  ggplot(aes(x = fouls_drawn_shoot, 
             y = vorp, alpha = highlight)) +
  geom_smooth(group = 1, color = "grey90", alpha = 0.2, method = "gam") +
  geom_text_repel(data = d2 %>% 
                    filter(highlight),
                  aes(label = player)) +
  geom_point() +
  scale_color_viridis_c() +
  scale_alpha_manual(values = c(0.4, 1), guide = "none") +
  labs(x = "Total FGA within 0-3 ft.",
       y = "Shooting fouls drawn",
       color = "VORP")


tr <- get_team_ratings(year = 2021)

tr <- d %>% 
  group_by(tm) %>%
  summarise(mean_vorp = mean(vorp),
            mean_bpm = mean(bpm),
            mean_ws_48 = mean(ws_48),
            mean_usg = mean(usg_percent))

tr %>% 
  select(starts_with("mean"), adjusted_n_rtg_a, tm) %>% 
  pivot_longer(starts_with("mean")) %>% 
  ggplot(aes(x = value, y = adjusted_n_rtg_a, color = tm)) +
  geom_point() +
  geom_text_repel(aes(label = tm)) +
  scale_color_manual(values = team_colors) +
  facet_wrap(vars(name), scales = "free_x") +
  theme(legend.position = "none") +
  labs(x = "",
       y = "Adjusted Net Rating")

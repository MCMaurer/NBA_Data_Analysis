# NBA Data Analysis and Visualization

Doing some analysis and visualization of NBA data, for fun.

Data, so far, are gathered from the wonderful [Basketball
Reference](https://www.basketball-reference.com/).

## Data as of November 15, 2021

### Team Standings

    ## # A tibble: 30 × 107
    ##    team       g    mp    fg   fga fg_percent   x3p  x3pa x3p_percent   x2p  x2pa
    ##    <chr>  <dbl> <dbl> <int> <int>      <dbl> <int> <int>       <dbl> <int> <int>
    ##  1 Charl…    15  3650   632  1409      0.449   201   539       0.373   431   870
    ##  2 Los A…    14  3435   586  1267      0.463   168   461       0.364   418   806
    ##  3 Phila…    14  3360   568  1203      0.472   180   470       0.383   388   733
    ##  4 India…    14  3410   586  1242      0.472   177   493       0.359   409   749
    ##  5 Portl…    14  3360   563  1251      0.45    194   560       0.346   369   691
    ##  6 Brook…    14  3360   552  1174      0.47    194   494       0.393   358   680
    ##  7 Milwa…    14  3385   557  1264      0.441   205   578       0.355   352   686
    ##  8 Atlan…    14  3360   569  1275      0.446   160   445       0.36    409   830
    ##  9 Golde…    13  3145   544  1160      0.469   197   551       0.358   347   609
    ## 10 Toron…    14  3360   560  1276      0.439   150   444       0.338   410   832
    ## # … with 20 more rows, and 96 more variables: x2p_percent <dbl>, ft <int>,
    ## #   fta <int>, ft_percent <dbl>, orb <int>, drb <int>, trb <int>, ast <int>,
    ## #   stl <int>, blk <int>, tov <int>, pf <int>, pts <int>, fg_p100p <dbl>,
    ## #   fga_p100p <dbl>, fg_percent_p100p <dbl>, x3p_p100p <dbl>, x3pa_p100p <dbl>,
    ## #   x3p_percent_p100p <dbl>, x2p_p100p <dbl>, x2pa_p100p <dbl>,
    ## #   x2p_percent_p100p <dbl>, ft_p100p <dbl>, fta_p100p <dbl>,
    ## #   ft_percent_p100p <dbl>, orb_p100p <dbl>, drb_p100p <dbl>, …

#### Eastern Conference

| Team                | Games | Div. |  W |  L |   W/L | Net Rating |
| :------------------ | ----: | :--- | -: | -: | ----: | ---------: |
| Washington Wizards  |    12 | SE   |  9 |  3 | 0.750 |       4.87 |
| Brooklyn Nets       |    14 | A    | 10 |  4 | 0.714 |       5.20 |
| Chicago Bulls       |    13 | C    |  9 |  4 | 0.692 |       4.92 |
| Cleveland Cavaliers |    14 | C    |  9 |  5 | 0.643 |       2.42 |
| Miami Heat          |    13 | SE   |  8 |  5 | 0.615 |       6.50 |
| Philadelphia 76ers  |    14 | A    |  8 |  6 | 0.571 |       4.26 |
| New York Knicks     |    13 | A    |  7 |  6 | 0.538 |       0.46 |
| Charlotte Hornets   |    15 | SE   |  8 |  7 | 0.533 |     \-1.62 |
| Toronto Raptors     |    14 | A    |  7 |  7 | 0.500 |       1.20 |
| Boston Celtics      |    13 | A    |  6 |  7 | 0.462 |       0.83 |
| Indiana Pacers      |    14 | C    |  6 |  8 | 0.429 |       0.67 |
| Milwaukee Bucks     |    14 | C    |  6 |  8 | 0.429 |     \-1.89 |
| Atlanta Hawks       |    14 | SE   |  5 |  9 | 0.357 |     \-2.77 |
| Detroit Pistons     |    12 | C    |  3 |  9 | 0.250 |    \-10.03 |
| Orlando Magic       |    13 | SE   |  3 | 10 | 0.231 |     \-9.79 |

#### Western Conference

| Team                   | Games | Div. |  W |  L |   W/L | Net Rating |
| :--------------------- | ----: | :--- | -: | -: | ----: | ---------: |
| Golden State Warriors  |    13 | P    | 11 |  2 | 0.846 |      13.21 |
| Phoenix Suns           |    12 | P    |  9 |  3 | 0.750 |       5.57 |
| Denver Nuggets         |    13 | NW   |  9 |  4 | 0.692 |       6.19 |
| Dallas Mavericks       |    12 | SW   |  8 |  4 | 0.667 |     \-1.50 |
| Utah Jazz              |    13 | NW   |  8 |  5 | 0.615 |       6.81 |
| Los Angeles Clippers   |    13 | P    |  8 |  5 | 0.615 |       4.75 |
| Los Angeles Lakers     |    14 | P    |  8 |  6 | 0.571 |     \-1.53 |
| Memphis Grizzlies      |    13 | SW   |  6 |  7 | 0.462 |     \-6.53 |
| Portland Trail Blazers |    14 | NW   |  6 |  8 | 0.429 |     \-0.62 |
| Oklahoma City Thunder  |    12 | NW   |  5 |  7 | 0.417 |     \-8.24 |
| Sacramento Kings       |    13 | P    |  5 |  8 | 0.385 |     \-0.68 |
| Minnesota Timberwolves |    12 | NW   |  4 |  8 | 0.333 |     \-4.44 |
| San Antonio Spurs      |    13 | SW   |  4 |  9 | 0.308 |       0.13 |
| New Orleans Pelicans   |    14 | SW   |  2 | 12 | 0.143 |     \-9.74 |
| Houston Rockets        |    13 | SW   |  1 | 12 | 0.077 |     \-9.19 |

### Individual Stats

    ## Joining, by = c("player", "pos", "age", "tm", "g", "gs", "mp")

    ## Joining, by = c("player", "pos", "age", "tm", "g", "mp")

    ## Joining, by = c("player", "pos", "age", "tm")

    ## New names:
    ##  -> ..1
    ##  -> ..2
    ##  -> ..3
    ##  -> ..4
    ##  -> ..5
    ##  -> ..6
    ##  -> ..7
    ##  -> ..8
    ##  -> ..9
    ##  -> ..10
    ## % of FGA by Distance -> % of FGA by Distance..11
    ## % of FGA by Distance -> % of FGA by Distance..12
    ## % of FGA by Distance -> % of FGA by Distance..13
    ## % of FGA by Distance -> % of FGA by Distance..14
    ## % of FGA by Distance -> % of FGA by Distance..15
    ## % of FGA by Distance -> % of FGA by Distance..16
    ##  -> ..17
    ## FG% by Distance -> FG% by Distance..18
    ## FG% by Distance -> FG% by Distance..19
    ## FG% by Distance -> FG% by Distance..20
    ## FG% by Distance -> FG% by Distance..21
    ## FG% by Distance -> FG% by Distance..22
    ## FG% by Distance -> FG% by Distance..23
    ##  -> ..24
    ## % of FG Ast'd -> % of FG Ast'd..25
    ## % of FG Ast'd -> % of FG Ast'd..26
    ##  -> ..27
    ## Dunks -> Dunks..28
    ## Dunks -> Dunks..29
    ##  -> ..30
    ## Corner 3s -> Corner 3s..31
    ## Corner 3s -> Corner 3s..32
    ##  -> ..33
    ## Heaves -> Heaves..34
    ## Heaves -> Heaves..35

    ## Joining, by = c("player", "pos", "age", "tm", "g", "mp", "fg_percent")

    ## New names:
    ##  -> ..1
    ##  -> ..2
    ##  -> ..3
    ##  -> ..4
    ##  -> ..5
    ##  -> ..6
    ##  -> ..7
    ##  -> ..8
    ## Player Shooting % -> Player Shooting %..9
    ## Player Shooting % -> Player Shooting %..10
    ## Player Shooting % -> Player Shooting %..11
    ## Player Shooting % -> Player Shooting %..12
    ## Player Shooting % -> Player Shooting %..13
    ## Player Shooting % -> Player Shooting %..14
    ## Player Shooting % -> Player Shooting %..15
    ## Player Shooting % -> Player Shooting %..16
    ##  -> ..17
    ## League-Adjusted -> League-Adjusted..18
    ## League-Adjusted -> League-Adjusted..19
    ## League-Adjusted -> League-Adjusted..20
    ## League-Adjusted -> League-Adjusted..21
    ## League-Adjusted -> League-Adjusted..22
    ## League-Adjusted -> League-Adjusted..23
    ## League-Adjusted -> League-Adjusted..24
    ## League-Adjusted -> League-Adjusted..25
    ##  -> ..26
    ##  -> ..27
    ##  -> ..28

    ## Joining, by = c("player", "pos", "age", "tm", "g", "mp")

    ## 
    ## ── Column specification ────────────────────────────────────────────────────────
    ## cols(
    ##   .default = col_double(),
    ##   player = col_character(),
    ##   pos = col_character(),
    ##   tm = col_character(),
    ##   pos_simple = col_character()
    ## )
    ## ℹ Use `spec()` for the full column specifications.

#### PPG Leaders

| player                | tm  | pts |  g |      ppg |
| :-------------------- | :-- | --: | -: | -------: |
| Kevin Durant          | BRK | 415 | 14 | 29.64286 |
| Stephen Curry         | GSW | 365 | 13 | 28.07692 |
| Giannis Antetokounmpo | MIL | 345 | 13 | 26.53846 |
| Paul George           | LAC | 344 | 13 | 26.46154 |
| Ja Morant             | MEM | 340 | 13 | 26.15385 |

#### VORP Leaders

| player                | tm  | vorp |
| :-------------------- | :-- | ---: |
| Nikola Jokić          | DEN |  1.6 |
| Kevin Durant          | BRK |  1.3 |
| Giannis Antetokounmpo | MIL |  1.2 |
| Stephen Curry         | GSW |  1.2 |
| Jimmy Butler          | MIA |  1.1 |

![](README_files/figure-gfm/README-unnamed-chunk-7-1.png)<!-- -->

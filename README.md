# NBA Data Analysis and Visualization

Doing some analysis and visualization of NBA data, for fun.

Data, so far, are gathered from the wonderful [Basketball
Reference](https://www.basketball-reference.com/).

## Data as of November 12, 2021

### Team Standings

#### Eastern Conference

| Team                | Games | Div. | W | L |   W/L | Net Rating |
| :------------------ | ----: | :--- | -: | -: | ----: | ---------: |
| Chicago Bulls       |    11 | C    | 8 | 3 | 0.727 |       7.25 |
| Washington Wizards  |    11 | SE   | 8 | 3 | 0.727 |       4.17 |
| Philadelphia 76ers  |    12 | A    | 8 | 4 | 0.667 |       5.93 |
| Brooklyn Nets       |    12 | A    | 8 | 4 | 0.667 |       3.29 |
| Miami Heat          |    11 | SE   | 7 | 4 | 0.636 |       7.40 |
| New York Knicks     |    12 | A    | 7 | 5 | 0.583 |       1.16 |
| Cleveland Cavaliers |    12 | C    | 7 | 5 | 0.583 |       0.89 |
| Toronto Raptors     |    12 | A    | 6 | 6 | 0.500 |       1.40 |
| Milwaukee Bucks     |    12 | C    | 6 | 6 | 0.500 |       0.29 |
| Charlotte Hornets   |    13 | SE   | 6 | 7 | 0.462 |     \-2.79 |
| Boston Celtics      |    11 | A    | 5 | 6 | 0.455 |       0.35 |
| Indiana Pacers      |    12 | C    | 4 | 8 | 0.333 |     \-0.62 |
| Atlanta Hawks       |    12 | SE   | 4 | 8 | 0.333 |     \-4.17 |
| Orlando Magic       |    12 | SE   | 3 | 9 | 0.250 |     \-9.55 |
| Detroit Pistons     |    10 | C    | 2 | 8 | 0.200 |    \-10.57 |

#### Western Conference

| Team                   | Games | Div. |  W |  L |   W/L | Net Rating |
| :--------------------- | ----: | :--- | -: | -: | ----: | ---------: |
| Golden State Warriors  |    11 | P    | 10 |  1 | 0.909 |      13.62 |
| Utah Jazz              |    11 | NW   |  8 |  3 | 0.727 |       9.66 |
| Phoenix Suns           |    10 | P    |  7 |  3 | 0.700 |       1.77 |
| Denver Nuggets         |    11 | NW   |  7 |  4 | 0.636 |       3.47 |
| Dallas Mavericks       |    11 | SW   |  7 |  4 | 0.636 |     \-2.90 |
| Los Angeles Clippers   |    10 | P    |  6 |  4 | 0.600 |       4.28 |
| Los Angeles Lakers     |    12 | P    |  7 |  5 | 0.583 |     \-0.43 |
| Memphis Grizzlies      |    11 | SW   |  6 |  5 | 0.545 |     \-4.43 |
| Portland Trail Blazers |    12 | NW   |  5 |  7 | 0.417 |       0.99 |
| Sacramento Kings       |    12 | P    |  5 |  7 | 0.417 |     \-0.57 |
| Oklahoma City Thunder  |    10 | NW   |  4 |  6 | 0.400 |     \-7.60 |
| San Antonio Spurs      |    11 | SW   |  4 |  7 | 0.364 |       2.17 |
| Minnesota Timberwolves |    10 | NW   |  3 |  7 | 0.300 |     \-5.18 |
| Houston Rockets        |    11 | SW   |  1 | 10 | 0.091 |     \-7.47 |
| New Orleans Pelicans   |    12 | SW   |  1 | 11 | 0.083 |    \-11.68 |

### Individual Stats

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
| Kevin Durant          | BRK | 354 | 12 | 29.50000 |
| Stephen Curry         | GSW | 301 | 11 | 27.36364 |
| Paul George           | LAC | 267 | 10 | 26.70000 |
| Giannis Antetokounmpo | MIL | 319 | 12 | 26.58333 |
| Ja Morant             | MEM | 292 | 11 | 26.54545 |

#### VORP Leaders

| player                | tm  | vorp |
| :-------------------- | :-- | ---: |
| Nikola Jokić          | DEN |  1.3 |
| Giannis Antetokounmpo | MIL |  1.2 |
| Jimmy Butler          | MIA |  1.1 |
| Kevin Durant          | BRK |  1.1 |
| Stephen Curry         | GSW |  0.9 |

![](README_files/figure-gfm/unnamed-chunk-7-1.png)<!-- -->

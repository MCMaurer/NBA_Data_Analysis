# NBA Data Analysis and Visualization

Doing some analysis and visualization of NBA data, for fun.

Data, so far, are gathered from the wonderful [Basketball
Reference](https://www.basketball-reference.com/).

## Data as of November 14, 2021

### Team Standings

#### Eastern Conference

| Team                | Games | Div. | W | L |   W/L | Net Rating |
| :------------------ | ----: | :--- | -: | -: | ----: | ---------: |
| Washington Wizards  |    11 | SE   | 8 | 3 | 0.727 |       4.17 |
| Brooklyn Nets       |    13 | A    | 9 | 4 | 0.692 |       3.68 |
| Chicago Bulls       |    12 | C    | 8 | 4 | 0.667 |       4.48 |
| Philadelphia 76ers  |    13 | A    | 8 | 5 | 0.615 |       4.99 |
| Cleveland Cavaliers |    13 | C    | 8 | 5 | 0.615 |       2.44 |
| Miami Heat          |    12 | SE   | 7 | 5 | 0.583 |       6.53 |
| Toronto Raptors     |    13 | A    | 7 | 6 | 0.538 |       1.78 |
| New York Knicks     |    13 | A    | 7 | 6 | 0.538 |       0.46 |
| Boston Celtics      |    12 | A    | 6 | 6 | 0.500 |       1.08 |
| Charlotte Hornets   |    14 | SE   | 7 | 7 | 0.500 |     \-2.02 |
| Milwaukee Bucks     |    13 | C    | 6 | 7 | 0.462 |     \-0.43 |
| Indiana Pacers      |    13 | C    | 5 | 8 | 0.385 |       0.31 |
| Atlanta Hawks       |    13 | SE   | 4 | 9 | 0.308 |     \-4.59 |
| Orlando Magic       |    12 | SE   | 3 | 9 | 0.250 |     \-9.55 |
| Detroit Pistons     |    11 | C    | 2 | 9 | 0.182 |    \-11.52 |

#### Western Conference

| Team                   | Games | Div. |  W |  L |   W/L | Net Rating |
| :--------------------- | ----: | :--- | -: | -: | ----: | ---------: |
| Golden State Warriors  |    12 | P    | 11 |  1 | 0.917 |      14.65 |
| Phoenix Suns           |    11 | P    |  8 |  3 | 0.727 |       3.78 |
| Utah Jazz              |    12 | NW   |  8 |  4 | 0.667 |       7.90 |
| Denver Nuggets         |    12 | NW   |  8 |  4 | 0.667 |       3.99 |
| Dallas Mavericks       |    12 | SW   |  8 |  4 | 0.667 |     \-1.50 |
| Los Angeles Clippers   |    11 | P    |  7 |  4 | 0.636 |       4.17 |
| Los Angeles Lakers     |    13 | P    |  7 |  6 | 0.538 |     \-2.27 |
| Memphis Grizzlies      |    12 | SW   |  6 |  6 | 0.500 |     \-6.06 |
| Portland Trail Blazers |    13 | NW   |  6 |  7 | 0.462 |       1.84 |
| Oklahoma City Thunder  |    11 | NW   |  5 |  6 | 0.455 |     \-6.72 |
| Sacramento Kings       |    13 | P    |  5 |  8 | 0.385 |     \-0.68 |
| Minnesota Timberwolves |    11 | NW   |  4 |  7 | 0.364 |     \-2.48 |
| San Antonio Spurs      |    12 | SW   |  4 |  8 | 0.333 |       0.83 |
| Houston Rockets        |    12 | SW   |  1 | 11 | 0.083 |     \-7.86 |
| New Orleans Pelicans   |    13 | SW   |  1 | 12 | 0.077 |    \-11.43 |

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
| Kevin Durant          | BRK | 382 | 13 | 29.38462 |
| Stephen Curry         | GSW | 341 | 12 | 28.41667 |
| Paul George           | LAC | 294 | 11 | 26.72727 |
| Giannis Antetokounmpo | MIL | 319 | 12 | 26.58333 |
| Ja Morant             | MEM | 318 | 12 | 26.50000 |

#### VORP Leaders

| player                | tm  | vorp |
| :-------------------- | :-- | ---: |
| Nikola Jokić          | DEN |  1.4 |
| Giannis Antetokounmpo | MIL |  1.2 |
| Kevin Durant          | BRK |  1.2 |
| Jimmy Butler          | MIA |  1.1 |
| Stephen Curry         | GSW |  1.1 |

![](README_files/figure-gfm/unnamed-chunk-7-1.png)<!-- -->

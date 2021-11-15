# NBA Data Analysis and Visualization

Doing some analysis and visualization of NBA data, for fun.

Data, so far, are gathered from the wonderful [Basketball
Reference](https://www.basketball-reference.com/).

## Data as of November 15, 2021

### Team Standings

#### Eastern Conference

| Team                | Games | Div. | W |  L |   W/L | Net Rating |
| :------------------ | ----: | :--- | -: | -: | ----: | ---------: |
| Washington Wizards  |    12 | SE   | 9 |  3 | 0.750 |       4.87 |
| Brooklyn Nets       |    13 | A    | 9 |  4 | 0.692 |       3.68 |
| Chicago Bulls       |    12 | C    | 8 |  4 | 0.667 |       4.48 |
| Cleveland Cavaliers |    14 | C    | 9 |  5 | 0.643 |       2.42 |
| Miami Heat          |    13 | SE   | 8 |  5 | 0.615 |       6.50 |
| Philadelphia 76ers  |    14 | A    | 8 |  6 | 0.571 |       4.26 |
| New York Knicks     |    13 | A    | 7 |  6 | 0.538 |       0.46 |
| Toronto Raptors     |    14 | A    | 7 |  7 | 0.500 |       1.20 |
| Charlotte Hornets   |    14 | SE   | 7 |  7 | 0.500 |     \-2.02 |
| Boston Celtics      |    13 | A    | 6 |  7 | 0.462 |       0.83 |
| Milwaukee Bucks     |    13 | C    | 6 |  7 | 0.462 |     \-0.43 |
| Indiana Pacers      |    14 | C    | 6 |  8 | 0.429 |       0.67 |
| Atlanta Hawks       |    13 | SE   | 4 |  9 | 0.308 |     \-4.59 |
| Detroit Pistons     |    12 | C    | 3 |  9 | 0.250 |    \-10.03 |
| Orlando Magic       |    13 | SE   | 3 | 10 | 0.231 |     \-9.79 |

#### Western Conference

| Team                   | Games | Div. |  W |  L |   W/L | Net Rating |
| :--------------------- | ----: | :--- | -: | -: | ----: | ---------: |
| Golden State Warriors  |    12 | P    | 11 |  1 | 0.917 |      14.65 |
| Phoenix Suns           |    11 | P    |  8 |  3 | 0.727 |       3.78 |
| Los Angeles Clippers   |    12 | P    |  8 |  4 | 0.667 |       6.00 |
| Denver Nuggets         |    12 | NW   |  8 |  4 | 0.667 |       3.99 |
| Dallas Mavericks       |    12 | SW   |  8 |  4 | 0.667 |     \-1.50 |
| Utah Jazz              |    13 | NW   |  8 |  5 | 0.615 |       6.81 |
| Los Angeles Lakers     |    13 | P    |  7 |  6 | 0.538 |     \-2.27 |
| Portland Trail Blazers |    13 | NW   |  6 |  7 | 0.462 |       1.84 |
| Memphis Grizzlies      |    13 | SW   |  6 |  7 | 0.462 |     \-6.53 |
| Oklahoma City Thunder  |    11 | NW   |  5 |  6 | 0.455 |     \-6.72 |
| Sacramento Kings       |    13 | P    |  5 |  8 | 0.385 |     \-0.68 |
| San Antonio Spurs      |    12 | SW   |  4 |  8 | 0.333 |       0.83 |
| Minnesota Timberwolves |    12 | NW   |  4 |  8 | 0.333 |     \-4.45 |
| New Orleans Pelicans   |    14 | SW   |  2 | 12 | 0.143 |     \-9.74 |
| Houston Rockets        |    12 | SW   |  1 | 11 | 0.083 |     \-7.86 |

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
| Giannis Antetokounmpo | MIL | 319 | 12 | 26.58333 |
| Paul George           | LAC | 317 | 12 | 26.41667 |
| Ja Morant             | MEM | 340 | 13 | 26.15385 |

#### VORP Leaders

| player                | tm  | vorp |
| :-------------------- | :-- | ---: |
| Nikola Jokić          | DEN |  1.4 |
| Giannis Antetokounmpo | MIL |  1.2 |
| Kevin Durant          | BRK |  1.2 |
| Jimmy Butler          | MIA |  1.1 |
| Stephen Curry         | GSW |  1.1 |

![](README_files/figure-gfm/unnamed-chunk-7-1.png)<!-- -->

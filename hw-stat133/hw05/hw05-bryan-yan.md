Hw05
================
Bryan
April 27, 2018

``` r
library(dieroller)
```

problem1
--------

``` r
# create a fair die:
fair<- die()

# let the game begin
set.seed(123)
game_time <- 1000
game_result <- data.frame()
for (i in 1:game_time) 
  
  {  a <- roll(fair, times = 4)$rolls
  has_6 <- sum(6 == a) > 0
  a <- c(a, has_6)
  game_result <- rbind(game_result, a)
}
colnames(game_result) <- c("1st die", "2nd die", "3rd die", "4th die", "has_6")

head(game_result, 5)
```

    ##   1st die 2nd die 3rd die 4th die has_6
    ## 1       3       6       4       1     1
    ## 2       1       2       5       1     0
    ## 3       5       4       1       4     0
    ## 4       6       5       2       1     1
    ## 5       3       2       3       1     0

analysis part:

``` r
# count the number of games
sum(game_result$has_6)
```

    ## [1] 527

``` r
# compute the relative frequency 
sum(game_result$has_6) / game_time
```

    ## [1] 0.527

Problem II
----------

``` r
set.seed(123)
game_time <- 1000
game_result <- data.frame()
for (i in 1:game_time) {
  b <- roll(fair, times = 48)$rolls
  pair_result <- vector(mode = "numeric", length = 0L)
  for (j in 1:24){
    pair_sum <- b[2*j - 1] + b[2*j]
    pair_result <- c(pair_result, pair_sum)
  }
  has_2_6 <- sum(12 == pair_result) > 0
  b <- c(b, has_2_6)
  
  game_result <- rbind(game_result, b)
}
colnames(game_result) <- c(rep(c("die1", "die2"), 24), "has_double_6")


head(game_result, 5)
```

    ##   die1 die2 die1 die2 die1 die2 die1 die2 die1 die2 die1 die2 die1 die2
    ## 1    3    6    4    1    1    2    5    1    5    4    1    4    6    5
    ## 2    3    1    2    4    6    2    5    3    2    6    1    4    5    2
    ## 3    6    2    4    5    5    3    4    1    4    1    1    5    4    2
    ## 4    1    3    3    2    3    6    1    4    4    3    2    4    5    3
    ## 5    1    5    1    4    4    5    2    5    3    1    5    5    4    1
    ##   die1 die2 die1 die2 die1 die2 die1 die2 die1 die2 die1 die2 die1 die2
    ## 1    2    1    3    2    3    1    1    6    5    1    5    6    5    5
    ## 2    4    3    6    4    6    6    6    4    6    5    6    2    4    3
    ## 3    1    3    2    1    6    2    5    1    5    4    5    3    3    3
    ## 4    4    3    5    4    5    4    4    5    6    3    4    3    5    3
    ## 5    4    3    3    3    4    3    3    6    2    6    4    4    6    1
    ##   die1 die2 die1 die2 die1 die2 die1 die2 die1 die2 die1 die2 die1 die2
    ## 1    3    2    1    1    6    6    2    4    6    3    3    3    2    4
    ## 2    4    5    4    2    3    6    4    6    2    4    1    1    1    3
    ## 3    4    1    2    2    2    6    5    1    6    6    5    5    6    6
    ## 4    1    6    6    5    4    5    1    5    1    3    6    3    5    4
    ## 5    3    1    6    6    2    4    4    5    6    1    5    4    5    2
    ##   die1 die2 die1 die2 die1 die2 has_double_6
    ## 1    4    4    2    2    3    4            1
    ## 2    2    5    4    5    3    3            1
    ## 3    1    4    3    4    2    3            1
    ## 4    3    5    1    1    3    3            0
    ## 5    3    4    3    6    2    6            1

analysis part:

``` r
# count the number of games 
sum(game_result$has_double_6)
```

    ## [1] 461

``` r
# compute the relative frequency 
sum(game_result$has_double_6) / game_time
```

    ## [1] 0.461

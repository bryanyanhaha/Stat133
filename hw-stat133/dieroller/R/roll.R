#' @title Roll a die
#' @description Creates an object of class \code{"roll"}
#' @param die object of class \code{"die"}
#' @param times number of tosses
#' @return an object of class \code{"roll"} with the following elements:
#' @return \item{rolls}{vector of rolls}
#' @return \item{sides}{vector of die \code{"sides"}}
#' @return \item{prob}{vector of die \code{"prob"}}
#' @return \item{total}{total number of rolls}
#' @export
#' @examples
#' die1 <- die()
#'
#' # roll a die 10 times
#' roll10 <- roll(die1, times = 10)
#'
#' # add 5 more tosses
#' roll15 <- roll10 + 5


roll <- function(die, times = 1) {
  check_times(times)
  rolltime <- rolltime(die, times = times)
  make_roll(die, rolltime)
}


# private function to check vector of 'times'
check_times <- function(times) {
  if (times <= 0 | !is.numeric(times)) {
    stop("\nargument 'times' must be a positive integer")
  } else {
    TRUE
  }
}


# private function
rolltime <- function(x, times = 1) {
  sample(x$sides, size = times, replace = TRUE, prob = x$prob)
}


#' @title Make Roll Object
#' @description Constructor function for object "roll"
#' @param die object of class die
#' @param rolltime object of class rolltime
#' @keywords internal
make_roll <- function(die, rolltime) {
  res <- list(
    rolls = rolltime,
    sides = die$sides,
    prob = die$prob,
    total = length(rolltime))
  class(res) <- "roll"
  res
}


#' @export
print.roll <- function(x, ...) {
  cat('object "roll"\n\n')
  cat(x$rolls)
  invisible(x)
}


#' @export
summary.roll <- function(x, ...) {
  freqs <- data.frame(
    side = x$sides,
    count = c(sum(x$rolls == x$sides[1]),
              sum(x$rolls == x$sides[2]),
              sum(x$rolls == x$sides[3]),
              sum(x$rolls == x$sides[4]),
              sum(x$rolls == x$sides[5]),
              sum(x$rolls == x$sides[6])),
    prop = c(sum(x$rolls == x$sides[1]) / x$total,
             sum(x$rolls == x$sides[2]) / x$total,
             sum(x$rolls == x$sides[3]) / x$total,
             sum(x$rolls == x$sides[4]) / x$total,
             sum(x$rolls == x$sides[5]) / x$total,
             sum(x$rolls == x$sides[6]) / x$total))
  res <- list(freqs = freqs)
  class(res) <- "summary.roll"
  res
}


#' @export
print.summary.roll <- function(x, ...) {
  cat('summary "roll"\n\n')
  print(x$freqs)
  invisible(x)
}


#' @export
"[.roll" <- function(x, i) {
  x$rolls[i]
}


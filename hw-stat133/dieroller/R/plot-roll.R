#' @title Plot of object roll
#' @description Plots the relative frequencies of a series of rolls
#' @param x an object of class \code{"die"}
#' @param side number indicating which side of die to consider
#' @param \dots arguments to be passed to/from other methods
#' @export
#' @examples
#'  \dontrun{
#'  # create a die and toss it 100 times
#'  die1 <- die()
#'  roll1000 <- roll(die1, times = 1000)
#'
#'  plot(roll1000)
#'  }


plot.roll <- function(x, ...) {
  barplot(summary(x)$freqs$prop,
          names.arg = x$sides,
          xlab = "sides of die",
          ylab = "relative frequency")
  title(sprintf("Relative Frequencies in a series of %s die rolls", x$total))
}


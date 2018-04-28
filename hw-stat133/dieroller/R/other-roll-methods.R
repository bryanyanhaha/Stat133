#' @export
"[.roll" <- function(x, i) {
  x$rolls[i]
}


#' @description replace the value of a given roll
#' @param x an R object
#' @param i the index
#' @param value the new value
#' @export
"[<-.roll" <- function(x, i, value) {
  if (sum(value == x$sides) == 0) {
    stop("replacing value must be one of the sides the die has")
  }
  if (i > x$total) {
    stop("\nindex out of bounds")
  }
  x$rolls[i] <- value
}


#' @title "+" method
#' @description add more rolls
#' @param x an R objec
#' @param more
#' @export
"+.roll" <- function(x, more) {
  if (length(more) != 1 | more <= 0) {
    stop("\ninvalid increament")
  }
  more_shakes <- rolltime(x = die(x$sides, x$prob), times = more)
  make_roll(x$coin, c(x$rolls, more_shakes))
}


## title: regex-functions
## description: regex functions fro the rest of the project
## input(s): 
## output(s): regex functions

#2.1)splitting characters
#' @title split_chars
#' @description break into single characters
#' @param x a character string 
#' @return a character vector 
split_chars <- function(x){
  n <- nchar(x)
  split <- vector(mode = "character", length = 0L)
  for (i in 1:n){
    split1 <- str_sub(x, start = i, end = i)
    split <- c(split, split1)
  }
  return(split)
}

split_chars('bryan')

#2.2)number of vowels
#' @title num_vowels
#' @description calculate the number of vowels 
#' @param x a vector 
#' @return a vector 
num_vowels <- function(x){
  a <- 0
  e <- 0
  i <- 0
  o <- 0
  u <- 0
    for (k in tolower(x)){
    a <- a + as.numeric(k == "a")
    e <- e + as.numeric(k == "e")
    i <- i + as.numeric(k == "i")
    o <- o + as.numeric(k == "o")
    u <- u + as.numeric(k == "u")
  }
  result <- c(a, e, i, o, u)
  names(result) <- c("a", "e", "i", "o", "u")
  return(result)
}


#2.3) counting vowels
#' @title count_vowels
#' @description calculate the number of vowels in a character string
#' @param x a vector 
#' @return a vector 

count_vowels <- function(x){
  d <- split_chars(x)
  f <- num_vowels(d)
  return(f)
  
}

#2.4) reversing characters
#' @title reverse_chars
#' @description reverse a string by characters
#' @param x a character vector
#' @return a reversed character vector
reverse_chars <- function(x){
  
  d<- split_chars(x)
  rev <- rev(d)
  result <- ""
  for (i in 1:length(rev)){
    result <- str_c(result, rev[i])
  }
  return(result)
}

#2.5) reversing sentences by words

#' @title spaces
#' @description get the number of spaces 
#' @param x the string
#' @return number of spaces in a string
spaces <- function(x){ 
  sapply(gregexpr(" ", x), function(p) { sum(p>=0) } ) 
}

#use the space fuction to claculate number of words

#' @title reverse_words
#' @description reverses a sentence by words
#' @param k a character string
#' @return the reversed sentence
reverse_words <- function(k){
  n_word <- spaces(k) + 1
  if (n_word == 1) {
    return(k)
  }
  else{
    words <- vector(mode = "character", length = 0L)
    for (i in 1:n_word){
      words <- c(words, word(k, i))
    }
    reversed <- rev(words)
    result <- reversed[1]
    for (i in 2:n_word){
      result <- paste(result, reversed[i], sep = " ")
    }
    return(result)
  }
}



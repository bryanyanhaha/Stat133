# Title:binomial-functions
#descripition: series of functions to achieve a function of binomial distribution


#3)
#' @title is_integer
#' @description to determine if a numeric value is an integer
#' @param x numeric value of x
#' @return TRUE or FALSE
is_integer <- function(x) return(x%%1 == 0)
is_integer(10L)


#' @title is_positive
#' @description to determine if a numeric value is positive
#' @param x numeric value of x
#' @return TRUE or FALSE
is_positive <- function(x) if (x>0) return(TRUE) else return(FALSE)
is_positive(10.1)


#' @title is_nonnegative
#' @description to determine if a numeric value is nonnegative
#' @param x numeric value of x
#' @return TRUE or FALSE
is_nonnegative <- function(x) if (x>=0) return(TRUE) else return(FALSE)
is_nonnegative(10)


#' @title is_positive_integer
#' @description to determine if a numeric value is both positive and an integer
#' @param x numeric value of x
#' @return TRUE or FALSE
is_positive_integer <- function(x) if (is_positive(x)==TRUE & is_integer(x)==TRUE) return(TRUE) else return(FALSE)
is_positive_integer(10)

#' @title is_nonneg_integer
#' @description to determine if a numeric value is both nonnegative and an integer
#' @param x numeric value of x
#' @return TRUE or FALSE
is_nonneg_integer <- function(x) if (is_nonnegative(x)==TRUE & is_integer(x)==TRUE) return(TRUE) else return(FALSE)
is_nonneg_integer(0)

#' @title is_probability
#' @description to determine if a numeric value is a valid probability
#' @param x numeric value of x
#' @return TRUE or FALSE
is_probability <- function(x) if (x>=0 & x<=1) return(TRUE) else return(FALSE)
is_probability(2)

#' @title bin_factorial
#' @description to calculate the factorial of a non negative integer n 
#' @param n numeric value of n
#' @return the factorial of n

bin_factorial <- function(n) {
  if(n<0 | !n%%1 == 0){return(FALSE)}
  else{
    {if (n==0){return(1)}
  else {i =1 
  k=1
  for (i in 1:n) {k=k*i}
  }
  return(k)
    }}}
  
 
bin_factorial(1.5)



#' @title bin_combinations
#' @description to calculate the combination  
#' @param n number of trials
#' @param k number of successes
#' @return the coombination of n and k

bin_combinations <- function(n, k){
  if(n<0 | !n%%1 == 0){return(FALSE)}
else{
  k <- bin_factorial(n)/(bin_factorial(k)*bin_factorial(n-k))
  return(k)}}
bin_combinations(10,6)

#' @title bin_probability
#' @description to calculate the probability  
#' @param n number of trials
#' @param k number of successes
#' @param p probability of success
#' @return the probability
bin_probability <- function(n,k,p) {
  if (is_nonneg_integer(n)==FALSE |is_probability(p)==FALSE|is_nonneg_integer(k)==FALSE)
  {stop("error")}
  else {
    pp = (p^k)*(1-p)^(n-k)*bin_combinations(n,k)
    return(pp)
     }
}
bin_probability(10,1,0.5)

#' @title distribution of probability 
#' @description the distribution of probability of getting a number of successes in a number of trials
#' @param n number of trials 
#' @param p probability of success 
#' @return a dataframe of the distribution


bin_distribution <- function(n,p){
  i = 0
  probability = rep(0,n)
  success = rep(0,n)
  while(i <= n){
    probability[i+1] = bin_probability(n,i,p)
    success[i+1] = i
    i = i+1
  }
  zuile <- as.data.frame(cbind(success,probability))
  zuile
}
bin_distribution(10,0.2)

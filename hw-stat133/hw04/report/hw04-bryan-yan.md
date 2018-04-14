hw04-bryan-yan
================
Bryan
April 13, 2018

``` r
library(XML)
library(stringr)
```

    ## Warning: package 'stringr' was built under R version 3.4.4

``` r
library(ggplot2)
```

``` r
source("code/archive-functions.R")

#1.4)

raw_data <- read_archive('stringr')
clean_data <- clean_archive(raw_data)
plot_archive(clean_data)
```

![](images/unnamed-chunk-2-1.png)

``` r
write.csv(clean_data, file = "data/stringr-archive.csv")


#1.5)


pak<- c("dplyr", "ggplot2", "XML", "knitr")
finaldat <- data.frame()

for (i in pak){
  raw_data <- read_archive(i)
  clean_data <- clean_archive(raw_data)
  file_name <- str_c(i, "-archive.csv")
  file_dest <- str_c("data/", file_name)
  write.csv(clean_data, file = file_dest)
  finaldat <- rbind(finaldat, clean_data)
}

#all in one
ggplot(finaldat, aes(x = date, y = size, color = name)) +geom_step(alpha = 1, size = 1)+labs(x = "date", y = "size (kb)")
```

![](images/unnamed-chunk-2-2.png)

``` r
#one per pak
ggplot(finaldat, aes(x = date, y = size, color = name)) +geom_step(alpha = 1, size = 1)+labs(x = "date", y = "size (kb)")+facet_wrap(~name, scales = "free")
```

![](images/unnamed-chunk-2-3.png)

``` r
#2.1)splitting characters
source("code/regex-functions.R")
split_chars('Go Bears!')
```

    ## [1] "G" "o" " " "B" "e" "a" "r" "s" "!"

``` r
split_chars('Expecto Patronum')
```

    ##  [1] "E" "x" "p" "e" "c" "t" "o" " " "P" "a" "t" "r" "o" "n" "u" "m"

``` r
#2.2) number of vowels
vec <- c('G', 'o', ' ', 'B', 'e', 'a', 'r', 's', '!') 
num_vowels(vec)
```

    ## a e i o u 
    ## 1 1 0 1 0

``` r
#2.3)counting vowels
count_vowels("The quick brown fox jumps over the lazy dog")
```

    ## a e i o u 
    ## 1 3 1 4 2

``` r
count_vowels("THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG")
```

    ## a e i o u 
    ## 1 3 1 4 2

``` r
#2.4) reversing characters
reverse_chars("interessting")
```

    ## [1] "gnitsseretni"

``` r
#2.5) reversing words
reverse_words("my name is bryan")
```

    ## [1] "bryan is name my"

``` r
reverse_words("bryan")
```

    ## [1] "bryan"

``` r
a <- read.csv("data/text-emotion.csv",stringsAsFactors = FALSE)

#3.1)number of characters per tweet
num <- nchar(a[,4])
summary(num)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##    1.00   43.00   69.00   73.44  103.00  184.00

``` r
hist(num, 
     breaks = seq(1,190,5))
```

![](images/unnamed-chunk-4-1.png)

``` r
#3.2) number of mentions
content <- a[,4]

splitted <- str_split(content,pattern=" ")



# define a function that checks if a string is a username:
#' @title ifuser
#' @description see if a word is a valid usernmae
#' @param s a character vector
#' @return TRUE if it is a valid; FALSE else

ifuser <- function(x) {
  end <- vector(mode = "logical", length = 0L)
  
  for (i in x)
    
    
    {
    no_sign <- gsub(x = i, pattern = "_", replacement = '')
    if (str_detect(no_sign, pattern = "[:punct:]")) {
      end <- c(end, FALSE)
    }
    else{
      end <- c(end, TRUE)
    }
  }
  return(end)}

#number of valid mentions
validmens <- vector(mode = "numeric", length = 0L)
for (i in 1:length(splitted)) {
  word <- splitted[[i]]
  word_at <- word[str_detect(word, pattern = "@")]
  check_valid <- gsub(x = word_at, pattern = "@", replacement = '')
  if (length(check_valid) != 0){
    validmens <- c(validmens, sum(ifuser(check_valid)))
  }
  else{
    validmens <- c(validmens, 0)
  }
}
head(validmens, n=20)
```

    ##  [1] 1 0 0 0 1 0 0 0 1 1 0 0 0 1 0 0 1 0 1 0

``` r
#display such frquencies
table(validmens)
```

    ## validmens
    ##     0     1     2     3     4     5     6     7     8     9    10 
    ## 21186 18040   642    85    26    14     2     1     2     1     1

``` r
barplot(table(validmens), 
        xlab = "number of mentions",
        ylab = "frequency",
        col = "blue")
```

![](images/unnamed-chunk-4-2.png)

``` r
#display the content of the tweet with 10 mentions
b <- data.frame(content, validmens)
content[b$validmens == 10]
```

    ## [1] "last #ff  @Mel_Diesel @vja4041 @DemonFactory @shawnmcguirt @SEO_Web_Design @ChuckSwanson @agracing @confidentgolf @tluckow @legalblonde31"

``` r
#3.3)

#count the number of hashtags in the tweet contents

#' @title if#
#' @description tests if a string is a valid hashtag
#' @param a a character vector
#' @return TRUE if valid 

ifhash <- function(x){
  result <- vector(mode = "logical", length = 0L)
  for (i in x){
    tag <- substr(i, start = 2, stop = nchar(i))
    if (substr(i, start = 1L, stop = 1L) != "#"){
      result <- c(result, FALSE)
    }
    else if (str_detect(tag, pattern = "[:punct:]")) {
      result <- c(result, FALSE)
    }
    else if (substr(tag, start = 1L, stop = 1L) %>% str_detect(pattern = "[:digit:]")) {
      result <- c(result, FALSE)
    }
    else if (!str_detect(tag, pattern = "[:alpha:]")){
      result <- c(result, FALSE)
    }
    else{
      result <- c(result, TRUE)
    }
  }
  return(result)
}


validhash <- vector(mode = "numeric", length = 0L)
for (i in 1:length(splitted)) {
  word <- splitted[[i]]
  check_valid <- word[str_detect(word, pattern = "#")]
  if (length(check_valid) != 0){
    validhash <- c(validhash, sum(ifhash(check_valid)))
  }
  else{
    validhash <- c(validhash, 0)
  }
}
head(validhash, n =20)
```

    ##  [1] 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

``` r
#display such frequescies
table(validhash)
```

    ## validhash
    ##     0     1     2     3     5     7 
    ## 39331   601    54    12     1     1

``` r
#barplot
barplot(table(validmens), 
        xlab = "number of hashtags",
        ylab = "frequency",
        col = "blue")
```

![](images/unnamed-chunk-5-1.png)

``` r
#average length of the hashtage
tags <- vector(mode = "character", length = 0L)
for (i in 1:length(splitted)) {
  word<- splitted[[i]]
  notchecked <- word[str_detect(word, pattern = "#")]
  tags <- c(tags, notchecked[ifhash(notchecked)])
}
mean(nchar(tags))-1
```

    ## [1] 7.550859

``` r
#most common length

mode <- function(x){
  ux <- unique(x)
  ux[which.max(tabulate(match(x,ux)))]
}

mode(nchar(tags))-1
```

    ## [1] 4
#title: archive-funtion
#description:develop funstions needed for the rest of the homework, including read_archive() and other functions
#inputs:tables from online websites
#outputs:functions regarding tables and graphs


library(XML)
library(stringr)
library(ggplot2)
#1.1) read archieve data table
#     write a function that takes the names of a package and returns the data frame from reading the HTML table


#' @title read_archive
#' @description   takes the names of a package and returns the data frame from reading the HTML table
#' @param x data of the names of the package
#' @return the data frame

read_archive <- function(x){
  a <- 'http://cran.r-project.org/src/contrib/Archive/'
  b <- paste0(a,x)
  return(readHTMLTable(b))
}

#1.2) data cleaning


#' @title pakname
#' @description take package name and form a list 
#' @param pn name of the package
#' @return vector of package name
pakname <- function(pn){
end <- vector(mode = "character", length = 0L)
for (i in 1:length(pn)){
  end1 <- str_split(pn[i], pattern = "_")[[1]][1]
  end <- c(end, end1)
}
return(end)
}

#' @title pakversion
#' @description take package version and form a list 
#' @param pn data of versions of the package
#' @return vector of versions
#' since package names and versions are in the same column, the parametes are the same for both functions

pakversion <- function(pn){
end <- vector(mode = "character", length = 0L)
for (i in 1:length(pn)){
  end1 <- str_split(pn[i], pattern = "_")[[1]][2]
  end1 <- str_replace(end1, pattern = '.tar.gz', replacement = '')
  end <- c(end, end1)
}
return(end)
}



#' @title dates
#' @description gets the dates of different versions
#' @param d date data
#' @return list of dates
date <- function(d){
  end <- str_sub(d, start = 1L, end = 10L)%>% as.Date()
  return(end)
}


#' @title size
#' @description gets the size of the version
#' @param s size data 
#' @return a list of sizes of packages
sizes <- function(s){
  end <- vector(mode = "double", length = 0L)
  for (i in 1:length(s)) {
    if (s[i] %>% str_sub(start = -1) == "K")
      
      {
      end1 <- s[i] %>% str_sub(start = 1L, end = nchar(s[i])-1)%>% as.numeric()
      end <- c(end,end1)
    }
    else if (s[i] %>% str_sub(start = -1) == "M") 
      
      {
      end1 <- s[i] %>% str_sub(start = 1L, end = nchar(s[i])-1)%>% as.numeric()
      end <- c(end, 1024*end1)
    }
  }
  return(end)
}


#' @title clean_archive
#' @description cleans the raw data frame
#' @param raw the raw data frame from read_archive
#' @return a clean data frame
#' 
#' 
clean_archive <- function(raw){
  dat <- na.omit(raw[[1]])        
  dat <- dat[2:nrow(dat),]         
  nv <- dat$Name %>% as.vector()    
  d <- dat$`Last modified` %>% as.vector()
  s <- dat$Size %>% as.vector()
  name <- pakname(nv)
  version <- pakversion(nv)
  date <- date(d)
  size <- sizes(s)
  return(data.frame(name, version, date, size, stringsAsFactors = FALSE))
}




#1.3) timeline plot
#' @title plot_archive
#' @description visualize the timeline with the version sizes of a package
#' @param dat data from the clean_archive function
#' @return a ggplot graph
plot_archive <- function(dat){
  ggplot(dat, aes(x = date, y = size)) +
    geom_step(alpha = 1, color = "blue") +
    geom_point(color = "blue") +
    labs(title = "stringr: timeline of version sizes", x = "date", y = "size (kb)")
    
}




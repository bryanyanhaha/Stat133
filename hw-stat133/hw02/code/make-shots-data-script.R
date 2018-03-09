

# Title: make-shots-data-script
# Description: 
#    this script is to prepare the datasets to creat a csv data file named shots-data.csv
# input(s): 
#          stephen-curry.csv
#          kevin-durant.csv
#          draymond-green.csv
#          klay-thompson.csv
#          angre-igudala.csv
# output(s):shots-data.csv

#read in the five data sets, using relative file paths
curry <- read.csv('hw-stat133/hw02/data/stephen-curry.csv',stringsAsFactors = FALSE)
durant <- read.csv('hw-stat133/hw02/data/kevin-durant.csv',stringsAsFactors = FALSE)
igudala <- read.csv('hw-stat133/hw02/data/andre-igudala.csv',stringsAsFactors = FALSE)
thompson <- read.csv('hw-stat133/hw02/data/klay-thompson.csv',stringsAsFactors = FALSE)
green <- read.csv('hw-stat133/hw02/data/draymond-green.csv',stringsAsFactors = FALSE)

#add a column name to each data frame with corresponding player
curry$name <- "Stephen Curry"
durant$name <- "Kevin Durant"
igudala$name <- "Andre Igudala"
thompson$name <- "Klay Thompson"
green$name <- "Graymond Green"

#change the original values of shot_made_flag to more descriptive values
curry$shot_made_flag[curry$shot_made_flag == "n"] <- "missed shot"
curry$shot_made_flag[curry$shot_made_flag == "y"] <- "made shot"
durant$shot_made_flag[durant$shot_made_flag == "n"] <- "missed shot"
durant$shot_made_flag[durant$shot_made_flag == "y"] <- "made shot"
green$shot_made_flag[green$shot_made_flag == "n"] <- "missed shot"
green$shot_made_flag[green$shot_made_flag == "y"] <- "made shot"
thompson$shot_made_flag[thompson$shot_made_flag == "n"] <- "missed shot"
thompson$shot_made_flag[thompson$shot_made_flag == "y"] <- "made shot"
igudala$shot_made_flag[igudala$shot_made_flag == "n"] <- "missed shot"
igudala$shot_made_flag[igudala$shot_made_flag == "y"] <- "made shot"





#add a column mnute that contains the minute number where a shot occurred
curry <- mutate(curry, minute = 12*period - minutes_remaining)
igudala <- mutate(igudala, minute = 12*period - minutes_remaining)
durant <- mutate(durant, minute = 12*period - minutes_remaining)
green <- mutate(green, minute = 12*period - minutes_remaining)
thompson <- mutate(thompson, minute = 12*period - minutes_remaining)

#send summaries of each data frame into individuals text files
sink(file = 'hw-stat133/hw02/output/andre-igudala-summary.txt')
summary(igudala)
sink()

sink(file = 'hw-stat133/hw02/output/stephen-curry-summary.txt')
summary(curry)
sink()

sink(file = 'hw-stat133/hw02/output/kevin-durant-summary.txt')
summary(durant)
sink()

sink(file = 'hw-stat133/hw02/output/klay-thompson-summary.txt')
summary(thompson)
sink()

sink(file = 'hw-stat133/hw02/output/draymond-green-summary.txt')
summary(green)
sink()

#stack the tables into one single data frame
b <- rbind(curry,igudala,thompson, durant,green)
a <- mutate(b, minute = 12*period - minutes_remaining)

#export shots-data.csv inside the folder data/
write.csv(a, "hw-stat133/hw02/data/shots-data.csv")

#send the summary of the assembled table to the output folder
sink(file = 'hw-stat133/hw02/output/shots-data-summary.txt')
summary(a)
sink()






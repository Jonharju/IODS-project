#Jonas Harjunpää 04.02.2017
#This file contains the wrangled data of a study about student alcohol consumpiton
#from here https://archive.ics.uci.edu/ml/datasets/STUDENT+ALCOHOL+CONSUMPTION
setwd("C:/Users/Jonas/Documents/GitHub/IODS-project/data")
getwd()
# read the math class questionaire data into memory
math <- read.csv("student-mat.csv", sep = ";" , header=TRUE)

# read the portuguese class questionaire data into memory
por <- read.csv("student-por.csv", sep = ";", header = TRUE)

# look at the structure and dimensions of both data
str(math)
dim(math)
str(por)
dim(por)

library(dplyr)
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")
math_por <- inner_join(math, por, by = join_by, suffix=c(".math",".por"))

str(math_por)
dim(math_por)

alc <- select(math_por, one_of(join_by))

notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

notjoined_columns

for(column_name in notjoined_columns) {
  two_columns <- select(math_por, starts_with(column_name))
  first_column <- select(two_columns, 1)[[1]]
  if(is.numeric(first_column)) {
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    alc[column_name] <- first_column
  }
}

alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
alc <- mutate(alc, high_use = alc_use > 2)

glimpse(alc)

write.csv(alc, file = "alc.csv", row.names=FALSE)
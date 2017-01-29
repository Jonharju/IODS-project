#Jonas Harjunpää 27.01.2016
#This file contains the wrangled data

learning2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt",sep="\t", header=TRUE)
dim(learning2014)
str(learning2014)
#dim outputs 184 and 60, as in observations and variables
#str outputs each variable, how many levels and what the values where

learning2014$attitude <- learning2014$Attitude/10
library(dplyr)
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D07","D14","D22","D30")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

deep_columns <- select(learning2014, one_of(deep_questions))
learning2014$deep <- rowMeans(deep_columns)

surface_columns <-select(learning2014, one_of(surface_questions))
learning2014$surf <- rowMeans(surface_columns)

strategic_columns <- select(learning2014, one_of(strategic_questions))
learning2014$stra <- rowMeans(strategic_columns)

keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")
learning2014 <- select(learning2014, one_of(keep_columns))
colnames(learning2014)[2] <- "age"
colnames(learning2014)[7] <- "points"

learning2014<-filter(learning2014, points > 0)

write.csv(learning2014, file = "learning2014.csv", row.names=FALSE)

lrn2014 <- read.csv("learning2014.csv")
str(lrn2014)
head(lrn2014)

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

str(hd)
dim(hd)

str(gii)
dim(gii)

summary(hd)
summary(gii)

colnames(hd)[1:8] <- c("HDI_r", "Country", "HDI", "Life_exp", "Edu_exp", "Edu_mean", "GNI", "GNI-HDI")
colnames(gii)[1:10] <- c("GII_r", "Country", "GII", "Mat_deaths", "Young_births", "Parl_seats", "High_edu_f", "High_edu_m", "F_working", "M_working")

library(dplyr)

gii <- mutate(gii, High_edu_f_m = High_edu_f / High_edu_m)
gii <- mutate(gii, F_m_working = F_working / M_working)

human <- inner_join(hd, gii, by = "Country")

write.csv(human, file = "human.csv", row.names=FALSE)
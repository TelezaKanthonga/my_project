3 + 5
1-0

x <- 20

#Calculate x * 8
x*8

#Challeng

weight_g <- c(50,60,65,82)

animals <- c("mouse","rat","dog")

length(weight_g)
 animals[1:3]
animals[-2] 
animals[c(1,3)]


weight <- c(21, 34, 39, 54, 55)
weight > 50
weight[weight >50]
weight[weight >50 | weight <30]

animals <-  c("mouse","rat","dog","cat","fish")
animals[animals %in% c("dog","cat")]

heights <- c(2,4,6,NA,6)
mean(heights)
mean(heights, na.rm =TRUE)
na.omit(heights)

#install 
install.packages("tidyverse")
library("tidyverse")


surveys <- read_csv("data/portal_data_joined.csv")

class(surveys)
length(surveys)
nrow(surveys)
dim(surveys)#rows and columns
summary(surveys)
view(surveys)#open data in new tab
surveys[1]#get columns 
surveys[1,]#get row and columns
surveys[,3:5]
surveys[,8]#As vector
surveys$hindfoot_length#return it horizontal as data frame



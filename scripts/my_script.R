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


factor(surveys$sex)
library(tidyverse)

library(readr)
surveys <- read_csv("data/portal_data_joined.csv")
sex_data <- factor(surveys$sex)

View(surveys)
plot(sex_data)

nlevels(sex_data)


animal_sizes <- factor(c("m","s","s","m","l","m"))
levels(animal_sizes)
#To reorder
animal_sizes <- factor(animal_sizes,
                      levels = c("s","m","l") )
#converting factors to character
as.character(animal_sizes)

#convert dates from numeric to factor
year_fct <- factor(c(1990,1983.1977,1998,1990))
as.numeric(as.character(year_fct))

library(tidyverse)
sex_data <- surveys$sex
sex_data <- factor(surveys$sex)#convert to factor for plotting
levels(sex_data)

plot(sex_data)
sex_data <- addNA(sex_data)#include NA
plot(sex_data)

levels(sex_data) #including NA in levels

levels(sex_data)[3] <- "undetermined"
levels(sex_data) 
plot(sex_data)

#challenge 7, Reordering the graphs
sex_data<- factor(sex_data,
                       levels = c("undetermined","F","M") )


levels(sex_data) 
plot(sex_data)















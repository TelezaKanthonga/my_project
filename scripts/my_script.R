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

#challenge 8
animal_data <- data.frame(
  animal = c("dog", "cat", "sea cucumber", "sea urchin"),
  feel = c("furry", "squishy", "spiny",  "spiny"),
  weight = c(45, 8, 1.1, 0.8)
)

animal_data


#challenge 8.2
# 8.2. Can you predict the class for each of the columns in the following example?
# Check your guesses using `str(country_climate)`:

country_climate <- data.frame(country=c("Canada", "Panama", "South Africa", "Australia"),
                              climate=c("cold", "hot", "temperate", "hot/temperate"),
                              temperature=c(10, 30, 18, "15"),
                              northern_hemisphere=c(TRUE, TRUE, FALSE, "FALSE"),
                              has_kangaroo=c(FALSE, FALSE, FALSE, 1))

country_climate

# What would you need to change to ensure that each column had the accurate data type?


country_climate <- data.frame(country=c("Canada", "Panama", "South Africa", "Australia"),
                              climate=c("cold", "hot", "temperate", "hot/temperate"),
                              temperature=c(10, 30, 18, 15),
                              northern_hemisphere=c(TRUE, TRUE, FALSE, FALSE),
                              has_kangaroo=c(FALSE, FALSE, FALSE, TRUE))

country_climate


library(lubridate)
my_date <- ymd("2015-01-01")
str(my_date)


my_date <- ymd(paste("2015" , "01" , "01", sep= "-"))
str(my_date)
surveys$date <- ymd(paste(surveys$year, surveys$month, surveys$day, sep = "-"))
summary(surveys$date)
summary(surveys)

#To check for missing dates
surveys[is.na(surveys$date), c("year","month","day")]

#install package
install.packages("esquisse")
library(esquisse)

#for the symbol place ctrl+shift+M
surveys %>% 
  filter(year == 1995) %>% 
  select(species_id) %>% 
  group_by(species_id) %>% 
  summarise(total =n()) %>% 
  arrange(desc(total))

#mutate is used to make a new column, filter keep rows that are not in the condition
surveys %>% 
  filter(!is.na(weight)) %>% 
  mutate(weight_kg = weight/1000) %>% 
  select(weight, weight_kg) %>% 
  head()




#for the symbol place ctrl+shift+M
surveys %>% 
  filter(year == 1995) %>% 
  select(species_id) %>% 
  count(species_id) %>% 
  arrange(desc(n))


surveys %>% 
  filter(year == 1995) %>% 
  select(species_id, weight) %>% 
  summarise(min_weight = min(weight),
           max_weight = max(weight),
           total = n())

surveys %>% 
  mutate(hindfoot_cm =hindfoot_length /10) %>% 
  filter(!is.na(hindfoot_cm<3)) %>% 
  select(species_id,hindfoot_cm) %>% 

#cleaning data ti filter missing values
 surveys %>% 
  filter(!is.na(weight),
         !is.na(sex),
         !is.na(hindfoot_length)) -> surveys_clean

surveys_clean %>% 
  count(species_id) %>% 
  filter(n >= 50) -> species_count

surveys_clean %>% 
  filter(surveys_clean$species_id %in% species_count$species_id) -> surveys_complete

surveys_clean 

write_csv(surveys_complete,
          "data_output/surveys_complete.csv")

ggplot(data = surveys_complete) +
  aes(x = weight,
      y = hindfoot_length,
      color = species_id,
      shape = plot_type) +
  geom_point(alpha = 0.3)


ggplot(data = surveys_complete) +
  aes(x = weight,
      y = hindfoot_length) +
  geom_point() +
  geom_point(data = filter(surveys_complete,
                           species_id %in% c("DM")),
             color = "red",
             shape = 21) + 
  labs(title = "My title",
       subtitle = "This is the subtitle",
       x = "Weight (g)",
       y = "Hindfoot length (mm)") +
  theme_minimal()


ggplot(data = yearly_sex_counts) +
  aes(x = year,
      y = n,
      color = sex) +
  geom_line() +
  facet_grid(rows = vars(genus))





librarya(fmsb)





#Exercirce using kaggle users data
#first load the data
UserCountries <- read_csv("~/Desktop/UserCountries.csv")
UserCountries

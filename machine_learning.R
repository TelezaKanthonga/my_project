

library(readr)
library(dplyr)

dat <- read.csv("data.csv")
names <- c(1,2,3,4,5,11,12)
dat[,names] <- lapply(dat[,names],factor)
glimpse(data)

continous <- select_if(dat,is.numeric)
summary(continous)

#Removing outliers
#Its important to plot distribution of variables with outliers
#here we plot histogram with kernel density curve
library(ggplot2)
ggplot(continous, aes(x =ApplicantIncome)) +
  geom_density (alpha = .2, fill = "#000080")

#setting threshold to 98%
applicant_income <- quantile(dat$ApplicantIncome, .98)
applicant_income

#Drop the observations above the is threshold
dat_drop <- dat %>%
  filter(ApplicantIncome<applicant_income)
dim(dat_drop)


#Standardize the continuous variables
#Re-scale,bring everything to one scale for easy comparison
dat_rescale <- dat_drop %>%
  mutate_if(is.numeric, list(~as.numeric(scale(.))))
head(dat_rescale)













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

#Check factors,define new levels
#The goal is to figure out which factors influence this model/system
#select categorical column
factor <- data.frame(select_if(dat_rescale,is.factor))
 ncol(factor)

#plot graphs for each column
 library(ggplot2)
graph <- lapply(names(factor),
                function(x)
                  ggplot(factor,aes(get(x))) +
                geom_bar() +
                  theme(axis.text.x = element_text(angle =90)))

graph 

#plot gender income
ggplot(dat_rescale,
       aes(x = Gender, fill = Loan_status)) +
  geom_bar(position = "fill") +
  theme_classic()

#plot education loan status
ggplot(dat_rescale,
       aes(x = Education, fill = Loan_status)) +
  geom_bar(position = "fill") +
  theme_classic()
theme(axis.text.x = element_text(angle =90))

#plot property area loan status
ggplot(dat_rescale,
       aes(x = Property_area, fill = Loan_status)) +
  geom_bar(position = "fill") +
  theme_classic()
theme(axis.text.x = element_text(angle =90))

#Check if applicant income is related to loan

ggplot(dat_rescale, aes(x = ApplicantIncome, y = Loan_amount)) +
  geom_point(aes(color = Loan_status),
             size = 0.5) +
  stat_smooth(method = "lm",
formula = y~poly(x, 2),
se =TRUE,
aes(color = Loan_status)) +
  theme_classic()


#visualize betwween variables
install.packages("GGally")
library(GGally)
#convert data to numeric
corr <- data.frame(lapply(dat_rescale, as.integer))
#plot the graph
ggcorr(corr,
       method = c("pairwise", "spearman"),
       nbreaks = 6,
       hjust =0.8,
       label =TRUE,
       label_size =3,
       color ="grey50")


#train /test set
install.packages("caret")
library(caret)
set.seed(1234)

trainIndex <- createDataPartition(dat$Loan_status, p =0.7,
                                  list =FALSE, times =1)
trainData <- dat[trainIndex,]
testData <- dat[-trainIndex,]

print(dim(trainData)); print(dim(testData))

#Build modelm
model_glm = glm(Loan_status~., family="binomial",
                data = trainData)
                                  
summary(model_glm)

#Baseline Accurancy
prop.table(table(trainData$Loan_status))


#Assess the performance of the model
#prediction on the training set
predictTrain <- predict(model_glm, trainData, type = "response")


#Confusion matrix on training data
train_mat <- table(trainData$Loan_status, predictTrain >= 0.5)
                                  
train_mat                              

#predictions on the test set
predictTest <- predict(model_glm, testData, type ="response")
                                  
#Confusion matrix on test data
test_mat <- table(testData$Loan_status, predictTest >= 0.5)

test_mat               



accuracy_train <- sum(diag(train_mat)) /sum(train_mat)
accuracy_train

accuracy_test <- sum(diag(test_mat)) /sum(test_mat)
accuracy_test

# Chapter 2 Exercises R Code -----------------------------------------------------
# Exercises 8, 9, 10

# Exercise 8 --------------------------------------------------------------
# a.)
setwd("/Users/doojerthekid/Documents/Merrimack Grad School Documents/DSE6111")
college = read.csv("Week_1/College.csv")

# b.)
fix(college)
row.names(college) = college[,1]
fix(college)

# Eliminate first column in data where names are stored
college = college[,-1]
fix(college)

# c.)
# i.) 
summary(college)

# ii.) 
# Convert private variable into factor using as.factor
college$Private = as.factor(college$Private)
pairs(college[,1:10])

# iii.)
plot(college$Private, college$Outstate,
     xlab = "Private University: Yes or No",
     ylab = "Out of State Tuition in $")

# iv.)
# Create qualitative variable, called Elite, by binning Top10perc variable
Elite = rep("No", nrow(college))
Elite[college$Top10perc > 50] = "Yes"
Elite = as.factor(Elite)
college = data.frame(college, Elite)
summary(college)
# 78 elite schools meaning they have over 50% of new students from top 10% of 
## high school class
# 699 schools have less than 50% of new studnets from top 10% of high school class

# Plot side-by-side boxplots of Outstate versus Elite
plot(college$Elite, college$Outstate,
     xlab = "Over 50% of New Students from Top 10% of High School Class",
     ylab = "Out of State Tuition in $")

# v.) 
# Create four histograms: out of state tuition, book cost, room and board cost,
## and graduation rate
par(mfrow=c(2,2))
hist(college$Outstate)
hist(college$Books)
hist(college$Room.Board)
hist(college$Grad.Rate)

# vi.) 
# Find university with highest and lowest acceptance rate
acceptance_rate = college$Accept / college$Apps
row.names(college)[which.max(acceptance_rate)]
# Returned Emporia State University
row.names(college)[which.min(acceptance_rate)]
# Returned Princeton University
# Find acceptance rates of Emporia State University and Princeton University
max(acceptance_rate)
# Returns 1, meaning Emporia State University has 100% acceptance rate
min(acceptance_rate)
# Returns 0.1545, meaning Princeton University has aprox 15% acceptance rate

# Find universities with highest and lowest enrollment rate
enrollment_rate = college$Enroll / college$Accept
row.names(college)[which.max(enrollment_rate)]
# Returned California Lutheran University
row.names(college)[which.min(enrollment_rate)]
# Franklin Pierce College
# Find enrollment rates of each school
max(enrollment_rate)
# Returned 1, meaning 100% of students accepted to California Luthern University, enroll there
min(enrollment_rate)
# Returned 0.09975, meaning 9.98% of students accepted by Franklin Pierce College, enroll there


# Look at school(s) with highest and lowest graduation rate
row.names(college)[which.max(college$Grad.Rate)]
# Returned Cazenovia College
row.names(college)[which.min(college$Grad.Rate)]
# Returned Texas Southern University
# Find grad rates of each school
max(college$Grad.Rate)
# Returned 118% for Cazenovia College. How does that even happen???
min(college$Grad.Rate)
# Returned 10% graduation rate for Texas Souther University

# Look at Grad.Rate and see how it matches up with out of state tuition, room and board costs,
## book costs and personal spending
par(mfrow=c(2,2))
plot(college$Outstate, college$Grad.Rate)
plot(college$Room.Board, college$Grad.Rate)
plot(college$Books, college$Grad.Rate)
plot(college$Personal, college$Grad.Rate)
# Higher out-of-state tuition and higher Room and Boarde costs
## looks like it means higher graduation rate
# No real relationship between book/personal costs and graduation rate

# Histogram of grad rate
hist(college$Grad.Rate)
# Seems to have unimodal normal distribution

# Histogram of room and board
hist(college$Room.Board)
# Also seems to have normal distribution

# Exercise 9 --------------------------------------------------------------
# Read in Auto data
auto = read.csv("Week_1/Auto.csv")
# No NA's in data. There are ?. Change ? to NA's then remove them
auto$horsepower[auto$horsepower == "?"] = NA
auto = na.omit(auto)


# a.) 
summary(auto)
# Quantitative variables: mpg, cylinders, displacement, horsepower, weight,
# acceleration
# Qualitative variables: year, origin, name
# Year and origin are numerical in the data, but have no purpose being viewed 
## as quantitative

# b.)
# Range of each quantitative variable:
range(auto$mpg)
# Range is from 9.0 to 46.6

range(auto$cylinders)
# Range is from 3 to 8

range(auto$displacement)
# Range is from 68 to 455

# Change horsepower column to integer
auto$horsepower = as.integer(auto$horsepower)
range(auto$horsepower)
# Range is 46 to 230

range(auto$weight)
# Range is 1613 to 5140

range(auto$acceleration)
# Range is 8.0 to 24.8

# c.) 
# Mean and SD of each variable
mean(auto$mpg)
# 23.45
sd(auto$mpg)
# 7.81

mean(auto$cylinders)
# 5.47
sd(auto$cylinders)
# 1.71

mean(auto$displacement)
# 194.41
sd(auto$displacement)
# 104.64

mean(auto$horsepower)
# 104.64
sd(auto$horsepower)
# 38.49

mean(auto$weight)
# 2977.58
sd(auto$weight)
# 849.40

mean(auto$acceleration)
# 15.54
sd(auto$acceleration)
# 2.76

# d.)
# Remove 10th and 85th observation
auto = auto[-c(10, 85), ]

# Mean and SD now
mean(auto$mpg)
# 23.49
sd(auto$mpg)
# 7.79

mean(auto$cylinders)
# 5.46
sd(auto$cylinders)
# 1.70

mean(auto$displacement)
# 193.51
sd(auto$displacement)
# 104.14

mean(auto$horsepower)
# 104.07
sd(auto$horsepower)
# 38.18

mean(auto$weight)
# 2972.47
sd(auto$weight)
# 848.51

mean(auto$acceleration)
# 15.57
sd(auto$acceleration)
# 2.74

# Not a big difference on the means and SD's when 10th and 85th observations taken out

# e.) 
plot(auto$weight, auto$mpg)
# Seems to have negative relationship. As the weight increases in vehicles, the mpg 
## decreases

plot(auto$weight, auto$horsepower)
# Seems to have positive relationship. As weight increases in vehicles, the horsepower increases.


plot(auto$weight, auto$acceleration)
# Grand scheme, the more heavy a vehicle is, the less acceleration. Not as linear of a relationship
## compared to miles per gallon and horsepower


plot(auto$horsepower, auto$displacement)
# Positive relationship here. The more horsepower, the more displacement. 


plot(auto$horsepower, auto$acceleration)
# Negative relationship. The more horsepower, the less acceleration

plot(auto$horsepower, auto$mpg)
# Negative relationship. The more horsepower, the less mpg

# f.)
par(mfrow=c(2,2))
plot(auto$weight, auto$mpg)
plot(auto$horsepower, auto$mpg)
plot(auto$displacement, auto$mpg)
plot(auto$acceleration, auto$mpg)
# Weight, horsepower and displacement seem to be best predictors. They all have 
## negative relationship with mpg. As all three increase, mpg on average decreases.

# Exercise 10 -------------------------------------------------------------
# a.)
library(MASS)
boston = Boston
?Boston
dim(boston)
# 506 rows. 14 columns
# Each row represents a suburb of Boston.
# Each column represents a different variable regarding that specific suburb.

# b.)
par(mfrow=c(1,1))
plot(boston$dis, boston$medv)
# The farther away from Boston employment centers, the more expensive owner-occupied homes are. More residential.

plot(boston$dis, boston$medv)
# The farther from Boston employment centers, the less non-business acres per town. More residential the farther 
## out from Boston.

plot(boston$dis, boston$nox)
# Farther away from Boston employment centers, less nitrogen oxide concentration. More nitrogen oxide
## in and near city.

plot(boston$age, boston$rm)
# Not much to report on here. Most houses in and around Boston have 5+ rooms regardless 
## of the proportion of owner-occupied units built prior to 1940.

# c.) 
plot(boston$nox, boston$crim)
# Somewhat associated. But not too much of relationship to say so.

plot(boston$rm, boston$crim)
# Somewhat associated. But not too much of relationship to say so.

plot(boston$dis, boston$crim)
# Higher crime rate in city compared to farther out in the suburbs

plot(boston$black, boston$crim)
# No correlation here.

plot(boston$lstat, boston$crim)
# Somewhat associated. As lower status of population increases, crime rate seems to increase

plot(boston$medv, boston$crim)
# Higher the median value of owner-occupied homes, lower the crime rates. Less crime rate in 
## residential areas

# d.)
range(boston$crim)
# returns 0.06% and 88.97%

range(boston$zn)
# 0 to 100

range(boston$indus)
# 0.46 to 27.74

range(boston$chas)
# 0 to 1

range(boston$nox)
# 0.385 to 0.871

range(boston$rm)
# 3.561 to 8.780

range(boston$age)
# 2.9 to 100

range(boston$dis)
# 1.13 to 12.13

range(boston$rad)
# 1 to 24

range(boston$tax)
# Returns 187 and 711

range(boston$ptratio)
# Returns 12.6 and 22.0

range(boston$black)
# 0.32 to 396.90

range(boston$lstat)
# 1.73 to 37.97

range(boston$medv)
# 5 to 50

# e.)
# Uses table function to count distinct values in column.
table(boston$chas)
# 35 of the 506 suburbs bound the Charles river

# f.)
summary(boston$ptratio)
# Using summary() function to find median pupil-teacher ration is 19.05%

# g.)
row.names(boston)[which.min(boston$medv)]
# the 399th suburb on the list has lowest median value of owner-occupied homes

boston[399,]
#       crim    zn indus chas   nox    rm    age    dis    rad  tax  ptratio   black  lstat  medv
# 399   38.3518  0  18.1    0  0.693  5.453  100   1.4896  24   666    20.2    396.9  30.59   5
# Crim: Closer to lower end of range compared to higher. About halfway in the range.
# zn: Lowest possible value in range.
# indus: Closer to higher range value.
# chas: 0. Does not bound Charles river.
# nox: Closer to higher end of range.
# rm: Closer to higher end of range.
# age: Highest possible value.
# dis: Close to lower end of range. Close to Boston.
# rad: Highest possible value of rad.
# tax: Closer to higher end of tax value range.
# ptration: Close to high end of range.
# black: Highest possible value of variable.
# lstat: Close to highest value in range.
# medv: Lowest possible value in range.

# h.)
sum(boston$rm > 7)
# 64 suburbs. Used sum() function to add up how many rows have greater than 7 rooms

# Do the same for rm variable greater than 8
sum(boston$rm > 8)
# 13 suburbs
# Summary on 13 suburbs
summary(subset(boston, rm > 8))

# Looking at summary of the 13 suburbs, one thing that I noticed is that they have a higher than 
## average median value for the age variable. Meaning that that the proportion of houses 
### built between 1940 are high in those suburbs. And on average, they are not too far away from
#### the city. 


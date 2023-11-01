# Module 01 Question 2 example R code

# Using simple assignment
x = 3
y = 4
z = 5

# Use arithmetic with assignments
var_add = (x + y)
print(var_add)

var_sub = (z - x)
print(var_sub)

var_mult = (x * y)
print(var_mult)

var_div = (z / x)
print(var_div)

# Create vector of assignments. Print new vector and call the first element
arith_vec = c(var_add, var_sub, var_mult, var_div)
print(arith_vec)
arith_vec[1]

# Mutiply the vector by 2 and assign that vector to new vector. Call first and second element
double_arith_vec = ((arith_vec) * 2)
print(double_arith_vec)
double_arith_vec[1:2]

# Square arith_vec and assign it to new vector. Print vector with second element not showing
square_arith_vec = ((arith_vec) ^ 2)
print(square_arith_vec)
print(square_arith_vec[-2])

# Add doubleb_arith_vec and square_artih_vec and assign it to new vector
add_vec = (double_arith_vec) + (square_arith_vec)
print(add_vec)

# Check to see if elements in double_arith_vec are equal to arith_vec
double_arith_vec == arith_vec
# This returns FALSE FALSE FALSE FALSE

# Divide double_arith_vec by 2 and check to see if elements in new vector are equal to arith_vec
half_double_vec = ((double_arith_vec) / 2)
half_double_vec == arith_vec
# This returned TRUE TRUE TRUE TRUE


# Create data frame of MLB teams, city they are from, what league they are in, 
## when they teams were created, and how many World Series they won. Name the column
### names as well.
mlb_df = data.frame(team_name = c('Red Sox', 'Yankees', 'Dodgers', 'Mariners' ),
                    team_city = c('Boston', 'New York', 'Los Angeles', 'Seattle'),
                    team_league = c('American', 'American', 'National', 'American'),
                    team_origination_year = c(1901, 1903, 1883, 1977),
                    world_series = c(9, 27, 7, 0)
                    )
print(mlb_df)
# Data frame subsetting
mlb_df[1] # First column with column name
mlb_df[,1] # Elements of first column listed out
class(mlb_df[1]) # Class is data.frame
class(mlb_df[,1]) # Class is character

mlb_df[4] # Last column with column name 
mlb_df[,4] # Elements of last column listed out
class(mlb_df[4]) # Class is data.frame
class(mlb_df[,4]) # Class is numeric

# Call to team_league using $ syntax and print results
print(mlb_df$team_league)


# Create matrix
matrix_ex_1 = matrix(c(4, 5, 6, 4, 8, 19, 40, 99), nrow = 2, ncol = 4)
print(matrix_ex_1)
# Create same matrix by binding vectors as rows and check to see if elements in 
## matrices equal each other
matrix_ex_2 = rbind(c(4, 6, 8, 40), c(5, 4, 19, 99))
print(matrix_ex_2)
(matrix_ex_1) == (matrix_ex_2) # This returned all true
# Create same matrix by stacking columns side by side and check to see if elements
## in matrix equal matrix_ex_1
matrix_ex_3 = cbind(c(4,5), c(6,4), c(8, 19), c(40,99))
print(matrix_ex_3)
(matrix_ex_1) == (matrix_ex_3) # This also returned all true

# Subset matrix_ex_1
matrix_ex_1[2,4] # Returns element in second row, fourth column
matrix_ex_1[1,] # Returns all elements in first row
matrix_ex_1[,2] # Returns all elemtns in second column


# Functions
even_num = c(2, 4, 6, 8, 10)
odd_num = c(1, 3, 5, 7, 9)

# Length, sum, mean, median, standard deviationon each
# Length
length(even_num)
length(odd_num)
length(even_num) == length(odd_num) # This returns true

# Sum
sum(even_num)
sum(odd_num)
sum(even_num) == sum(odd_num) # This returns false

# Mean
mean(even_num)
mean(odd_num)
mean(even_num) == mean(odd_num) # This returns false

# Median
median(even_num)
median(odd_num)
median(even_num) == median(odd_num) # This returns false

# Standard deviation
sd(even_num)
sd(odd_num)
sd(even_num) == sd(odd_num) # This returns true


# Install dply package
install.packages("dplyr")
# Install multiple packages
install.packages(c("dplyr", "ggplot2", "tidyverse"))
# Load all the packages
library("dplyr")
library("ggplot2")
library("tidyverse")


# Check working directory then read in weight.csv saved in DSE5001 folder
getwd()
# Returned: "/Users/doojerthekid/Documents/Merrimack Grad School Documents/DSE5002 Git Clone"
# Let's set new directory using setwd()
setwd("/Users/doojerthekid/Documents/Merrimack Grad School Documents/DSE5001")
# Check directory now
getwd()
# Returned: "/Users/doojerthekid/Documents/Merrimack Grad School Documents/DSE5001"
# Read in weight.csv data
weight_df = read.csv("week_1/weight.csv")
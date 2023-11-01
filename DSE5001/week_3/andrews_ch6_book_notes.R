# Functions ---------------------------------------------------------------
# Vector of probabilities
p = c(0.1, 0.25, 0.5, 0.75)
# Logarithm to base 2:
log(p/(1 - p), base = 2)
# Base 3 or base 5
log(p/(1 - p), base = 3)
log(p/(1 - p), base = 5)

# Create a function that takes any vectors of probabilities and returns logarthim 
## of their odds to any desired base
log_odds = function(p, b){
  log(p/(1-p), base = b)
}
log_odds(p,2)
log_odds(p,3)

# Could also write function as:
log_odds = function(p,b) log(p/(1-p),base = b)
log_odds(p,3)

# When explicitly assignming arguments, order does not matter
probs = c(0.25, 0.75, 0.9)
log_base = 2
log_odds(probs, log_base)

log_odds(p = probs, b = log_base)
# same as:
log_odds(b = log_base, p = probs)

# Can create default functions for arguments
log_odds_2 = function(p, b = 10) {
  log(p/(1-p), base = b)
}

log_odds_2(probs, log_base)
log_odds_2(b = 3, p = probs)
# If we do not include b argument explicitly, it will use default b = 10
log_odds_2(probs)

# Optional Arguments
# Functions can have optional arguments indicated by ...
# Used to pass arugments to funtions that are called within functions
# Consider function that calculates polynomial function
f_poly = function(x, y, s, t){
  x^s + y^t
}
# Create function that returns logarithm to some specified base of f_poly for given
## values x, y, s, t
log_f_poly = function(b = 2, x, y, s, t){
  log(f_poly(x, y, s, t), base = b)
}
# Or we can write it this way
log_f_poly = function(..., b = 2){
  log(f_poly(...), base = b)
}
# This captures all the arguments other than b in the call of log_f_poly and passes them 
## to f_poly
x = c(0.5, 1)
y = c(1,2)
s = 2
t = 3
log_f_poly(x, y, s, t, b = 2)

# We may obtain optional arguemnts as a list given by ...
f = function(...){
  list(...)
}
f(x = 1, y =2, z = 3)

# Missing arguments
add_xy = function(x, y, z){
  x + y
}
add_xy(5,8)
# z is missing argument
# create function to test whether each of three input arguments are missing or not
is_missing_xyz = function(x, y, z){
  c(missing(x),
    missing(y),
    missing(z))
}
is_missing_xyz(1,2)
is_missing_xyz(z = 1, y = 42)
is_missing_xyz(5,4,3)

# Function return values
# Functions can have arbitrarily many statements and expressions in their body.
## When there are multiple statements, the value of the last expression is the value that
### is returned.
log_odds_3 = function(p, b = 10){
  odds = p / (1-p)
  log(odds, base = b)
}
log_odds_3(probs)

# Variant of log_odds_3
log_odds_4 = function(p, b = 10){
  odds = p / (1 - p)
  log_of_odds = log(odds, base = b)
  log_of_odds
}
log_odds_4(probs)

# can explicitly put return statement as well
log_odds_5 = function(p, b = 10){
  odds = p / (1 - p)
  log_of_odds = log(odds, base = b)
  return(log_of_odds)
}
log_odds_5(probs)

# Function scope and environment
assign_x = function(){
  x = 17
  x
}
x = 42
assign_x()
# assign x still 17. x in assign_x() is local variable while x = 42, x is global
# variable

assign_x2 = function(x){
  x[2] = 42
  x
}
x = c(2, 4, 8)
assign_x2(x)
# assign_x2(x) returns 2, 42, 8

# Variables in local enivornment are not visiable or usable in global environment
# Opposite is not true. Variables in global environment CAN be used in local environment
increment_x = function(){
  x + 1
}
x = 42
increment_x()
# returns 43. x still remains 42 in global environment

# Funtions can be nested
f = function(){
  x = 1
  g = function(){
    x + 1
  }
  h = function(){
    y + 2
  }
  c(g(), h())
}
# Functions g and h have their own local environment within the local environment of f
# Thus, f would be parent environment of g and h and the global environment is parent
## environment of f. 
y = 42
f()
# returns 2 and 44

f = function(){
  y = 42
  function(x){
    x + y
  }
}
g = f()
# g, which is the output of f(), is a function whose parent enivronment is the 
## environment of f. 
y = 21
g(17)
# This returns 59

# We can use special assignment operator <<- to assign value in the parent environment
f = function(){
  x <<- 42
}
x = 17
f()
x
# x now returns 42

# Anonymous functions
f = function(x, g){
  g(sum(x))
}
# f takes an object x and a function g and calls g(sum(x)) and returns the result
# We can pass any existing R functions we wish as the value of g:
x = c(0.1, 1.1, 2.7)
f(x, log10)
log10(3.9)

f(x, sqrt)
sqrt(3.9)

f(x, tanh)
tanh(3.9)
# we can also pass in any funciton we have defined ourselves:
square = function(x) x^2
f(x, square)
# Returns. 15.21, same as doing 3.9^2

# We do not have to assign a name to our custom function and pass in that name.
# We can isntead just pass in the unnamed, or anonymous function itself
f(x, function(x) x^2)
f(x, function(x) log(x^2))

# We can create a self-executing anonymous function:
y = (function(x, y, z){x + y + z}) (1, 2, 3)
y
# A function is created and called immediately and the result assigned to y


# Conditionals ------------------------------------------------------------
# Allow us to execute some code based on whether some condition is true or not
library(tidyverse)
data_df = tibble(x = rnorm(10),
                 y = rnorm(10))
write_data = T
if (write_data) {
  write_csv(data_df, 'tmp_data.csv')
}
# We write data_df to a .csv file if and only if write_data

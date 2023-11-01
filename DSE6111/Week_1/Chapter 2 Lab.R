# 2.3 Lab: Intro to R -----------------------------------------------------------

# 2.3.1 Basic Commands ----------------------------------------------------
# Run a function called funcname
funcname(input1, input2)

# Create a vector of numbers, use c(), for concatenate
x = c(1,3,2,5)
x = c(1,6,2)
y = c(1,4,3)

# Add x and y together. First check lenght of each vector
length(x)
length(y)

x + y
# Returns 2 10 5

# ls() function allows us to look at a list of objects, such as data and functions
## that we have saved so far
# rm() function can be used to delete any that we do not want
ls()
rm(x,y)
ls()

# Remove all objects at once
rm(list = ls())

# matrix() function can be used to create a matric of numbers
x = matrix(data = c(1,2,3,4), nrow = 2, ncol = 2)
# can just omit data = and nrow = and ncol = 
x = matrix(c(1,2,3,4), 2, 2)
# R creates matrices by successively filling in columns. Alternatively the byrow = TRUE 
## option can be used to populate the matrix in order by rows
matrix(c(1,2,3,4), 2, 2, byrow = TRUE)

# sqrt() function returns the square root of each element of a vector or matrix
sqrt(x)
# x^2 raises each element of x to the pwoer of 2
x^2

# The rnorm() function generates a vector of random normal variables, with the first
## argument n the sample size. Each time we call this function, we will get a different
### answer
x = rnorm(50)
y = x + rnorm(50, mean = 50, sd = 0.1)
# cor() function used to compute the correlation between two correlated sets of numbers, x and y
cor(x,y)

# By default, rnorm() creates standard normal random variables with a mean of 0 and a 
## standard deviation of 1. Can alter this using mean and sd arguments. Illustrated above

# Sometimes we want our code to reproduce the exact same set of random numbers, we can 
## use set.seed() function to do this. Takes in an arbitrary integer argument
set.seed(1303)
rnorm(50)

# mean() and var() functions can be used to compute mean and variance of vectors of 
## numbers. Applying sqrt() to the output of var() will give standard devation.
### Or just use sd() function.
set.seed(3)
y = rnorm(100)
mean(y)
var(y)
sqrt(var(y))
sd(y)
sqrt(var(y)) == sd(y)

# 2.3.2 Graphics ----------------------------------------------------------
# plot() function is primary way to plot data in R
# plot(x,y) prduces scatter plot of numbers in x versus numbers in y
x = rnorm(100)
y = rnorm(100)
plot(x, y, xlab = "This is the x-axis", 
     ylab = "This is the y-axis",
     main = "Plot of X vs Y")

# Often want to save teh output of an R plot. Command that we use to do this will depend
## on the file type that we would like to create
# To create PDF, we use the pdf() function, to create jpeg we use jpeg() function
pdf("Figure.pdf")
plot(x, y, col = "green")
def.off()

# seq() funciton can be used to create sequence of numbers. For instance,
## seq(a,b) makes a vector of integers between a and b. 
# seq(0,1,length = 10) makes sequence of 10 numbers that are equally spaced between
## 0 and 1.
# Typing 3:11 is a shortand for seq(3,11)
x = seq(1,10)
x = 1:10
x = seq(-pi, pi, length = 50)

# Create more sophisticated plots
# contour() function produces a contour plot in order to represent three dimensional
## data, like a topographical map.
# It takes 3 arguments:
## 1. A vector of the x values - First Dimenstion
## 2. A vector of the y values - Second Dimension
## 3. A matris whose elements correspond to the z value (Third Dimension) for each pair of
##.   (x,y) coordnates
y = x
f = outer(x, y, function (x,y)cos(y)/(1+x^2))
contour(x, y, f)

contour(x, y, f, nlevels = 45, add = T)

fa = (f-t(f))/2
contour(x, y, fa, nlevels = 15)

# image() function works same way as contour(), except that it produces a color-coded
## plot whose colors depend on z value. This is known as heatmap and is sometimes
### used to plot temperature in weather forecasts.
# persp() can be used to produce three-dimensional plot. theta and phi arguments
## control the angles at which the plot is viewed
image(x, y , fa)
persp(x, y, fa)
persp(x, y, fa, theta = 30)
persp(x, y, fa, theta = 30, phi = 20)
persp(x, y, fa, theta = 30, phi = 70)
persp(x, y, fa, theta = 30, phi = 40)

# 2.3.3 Indexing Data -----------------------------------------------------
# Look at data in matrix A
A = matrix(1:16, 4, 4)
A[2,3]
# Returns 10, which is element in 2nd row, 3rd column
# A[row, column]
# we can select multiple rows and columns at a time

A[c(1,3), c(2,4)]
# Extracts rows 1 and 3 and columns 2 and 4 from matrix A

A[1:3, 2:4]
# Extracts rows 1 through 3, and columns 2 through 4

A[1:2,]
# Extracts rows 1 and 2, and all elements in each column

A[,1:2]
# Extracts all rows, and columns 1 and 2

A[1,]
# Extracts just first row

# Use of negative sign in the index tells R to keep all rows or columns
## except those indicated in index
A[-c(1,3),]
# Takes out rows 1 and 3

A[-c(1,3), -c(1,3,4)]
# Removes rows 1 and 3, columns 1, 3 and 4

# The dim() function outputs the numbers of rows followed by number of columns of
## given matrix
dim(A)





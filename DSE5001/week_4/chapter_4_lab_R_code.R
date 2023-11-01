# Lab Data ----------------------------------------------------------------

download.file("http://www.openintro.org/stat/data/bdims.RData", destfile = "bdims.RData")
load("bdims.RData")

head(bdims)

mdims <- subset(bdims, sex == 1)
fdims <- subset(bdims, sex == 0)

# Exercise 1 --------------------------------------------------------------
library(ggplot2)

# Histogram for males
ggplot(mdims,
       mapping = aes(x = hgt)) +
  geom_histogram(color = 'white', fill = 'red') +
  labs(x = 'Height in cm',
       y = 'Count',
       title = 'Counts of Males by Height in cm')

# Histograms for females
ggplot(fdims,
       mapping = aes(x = hgt)) +
  geom_histogram(color = 'white', fill = 'blue') +
  labs(x = 'Height in cm',
       y = 'Count',
       title = 'Counts of Females by Height in cm')

# One histogram with height by males and females
ggplot(bdims,
       mapping = aes(x = hgt, fill = sex)) +
  geom_histogram(color = 'white') +
  labs(x = 'Height in cm',
       y = 'Count',
       title = 'Counts of Males vs. Females by Height in cm',)
  
# Both plots look relatively normal. Both distributions are unimodial and the males histogram
# looks almost symmetric. Both have a bell-shape to them.


# Exercise 2 --------------------------------------------------------------
# Working with woman's height, find mean and sd:
fhgtmean <- mean(fdims$hgt)
fhgtsd   <- sd(fdims$hgt)

# Make density histogram to use as backdrop and overlay a normal probability curve
hist(fdims$hgt, probability = TRUE, ylim = c(0, 0.06))
x <- 140:190
y <- dnorm(x = x, mean = fhgtmean, sd = fhgtsd)
lines(x = x, y = y, col = "blue")

# Based on this density histogram, I would say the data follows a nearly normal distribution


# Exercise 3 --------------------------------------------------------------
# We can also construct a normal probability plot to check if distribution is nearly normal.
# This plot is also called a Q-Q plot for , "quantile-quantile".
# A data set that is nearly normal will result in a probability plot where the points closely 
## follow the line.

qqnorm(fdims$hgt)
qqline(fdims$hgt)

# What do probability plots look like for data that I know came from a normal distribution? 
# We can answer this by simulating data from a normal distribution using rnorm.

sim_norm <- rnorm(n = length(fdims$hgt), mean = fhgtmean, sd = fhgtsd)
qqnorm(sim_norm)
qqline(sim_norm)
# Not all points fall on the line. But it seems that more points are closer to the 
## line compared to the probability plot for the real data.The points near the line
### seem to be more linear in the probability plot for sim_norm compared to the real data.


# Exercise 4 --------------------------------------------------------------
# Even better than comparing the original plot to a single plot generated from a normal 
## distribution is to compare it to many more plots using the following function.

qqnormsim(fdims$hgt)

# Error:
# Error in plot.new() : figure margins too large

# I cannot see the multiple simulated plots from qqnormsim(fdims$hgt) due to the error
## in R. Based on the plot from sim_norm, and the shape/distribution of original data,
### I am going to say that this data is nearly normal, with a few outliers.


# Exercise 5 --------------------------------------------------------------
# Using the same technique, determine whether or not female weights appear to 
## come from a normal distribution.
ggplot(fdims,
       mapping = aes(x = wgt)) +
  geom_histogram(color = 'white', fill = 'blue') +
  labs(x = 'Weight in kg',
       y = 'Count',
       title = 'Counts of Females by Weight in kg')

# Working with woman's weight, find mean and sd:
fwgtmean <- mean(fdims$wgt)
fwgtsd   <- sd(fdims$wgt)


# Make density histogram to use as backdrop and overlay a normal probability curve
min(fdims$wgt)
# Returned 42
max(fdims$wgt)
# Returned 105.2

hist(fdims$wgt, probability = TRUE, ylim = c(0, 0.06))
x <- 42:105.2
y <- dnorm(x = x, mean = fwgtmean, sd = fwgtsd)
lines(x = x, y = y, col = "blue")

# Based on the distribution from the density histogram, it does not look like the 
# distribution is normal. Looks more right-skewed than symmetric.

# Let's look at normal probability plot:

qqnorm(fdims$wgt)
qqline(fdims$wgt)

# The probablity plot is concave up which further confirms my thoughts that the 
# distribution is right-skewed.

# Let's simulate data from a normal distribution using rnorm.
sim_norm_wgt <- rnorm(n = length(fdims$wgt), mean = fwgtmean, sd = fwgtsd)
qqnorm(sim_norm_wgt)
qqline(sim_norm_wgt)

# This data looks s-shaped more than linear. Therefore, I am going to say that the
## female weight distribution is right-skewed and not normal.


# Exercise 6 --------------------------------------------------------------
# What is the probability that a randomly chosen young adult female is taller 
## than 6 feet (about 182 cm)?
1 - pnorm(q = 182, mean = fhgtmean, sd = fhgtsd)
# Returned 0.0044 which is 0.44%

# Assuming a normal distribution has allowed us to calculate a theoretical probability. 
## If we want to calculate the probability empirically, we simply need to determine how many 
### observations fall above 182 then divide this number by the total sample size.

sum(fdims$hgt > 182) / length(fdims$hgt)
# This returned 0.0038 which is 0.38%

# Exercise Q/A
# Question 1
# What is the probability that a randomly chosen young adult female is smaller than 
## 5 feet 7 inches (about 170 cm)?
pnorm(170, mean = fhgtmean, sd = fhgtsd)
# Returned 0.7833 which is 78.33%

# Calculate probability empirically
sum(fdims$hgt < 170) / length(fdims$hgt)
# Returned 0.7538 which is 75.38%

# Difference between two probabilities:
78.33 - 75.38
# 2.95

# Question 2
# What is the probability that a randomly chosen young adult female weighs more than 
## 55 kg?
1 - (pnorm(55, mean = fwgtmean, sd = fwgtsd))
# This returned 0.7199 which is 71.99%

# Calculate probability empirically
sum(fdims$wgt > 55) / length(fdims$wgt)
# This returned 0.6923 which is 69.23%

# Difference between two probabilities:
71.99 - 69.23
# 2.76

# Weight had a closer agreement between two methods. However, height is more normal than 
## weight, so I believe those probabilities are more accurate.


# On Your Own Lab ---------------------------------------------------------
# 1.
# a. a. The histogram for female biiliac (pelvic) diameter (bii.di) belongs to 
## normal probability plot letter ____.
qqnorm(fdims$bii.di)
qqline(fdims$bii.di)
# Belongs to plot B

# b.The histogram for female elbow diameter (elb.di) belongs to normal probability
## plot letter ____.
qqnorm(fdims$elb.di)
qqline(fdims$elb.di)
# Belongs to plot C

# c. The histogram for general age (age) belongs to normal probability plot letter ____.
qqnorm(fdims$age)
qqline(fdims$age)
# Belongs to plot D

# d. The histogram for female chest depth (che.de) belongs to normal probability plot letter ____.
qqnorm(fdims$che.de)
qqline(fdims$che.de)
# Belongs to plot A

# 2. 
# This occurs because these distributions are not normal. The more ouutliers there are,
## the more skewed the data.

# 3. 
qqnorm(fdims$kne.di)
qqline(fdims$kne.di)
# Based on probability plot being concave up, this looks right-skewed.

# Create histogram to confirm conclusion.
ggplot(fdims,
       mapping = aes(x = kne.di)) +
  geom_histogram(color = 'white', fill = 'blue') +
  labs(x = 'Knee Diameter',
       y = 'Count',
       title = "Counts of Female's Knee Diameter")

# Confirmed with histogram that data is right-skewed

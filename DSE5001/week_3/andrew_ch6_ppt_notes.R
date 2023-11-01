f = function(x, g){
  g(sum(x))
}
x = c(0.1, 1.1, 2.7)
f(x, log10)

f(x, function(x) x^2)

library(tidyverse)
data_df = tibble(x = rnorm(10),
                 y = rnorm(10))
write_data = TRUE
if (write_data){
  write_csv(data_df, 'tmp_data.csv')
}

use_new_data = TRUE
if (use_new_data){
  data_df = read_csv('data.new.csv')
} else{
  data_df = read_csv('data_old.csv')
}


N = 1000
x = seq(-0.1, 1.1, length.out = N)

relu = function(x){
  if (x < 0) { 0 } 
  else{ x }
}
# Create for loop
y = numeric(N)
for (i in 1:N){
  y[i] = relu(x[i])
}
}
y

k = 0
while (2^(k+1) <= 10^6){
  k = k + 1
}
k
2^19
10^6

# lapply
x = c(-1, 0, 1)
y = lapply(x, relu)
y

# map
y1 = map(x, relu)
y1



# Create a vector of housing prices
housing_prices <- c(rep(300000, 25), rep(600000, 50), rep(900000, 75), seq(6000000, 10000000, by = 100000))

# Create a box plot
boxplot(housing_prices, horizontal = TRUE, notch = TRUE, main = "Housing Prices",
        xlab = "Price in USD", outline = FALSE)

# Add labels to quartiles
text(c(350000, 450000, 1000000), c(1.5, 1.5, 1.5), c("Q1", "Median", "Q3"), pos = 4, col = "red", font = 2)

# Add labels to outliers
text(6000000, 1.5, "Outliers", pos = 4, col = "blue", font = 2)

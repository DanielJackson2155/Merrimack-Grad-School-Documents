# Exercise 4.2 code and plots
library(visualize)

# a.) Z > -1.13
# Graph code:
visualize.norm(stat = -1.13, mu = 0, sd = 1, section = 'upper')


# b.) Z < 0.18
# Graph code:
visualize.norm(stat = 0.18, mu = 0, sd = 1, section = 'lower')

# c.) Z > 8
# Graph code:
visualize.norm(stat = 8, mu = 0, sd = 1, section = 'upper')

# d.) |Z| < 0.5
# Graph code:
visualize.norm(stat = c(-0.5, 0.5), mu = 0, sd = 1, section = 'bounded')
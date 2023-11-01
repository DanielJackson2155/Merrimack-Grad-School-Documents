# Chapter 3 Coding Notes --------------------------------------------------
library(dplyr)
blp_df = read_csv('week_2/blp-trials-short.txt')
blp_df
# From dpylr
glimpse(blp_df) # look at resulting data frame

# Use select to select variables
select(blp_df, participant, lex, resp, rt)
select(blp_df, spell:prev.rt)
select(blp_df, c(2:5))
select(blp_df, starts_with('p'))
select(blp_df, ends_with('t'))
select(blp_df, contains('rt'))

# Use regular expression match ^rt|rt$ will match the rt as if it begins (^rt) or(|) ends (rt$^) a string
select(blp_df, matches('^rt|rt$'))

# Remove variables using minus sign
select(blp_df, -participant)

# Removing range of variables by indices
select(blp_df, -(2:6))
# Remove variables containing string
select(blp_df, -contains('rt'))

# Reorder variables in order
select(blp_df, spell, participant, resp)

# Use everything() function in select() to call to the rest of the variables
select(blp_df, spell, participant, resp, everything())

# Use everything() to move variable columns around
select(blp_df, resp, everything(), -participant, participant)
# This code reordered variables: resp first, everything, removed participant then added participant to end of data frame

# Using is.character() and is.numeric()
x = c(1, 42, 3)
y = c('good', 'dogs', 'brent')
is.numeric(x)
# TRUE

is.numeric(y)
# FALSE

is.character(x)
# FALSE

is.character(y)
# TRUE

# Use is.character and is.numeric to select variables that are character and 
## numeric vectors
select(blp_df, where(is.character))
select (blp_df, where(is.numeric))

# Custom function that will return TRUE if variable is numeric variable with mean 
## that is less than 700
has_low_mean = function(x){
  is.numeric(x) && (mean(x, na.rm = TRUE) < 700)
}
# Use select_if to see what variables meet this criteria
select_if(blp_df, has_low_mean)
# We do not have to name a function if we only use it as a one-off manner
## We call these anonymous functions and just put it inside select_if
select_if(blp_df,function(x){
  is.numeric(x) && (mean(x, na.rm = TRUE) < 700)
})

# Load tidyverse
library(tidyverse)
# Use syntactic shortcut that is part ofpurrr package which loads in with tidyverse
select_if(blp_df, ~is.numeric(.) && (mean(., na.rm = T) < 700))

# Renaming variables with select() and rename()
select(blp_df, subject = participant, reaction_time = rt)
# subject and reaction_time are new variable names. participant and rt are old ones
blp_df
# Does not reflect new variable names. We created new one in line 76

rename(blp_df, subject = participant, reaction_time = rt)
# this reflects new names. Need to assign it if we want to call to new df

# Useful variants of rename are rename_all, rename_at, rename_if
# rename_all allows us to rename all variables using some renaming fuction, that 
## is a function that takes a string as input and returns another as outpur
# Here is a purrr-style anonymous function using replace_all from stringr package
rename_all(blp_df, ~str_replace_all(., '\\.', '_'))
# Uses regular expressions for text pattern matching
## In regex, a . character means any character, we then use \\. to refer to a literal dot

# rename_at functions allws us to select certain variables then apply a renaming function
## just to those selected variables
rename_at(blp_df,
          vars(matches('^rt|rt$')),
          ~str_replace_all(., 'rt', 'reaction_time'))
# Selected all variables whose names contain rt at their start or end and then replace their 
## occurrences of rt with reaction_time

# Use rename_if() to rename variables whose values match certain criteria. Let's
## capitalize variables that are character variables
rename_if(blp_df, is.character, str_to_upper)
# str_to_upper comes from stringr which loads with tidyverse

# Selecting observations with slice and filter
# Allows us to slect or remove observations instead of variables (columns)
slice(blp_df, c(10, 20, 50, 100, 500))
# This selects 10th, 20th, 50th, 100th and 500th row and displays them

slice(blp_df, 10:100)
# Shows observations from row 10 to row 100

# We can also use minus sign to drop the corresponding observations
slice(blp_df, -(1:10))
# This drops observations from row 1 to row 10

# Useful dplyr function that can be used in slice and elsewhere is n()
## n() gives number of observations in data frame
# List observations from index 600 to the end 
slice(blp_df, 600:n())

# List last 11 rows
slice(blp_df, (n() - 10): n())
# Filter observations means to filter them in, rather than filter them out

# Select observaionts where lex variable is N
filter(blp_df, lex == 'N')

# Filter by multiple conditions
filter(blp_df, lex == 'N', resp == 'W')
filter(blp_df, lex == 'N', resp == 'W', rt.raw <= 500)

# Could also make a conjuntion using $
filter(blp_df, lex == 'N' & resp == 'W' & rt.raw <= 500)

# Use or | operator
filter(blp_df, rt.raw < 500 | rt.raw > 1000)

# Filter by observations whose values of certain variables are in a set
## we can use %in% operator
filter(blp_df, rt.raw %in% 500:510)

# Create complex Boolean conditional using combo of logical AND &, logical OR |, 
## logical NOT !
filter(blp_df,
       lex == 'W',
       str_length(spell) < 5 & (resp != lex | rt.raw > 900))

# Filter command has vairants filter_all, filter_at and filter_if
filter_all(blp_df, any_vars(is.na(.)))
# . signifies the variables that are selction, which becausae of filter_all would be
## all variables

# To apply filtering rules to a selected set of variables we can use filter_at
filter_at(blp_df, vars(matches('^rt|rt$')), all_vars(. > 500))
# This filters all observaitons where the values of all variables that start or end 
## with rt are greater than 500

# Following filters all observations where all variables that start or end with rt 
## have values that are less than the median values of those values
filter_at(blp_df, 
          vars(matches('^rt|rt$')),
          all_vars(. < median(., na.rm = TRUE)))

# filter_if variant, like select_if of rename_if, allows us to select variables
## according to their properties, rather than their names, then applying filtering commands
### to selected variables
filter_if(blp_df,
          is.numeric,
          all_vars(. < median(., na.rm = TRUE)))
# This code selected numeric variables in data frame then filtered the observations
## where all values of selected variables are less than median value of those variables

# Mutate command allows us to create new variables and alter values of existing ones
# Create new variable acc that takes the value TRUE whenever lex and resp have same values
mutate(blp_df, acc = lex == resp)
# added new column(variable) to data frame

# Create new variable that gives the length of the word given by spell variable
mutate(blp_df, len = str_length(spell))

# Can create multiple variables at once
mutate(blp_df, 
       acc = lex == resp,
       len = str_length(spell))

# Mutate has mutate_all, mutate_at, and mutate_if
# mutate_all will apply transformation function to all variables in data frame, then
## replace all original values of all variables with results of function
mutate_all(blp_df, as.character)
# Converted any vector into a character vector

# mutate_at allows us to apply a function to selected variables. 
# Apply log transform to all rt variables:
mutate_at(blp_df, vars(matches('^rt|rt$')), log)

# mutate_if selects variables by their properties then applies a function to selected
## variables
mutate_if(blp_df, is.character, as.factor)
# Selected all variables that are character vectors and convert them to a factor, 
## which is a categorical variable vector with a defined set of 'levels'

# Recoding: we have number of options to use with mutate and variants for recoding
## Simplest option is if_else, which evaluates a condition for each value of a variable
### If result is true, it returns one value, otherwise it returns another
mutate(blp_df, speed = if_else(rt.raw < 750,
                               'slow',
                               'fast')
)
# this created new variable speed that takes the value fast if rt.raw is less than 750
## and takes value slow otherwise

# recode is widelyused recoding method. 
mutate(blp_df, 
       lex = recode(lex, 'W' = 'word', 'N' = 'nonword'))
# This replaces lex variable values W and N with word and nonword respectively

# If variables are coded identically, we can apply same recoding rule to both
## using mutate_at
mutate_at(blp_df,
          vars(lex, resp),
          ~recode(., 'W' = 'word', 'N' = 'nonword'))
# Stopped at page 76. Going to look at homework now







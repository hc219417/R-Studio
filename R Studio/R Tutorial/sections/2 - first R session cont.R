#using character values

character_object1 <- 'this is a character value'
character_object2 <- "this is also a character value"
character_object1
character_object2
this is a character value #error (absence of quotation marks)
character_object1 + 1 #error (numerical computations cannot be done with character values)

#creating vectors

c(1, 3, 2, 5, 3) #c is short for concatenate (or combine apparently)
coffee <- c(1, 3, 2, 5, 3)
coffee
caffeine <- coffee * 112.5
caffeine
gender <- c('male', 'male', 'female', 'female', 'female')
gender

#using basic R functions

# sqrt() - calculates the square root of a (set of) numeric value(s)
# log() - calculates the natural logarithm of a (set of) numeric value(s)
# round() - rounds a (set of) numerical value(s) by default to the nearest integer (whole number)
# sum() - calculates the sum of a set of numerical values
# mean() - calculates the mean of a set of numerical values
# hist() - draws a histogram from a set of numerical values
# table() - creates a frequency table from a set of numeric or character values

sqrt(caffeine)
log(caffeine)
round(caffeine)
sum(caffeine)
mean(caffeine)
hist(caffeine)
table(gender)

#annotate your R script (use # to denote comments)
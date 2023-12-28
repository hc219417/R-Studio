#store data in objects
coffee <- c(1, 3, 2, 5, 3)
gender <- c('male', 'male', 'female', 'female', 'female')

#show content of 'coffee' and 'gender'
coffee
gender

#calculate caffeine
caffeine <- coffee * 112.5

#show content of 'caffeine'
caffeine

#run various functions
sqrt(caffeine)  # the square root
log(caffeine)   # the natural logarithm
round(caffeine) # round to nearest integer
sum(caffeine)   # the sum
mean(caffeine)  # the mean
hist(caffeine)  # draw a histogram
table(gender)   # counts of males and females

#all text placed on the right of this sign is
#ignored by R (not used for making computations)
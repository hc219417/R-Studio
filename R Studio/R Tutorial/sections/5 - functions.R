#changing the color of a histogram

obs1 <- c(4, 10, 23, 13, 16, 20, 21, 14, 8, 9, 9) #store a set of numeric values as 'obs1'
hist(x = obs1, col = 'red') #red histogram of obs1

#hist(x = obs1, col = 'cornflowerblue') #'cornflowerblue' histogram of obs1

#round the elements of a vector to nearest decimal or integer

obs2 <- c(1.332430, 5.668487, 2.333425) #store a set of numerical values as 'obs2'
obs2int <- round(x = obs2) #round the values of obs2 to the nearest integer
obs2int

obs2dec <- round(x = obs2, digits = 3) #round the values of obs2 to nearest three digits
obs2dec

mean(x = obs2) #the mean of the original obs2 vector
mean(x = obs2int) #the mean of the obs2 after rounding to nearest integer

round(x = mean(obs2), digits = 2) #mean of obs2 rounded to the nearest two digits

#example: analysis of epileptic seizures data

num.seiz <- c(0, 1, 2, 3, 4, 5, 6, 8, 10, 11, 18, 19, 22, 102) #store the number of seizures 'num.seiz'
num.pat <- c(3, 4, 5, 3, 3, 2, 2, 2, 1, 2, 1, 1, 1, 1) #store the number of observations (i.e. patients)

?weighted.mean #see the manual of weighted.mean

weighted.mean(x = num.seiz, w = num.pat) #determine the weighted average

#searching for R functions

#see also
#help.start()
#Rseek.org - an R search engine
#online cheat sheets
#a simple Google search

obs3 <- c(1.1, 2, 1.4, 1.9, 2.5, 3.7, 4.2) #store a set of numeric values as 'obs3'
IQR(obs3) #determine the interquartile range

#there is no such thing as "the correct R function"
#there are many functions with overlapping functionality
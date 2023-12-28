#basic statistics in R

mpg = ggplot2::mpg #import the miles per gallon data set
View(mpg) #first thing you should do is look at the data
?mpg #fuel economy data from 1999 to 2008 for 38 popular models of cars

#numeric variables

#center

mean(mpg$cty)   #average
median(mpg$cty) #middle

#spread

var(mpg$cty)   #variance
sd(mpg$cty)    #standard deviation
range(mpg$cty) #min and max
IQR(mpg$cty)   #interquartile range

#summary

summary(mpg$cty)

#robust

mpg$cty[1] = 500 #median is a robust statistic (not affected by massive outliers)

#categorical variables

table(mpg$drv)             #frequency table (drivetrain)
table(mpg$drv) / nrow(mpg) #proportions
table(mpg$class)           #frequency table (type of car)
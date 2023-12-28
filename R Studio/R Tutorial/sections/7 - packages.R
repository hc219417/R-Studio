weight <- c(80, 40, 50, 80, 90, 60, 75, 85, 66, 105) #kg
length <- c(1.75, 1.6, 1.55, 1.68, 1.8, 1.9, 1.75, 1.85, 1.66, 1.8) #m

BMI <- weight / (length ^ 2)

install.packages('rgl') #install package rgl, replace rgl with a package of your choice to install that package
library(rgl) #load package rgl from the system library, replace rgl with a package of your choice to load that package

?plot3d
plot3d(x = weight, y = length, z = BMI, col = 'red')
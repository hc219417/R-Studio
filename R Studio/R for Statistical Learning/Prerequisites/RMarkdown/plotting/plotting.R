mpg = ggplot2::mpg

#histograms (numeric)

hist(mpg$cty)
mean(mpg$cty)
sd(mpg$cty)

hist(mpg$cty, #additional arguments
     xlab = "Miles Per Gallon (City)",
     main = "Histogram of MPG (City)",
     breaks = 12,
     col = "darkorange",
     border = "dodgerblue")

#bar plots (categorical)

barplot(table(mpg$drv))

barplot(table(mpg$drv),
        xlab = "Drivetrain (f = FWD, r = RWD, 4 = 4WD)",
        main = "Drivetrains",
        col = "dodgerblue",
        border = "darkorange")

#box plots (numeric vs categorical)

boxplot(hwy ~ drv, data = mpg) #formula (y ~ x)

boxplot(hwy ~ drv, data = mpg,
        xlab = "Drivetrain (f = FWD, r = RWD, 4 = 4WD)",
        ylab = "Miles Per Gallon (Highway)",
        main = "MPG (Highway) vs Drivetrain",
        pch = 20, #plot character
        cex = 2,
        col = "darkorange",
        border = "dodgerblue")

#scatter plots (numeric vs numeric)

plot(hwy ~ displ, data = mpg)

plot(hwy ~ displ, data = mpg,
     xlab = "Engine Displacement (in Liters)",
     ylab = "Miles Per Gallon (Highway)",
     main = "MPG (Highway) vs Engine Displacement",
     pch = 20,
     cex = 2,
     col = "dodgerblue")

#plotting systems

library(lattice)
xyplot(hwy ~ displ, data = mpg)

library(ggplot2) #becoming increasingly popular
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point()
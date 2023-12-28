#constructing a data frame from two vectors

height <- c(184.0, 174.2, 166.6, 193.2, 173.8, 166.4, 175.4, 183.3, 159.4, 171.8, 179.2, 165.8, 170.4, 178.1, 171.4, 159.7) #cm
sex <- c('m', 'm', 'm', 'm', 'm', 'm', 'm', 'm', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f') #male or female (duh)

dat <- data.frame(height, sex)
dat #order of the data points is important!

#avoid confusion: keep your workspace clean

rm(sex)
rm(height)

#remove the objects height and sex from the global environment

height #error: object 'height' not found

#don't fret! the information that was stored in height and sex is still available in dat

dat$height
dat$sex

#we can access (and apply functions to) that information using the $ sign

mean(dat$height)
table(dat$sex)

#general construction of a data frame

dat <- data.frame(
  height = c(184.0, 174.2, 166.6, 193.2, 173.8, 166.4, 175.4, 183.3, 159.4, 171.8, 179.2, 165.8, 170.4, 178.1, 171.4, 159.7), 
  sex = c('m', 'm', 'm', 'm', 'm', 'm', 'm', 'm', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f')
)

dat$smoking_status <- c(0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 1, 0, 1, 0)
dat

#creating data sets in R: a good idea? no
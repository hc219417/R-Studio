#exercise 1

#suppose we have measurements of the heights for 8 individuals (in cm)
#perform a simple descriptive analysis:

# 1. store the data as a numeric vector

height <- c(184.0, 174.2, 166.6, 193.2, 173.8, 166.4, 175.4, 183.3)

# 2. calculate the mean and median height

mean(height)
median(height)

# 3. describe the variability in the data by the standard deviation

sd(height)

# 4. visualize the data using a histogram

hist(height)

#write a script to perform these steps
#annotate the script in such a way that someone else who is not familiar with R
#will be able to understand the steps you have taken the perform this analysis
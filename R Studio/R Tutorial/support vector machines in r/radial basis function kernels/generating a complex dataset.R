#generating a complex dataset

#number of data points
n <- 1000

#set seed
set.seed(1)

#create dataframe
df <- data.frame(x1 = rnorm(n, mean = -0.5, sd = 1), x2 = runif(n, min = -1, max = 1))

#set radius and centers 
radius <- 0.8
center_1 <- c(-0.8, 0)
center_2 <- c(0.8, 0)
radius_squared <- radius ^ 2

#create binary classification variable 
df$y <- factor(ifelse((df$x1-center_1[1]) ^ 2 + (df$x2-center_1[2]) ^ 2 < radius_squared |
                      (df$x1-center_2[1]) ^ 2 + (df$x2-center_2[2]) ^ 2 < radius_squared, -1, 1), levels = c(-1, 1))
#load ggplot
library(ggplot2)

#plot x2 vs x1, colored by y
scatter_plot <- ggplot(data = df, aes(x = x1, y = x2 , color = y)) + 
  #add a point layer
  geom_point() + scale_color_manual(values = c("red", "blue")) +
  #specify equal coordinates
  coord_equal()

scatter_plot
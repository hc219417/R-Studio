#sugar content of soft drinks

#load ggplot2
library(ggplot2)

library(tidyverse)

df = data.frame(sugar_content = c(10.9, 10.9, 10.6, 10, 8, 8.2, 8.6, 10.9,
                                  10.7, 8, 7.7, 7.8, 8.4, 11.5, 11.2, 8.9,
                                  8.7, 7.4, 10.9,10, 11.4, 10.8, 8.5, 8.2, 10.6)) %>% mutate(sample = row_number())
#print variable names
colnames(df)

#plot sugar content along the x-axis
plot_df <- ggplot(data = df, aes(x = sugar_content, y = 0)) + 
geom_point() + geom_text(aes(label = sugar_content), size = 2.5, vjust = 2, hjust = 0.5)

#display plot
plot_df

#the maximal margin separator is at the midpoint of the two extreme points in each cluster
mm_separator <- (8.9 + 10) / 2

#create data frame containing the maximum margin separator
separator <- data.frame(sep = mm_separator)

plot = plot_df

#add separator to sugar content scatterplot
plot_sep <- plot + geom_point(data = separator, aes(x = mm_separator, y = 0), color = "blue", size = 4)

#display plot
plot_sep
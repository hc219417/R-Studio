#importing data (see import dataset)

#importing external data

library(readr)
ex_from_csv = read.csv("example-data.csv")

ex_from_csv$y  #tibble (keeps character information as characters)
example_data$y #data frame (coerces characters to be factors)

read_csv("example-data.csv") #faster, tibble (newer)
read.csv("example-data.csv") #slower, data.frame
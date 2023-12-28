#data frames

#create (list of vectors)

example_data = data.frame(
  x = c(1, 3, 5, 7, 9, 1, 3, 5, 7, 9),
  y = c(rep("hello", 9), "goodbye"),
  z = rep(c(TRUE, FALSE), 5)
)

example_data #rows (observations)
             #columns (variables)
list(
  x = c(1, 3, 5, 7, 9, 1, 3, 5, 7, 9),
  y = c(rep("hello", 9), "goodbye"),
  z = rep(c(TRUE, FALSE), 5)
)

example_data$x #extract a particular vector (using the $ operator)

all.equal(length(example_data$x),
          length(example_data$y),
          length(example_data$z)
) #vectors of the same length (requirement)

str(example_data) #structure (10 obs. of 3 variables) also factor variable??

nrow(example_data) #number of rows
ncol(example_data) #number of columns
dim(example_data)  #dimension
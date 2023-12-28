#vectors

#data types

  42.5 #numeric, double
  is.numeric(42.5)
  is.double(42.5)
  
  TRUE #logical
  is.logical(TRUE)
  
  "statistics" #character
  is.character("statistics")

#vectors (one-dimensional homogeneous data structure)

2
c(1, 3, 5, 7, 8, 9) #c stands for combine
x = c(1, 3, 5, 7, 8, 9)
(y = 1:100) #vector of 1 to 100
2 #actually a vector

c(42, "statistics", TRUE) #all end up becoming characters
c(42, TRUE) #all become numeric

z = c(TRUE, TRUE, FALSE, TRUE, TRUE, FALSE)
z

seq(from = 1.5, to = 4.2, by = 0.1) #sequence function
seq(1, 9, 2)

rep("A", times = 10) #repetition function
rep(x, 3) #repeat the vector x three times

#subsetting*

x[1] #extract the first element of x
x[3] #similarly, extract the third element
x[-2] #extract everything EXCEPT the second element
x[1:3] #extract the first through third elements of x
x[c(1, 3, 4)] #extract the first third and fourth elements
x[z] #first second NOT the third fourth fifth NOT the sixth

#all together (mix and match)

c(1:10, rep(42, times = 10))[seq(2, 20, by = 2)]

# *R is indexed starting at 1, NOT at 0... just keep that in mind
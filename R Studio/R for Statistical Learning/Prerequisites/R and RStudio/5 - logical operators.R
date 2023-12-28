#logical operators

x = c(1, 3, 5, 7, 8, 9)

x > 3 #greater than
x < 3 #less than
x == 3 #equal to
x != 3 #NOT equal

x == 3 & x != 3 #AND operator
x == 3 | x != 3 #OR operator

x[x > 3] #display only the values of x that are greater than 3
x[x != 3] #display the values of x not equal to 3

sum(x > 3) #count how many elements are greater than 3
as.numeric(x > 3) #0 0 1 1 1 1

which(x > 3) #extract the indices where something is true
x[which(x > 3)] #redundant (same as x[x > 3])

max(x) #maximum
which(x == max(x)) #where is the max element?
which.max(x) #same as above, just less awkward

#there exist similar functions for min
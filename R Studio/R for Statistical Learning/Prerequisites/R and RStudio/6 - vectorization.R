#vectorization

x = c(1, 3, 5, 7, 8, 9)
y = 1:100

#the following operations apply to EACH element of x

x + 2
log(x)
sqrt(x)
x ^ 2

#vectorized operations

x + 2 #repeat shorter vector until same length as longer vector
x + rep(2, 6) #element by element wise comparison

x > 3 #same goes for logical comparison
x > rep(3, 6) #compare x to a vector of 3 repeated 6 times (3 3 3 3 3 3)

x + y #warning: x does not divide into y evenly*

length(x)
length(y)

length(y) / length(x) #16 (and then some)
(x + y) - y #what is truly being added to y (repeat of x minus 2)

y = 1:60 #changing the length of y...
x + y #happens now, no problem
length(y) / length(x) #exactly 10

rep(x, 10) + y #same as x + y

all(x + y == rep(x, 10) + y) #verify all
identical(x + y, rep(x, 10) + y) #shortcut

?any #instead of are ALL the values true, are ANY of the values true?
?all.equal #allows for a tiny bit of machine error due to numeric computation issues

# *computation still happens (no error)
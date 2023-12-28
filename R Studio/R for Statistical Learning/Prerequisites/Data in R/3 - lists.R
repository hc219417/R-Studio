#lists

list(42, "hello", TRUE) #one dimensional (can contain different data types)
                        #double brackets indicate element number of the list
ex_list = list(
  a = c(1, 2, 3, 4),                              #vector (numbers)
  b = TRUE,                                       #vector (logic)
  c = "Hello!",                                   #vector (character)
  d = function(arg = 42) {print("Hello World!")}, #function
  e = diag(5)                                     #matrix
)

ex_list #note the named elements

#subsetting

ex_list$e #extract a named element (in this case our matrix e)

ex_list[1:2]         #extract a and b
ex_list[1]           #does NOT extract the first element -> returns a list
ex_list[[1]]         #use double brackets to obtain the actual list element
ex_list[c("e", "a")] #provide a list of names rather than vector of indices
ex_list["e"]         #creating a list with the element e (identity matrix)
ex_list[["e"]]       #return what's stored in e (double bracket notation)

ex_list$d          #return the function
ex_list$d(arg = 1) #add parentheses to make a function call (given an arg)
#programming basics

#if, else

x = 1
y = 3

if (x > y) {
  z = x * y
  print ("x is larger than y")
} else {
  z = x + 5 * y
  print ("x is less than or equal to y")
}

#ifelse

ifelse(4 > 3, 1, 0) #(condition, if true return this value, else return this)

fib = c(1, 1, 2, 3, 5, 8, 13, 21) #fibonacci sequence
ifelse(fib > 6, "Foo", "Bar") #bar bar bar bar bar foo foo foo

#for loops

x = 11:15
for (i in 1:5) {
  x[i] = x[i] * 2
}
x #inefficient

x = 11:15
x = x * 2
x #much better

#functions

#using

seq(from = 1.5, to = 4.2, by = 0.1) #three arguments
seq(1.5, 4.2, 0.1) #unnamed arguments
seq() #default arguments
?seq

#writing

silly_fun = function(arg1, arg2, arg3 = 42) {
  a = arg1 + arg2 - 3
  b = a * arg3
  c(a, b, a + b, 0) #return last line
} #run before using

silly_fun(arg1 = 2, arg2 = 3, arg3 = 4)
silly_fun(arg1 = 1, arg2 = 2) #arg3 = 42 by default
silly_fun(arg1 = 1, arg2 = 1, arg3 = 42)
silly_fun(10, 2, 3) #unnamed arguments (in order of specification)

#style (spaces after commas and in between binary operators)

seq(from = 1.5, tp = 4.2, by = 0.1) #perfection
seq(from=1.5,to=4.2,by=0.1) #absolutely not

silly_fun=function(arg1,arg2,arg3=42){ #nope
a=arg1+arg2-3
b=a*arg3
c(a,b,a+b,0)} #code -> reformat code (ctrl + shift + A)
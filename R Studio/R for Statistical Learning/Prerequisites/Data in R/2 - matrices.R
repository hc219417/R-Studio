#matrices

x = 1:9 #R is case sensitive
x #one dimensional & homogeneous

X = matrix(x, nrow = 3, ncol = 3)
X #still homogeneous, but now two dimensional!

Y = matrix(x, nrow = 3, ncol = 3, byrow = TRUE)
Y #transpose of X

Z = matrix(0, 2, 4)
Z #matrix of all 0

X             #original matrix
X[1,2]        #[row,column]
X[1, ]        #first row
X[ ,2]        #second column
X[2,c(1,3)]   #first and third column of the second row

cbind(col1 = x, col2 = rev(x), col3 = rep(1, 9)) #column bind (rbind for row)
                                                 #remember to name the columns
X + Y
X - Y
X * Y #NOT matrix multiplication
X / Y #element by element wise operation

X %*% Y #matrix multiplication syntax

Z = matrix(c(9, 2, -3, 2, 4, -2, -3, -2, 16), 3, byrow = TRUE)
Z

solve(Z) #inverse of Z
solve(Z) %*% Z
diag(3) #identity matrix
all.equal(solve(Z) %*% Z, diag(3)) #TRUE

solve(X) #singular (determinant is 0) -> does NOT have an inverse

X
dim(X)      #dimension
nrow(X)     #number of rows
ncol(X)     #number of columns
rowSums(X)  #sum the rows
colMeans(X) #means of each column
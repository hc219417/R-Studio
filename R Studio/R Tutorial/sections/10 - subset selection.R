#subsetting a vector by position number

height <- c(184.0, 174.2, 166.6, 193.2, 173.8, 166.4, 175.4, 183.3, 159.4, 171.8, 179.2, 165.8, 170.4, 178.1, 171.4, 159.7)
sex <- c('m', 'm', 'm', 'm', 'm', 'm', 'm', 'm', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f')

height[1] # display first element in object height

firstheight <- height[1]
firstheight

ind <- c(2, 10)
height[ind]

#or, equivalently: height[c(2, 10)]

#subsetting a vector by logical statement

over170 <- height > 170
over170

heightover170 <- height[over170]
heightover170

#or, equivalently:

#heightover170 <- height[height > 170]
#heightover170

#more logical statements

#the > command is called a ‘logical operator’
#R also recognizes the following logical operators:

  # < (less than)
  # <= (less than or equal to)
  # >= (greater than or equal to)
  # != (not equal to)
  # == (equal to)

height[sex == 'm'] # display height for males

#alternatively, you may use: height[sex != 'f']
#changing the condition to ‘sex is not female’

height[sex == 'f' & height > 170] # display height for females AND height higher than 170

#the & (‘AND’) operator combines both logical statements,
#thereby requiring that both statements are satisfied

#if only one of the two statements need to be satisfied,
#one may use the operator | (‘OR’)

height[sex == 'f' | height > 170] # display height for females OR height higher than 170

#subsetting data frames

df <- read.table(file = "aneurysm.txt", header = TRUE)
df$AGE10 #use the $ operator to select a column of a data frame

df$AGE10[c(1, 2, 3)] #select the first three values
df$AGE10[df$AGE10 >= 6] #select all values greater than or equal to 6

df[5, 2] #extract the fifth value from the second column ([row, column])

df[c(1, 2, 3), 2] #extract the first three values of the second column

#leave the position indicator empty, but DO NOT FORGET THE COMMA

df[c(237, 238),] #select only the rows 237 and 238

df[, c(1, 4)] #select only columns 1 and 4

#split the complete data frame according to a certain subgroup

df.m <- df[df$SEX == 'Male',]
df.f <- df[df$SEX == 'Female',]

#check to be sure that df.m contains only data of males and df.f only of females (yep!)
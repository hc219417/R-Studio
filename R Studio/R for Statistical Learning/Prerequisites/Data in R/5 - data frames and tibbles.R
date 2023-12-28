#data frames and tibbles

#load from package

Galton = mosaicData::Galton #store to global environment
Galton                      #print to console (restrict)

View(Galton) #opens up a data viewer (click the name in the environment tab)
head(Galton, n = 10) #first ten observations
str(Galton) #structure (factor variable -> how R treats categorical variables)

Galton$sex         #data frames will by default
levels(Galton$sex) #make character values factors

#subsetting

#like matrix

Galton[7,3]   #vector
Galton[ ,2]   #vector
names(Galton) #vector
Galton[1, ]   #data frame?

#like list

Galton[5]   #data frame
Galton[1:2] #data frame


Galton$father      #vector
Galton[2]          #data frame
Galton["father"]   #data frame
Galton[["father"]] #vector

#more complex

Galton[Galton$sex == "F", ]$height #female heights
head(subset(Galton, subset = height > 70), n = 10) #first 10 rows, height > 70

#data.frame vs tibble... what is returned?

library(tibble) #tibble -> prints in a sane fashion, subsets slightly different
Galton = as_tibble(Galton)
Galton #automatically prints only the first few observations w/ some extra info

Galton["height"] #tibble
Galton$height    #vector
Galton[, 5]      #tibble
Galton[1,5]      #tibble

Galton = as.data.frame(Galton)

Galton["height"] #data frame
Galton$height    #vector
Galton[, 5]      #vector
Galton[1,5]      #vector

#attach() DO NOT USE!!

height = c(70, 65)
attach(Galton)

father > height #comparing father from Galton data to height defined above
father > Galton$height #what we're ACTUALLY trying to do (both from Galton)
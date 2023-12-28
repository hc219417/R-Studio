## 1: Import the data, and store it an object (named 'd')
d <- read.csv(file = "C:/anorexia.csv") ## Note: adjust the file location if necessary.

## 2: Check first three rows
d[c(1,2,3),]

## 3: Change w_pre and w_post from lbs to kilograms, store as new variables
d$w_pre_kg <- d$w_pre / 2.205
d$w_post_kg <- d$w_post / 2.205

## 4: Calculate weight change, and store it as a new variable in 'd'
d$w_change <- d$w_post_kg - d$w_pre_kg

## 5: Make a box plot of the change scores, for each treatment
boxplot(d$w_change[d$treat == 0]) ## For control treatment
boxplot(d$w_change[d$treat == 1]) ## For cognitive behavioural treatment
boxplot(d$w_change[d$treat == 2]) ## For family treatment

## 6: Calculate the average weight change for each of the treatments
mean(d$w_change[d$treat == 0]) ## For control treatment     
mean(d$w_change[d$treat == 1]) ## For cognitive behavioural treatment
mean(d$w_change[d$treat == 2]) ## For family treatment

## 7: Add categorized change score
d$w_change_cat <- d$w_change                                    ## First copy the change score variable
d$w_change_cat[d$w_change <= -1] <- 'Decrease'                  ## Set to 'Decrease' if change is lower than or equal to -1
d$w_change_cat[d$w_change >= 1] <- 'Increase'                   ## Set to 'Increase' if change is at least 1
d$w_change_cat[d$w_change > -1 & d$w_change < 1] <- 'No change' ## Set to 'no change' if change > -1 and < 1

## 8: Make frequency tables
table(d$w_change_cat[d$treat == 0]) ## For control treatment 
table(d$w_change_cat[d$treat == 1]) ## For cognitive behavioural treatment
table(d$w_change_cat[d$treat == 2]) ## For family treatment

## 9: Display as proportions
table(d$w_change_cat[d$treat == 0]) / length(d$w_change_cat[d$treat == 0]) ## For control treatment 
table(d$w_change_cat[d$treat == 1]) / length(d$w_change_cat[d$treat == 1]) ## For cognitive behavioural treatment
table(d$w_change_cat[d$treat == 2]) / length(d$w_change_cat[d$treat == 2]) ## For family treatment

## 10: Conclusion
## Based on the average change scores (step 6) and the proportions from step 9, 
## it appears that the family treatment is superior to the cognitive behavioural treatment,
## which in turn is superior to the control treatment.
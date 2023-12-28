#modeling basics in R

library(readr)
Advertising = read_csv("data/Advertising.csv")

Advertising #inspect the data (a tibble)

#predictor variables (tv, radio, newspaper) vs response variable (sales)

#visualization for regression

plot(Sales ~ TV, data = Advertising, #scatter plot (only numeric variables)
     col = "dodgerblue",
     pch = 20,
     cex = 1.5,
     main = "Sales vs Television Advertising")

pairs(Advertising) #useful way to quickly visualize a number of scatter plots

library(caret) #only interested in relationship between each predictor and response
featurePlot(x = Advertising[ , c("TV", "Radio", "Newspaper")], y = Advertising$Sales)

#the lm() function

mod_1 = lm(Sales ~ ., data = Advertising) #full additive linear model
#mod_1 = lm(Sales ~ TV + Radio + Newspaper, data = Advertising)

#hypothesis training

summary(mod_1)

mod_0 = lm(Sales ~ TV + Radio, data = Advertising) #reduced model (-newspaper)

anova(mod_0, mod_1) #the anova() function is useful for comparing two models
                    #essentially testing for significance of newspaper variable
#prediction

head(predict(mod_1), n = 10) #use ?predict.lm() for details

new_obs = data.frame(TV = 150, Radio = 40, Newspaper = 1) #specify new data

#use predict() for point estimates, confidence intervals, and prediction intervals

predict(mod_1, newdata = new_obs) #return a point estimate ("predicted value")

predict(mod_1, newdata = new_obs, interval = "confidence") #95% confidence interval

predict(mod_1, newdata = new_obs, interval = "prediction", level = 0.99) #prediction interval

#unusual observations

#R provides several functions for obtaining metrics related to unusual observations:

head(resid(mod_1), n = 10) #provides the residual for each observation
head(hatvalues(mod_1), n = 10) #gives the leverage of each observation
head(rstudent(mod_1), n = 10) #gives the studentized residual for each observation
head(cooks.distance(mod_1), n = 10) #calculates the influence of each observation

#adding complexity

  #interactions

  mod_2 = lm(Sales ~ . + TV:Newspaper, data = Advertising)
  coef(mod_2) #use the : operator to introduce a single interaction of interest
  
  mod_3 = lm(Sales ~ . ^ 2, data = Advertising)
  coef(mod_3) #the response ~ . ^ k syntax can be used to model all k-way interactions
  
  mod_4 = lm(Sales ~ TV * Radio * Newspaper, data = Advertising)
  coef(mod_4) #the * operator can be used to specify interactions of a certain order
  
  library(tibble)
  cat_pred = tibble(
    x1 = factor(c(rep("A", 10), rep("B", 10), rep("C", 10))),
    x2 = runif(n = 30),
    y  = rnorm(n = 30))
  cat_pred #categorical predictors are often recorded as factor variables in R
  
  #the following two models illustrate the effect of factor variables on linear models:
  
  cat_pred_mod_add = lm(y ~ x1 + x2, data = cat_pred)
  coef(cat_pred_mod_add)
  
  cat_pred_mod_int = lm(y ~ x1 * x2, data = cat_pred)
  coef(cat_pred_mod_int)
  
  #polynomials
  
  #polynomial terms can be specified using the inhibit function I() or the poly() function
  
  mod_5 = lm(Sales ~ TV + I(TV ^ 2), data = Advertising)
  coef(mod_5)
  
  mod_6 = lm(Sales ~ poly(TV, degree = 2), data = Advertising)
  coef(mod_6)
  
  all.equal(resid(mod_5), resid(mod_6)) #different coefficients, but same residuals!
  
  mod_7 = lm(Sales ~ . ^ 2 + poly(TV, degree = 3), data = Advertising)
  #mod_7 = lm(Sales ~ . ^ 2 + I(TV ^ 2) + I(TV ^ 3), data = Advertising)
  coef(mod_7) #consider using the commented line instead (for reasons...)

  #transformations
  
  mod_8 = lm(log(Sales) ~ ., data = Advertising)
  sqrt(mean(resid(mod_8) ^ 2)) #incorrect RMSE for Model 8
  
  sqrt(mean(resid(mod_7) ^ 2)) #RMSE for Model 7
  
  sqrt(mean(exp(resid(mod_8)) ^ 2)) #correct RMSE for Model 8
  
  #may need to un-transform to compare to non-transformed models

#rmarkdown
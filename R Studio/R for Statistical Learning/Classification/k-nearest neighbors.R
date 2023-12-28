#k-nearest neighbors

  #in this chapter we introduce our first non-parametric
  #classification method, k-nearest neighbors

  #so far, all of the methods for classification
  #that we have seen have been parametric

  #for example, logistic regression had the form

    #log[p(x) / (1 - p(x))] = Beta_0 + Beta_1 * x_1 + Beta_2 * x_2 + ... + Beta_p *x_p

  #in this case, the Beta_j are the parameters of the model,
  #which we learned (estimated) by training (fitting) the model

  #those estimates were then used to obtain
  #estimates of the probability p(x) = P(Y = 1|X = x),

    #p(x) = 1 / (1 + e ^ -(Beta_0 + Beta_1 * x_1 + Beta_2 * x_2 + ... + Beta_p *x_p))
    #     = sigma(Beta_0 + Beta_1 * x_1 + Beta_2 * x_2 + ... + Beta_p *x_p)

  #as we saw in regression, k-nearest neighbors has no such model parameters
  #instead, it has a tuning parameter, k

  #this is a parameter which determines how the model is trained,
  #instead of a parameter that is learned through training

  #note that tuning parameters are not used exclusively with non-parametric methods
  #later we will see examples of tuning parameters for parametric methods

  #often when discussing k-nearest neighbors for classification,
  #it is framed as a black-box method that directly returns classifications

  #we will instead frame it as a non-parametric model
  #for the probabilities p_g(x) = P(Y = g|X = x)

  #that is, a k-nearest neighbors model using k neighbors estimates this probability as

  #essentially, the probability of each class g is the
  #proportion of the k neighbors of x with that class, g

  #then, to create a classifier, as always, we simply
  #classify to the class with the highest estimated probability

    #C-hat_k(x) = argmax p-hat_kg(x)

  #this is the same as saying that we classify to the class
  #with the most observations in the k nearest neighbors

  #if more than one class is tied for the highest estimated probability,
  #simply assign a class at random to one of the classes tied for highest

  #in the binary case this becomes

    #C-hat_k(x) = 1 if p-hat_k0(x) > 0.5
    #C-hat_k(x) = 0 if p-hat_k1(x) < 0.5

  #again, if the probability for class 0
  #and 1 are equal, simply assign at random

    #in the above example, when predicting at x = (x_1,x_2) = (8,6),

    #p-hat_5b(x_1 = 8,x_2 = 6) = P-hat(Y = blue|X_1 = 8, X_2 = 6) = 3/5
    #p-hat_5o(x_1 = 8,x_2 = 6) = P-hat(Y = orange|X_1 = 8, X_2 = 6) = 2/5

    #thus, C-hat_5(x_1 = 8,x_2 = 6) = blue

#binary data example

  #we first load some necessary libraries

    library(ISLR)
    library(class)

  #we’ll begin discussing k -nearest neighbors for classification
  #by returning to the Default data from the ISLR package

  #to perform k-nearest neighbors for classification,
  #we will use the knn() function from the class package

  #unlike many of our previous methods, such as logistic regression,
  #knn() requires that all predictors be numeric, so we coerce student
  #to be a 0 and 1 dummy variable instead of a factor

  #(we can, and should, leave the response as a factor)

  #numeric predictors are required because
  #of the distance calculations taking place

    set.seed(42)

    Default$student = as.numeric(Default$student) - 1

    default_idx = sample(nrow(Default), 5000)
    default_trn = Default[default_idx, ]
    default_tst = Default[-default_idx, ]

  #like we saw with knn.reg form the FNN package for regression,
  #knn() from class does not utilize the formula syntax, rather,
  #requires the predictors be their own data frame or matrix,
  #and the class labels be a separate factor variable

  #note that the y data should be a factor vector,
  #not a data frame containing a factor vector

  #note that the FNN package also contains a knn() function for classification
  #we choose knn() from class as it seems to be much more popular

  #however, you should be aware of which packages you
  #have loaded and thus which functions you are using
  #they are very similar, but have some differences

    #training data
    X_default_trn = default_trn[, -1]
    y_default_trn = default_trn$default
    
    #testing data
    X_default_tst = default_tst[, -1]
    y_default_tst = default_tst$default

  #again, there is very little “training” with k-nearest neighbors
  #essentially the only training is to simply remember the inputs

  #because of this, we say that k-nearest neighbors is fast at training time
  #however, at test time, k-nearest neighbors is very slow

  #for each test observation, the method must find the
  #k-nearest neighbors, which is not computationally cheap

  #note that by default, knn() uses Euclidean distance to determine neighbors

    head(knn(train = X_default_trn, 
             test  = X_default_tst, 
             cl    = y_default_trn, 
             k     = 3))

  #because of the lack of any need for training,
  #the knn() function immediately returns classifications

  #with logistic regression, we needed to use glm() to fit the model,
  #then predict() to obtain probabilities we would use to make a classifier

  #here, the knn() function directly returns classifications
  #that is, knn() is essentially C-hat_k(x)

  #here, knn() takes four arguments:

    #train, the predictors for the train set
    #test, the predictors for the test set
      #knn() will output results (classifications) for these cases
    #cl, the true class labels for the train set
    #k, the number of neighbors to consider

    calc_class_err = function(actual, predicted) {
      mean(actual != predicted)
    }

  #we’ll use our usual calc_class_err() function
  #to asses how well knn() works with this data

  #we use the test data to evaluate

    calc_class_err(actual    = y_default_tst,
                   predicted = knn(train = X_default_trn,
                                   test  = X_default_tst,
                                   cl    = y_default_trn,
                                   k     = 5))

  #often with knn() we need to consider the scale of the predictors variables

  #if one variable contains much larger numbers because of the units or range
  #of the variable, it will dominate other variables in the distance measurements

  #but this doesn’t necessarily mean that it should be such an important variable

  #it is common practice to scale the predictors to have a mean of zero and
  #unit variance -> be sure to apply the scaling to both the train and test data

    calc_class_err(actual    = y_default_tst,
                   predicted = knn(train = scale(X_default_trn), 
                                   test  = scale(X_default_tst), 
                                   cl    = y_default_trn, 
                                   k     = 5))

  #here we see the scaling slightly improves the classification accuracy

  #this may not always be the case, and often, it is normal
  #to attempt classification with and without scaling

  #how do we choose k? try different values and see which works best

    set.seed(42)
    k_to_try = 1:100
    
    err_k = rep(x = 0, times = length(k_to_try))
    
    for (i in seq_along(k_to_try)) {
      pred = knn(train = scale(X_default_trn), 
                 test  = scale(X_default_tst), 
                 cl    = y_default_trn, 
                 k     = k_to_try[i])
      err_k[i] = calc_class_err(y_default_tst, pred)
    }

  #the seq_along() function can be very useful for
  #looping over a vector that stores non-consecutive numbers

  #it often removes the need for an additional counter variable
  #we actually didn’t need it in the above knn() example, but it is still a good habit

  #for example maybe we didn’t want to try every value of k,
  #but only odd integers, which would prevent ties

  #or perhaps we’d only like to check multiples
  #of 5 to further cut down on computation time

  #also, note that we set a seed before running this loops

  #this is because we are considering even values of k,
  #thus, there are ties which are randomly broken

  #naturally, we plot the k-nearest neighbor results

    #plot error vs choice of k
    plot(err_k, type = "b", col = "dodgerblue", cex = 1, pch = 20, 
         xlab = "k, number of neighbors", ylab = "classification error",
         main = "(Test) Error Rate vs Neighbors")

    #add line for min error seen
    abline(h = min(err_k), col = "darkorange", lty = 3)

    #add line for minority prevalence in test set
    abline(h = mean(y_default_tst == "Yes"), col = "grey", lty = 2)

  #the dotted orange line represents the smallest
  #observed test classification error rate

    min(err_k)

  #we see that five different values of k are tied for the lowest error rate

    which(err_k == min(err_k))

  #given a choice of these five values of k, we select the largest,
  #as it is the least variable, and has the least chance of overfitting

    max(which(err_k == min(err_k)))

  #recall that defaulters are the minority class
  #that is, the majority of observations are non-defaulters

    table(y_default_tst)

  #notice that, as k increases, eventually the error
  #approaches the test prevalence of the minority class

    mean(y_default_tst == "Yes")

#categorical data

  #like LDA and QDA, KNN can be used for both binary and multi-class problems
  #as an example of a multi-class problems, we return to the iris data

    set.seed(430)
    iris_obs = nrow(iris)

    iris_idx = sample(iris_obs, size = trunc(0.50 * iris_obs))
    iris_trn = iris[iris_idx, ]
    iris_tst = iris[-iris_idx, ]

  #all the predictors here are numeric, so we proceed
  #to splitting the data into predictors and classes

    #training data
    X_iris_trn = iris_trn[, -5]
    y_iris_trn = iris_trn$Species
    
    #testing data
    X_iris_tst = iris_tst[, -5]
    y_iris_tst = iris_tst$Species

  #like previous methods, we can obtain predicted probabilities
  #given test predictors -> to do so, we add an argument, prob = TRUE

    iris_pred = knn(train = scale(X_iris_trn), 
                    test  = scale(X_iris_tst),
                    cl    = y_iris_trn,
                    k     = 10,
                    prob  = TRUE)

    head(iris_pred, n = 50)

  #unfortunately, this only returns the
  #predicted probability of the most common class

  #in the binary case, this would be sufficient to recover all
  #probabilities, however, for multi-class problems, we cannot
  #recover each of the probabilities of interest

  #this will simply be a minor annoyance for now, which we will
  #fix when we introduce the caret package for model training

    head(attributes(iris_pred)$prob, n = 50)

#external links

  #k-nearest neighbor classification algorithm (yt)

  #video from user "mathematical monk" which gives
  #a brief but thorough introduction to the method

#rmarkdown
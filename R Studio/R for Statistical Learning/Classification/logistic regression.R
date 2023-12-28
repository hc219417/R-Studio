#logistic regression

  #in this chapter, we continue our discussion of classification
  #we introduce our first model for classification, logistic regression
  #to begin, we return to the Default data set from the previous chapter

    library(ISLR)
    library(tibble)

    as_tibble(Default)

  #we also repeat the test-train split from the previous chapter

    set.seed(42)

    default_idx = sample(nrow(Default), 5000)
    default_trn = Default[default_idx, ]
    default_tst = Default[-default_idx, ]

#linear regression

  #before moving on to logistic regression,
  #why not plain, old, linear regression?

    default_trn_lm = default_trn
    default_tst_lm = default_tst

  #since linear regression expects a numeric response
  #variable, we coerce the response to be numeric

  #(notice that we also shift the results, as we require 0 and 1, not 1 and 2)

  #notice we have also copied the data set so that
  #we can return the original data with factors later

    default_trn_lm$default = as.numeric(default_trn_lm$default) - 1
    default_tst_lm$default = as.numeric(default_tst_lm$default) - 1

  #why would we think this should work?

  #recall that E-hat[Y|X = x] = X * Beta-hat

  #since Y is limited to values of 0 and 1, we have E[Y|X = x] = P(Y = 1|X = x)

  #it would then seem reasonable that X * Beta-hat
  #is a reasonable estimate of P(Y = 1|X = x)

  #we test this on the Default data

    model_lm = lm(default ~ balance, data = default_trn_lm)

  #everything seems to be working, until we plot the results:

    plot(default ~ balance, data = default_trn_lm, 
         col = "darkorange", pch = "|", ylim = c(-0.2, 1),
         main = "Using Linear Regression for Classification")

    abline(h = 0, lty = 3)
    abline(h = 1, lty = 3)
    abline(h = 0.5, lty = 2)

    abline(model_lm, lwd = 3, col = "dodgerblue")

  #two issues arise:

    #first, all of the predicted probabilities are below 0.5
    #that means we would classify every observation as a "No"
    #this is certainly possible, but not what we would expect

      all(predict(model_lm) < 0.5) #TRUE

    #the next, and bigger issue, is predicted probabilities less than 0

      any(predict(model_lm) < 0) #TRUE

#bayes classifier

  #why are we using a predicted probability of 0.5 as the cutoff for classification?

  #recall the bayes classifier, which minimizes the classification error:

    #C^B(x) = argmax P(Y = g|X = x)

  #so, in the binary classification problem, we will use predicted probabilities

    #p-hat(x) = P-hat(Y = 1|X = x) and P-hat(Y = 0|X = x)

  #and then classify to the larger of the two

  #we actually only need to consider a single probability, usually P-hat(Y = 1|X = x)

  #since we use it so often, we give it the shorthand notation, p-hat(x)

  #then the classifier is written,

    #C-hat(x) = 1 if p-hat(x) > 0.5
    #C-hat(x) = 0 if p-hat(x) <= 0.5

  #this classifier is essentially estimating the bayes classifier,
  #thus, is seeking to minimize classification errors

#logistic regression with glm()

  #to better estimate the probability p(x) = P(Y = 1|X = x), we turn to logistic regression

  #the model is written

    #log[p(x) / (1 - p(x))] = Beta_0 + Beta_1 * x_1 + Beta_2 * x_2 + ... + Beta_p *x_p

  #rearranging, we see the probabilities can be written as

    #p(x) = 1 / (1 + e ^ -(Beta_0 + Beta_1 * x_1 + Beta_2 * x_2 + ... + Beta_p *x_p))
    #     = sigma(Beta_0 + Beta_1 * x_1 + Beta_2 * x_2 + ... + Beta_p *x_p)

  #notice we use the sigmoid function as shorthand notation,
  #which appears often in deep learning literature

  #it takes any real input, and outputs a number between 0 and 1 (how useful!)

  #(this is actually a particular sigmoid function called the logistic
  #function, but since it is by far the most popular sigmoid function,
  #often sigmoid function is used to refer to the logistic function)

    #sigma(x) = (e ^ x) / (1 + e ^ x) = 1 / (1 + e ^ -x)

  #the model is fit by numerically maximizing the
  #likelihood, which we will let R take care of

  #we start with a single predictor example,
  #again using balance as our single predictor

    model_glm = glm(default ~ balance, data = default_trn, family = "binomial")

  #fitting this model looks very similar to fitting a
  #simple linear regression (instead of lm() we use glm())

  #the only other difference is the use of family = "binomial"
  #which indicates that we have a two-class categorical response

  #using glm() with family = "gaussian" would perform the usual linear regression

  #first, we can obtain the fitted coefficients the same way we did with linear regression

    coef(model_glm)

  #the next thing we should understand is how the predict()
  #function works with glm() -> so, let’s look at some predictions

    head(predict(model_glm))

  #by default, predict.glm() uses type = "link"

    head(predict(model_glm, type = "link"))

  #that is, R is returning

    #Beta-hat_0 + Beta-hat_1 * x_1 + Beta-hat_2 * x_2 + ... + Beta-hat_p *x_p

  #for each observation

  #importantly, these are NOT predicted probabilities

  #to obtain the predicted probabilities

    #p-hat(x) = P-hat(Y = 1|X = x)

  #we need to use type = "response"

    head(predict(model_glm, type = "response"))

  #note that these are probabilities, NOT classifications

  #to obtain classifications, we will need to compare
  #to the correct cutoff value with an ifelse() statement

    model_glm_pred = ifelse(predict(model_glm, type = "link") > 0, "Yes", "No")
    #model_glm_pred = ifelse(predict(model_glm, type = "response") > 0.5, "Yes", "No")

  #the line that is run is performing

    #C-hat(x) = 1 if f-hat(x) > 0
    #C-hat(x) = 0 if f-hat(x) <= 0

  #where

    #f-hat(x) = Beta-hat_0 + Beta-hat_1 * x_1 + Beta-hat_2 * x_2 + ... + Beta-hat_p *x_p

  #the commented line, which would give the same result, is performing

    #C-hat(x) = 1 if p-hat(x) > 0.5
    #C-hat(x) = 0 if p-hat(x) <= 0.5

  #where

    #p-hat(x) = P-hat(Y = 1|X = x)

  #once we have classifications, we can calculate
  #metrics such as the training classification error rate

    calc_class_err = function(actual, predicted) {
      mean(actual != predicted)
    }

    calc_class_err(actual = default_trn$default, predicted = model_glm_pred)

  #as we saw previously, the table() and confusionMatrix()
  #functions can be used to quickly obtain many more metrics

    train_tab = table(predicted = model_glm_pred, actual = default_trn$default)
    
    library(caret)
    
    train_con_mat = confusionMatrix(train_tab, positive = "Yes")
    
    c(train_con_mat$overall["Accuracy"], 
      train_con_mat$byClass["Sensitivity"], 
      train_con_mat$byClass["Specificity"])

  #we could also write a custom function for the
  #error for use with trained logist regression models

    get_logistic_error = function(mod, data, res = "y", pos = 1, neg = 0, cut = 0.5) {
      probs = predict(mod, newdata = data, type = "response")
      preds = ifelse(probs > cut, pos, neg)
      calc_class_err(actual = data[, res], predicted = preds)
    }

  #this function will be useful later when calculating
  #train and test errors for several models at the same time

    get_logistic_error(model_glm, data = default_trn, res = "default", pos = "Yes", neg = "No", cut = 0.5)

  #to see how much better logistic regression is for this
  #task, we create the same plot we used for linear regression

    plot(default ~ balance, data = default_trn_lm, 
         col = "darkorange", pch = "|", ylim = c(-0.2, 1),
         main = "Using Logistic Regression for Classification")
    
    abline(h = 0, lty = 3)
    abline(h = 1, lty = 3)
    abline(h = 0.5, lty = 2)

    curve(predict(model_glm, data.frame(balance = x), type = "response"), 
          add = TRUE, lwd = 3, col = "dodgerblue")

    abline(v = -coef(model_glm)[1] / coef(model_glm)[2], lwd = 2)

  #this plot contains a wealth of information:

    #the orange | characters are the data, (x_i,y_i)

    #the blue "curve" is the predicted probabilities given by the
    #fitted logistic regression (that is, p-hat(x) = P-hat(Y = 1|X = x))

    #the solid vertical black line represents the decision boundary, the balance
    #that obtains a predicted probability of 0.5 (in this case, balance = 1934.2247145)

  #the decision boundary is found by solving for points that satisfy

    #p-hat(x) = P-hat(Y = 1|X = x) = 0.5

  #this is equivalent to points that satisfy Beta-hat_0 + Beta-hat_1 * x_1 = 0

  #thus, for logistic regression with a single predictor,
  #the decision boundary is given by the point x_1 = -(Beta-hat_0) / Beta-hat_1

  #the following is not run, but an alternative
  #way to add the logistic curve to the plot

    grid = seq(0, max(default_trn$balance), by = 0.01)
    
    sigmoid = function(x) {
      1 / (1 + exp(-x))
    }
    
    lines(grid, sigmoid(coef(model_glm)[1] + coef(model_glm)[2] * grid), lwd = 3)

  #using the usual formula syntax, it is easy to
  #add or remove complexity from logistic regressions

    model_1 = glm(default ~ 1, data = default_trn, family = "binomial")

    model_2 = glm(default ~ ., data = default_trn, family = "binomial")

    model_3 = glm(default ~ . ^ 2 + I(balance ^ 2),
                  data = default_trn, family = "binomial")

  #note that, using polynomial transformations of predictors
  #will allow a linear model to have non-linear decision boundaries

    model_list = list(model_1, model_2, model_3)

    train_errors = sapply(model_list, get_logistic_error, data = default_trn, 
                          res = "default", pos = "Yes", neg = "No", cut = 0.5)

    test_errors  = sapply(model_list, get_logistic_error, data = default_tst, 
                          res = "default", pos = "Yes", neg = "No", cut = 0.5)

  #here we see the misclassification error rates for each model
  #the train decreases, and the test decreases, until it starts to increase

  #everything we learned about the bias-variance
  #tradeoff for regression also applies here

    diff(train_errors)
    diff(test_errors)

  #we call model_2 the additive logistic model, which we will use quite often

#roc curves

  #let's return to our simple model with only balance as a predictor

    model_glm = glm(default ~ balance, data = default_trn, family = "binomial")

  #we write a function which allows us to make
  #predictions based on different probability cutoffs

    get_logistic_pred = function(mod, data, res = "y", pos = 1, neg = 0, cut = 0.5) {
      probs = predict(mod, newdata = data, type = "response")
      ifelse(probs > cut, pos, neg)
    }

      #C-hat(x) = 1 if p_hat(x) > c
      #C-hat(x) = 0 if p_hat(x) <= c

  #let's use this to obtain predictions using a
  #low, medium, and high cutoff (0.1, 0.5, and 0.9)

    test_pred_10 = get_logistic_pred(model_glm, data = default_tst, res = "default", 
                                     pos = "Yes", neg = "No", cut = 0.1)

    test_pred_50 = get_logistic_pred(model_glm, data = default_tst, res = "default", 
                                     pos = "Yes", neg = "No", cut = 0.5)

    test_pred_90 = get_logistic_pred(model_glm, data = default_tst, res = "default", 
                                     pos = "Yes", neg = "No", cut = 0.9)

  #now we evaluate accuracy, sensitivity, and specificity for these classifiers

    test_tab_10 = table(predicted = test_pred_10, actual = default_tst$default)
    test_tab_50 = table(predicted = test_pred_50, actual = default_tst$default)
    test_tab_90 = table(predicted = test_pred_90, actual = default_tst$default)
    
    test_con_mat_10 = confusionMatrix(test_tab_10, positive = "Yes")
    test_con_mat_50 = confusionMatrix(test_tab_50, positive = "Yes")
    test_con_mat_90 = confusionMatrix(test_tab_90, positive = "Yes")

    metrics = rbind(
      
      c(test_con_mat_10$overall["Accuracy"], 
        test_con_mat_10$byClass["Sensitivity"], 
        test_con_mat_10$byClass["Specificity"]),
      
      c(test_con_mat_50$overall["Accuracy"], 
        test_con_mat_50$byClass["Sensitivity"], 
        test_con_mat_50$byClass["Specificity"]),
      
      c(test_con_mat_90$overall["Accuracy"], 
        test_con_mat_90$byClass["Sensitivity"], 
        test_con_mat_90$byClass["Specificity"])
      
    )
    
    rownames(metrics) = c("c = 0.10", "c = 0.50", "c = 0.90")
    metrics

  #we see then sensitivity decreases as the cutoff is increased
  #conversely, specificity increases as the cutoff increases

  #this is useful if we are more interested in a
  #particular error, instead of giving them equal weight

  #note that usually the best accuracy will be seen near c = 0.50

  #instead of manually checking cutoffs, we can create an ROC curve
  #(receiver operating characteristic curve) which will sweep through
  #all possible cutoffs, and plot the sensitivity and specificity

    library(pROC)
    
    test_prob = predict(model_glm, newdata = default_tst, type = "response")
    test_roc = roc(default_tst$default ~ test_prob, plot = TRUE, print.auc = TRUE)

    as.numeric(test_roc$auc)

  #a good model will have a high AUC, that is as
  #often as possible a high sensitivity and specificity

#multinomial logistic regression

  #what if the response contains more than two categories?
  #for that we need multinomial logistic regression

    #P(Y = 1|X = x) = (softmax function)

  #as an example of a dataset with a three category response, we use
  #the iris dataset, which is so famous, it has its own Wikipedia entry
  #it is also a default dataset in R, so no need to load it

  #before proceeding, we test-train split this data

    set.seed(430)

    iris_obs = nrow(iris)
    iris_idx = sample(iris_obs, size = trunc(0.50 * iris_obs))
    iris_trn = iris[iris_idx, ]
    iris_test = iris[-iris_idx, ]

  #to perform multinomial logistic regression,
  #we use the multinom function from the nnet package

  #training using multinom() is done using similar syntax to lm() and glm()

  #we add the trace = FALSE argument to suppress information
  #about updates to the optimization routine as the model is trained

    library(nnet)

    model_multi = multinom(Species ~ ., data = iris_trn, trace = FALSE)

    summary(model_multi)$coefficients

  #notice we are only given coefficients for two of the three classes,
  #much like only needing coefficients for one class in logistic regression

  #a difference between glm() and multinom() is how the predict() function operates

    head(predict(model_multi, newdata = iris_trn))
    head(predict(model_multi, newdata = iris_trn, type = "prob"))

  #notice that by default, classifications are returned

  #when obtaining probabilities, we are given
  #the predicted probability for each class

  #interestingly, you’ve just fit a neural network,
  #and you didn’t even know it! (hence the nnet package)

  #later we will discuss the connections between logistic regression,
  #multinomial logistic regression, and simple neural networks

#rmarkdown
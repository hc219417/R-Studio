#overview

  #classification is a form of supervised learning where the
  #response variable is categorical, as opposed to numeric for regression

  #our goal is to find a rule, algorithm, or function
  #which takes as input a feature vector, and outputs a
  #category which is the true category as often as possible

  #that is, the classifier C-hat(x) returns the predicted category y-hat(X)

    #y-hat(x) = C-hat(x)

  #to build our first classifier, we will use the Default data set from the ISLR package

    library(ISLR)
    library(tibble)

    as_tibble(Default)

  #our goal is to properly classify individuals as defaulters
  #based on student status, credit card balance, and income

  #be aware that the response default is a factor, as is the predictor student

    is.factor(Default$default) #TRUE
    is.factor(Default$student) #TRUE

  #as we did with regression, we test-train our data (in this case, using 50% for each)

    set.seed(42)

    default_idx = sample(nrow(Default),5000)
    default_trn = Default[default_idx, ]
    default_tst = Default[-default_idx, ]

#visualization for classification

  #often, some simple visualizations can suggest simple classification rules

  #to quickly create some useful visualizations, we use
  #the featurePlot() function from the caret() package

    library(caret)

  #a density plot can often suggest a simple split based on a numeric predictor

  #essentially this plot graphs a density estimate for each
  #numeric predictor x_i and each category k of the response y

    featurePlot(x = default_trn[, c("balance", "income")], 
                y = default_trn$default,
                plot = "density", 
                scales = list(x = list(relation = "free"), 
                              y = list(relation = "free")), 
                adjust = 1.5, 
                pch = "|", 
                layout = c(2, 1), 
                auto.key = list(columns = 2))

  #some notes about the arguments to this function:

    #x is a data frame containing only numeric predictors
    #it would be nonsensical to estimate a density for a categorical predictor

    #y is the response variable (needs to be a factor variable)
    #if coded as 0 and 1, you will need to coerce to factor for plotting

    #plot specifies the type of plot, here density

    #scales defines the scale of the axes for each plot
    #by default, the axis of each plot would be the same,
    #which often is not useful, so the arguments here,
    #a different axis for each plot, will almost always be used

    #adjust specifies the amount of smoothing used for the density estimate

    #pch specifies the plot character used for the bottom of the plot

    #layout places the individual plots into rows and columns
    #for some odd reason, it is given as (col, row)

    #auto.key defines the key at the top of the plot
    #the number of columns should be the number of categories

  #it seems that the income variable by itself is not particularly useful

  #however, there seems to be a big difference in default status
  #at a balance of about 1400 (we will use this information shortly)

    featurePlot(x = default_trn[, c("balance", "income")], 
                y = default_trn$student,
                plot = "density", 
                scales = list(x = list(relation = "free"), 
                              y = list(relation = "free")), 
                adjust = 1.5, 
                pch = "|", 
                layout = c(2, 1), 
                auto.key = list(columns = 2))

  #above, we create a similar plot, except with student as the response
  #we see that students often carry a slightly larger balance, and have far lower income
  #this will be useful to know when making more complicated classifiers

    featurePlot(x = default_trn[, c("student", "balance", "income")], 
                y = default_trn$default, 
                plot = "pairs",
                auto.key = list(columns = 2))

  #we can use plot = "pairs" to consider multiple variables at the same time

  #this plot reinforces using balance to create a classifier,
  #and again shows that income seems not that useful

    library(ellipse)

    featurePlot(x = default_trn[, c("balance", "income")], 
                y = default_trn$default, 
                plot = "ellipse",
                auto.key = list(columns = 2))    

  #similar to pairs is a plot of type ellipse, which requires the ellipse package
  #here we only use numeric predictors, as essentially we are assuming multivariate normality
  #the ellipses mark points of equal density (this will be useful later when discussing LDA and QDA)

#a simple classifier

  #a very simple classifier is a rule based on
  #a boundary b for a particular input variable x

    #C-hat(x) = 1 if x > b
    #C-hat(x) = 0 if x <= b

  #based on the first plot, we believe we can
  #use balance to create a reasonable classifier

  #in particular,

    #C-hat(balance) = yes if balance > 1400
    #C-hat(balance) = no if balance <= 1400

  #so we predict an individual is a defaulter if their balance is
  #above 1400, and not a defaulter if the balance is 1400 or less

    simple_class = function(x, boundary, above = 1, below = 0) {
      ifelse(x > boundary, above, below)
    }

  #we write a simple R function that compares a variable
  #to a boundary, then use it to make predictions on the
  #train and test sets with our chosen variable and boundary

    default_trn_pred = simple_class(x = default_trn$balance, boundary = 1400, above = "Yes", below = "No")
    default_tst_pred = simple_class(x = default_tst$balance, boundary = 1400, above = "Yes", below = "No")
    
    head(default_tst_pred, n = 10)

#metrics for classification

  #in the classification setting, there are a large number
  #of metrics to assess how well a classifier is performing

  #one of the most obvious things to do is arrange
  #predictions and true values in a cross table

    (trn_tab = table(predicted = default_trn_pred, actual = default_trn$default))
    (tst_tab = table(predicted = default_tst_pred, actual = default_tst$default))

  #often we give specific names to individual cells of these tables,
  #and in the predictive setting, we would call this table a confusion matrix

  #be aware, that the placement of actual and predicted values affects
  #the names of the cells, and often the matrix may be presented transposed

  #in statistics, we label the errors Type I
  #and Type II, but these are hard to remember

  #false positive (FP) and false negative (FN)
  #are more descriptive, so we choose to use these

  #the confusionMatrix() function from the caret package
  #can be used to obtain a wealth of additional information,
  #which we see output below for the test data

  #note that we specify which category is considered “positive”

    trn_con_mat  = confusionMatrix(trn_tab, positive = "Yes")
    (tst_con_mat = confusionMatrix(tst_tab, positive = "Yes"))

  #the most common, and most important metric is the classification error rate

  #here, I is an indicator function, so we are essentially calculating
  #the proportion of predicted classes that match the true class

  #it is also common to discuss the accuracy, which is simply one minus the error

  #like regression, we often split the data, and then consider
  #train (classification) error and test (classification) error,

  #which will be used as a measure of how well
  #a classifier will work on unseen future data

  #accuracy values can be found by calling
  #confusionMatrix(), or, if stored, can be accessed directly

  #here, we use them to obtain error rates

    1 - trn_con_mat$overall["Accuracy"]
    1 - tst_con_mat$overall["Accuracy"]

  #sometimes guarding against making certain errors, FP or FN,
  #are more important than simply finding the best accuracy

  #thus, sometimes we will consider sensitivity and specificity

    #sensitivity = true positive rate = TP / P = TP / (TP + FN)

      tst_con_mat$byClass["Sensitivity"]

    #specificity = true negative rate = TN / N = TN / (TN + FP)

      tst_con_mat$byClass["Specificity"]

  #like accuracy, these can easily be found using confusionMatrix()

  #when considering how well a classifier is performing, often,
  #it is understandable to assume that any accuracy in a binary
  #classification problem above 0.50, is a reasonable classifier

  #this however is not the case
  #we need to consider the balance of the classes
  #to do so, we look at the prevalence of positive cases

    #prevalence = P / total observations = (TP + FN) / total observations

      trn_con_mat$byClass["Prevalence"]
      tst_con_mat$byClass["Prevalence"]

  #here, we see an extremely low prevalence, which suggests
  #an even simpler classifier than our current based on balance

    #C-hat(balance) = no if balance > 1400
    #C-hat(balance) = no if balance <= 1400

  #this classifier simply classifies all observations as negative cases

    pred_all_no = simple_class(default_tst$balance, boundary = 1400, above = "No", below = "No")
    table(predicted = pred_all_no, actual = default_tst$default)

  #the confusionMatrix() function won’t even accept this table as input,
  #because it isn’t a full matrix, only one row, so we calculate error rates directly

  #to do so, we write a function:

    calc_class_err = function(actual, predicted) {
      mean(actual != predicted)
    }

    calc_class_err(actual = default_tst$default, predicted = pred_all_no)

  #here we see that the error rate is exactly the prevalence of the minority class

    table(default_tst$default) / length(default_tst$default)

  #this classifier does better than the previous

  #but the point is, in reality, to create a good classifier,
  #we should obtain a test error better than 0.033, which is
  #obtained by simply manipulating the prevalence

  #next chapter, we’ll introduce much better classifiers
  #which should have no problem accomplishing this task

#rmarkdown
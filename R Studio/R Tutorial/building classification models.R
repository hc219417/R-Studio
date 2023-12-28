#building classification models

#introduction

  #building classification models is one of
  #the most important data science use cases

  #classification models are models that predict a categorical label

  #a few examples of this include predicting whether a
  #customer will churn or whether a bank loan will default

  #in this guide, you will learn how to build
  #and evaluate a classification model in R

  #we will train the logistic regression algorithm, which is
  #one of the oldest yet most powerful classification algorithms

#data

  #in this guide, we will use a fictitious data set
  #of loan applicants containing 600 observations and 10 variables,
  #as described below:

    #marital_status: whether the applicant is married ("yes") or not ("no")
    #is_graduate: whether the applicant is a graduate ("yes") or not ("no")
    #income: annual income of the applicant (in USD)
    #loan_amount: loan amount (in USD) for which the application was submitted
    #credit_score: whether the applicant's credit score is good ("good") or not ("bad")
    #approval_status: whether the loan application was approved ("yes") or not ("no")
    #age: the applicant's age in years
    #sex: whether the applicant is a male ("M") or a female ("F")
    #investment: total investment in stocks and mutual funds (in USD) as declared by the applicant
    #purpose: purpose of applying for the loan

  #let's start by loading the required libraries and the data

    library(plyr)
    library(readr)
    library(dplyr)
    library(caret)

    dat <- read_csv("data.csv")
    glimpse(dat)

  #the output shows that the data set has four numerical
  #(labeled as int) and six character variables (labeled as chr)

  #we will convert these into factor variables using the line of code below

    names <- c(1,2,5,6,8,10)
    dat[,names] <- lapply(dat[,names], factor)
    glimpse(dat)

#data partitioning

  #we will build our model on the training data set
  #and evaluate its performance on the test data set

  #this is called the holdout-validation approach to evaluating model performance
    
  #the first line of code below sets the random seed for reproducibility of results
  #the second line loads the caTools package that will be used for data partitioning,
  #while the third to fifth lines create the training and test data sets

  #the train data set contains 70 percent of the data (420 observations of 10 variables)
  #while the test data contains the remaining 30 percent (180 observations of 10 variables)

    set.seed(100)
    library(caTools)

    spl = sample.split(dat$approval_status, SplitRatio = 0.7)
    train = subset(dat, spl == TRUE)
    test = subset(dat, spl == FALSE)

    print(dim(train)); print(dim(test))

#build, predict, and evaluate the model

  #to fit the logistic regression model,
  #the first step is to instantiate the algorithm

  #this is done in the first line of code below with the glm() function
  #the second line prints the summary of the trained model

    model_glm = glm(approval_status ~ ., family = "binomial", data = train)
    summary(model_glm)

  #the significance code ‘***’ in the above output
  #shows the relative importance of the feature variables

  #let's evaluate the model further, starting by
  #setting the baseline accuracy using the code below

  #since the majority class of the target variable has a
  #proportion of 0.68, the baseline accuracy is 68 percent

    #baseline accuracy
    prop.table(table(train$approval_status))

  #let's now evaluate the model performance on the training and test data,
  #which should ideally be better than the baseline accuracy

  #we start by generating predictions on the training data,
  #using the first line of code below

  #the second line creates the confusion matrix with a threshold of 0.5,
  #which means that for probability predictions equal to or greater than 0.5,
  #the algorithm will predict the yes response for the approval_status variable

  #he third line prints the accuracy of the model on the training data,
  #using the confusion matrix, and the accuracy comes out to be 91 percent
    
  #we then repeat this process on the test data,
  #and the accuracy comes out to be 88 percent

    #predictions on the training set
    predictTrain = predict(model_glm, data = train, type = "response")

    #confusion matrix on training data
    table(train$approval_status, predictTrain >= 0.5)
    (114 + 268)/nrow(train) #accuracy - 91%

    #predictions on the test set
    predictTest = predict(model_glm, newdata = test, type = "response")

    #confusion matrix on test set
    table(test$approval_status, predictTest >= 0.5)
    158/nrow(test) #accuracy - 88%

#conclusion

  #in this guide, you have learned techniques of building a
  #classification model in R using the powerful logistic regression algorithm

  #the baseline accuracy for the data was 68 percent,
  #while the accuracy on the training and test data was
  #91 percent, and 88 percent, respectively

  #overall, the logistic regression model is beating the baseline accuracy by a
  #big margin on both the train and test data sets, and the results are very good
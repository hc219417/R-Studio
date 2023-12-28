#how to create an roc curve in r

  #ROC stands for Receiver Operating Characteristics, and it is
  #used to evaluate the prediction accuracy of a classifier model

  #ROC curve is a metric describing the trade-off between the sensitivity
  #(true positive rate, tpr) and specificity (false positive rate, fpr)
  #of a prediction in all probability cutoffs (thresholds)

  #it can be used for binary and multi-class classification accuracy checking

  #to evaluate the ROC in multi-class prediction, we create
  #binary classes by mapping each class against the other classes

  #in this tutorial, you'll learn how to check the ROC curve in R

  #we use the ROCR package in this tutorial

  #since ROC is created by the tpr and fpr value,
  #here I'll mention the formula of both metrics

  #please refer to my previous post about the
  #confusion matrix to understand below metrics

    #tpr = tp / (tp + fn)
    #fpr = fp / (fp + tn)

  #first, we'll generate a sample data set and build a classifier
  #with a logistic regression model, then predict the test data

  #based on prediction data we'll create a
  #ROC curve and find out some other metrics

    library(ROCR)

    df = data.frame(a = sample(1:25, 400, replace = T),
                    b = runif(400) * 3, 
                    c = sample(1:10, 400, replace = T))

    df = cbind(df,type = ifelse((df$a + df$b + df$c) >= 20, 1, 0)) 

    index = sample(1:nrow(df), size = .80 * nrow(df))
    train = df[index, ]
    test = df[-index, ]

    model = glm(type ~ a + b, data = train, family = binomial(link = "logit"))

    pred = predict(model, test, type = "response")

#performance check

  #next, we'll use the prediction and performance
  #functions of the ROCR package to check the accuracy

  #the accuracy vs cutoff values plot is shown below

    pred = prediction(pred, test$type)
    perf = performance(pred, "acc")
    plot(perf)

  #you can also check the other metrics with the
  #performance function and visualize them in a plot

    perf_cost = performance(pred, "cost")
    perf_err = performance(pred, "err")
    perf_tpr = performance(pred, "tpr")
    perf_sn_sp = performance(pred, "sens", "spec")
  
    plot(perf_cost)

  #we can get maximum accuracy cutoff from accuracy performance

    max_ind = which.max(slot(perf, "y.values")[[1]])
    acc = slot(perf, "y.values")[[1]][max_ind]
    cutoff = slot(perf, "x.values")[[1]][max_ind]
    print(c(accuracy = acc, cutoff = cutoff))

#ROC curve
  
  #next, we'll create a ROC curve
  
    roc = performance(pred, "tpr", "fpr")
    plot(roc, colorize = T, lwd = 2)
    abline(a = 0, b = 1)

  #a random guess is a diagonal line
  #and the model does not make any sense

  #if the curve approaches closer to the top-left corner,
  #model performance becomes much better

  #any curve under the diagonal is worse than a random guess

  #we can set the cutoff threshold based on our requirement
  #in terms of sensitivity and specificity importance

#AUC

  #the AUC represents the area under the ROC curve
  #we can evaluate the model performance by the value of the AUC
  #higher than 0.5 shows a better model performance
  #if the curve changes to rectangle it is perfect classifier with AUC value = 1

    auc = performance(pred, measure = "auc")
    print(auc@y.values)

  #in this tutorial, we've briefly learned how to build
  #a ROC curve and find out AUC with the ROCR package

#source code listing
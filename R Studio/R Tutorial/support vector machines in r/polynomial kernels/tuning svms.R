#tuning svms

#tune model
tune_out <- tune.svm(x = trainset[, -3], y = trainset[, 3], 
            type = "C-classification", kernel = "polynomial", degree = 2, cost = 10 ^ (-1:2), 
            gamma = c(0.1, 1, 10), coef0 = c(0.1, 1, 10))

#list optimal values
tune_out$best.parameters$cost
tune_out$best.parameters$gamma
tune_out$best.parameters$coef0

#build tuned model
svm_model <- svm(y~ ., data = trainset, type = "C-classification", 
                 kernel = "polynomial", degree = 2, 
                 cost = tune_out$best.parameters$cost, 
                 gamma = tune_out$best.parameters$gamma, 
                 coef0 = tune_out$best.parameters$coef0)

#calculate training and test accuracies   
pred_train <- predict(svm_model, trainset)
mean(pred_train == trainset$y)

pred_test <- predict(svm_model, testset)
mean(pred_test == testset$y)

#plot model
plot(svm_model, trainset)
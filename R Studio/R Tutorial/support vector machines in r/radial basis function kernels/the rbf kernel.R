#the rbf kernel

#create vector to store accuracies and set random number seed
accuracy <- rep(NA, 100)
set.seed(2)

#calculate accuracies for 100 training/test partitions
for (i in 1:100){
  df[, "train"] <- ifelse(runif(nrow(df)) < 0.8, 1, 0)
  trainset <- df[df$train == 1, ]
  testset <- df[df$train == 0, ]
  trainColNum <- grep("train", names(trainset))
  trainset <- trainset[, -trainColNum]
  testset <- testset[, -trainColNum]
  svm_model<- svm(y ~ ., data = trainset, type = "C-classification", kernel = "polynomial", degree = 2)
  pred_test <- predict(svm_model, testset)
  accuracy[i] <- mean(pred_test == testset$y)
}

#print average accuracy and standard deviation
mean(accuracy)
sd(accuracy)

#create vector to store accuracies and set random number seed
accuracy <- rep(NA, 100)
set.seed(2)

#calculate accuracies for 100 training/test partitions
for (i in 1:100){
  df[, "train"] <- ifelse(runif(nrow(df)) < 0.8, 1, 0)
  trainset <- df[df$train == 1, ]
  testset <- df[df$train == 0, ]
  trainColNum <- grep("train", names(trainset))
  trainset <- trainset[, -trainColNum]
  testset <- testset[, -trainColNum]
  svm_model<- svm(y ~ ., data = trainset, type = "C-classification", kernel = "radial")
  pred_test <- predict(svm_model, testset)
  accuracy[i] <- mean(pred_test == testset$y)
}

#print average accuracy and standard deviation
mean(accuracy)
sd(accuracy)

#tune model
tune_out <- tune.svm(x = trainset[, -3], y = trainset[, 3], 
                     gamma = 5 * 10 ^ (-2:2), 
                     cost = c(0.01, 0.1, 1, 10, 100), 
                     type = "C-classification", kernel = "radial")
#build tuned model
svm_model <- svm(y ~ ., data = trainset, type = "C-classification", kernel = "radial", 
                 cost = tune_out$best.parameters$cost, 
                 gamma = tune_out$best.parameters$gamma)

#calculate test accuracy
pred_test <- predict(svm_model, testset)
mean(pred_test == testset$y)

#plot decision boundary against test data
plot(svm_model, testset)
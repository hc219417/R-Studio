#multiclass problems

#load library and build svm model
library(e1071)

svm_model <- svm(y ~ ., data = trainset, type = "C-classification", kernel = "linear", scale = FALSE)

#compute training accuracy
pred_train <- predict(svm_model, trainset)
mean(pred_train == trainset$y)

#compute test accuracy
pred_test <- predict(svm_model, testset)
mean(pred_test == testset$y)

#plot
plot(svm_model, trainset)

accuracy = NULL

for (i in 1:100){
  #assign 80% of the data to the training set
  iris[, "train"] <- ifelse(runif(nrow(iris)) < 0.8, 1, 0)
  trainColNum <- grep("train", names(iris))
  trainset <- iris[iris$train == 1, -trainColNum]
  testset <- iris[iris$train == 0, -trainColNum]
  
  #build model using training data
  svm_model <- svm(Species ~ ., data = trainset, type = "C-classification", kernel = "linear")
  
  #calculate accuracy on test data
  pred_test <- predict(svm_model, testset)
  accuracy[i] <- mean(pred_test == testset$Species)
}

mean(accuracy)
sd(accuracy)
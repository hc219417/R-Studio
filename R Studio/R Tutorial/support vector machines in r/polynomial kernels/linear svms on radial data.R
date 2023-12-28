#linear svms on radial data

#split train and test data in an 80/20 proportion
df[, "train"] <- ifelse(runif(nrow(df)) < 0.8, 1, 0)

#assign training rows to data frame trainset
trainset <- df[df$train == 1, ]

#assign test rows to data frame testset
testset <- df[df$train == 0, ]

#find index of "train" column
trainColNum <- grep("train", names(df))

#remove "train" column from train and test dataset
trainset <- trainset[, -trainColNum]
testset <- testset[, -trainColNum]

#default cost mode
svm_model_1 <- svm(y ~ ., data = trainset, type = "C-classification", cost = 1, kernel = "linear")

#training accuracy
pred_train <- predict(svm_model_1, trainset)
mean(pred_train == trainset$y)

#test accuracy
pred_test <- predict(svm_model_1, testset)
mean(pred_test == testset$y)

#cost = 100 model
svm_model_2 <- svm(y ~ ., data = trainset, type = "C-classification", cost = 100, kernel = "linear")

#accuracy
pred_train <- predict(svm_model_2, trainset)
mean(pred_train == trainset$y)

pred_test <- predict(svm_model_2, testset)
mean(pred_test == testset$y)

#print average accuracy and standard deviation
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
  svm_model <- svm(y ~ ., data = trainset, type = "C-classification", kernel = "linear")
  pred_test <- predict(svm_model, testset)
  accuracy[i] <- mean(pred_test == testset$y)
}

#print average accuracy and its standard deviation
mean(accuracy)
sd(accuracy)
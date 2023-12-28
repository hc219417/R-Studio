#linear svm

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

library(e1071)

#build svm model, setting required parameters
svm_model <- svm(y ~ ., data = trainset, type = "C-classification", kernel = "linear", scale = FALSE)

#list components of model
names(svm_model)

#list values of the SV, index and rho
head(svm_model$SV)
svm_model$index
svm_model$rho

#compute training accuracy
pred_train <- predict(svm_model, trainset)
mean(pred_train == trainset$y)

#compute test accuracy
pred_test <- predict(svm_model, testset)
mean(pred_test == testset$y)
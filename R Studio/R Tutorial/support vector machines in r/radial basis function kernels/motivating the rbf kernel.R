#motivating the rbf kernel

#build model
svm_model <- svm(y ~ ., data = trainset, type = "C-classification", kernel = "linear")

#accuracy
pred_train <- predict(svm_model, trainset)
mean(pred_train == trainset$y)

pred_test <- predict(svm_model, testset)
mean(pred_test == testset$y)

#plot model against testset
plot(svm_model, testset)

#build model
svm_model <- svm(y ~ ., data = trainset, type = "C-classification", kernel = "polynomial", degree = 2)

#accuracy
pred_train <- predict(svm_model, trainset)
mean(pred_train == trainset$y)

pred_test <- predict(svm_model, testset)
mean(pred_test == testset$y)

#plot model
plot(svm_model, trainset)
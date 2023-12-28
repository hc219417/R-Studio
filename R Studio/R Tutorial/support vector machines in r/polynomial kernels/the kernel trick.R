#the kernel trick

#transform data
df1 <- data.frame(x1sq = df$x1 ^ 2, x2sq = df$x2 ^ 2, y = df$y)

#plot data points in the transformed space
plot_transformed <- ggplot(data = df1, aes(x = x1sq, y = x2sq, color = y)) + 
geom_point() + guides(color = FALSE) + scale_color_manual(values = c("red", "blue"))

#add decision boundary and visualize
plot_decision <- plot_transformed + geom_abline(slope = -1, intercept = 0.64)
plot_decision

svm_model <- svm(y ~ ., data = trainset, type = "C-classification", kernel = "polynomial", degree = 2)

#measure training and test accuracy
pred_train <- predict(svm_model, trainset)
mean(pred_train == trainset$y)

pred_test <- predict(svm_model, testset)
mean(pred_test == testset$y)

#plot
plot(svm_model, trainset)
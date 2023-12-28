#tuning linear svms

#build svm model, cost = 1
svm_model_1 <- svm(y ~ ., data = trainset, type = "C-classification",
                   cost = 1, kernel = "linear", scale = FALSE)

#print model details
svm_model_1

#build svm model, cost = 100
svm_model_100 <- svm(y ~ ., data = trainset, type = "C-classification",
                     cost = 100, kernel = "linear", scale = FALSE)

#print model details
svm_model_100

w_1 = w[1]
w_2 = w[2]

train_plot <- ggplot(data = trainset, aes(x = x1, y = x2, color = y)) + 
geom_point() + scale_color_manual(values = c("red", "blue"))

#add decision boundary and margins for cost = 1 to training data scatter plot
train_plot_with_margins <- train_plot + 
  geom_abline(slope = slope_1, intercept = intercept_1) +
  geom_abline(slope = slope_1, intercept = intercept_1 - 1 / w_1[2], linetype = "dashed") +
  geom_abline(slope = slope_1, intercept = intercept_1 + 1 / w_1[2], linetype = "dashed")

#display plot
train_plot_with_margins

#build svm model, cost = 100
svm_model_100 <- svm(y ~ ., data = trainset, type = "C-classification",
                     cost = 100, kernel = "linear", scale = FALSE)

w_100 = t(svm_model_100$coefs) %*% svm_model_100$SV

#calculate slope and intercept of decision boundary from weight vector and svm model
slope_100 <- -w_100[1] / w_100[2]
intercept_100 <- svm_model_100$rho / w_100[2]
train_plot_100 = train_plot_with_margins

#add decision boundary and margins for cost = 100 to training data scatter plot
train_plot_with_margins <- train_plot_100 + 
  geom_abline(slope = slope_100, intercept = intercept_100, color = "goldenrod") +
  geom_abline(slope = slope_100, intercept = intercept_100 - 1 / w_100[2], linetype = "dashed", color = "goldenrod") +
  geom_abline(slope = slope_100, intercept = intercept_100 + 1 / w_100[2], linetype = "dashed", color = "goldenrod")

#display plot
train_plot_with_margins
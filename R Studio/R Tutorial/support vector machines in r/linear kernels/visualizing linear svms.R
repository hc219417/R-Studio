#visualizing linear svms

#load ggplot
library(ggplot2)

#build scatter plot of training dataset
scatter_plot <- ggplot(data = trainset, aes(x = x1, y = x2, color = y)) + 
geom_point() + scale_color_manual(values = c("red", "blue"))

#add plot layer marking out the support vectors 
layered_plot <- scatter_plot + geom_point(data = trainset[svm_model$index, ],
                                          aes(x = x1, y = x2), color = "purple",
                                          size = 4, alpha = 0.5)
#display plot
layered_plot

w = t(svm_model$coefs) %*% svm_model$SV

#calculate slope and intercept of decision boundary from weight vector and svm model
slope_1 <- -w[1] / w[2]
intercept_1 <- svm_model$rho / w[2]

#build scatter plot of training dataset
scatter_plot <- ggplot(data = trainset, aes(x = x1, y = x2, color = y)) + 
geom_point() + scale_color_manual(values = c("red", "blue"))

#add decision boundary 
plot_decision <- scatter_plot + geom_abline(slope = slope_1, intercept = intercept_1) 

#add margin boundaries
plot_margins <- plot_decision + 
  geom_abline(slope = slope_1, intercept = intercept_1 - 1 / w[2], linetype = "dashed") +
  geom_abline(slope = slope_1, intercept = intercept_1 + 1 / w[2], linetype = "dashed")

#display plot
plot_margins

#load required library
library(e1071)

#build svm model
svm_model <- svm(y ~ ., data = trainset, type = "C-classification", kernel = "linear", scale = FALSE)

#plot decision boundaries and support vectors for the training data
plot(x = svm_model, data = trainset)
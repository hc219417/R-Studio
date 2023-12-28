#neural network

#introduction to neural network

  #Y = sum(weight * input) + bias
  #bias and weights are parameters
  #need a mapping mechanism

#forward propagation and back propagation

  #two main types of artificial neural networks:

    #feedforward -> not recursive
    #feedback -> contain cycles (recurrent)

#activation function

  #identity function
  #binary step function
  #sigmoid function
  #ramp function
  #ReLu function

#implementation of the neural network in r

  install.packages("neuralnet") #install package
  
  TKS = c(20, 10, 30, 20, 80, 30) #technical knowledge score
  CSS = c(90, 20, 40, 50, 50, 80) #communication skills score
  placed = c(1, 0, 0, 0, 1, 1) #student placed
  df = data.frame(TKS, CSS, placed) #create training data set
  
  require(neuralnet) #load library
  nn = neuralnet(placed ~ TKS + CSS, data = df,
                 hidden = 3, act.fct = "logistic",
                 linear.output = FALSE) #fit neural network
  
  plot(nn) #plot neural network
  
  TKS = c(30, 40, 85)
  CSS = c(85, 50, 40)
  test = data.frame(TKS, CSS) #create test set
  
  predict = compute(nn, test)
  predict$net.result #prediction using neural network
  
  prob = predict$net.result
  pred = ifelse(prob > 0.5, 1, 0) #convert probabilities into binary classes
  
  pred #setting threshold level to 0.5

#applications

  #pattern recognition
  #anomaly detection
  #time series prediction
  #natural language processing

#pros and cons

  #pros: more flexible (regression and classification)
  #cons: require more data (only numerical inputs, non-missing value data sets)

#conclusion
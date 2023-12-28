#final exercise

#here you will find a dataset in .csv format containing the results of
#a study performed to investigate the impact of three anorexia treatments

#the weights of (in total) 72 anorexia patients were
#measured before and after receiving one of the three treatments

#the data contain three variables:
  
  #treat: the treatment indicator (0 = control, i.e. no treatment,
                                  #1 = cognitive behavioral treatment,
                                  #2 = family treatment)
  #w_pre: the weight (in lbs) before receiving the treatment
  #w_post: the weight (in lbs) after receiving the treatment

#please perform the steps below to analyze these data
#don’t forget to annotate your script
#again, feel free to use any on-line information you can find

  #import the data into R, and store it as an object

    anorexia <- read.csv(file = "anorexia.csv", header = TRUE)

  #check the first three rows of the data to see if step 1 was performed correctly

    head(anorexia,3)
    
  #create two new variables representing the weight in kilograms (instead of lbs)
  #note: 1 kg = 2.205 lbs

    w_pre <- round(c(anorexia$w_pre / 2.205), 1)   #round to one
    w_post <- round(c(anorexia$w_post / 2.205), 1) #decimal place
    
  #calculate weight change, i.e. the weight after receiving the treatment minus
  #the change before receiving the treatment, and add this information to the dataset

    w_change <- c(w_post - w_pre)
    anorexia_new <- cbind(anorexia, w_change)
    
  #make three box plots of the change scores, one for each treatment

    boxplot(w_change ~ treat, anorexia_new)
    
    boxplot(w_change ~ treat, anorexia_new,
            xlab = "Treatment Indicator (0 = control, 1 = cognitive behavioral treament, 2 = family treatment)",
            ylab = "Weight Change (kg)",
            main = "Weight Change vs Treatment",
            pch = 1, #plot character
            cex = 1, #size of points
            col = "aliceblue",
            border = "cornflowerblue")
    
  #calculate the average weight change for each of the treatments

    avg0 <- round(mean(w_change[anorexia$treat == 0]),1)
    avg1 <- round(mean(w_change[anorexia$treat == 1]),1)
    avg2 <- round(mean(w_change[anorexia$treat == 2]),1)
    
  #add a new variable to the dataset indicating whether the weight was decreased,
  #increased or remained approximately the same
  #let the variable take on the character value ‘Decrease’
  #(if weight was decreased by at least 1 kg),
  #‘No change’ (if the change in weight was at most 1 kg in either direction),
  #or ‘Increase’ (if the increase in weight was at least 1 kg)
    
    w_descr <- vector("character",72) #initialize an empty vector of length 72
    
    for(i in 1:72){
      if(anorexia_new[i,4] < -1){
        w_descr[i] <- "decrease"
      } else if(anorexia_new[i,4] >= -1 & anorexia_new[i,4] <= 1){
        w_descr[i] <- "no change"
      } else if(anorexia_new[i,4] > 1){
        w_descr[i] <- "increase"
      }
    } #for loop using if and else if statements
    
    anorexia_NEW <- cbind(anorexia_new, w_descr) #add w_descr to dataset
    
  #for each treatment, create a frequency table for the variable included in step 7
    
    (t0 <- table(anorexia_NEW$w_descr[anorexia$treat == 0]))
    (t1 <- table(anorexia_NEW$w_descr[anorexia$treat == 1]))
    (t2 <- table(anorexia_NEW$w_descr[anorexia$treat == 2]))
    
    (total <- table(anorexia_NEW$w_descr)) #total frequency

  #note that the total number of patients assigned to each treatment differs
  #hence, it is more informative to compare proportions instead of absolute numbers
  #calculate, again per treatment, the proportion of patients in each category
  #of the variable created in step 7
    
    prop.table(t0) #26 patients
    prop.table(t1) #29 patients
    prop.table(t2) #17 patients
    
    prop.table(total) #72 total

  #write a short conclusion regarding the effectiveness of the three treatments
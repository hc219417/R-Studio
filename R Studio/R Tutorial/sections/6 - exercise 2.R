#exercise 2

#consider the hypothetical data on smoking status for 100 individuals:
#57 subjects never smoked, 28 subjects qualify as ex-smokers, and 15 are current smokers
#these data can be visualized by means of a so-called pie chart:

slices <- c(57, 28, 15)
colors <- c('green', 'orange', 'red')
lbls <- c("never smoked", "ex-smokers", "current smokers")
pie(slices, labels = lbls, col = colors, main = "Smoking Status")

#try to replicate this chart
#feel free to use any online information that you can find
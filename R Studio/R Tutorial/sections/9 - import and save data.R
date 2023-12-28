#the working directory*

  #in R-studio you can define the working directory (i.e. folder) in two ways:

    #method 1: browsing

      #manually browse to the working directory in the lower-right
      #R-studio panel by a left click on the (...) button

      #browse to the working directory
      #and then set as working directory

    #method 2: using the setwd function

      #use the setwd() function:

        setwd("C:/Users/hanna/OneDrive/Desktop/R Studio")
        setwd("C:/Users/hanna/OneDrive/Desktop/R Studio/R Tutorial")

      #notice that R uses / for defining directory paths, instead of \

#example data set: aneurysm data

  #download the zip file containing the aneurysm
  #data with .csv, .txt and .sav extensions 

  #unzip the zip-file in your working directory
  #make sure all three data files are unpacked

#importing data of different types

  #text file (aneurysm.txt = tab-delimited text file)

    #to import the tab-delimited file in R you can use the read.table() function:
    
        df <- read.table(file = "aneurysm.txt", header = TRUE)

    #notice that the argument header = TRUE tells R that the
    #first row of the text file contains the variable names

  #csv file (aneurysm.csv = comma separated values file)

    #to import the csv file in R you can use the read.csv() function:
    
        df2 <- read.csv(file = "aneurysm.csv", header = TRUE)

    #notice that some csv files may have other so-called
    #‘separation characters’ (separating the columns) than the comma

    #for instance, columns may be separated by a semicolon
    #to import such data you can add as an additional argument:
    #sep = ";" to the read.csv() function

  #spss file (aneurysm.sav)

    #files with a .sav extension can be imported using
    #the read.spss() function of the foreign library

    #before you run the following code, make
    #sure that the foreign library is installed

      library(foreign)
      df3 <- read.spss(file = "aneurysm.sav", to.data.frame = TRUE)
      
  #other files (aneurysm.xlsx)
      
      ?read.csv
      aneur <- read.csv(file.choose(), header = TRUE)
      
      head(aneur) #check the first few lines to see if the data was read in right
      dim(aneur) #check the dimensions of the data (238 observations, 8 variables)
      
      ?read.table
      aneur2 <- read.table(file.choose(), header = TRUE, sep = ",")
      
      head(aneur2)
      dim(aneur2)
      
      aneur3 <- read.table(file.choose(), header = TRUE, sep = "\t")
      
      head(aneur3)
      dim(aneur3)

#saving a data set

  #data frame df, originally from a tab-delimited
  #text file, can be saved as a CSV file using:

    write.csv(x = df, file = "aneurysmNEW.csv", row.names = FALSE)
      
  #check whether the file aneurysmNEW.csv is stored in your working directory (yep!)
      
  #another common format for R data files is by the .rds extension:
        
    saveRDS(object = df, file = "aneurysmNEW.rds")
  
  #to ‘import’ a file with .rds extension you can use:
        
    df4 <- readRDS(file = "aneurysmNEW.rds")

#importing data from outside the working directory

    df5 <- readRDS(file = "C:/Users/hanna/OneDrive/Desktop/R Studio/R Tutorial/aneurysmNEW.rds") #define the whole file path (URL)
    
    df6 <- readRDS(file = file.choose()) #use the function file.choose() that allows you to browse for the file
    
# *preferably contains various subdirectories
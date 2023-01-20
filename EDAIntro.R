##### Exploratory Data Analysis 
# variable is the same as column
# need to know schema of the dat ato find clues about coding 
# need to check assumptions about the data 
# don't skip validating the data, IE if it's in dollars, then it should have 2 decimals etc 


#### R doesn't like excel files to be open while you're working with it 

getwd()
setwd("/Users/aldenbutzke/Desktop/Datamining")
getwd()      


rm(list=ls())

#install.packages("readxl", dependencies = TRUE)

#library(svDialogs)
library(readxl)
#form<- list(
#  "Enter width" = 10.1,
#  "Enter Height" = 11.1,
#  "Enter length"= 12.1
  
#)

#Dat<-dlg_form(form, "Cueb Data")$res 
#Area<-Dat$'Enter Width' Dat$'Enter Height'*Dat$'Enter LEngth'
#print(paste0("The Area is: ", Area))


list.files()

### reading in Transit worksheet out of EDA_Data.elsx 

TranSurv<- read_xlsx("EDA_Data.xlsx", sheet = "Transit") #put exact name of sheet in quotes

### structure of the data, insight into number of obs, how many variables, etc 
# ncol() returns number of columns, one df at a time 
# nrow() reutrns number of rows, have to pick column 
# syntax for above would be nrow(TranSurv$ColumnName) when more columns 
# names() returns variable names 
# class() returns class, specifcy column like above 

NVar<-ncol(TranSurv)
NObservations<- nrow(TranSurv) #only takes a single column of data 

#determine names of columns/variables 

VarNames<- names(TranSurv)
VarT<- class(TranSurv$`Transit Type`)

print(paste0( " Number of Variables is: ", NVar))
print(paste0( " Number of Rows/Observations is: ", NObservations))
print(paste0( " Variable Types are: ", VarT))
print(paste0( " Variable Names are: ", VarNames))


#### determine if there are any missing values 
# if there are, which ones are missing 
# is.na() T = NA, F = value, works for single columns 
# which() goes through a vector of logic and tells which oens are true 
# which(is.na))
# length(which(is.na)) counts number of missing obs 
# unqiue() lists number of unique categories 
# table() can count anything, so can tally() 

x<- c(1, NA, 3, NA, 5)

MisRows<-which(is.na(x)) # which rows are missing

### how many rows are missing 

numMiss<-length(which(is.na(x)))

print(paste0( " We have, ", numMiss, " missing values, at rows " ))
print(MisRows)


#### good idea to print a little bit of data to ensure it looks how you think 

TranSurv$`Transit Type`[1:10]

### for categorical data, figuring out how many unique categories is a must 

CatList<-unique(TranSurv$`Transit Type`)

### tally or count repsonses in one type of data 

Freq<-table(TranSurv$`Transit Type`)
RelFreq<- Freq/sum(Freq)
print(RelFreq)

## graph
# making bar plot sideays so we can use long names 
# short names should be upwards 
# main will be the name of the chart 
# labels or xlab ylab will be labels 


barplot(Freq, main = "Bar Chart for Transit Survey Results",
        horiz = TRUE, col = "blue", xlim = c(0,400), las=1, cex.names = 0.5, xlab = "Counts", 
        ylab = "Categories"
        
        
        )

abline(v=0)


barplot(Freq, main = "Bar Chart for Transit Survey Results", col = "red", las=1,
        cex.names = 0.9, ylim = c(0,400), density = TRUE
        
        
        )

abline(h=0)

#### pie( column, labels, radius, main, col, clockwise or counter) 

pie(Freq)

pie(Freq, labels = paste0(round(100*Freq/sum(Freq), 1), "%"), 
    main = "Forms of Transportation", col =rainbow(length(Freq))
)
    legend("topright", names(Freq), cex = 0.7, fill = rainbow(length(Freq)))
    
#install.packages("plotrix", dependencies = TRUE)

library(plotrix)

pie3D(Freq, explode = 0.1, labels = paste0(round(100*Freq/sum(Freq), 1), "%"),
      main = "Forms of Transportation"
      )
legend("topright", names(Freq), cex = 0.7, fill = rainbow(length(Freq)))


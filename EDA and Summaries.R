getwd()
setwd("/Users/aldenbutzke/Desktop/Datamining")
getwd()
rm(list = ls())


########### functions
# basicStats() 
# names()
# summary() more basic than basicstats



college<-read.csv("College.csv", header = TRUE)
head(college, 2)

### can use summary in many ways, but works best for numerical data 

library(fBasics) #something weird with loading it 

##### how to remove scientific/engineering notation 

options(scipen=999)  #### this removes R's capacity to use scientific notation

EarnStat<-round(basicStats(college$Earnings), 2)

names(EarnStat)<-c("Values") #### making it a vector is preventive, it likes vectors 
EarnStat

CostStat<-round(basicStats(college$Cost), 2)
names(CostStat)<-c("Values")

CostStat

GradStat<-round(basicStats(college$Grad), 2)

names(GradStat)<-c("Values")


DebtStat<-round(basicStats(college$Debt), 2)

names(DebtStat)<-c("Values")

MeanDebt<-DebtStat$Values[7]


##### summary() 

summary(college$Earnings)
summary(college$Cost)

###### main tool is the box plot, five number summary 
###### we wantt o create plots for data of similar scale 
##### if not on the same scale then complete independent plots 

# [rows, columns]

college[c(2,4),c("Earnings", "Cost")]

boxplot(college[, c("Earnings", "Cost")], ### pulls the data, creates two box plots on same graph 
  main = "Box-plot of Earnigns and zCosts",  ### main label 
  col = c("Chocolate", "Orange"), #colors of each plot
  horizontal = T, # turns them sideways 
  border = "brown", #this colors border of plot
  notch = T, # we want a notched box
  xlab = "Money in Dollars, ($)"
  
  
  
  
)

p2<-boxplot(college[, c("Debt", "Grad")], ### pulls the data, creates two box plots on same graph 
        main = "Box-plot of Graduation and Debt",  ### main label 
        col = c("steelblue2", "orange"), #colors of each plot
        horizontal = T, # turns them sideways 
        border = "brown", #this colors border of plot
        notch = T, # we want a notched box
        xlab = "Rate in %")

##### Outliers 

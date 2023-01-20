#how to manually import data into R
#very rare, similar to excel but I must remember where data are

#introduction to data structures in the R environment 

######new functions 
#head()
#tail()
#data.frame() 
#view()
#length(df$variable)
#rep()
#write.csv()
#rbind()
#plot()


#notes 

#hard code is stuff you need to change each time
#flexible code chnages with the data 

getwd()
setwd("/Users/aldenbutzke/Desktop/Datamining")
getwd()

rm(list=ls())

Sales<-c(38,30,65,94,31,56,36,25) #check the right number to check all numbers entered 
# ^ this is equivalent of entering 8 rows of data in excel 
Adverts<-c(1.9,2.5,2.8,5,1.5,2.3,1.5,1.1)
#need to use dataframe, it is what R views as a table 

##sales and adverts dollars in $1000s 

Org_BusDat<-data.frame(Sales, Adverts) #must set it equal to a variable 
#will give us a new variable called "Data" lists 8 observations as number of rows  variables will be columns,

# head( the data frame name, how many rows) ###### will go to top of data frame and print number of specified rows 

head(Org_BusDat, 2)

tail(Org_BusDat, 2)

length(Org_BusDat) # length will return # of columns, or "variables" in df 
length(Org_BusDat$Sales) # will retrieve how many observations are in specific variable
Org_BusDat$Sales #prints out all observations in variable sales 

# View(Org_BusDat)  ###### super useful function to see data 

#### Adding info to a df 
## Adding a new column 

#need to create repeating vector that goes from 1 through 4 and repeats twice 
Quarters<-c(1:4,1:4)
## create new column called year, the first row is the first qrtr of 2019 

# use replication function: rep(what is to be replicated, how many times)

rep(2019, 4)

Year<- c(rep(2019,4), rep(2020,4))

## create an ID column 
ID<-c(1:length(Year))
length(Year)

###create a worker column 
Workers<-c(23,25,NA,27,NA,30,25,23)

## adding qrtrs to df, taking from values and combining to data 
#can be done in mnany ways 

#preferred version 

Org_BusDat$Quarters<-Quarters

#call df, write name of new column, tell it what variable you want it to be 

##another version 

Org_BusDat[["ID"]]<-ID

#like it cuz green highlights name of column

#View(Org_BusDat)

## third version for adding data least favorite of all, never used 
Org_BusDat[, "Year"]<-Year 

Org_BusDat$Workers<-Workers

head(Org_BusDat, 3)

#change the order of the columns/variables within the df 
#anyhting in [] is row, column

datF<-Org_BusDat[,c("ID", "Year", "Quarters", "Workers", "Adverts", "Sales")]

#rm(Org_BusDat)


###add rows to current df 
#the new row must have the same number of columns as the current df 
head(datF, 2)
tail(datF,2)
Newrow<-c(9, 2021, 1, 35, 3.5, 75 )

DF<-rbind(datF, Newrow)
View(DF)


New2<-c(10, 2021, 2, 23, 2.1, 25)

DF2<-rbind(DF, New2) #could have re-saved DF as DF instead of creating new DF 

View(DF2)

rm(datF, DF)

library(tidyr)

#txt files are the cheapest way to store data 

plot(DF2$Sales~DF2$Adverts)

#write.csv(DF2, "AdvSales.csv" )
#write.table(DF2, "DatText.txt")

#install.packages("ggplot2")



# to add new row, must use rbind() to add it, will always add to the bottom on default 

#### write.csv(datF, "AdvSales.csv" ) if run again, then delete file that has been created 

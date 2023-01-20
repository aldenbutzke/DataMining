getwd()
setwd("/Users/aldenbutzke/Desktop/Datamining")
getwd()

rm(list=ls())

Jan.Feb<-read.csv("Sales-Jan-Feb-17.csv")
Mar.Apr<-read.csv("Sales-Mar-Apr-17.csv")

## get rid of register, get rid of comments and quanity units, seperate out the date
## get rid of serial number and dscription, and manufacturer, 
# split date and time, maybe split cash and card into 1 or 0 
# product ID is also not relevant 
# sold by and sold to irrelevant


Jan.Feb1<-Jan.Feb[-c(3,8:10, 13,22,24,25,26,34:36)]
Jan.Feb1<-Jan.Feb1[-c(5,20,14)]

Mar.Apr1<-Mar.Apr[-c(3,8:10, 13,22,24,25,26,34:36)]
Mar.Apr1<-Mar.Apr1[-c(5,20,14)]

names(Jan.Feb1) == names(Mar.Apr1)

FinalDF<-rbind(Jan.Feb1, Mar.Apr1)

library(dplyr)
library(lubridate)

Trial<-data.frame(datetime = mdy_hm(FinalDF$Date))

Trial$Time<-format(as.POSIXct(Trial$datetime), format = "%H:%M")
Trial$OnlyDate<-as.Date(Trial$datetime)

FinalDF$Time<-Trial$Time
FinalDF$OnlyDate<-Trial$OnlyDate


#Jan<-Jan.Feb1$Date[grepl("^01",Jan.Feb1$Date)]

Jan<-as.numeric(grepl("^01",FinalDF$Date))
FinalDF$Is.Jan<-Jan

DataJ<-FinalDF[FinalDF$Is.Jan==1,]
tail(DataJ$Date)

### above finds whether Date is Jan
## DataJ is the data when Jan = 1 

# Jan.Apr<-as.data.frame(Jan.Feb1, Mar.Apr1)

Feb<-as.numeric(grepl("^02",FinalDF$Date))
FinalDF$Is.Feb<-Feb

DataF<-FinalDF[FinalDF$Is.Feb==1,]

### above finds whether Date is Feb
## DataF is the data when Feb = 1 


Mar<-as.numeric(grepl("^03",FinalDF$Date))
FinalDF$Is.Mar<-Mar

DataM<-FinalDF[FinalDF$Is.Mar==1,]

### above finds whether Date is Mar
## DataM is the data when Mar = 1 


Apr<-as.numeric(grepl("^04",FinalDF$Date))
FinalDF$Is.Apr<-Apr

DataA<-FinalDF[FinalDF$Is.Apr==1,]

tail(DataA$Date)

### above finds whether Date is Apr
## DataA is the data when Apr = 1 

May<-as.numeric(grepl("^05",FinalDF$Date))
tail(May)

Jun<-as.numeric(grepl("^06",FinalDF$Date))
tail(Jun)

### above finds whether Date is May or Jun to understand data and confirm 

### wondering why DataJ--DataA have different lengths? 

length(names(DataJ)) == length(names(DataA))

### ahh cuz I'm adding new columns. Moviing DataJ-A down here 

DataJ<-FinalDF[FinalDF$Is.Jan==1,]
DataF<-FinalDF[FinalDF$Is.Feb==1,]
DataM<-FinalDF[FinalDF$Is.Mar==1,]

length(names(DataJ)) == length(names(DataA))

### now everything works 

Q1<- rbind(DataJ, DataF, DataM)
Q2<-DataA



## creating the quarter dataframes based on the month dataframes 


# Q1 = Jan, Feb, Mar = 1
# Q2 = Apr, May, Jun = 1 

##FinalDF$Q2<-1

###ifelse(FinalDF$Is.Jan | FinalDF$Is.Feb | FinalDF$Is.Mar == 1, 
#FinalDF$Q1<-1 & FinalDF$Q2<-0 , FinalDF$Q1<-0 & FinalDF$Q2<-1)

## trying to add quarter column with logic statements 


#write.csv(Q1, file = "Q1_2017_AldenButzke.csv")
#write.csv(Q2, file = "Q2_2017_AldenButzke.csv")

## wrote csv files of Q1 and Q2 


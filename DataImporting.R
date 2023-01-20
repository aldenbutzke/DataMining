rm(list=ls())

getwd()
setwd("/Users/aldenbutzke/Desktop/Datamining/")
getwd()


#####functions used 
#read.table() go to for txt 
#read.delim() this works for data with stuff inbetween numbers go to for txt 
#names() to find column names 
#names(df)<-c(new names)
#read_excel part of readxl package, imports excel files. can tell it to guess col types 
#reaadLines()
#grep()



### text files 
#importing data from text files or delimited files 
#delimited means there is something between them
#read.table() and read.delim()

df1<-read.delim("DataEX.txt", header = TRUE )   #important to start by storing data 
head(df1,2)


### in some cases it may be necessary to skip some data, like useless lables etc
df2<-read.delim("DataEX.txt", skip = 1, header = FALSE) #now r will skip first line 
df2
df1

###use names() to determine the names of a df columns

names(df2)

#to change names of columns, 

names(df2)<-c("Sales_ID", "N0", "Date", "Days")
df2

###read.table()

df3<-read.table("DataEX.txt", header = T, )

df3==df1


#### next common is the comma separated values or csv 


df4<-read.csv("DataEX.csv", header = T)
df4

#install.packages("readxl")

library(readxl)

dfxl<-read_excel("DataEX.xlsx", col_names = TRUE, col_types = "guess")


#### advanced, but a key skill, called "web scrapping" 

#store link 

theURL<-"http://icasualties.org/App/Fatalities?page=1&rows=0"
thepage<-readLines(theURL) ##this reads the entire page 
loc<-grep("9/14/2020", thepage) #go and replace, finds location of data. picked this value cuz its the first location of data 


thepage[loc:loc+10] #bring me the location plus the next 10 data points 
#look in the code and pull specfics 

mypattern<-"<td>([^<]*)</td>" #i want everything inside td, and want all different tupes of texts 
#whether its sub scripts, etc....

datalines<-grep(mypattern, thepage[loc:length(thepage)], value = TRUE)
#this get severy data line from when the date was observed through the page 
datalines[1]
datalines[1:2]

#now we have the data and know where it is, clean up 
getexpr= function(s,g) substring(s,g,g+attr(g, "match.length")-1) #make a function to find td and remove it 

gg= gregexpr(mypattern, datalines) #searches through stuff and only gives us what we're looking for 

matches=mapply(getexpr, datalines, gg)

result=gsub(mypattern, "\\1", matches)

names(result)<-NULL

result[1:12]

casualties<-as.data.frame(matrix(result, ncol= 12, byrow=TRUE))

hist(as.numeric(casualties$V6), main = "Casualties Age Distribution", xlab ="Age", breaks = 20, col = "red")
state<- casualties$V11
StateFreq<-table(state)
StateFreq

barplot(StateFreq, xaxt="n")


#labs<-names(StateFreq)
#text(cex=1, x=x-.25, y=-100.25, labs, xdp=TRUE, srt=90)

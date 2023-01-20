rm(list=ls())

getwd()

theurl<- "https://finance.yahoo.com/quote/%5EDJI/history?period1=694310400&period2=1644451200&interval=1d&filter=history&frequency=1d&includeAdjustedClose=true"
financepage<-readLines(theurl)
location<-grep("Feb 09, 2022", financepage) #find in page code for data starts 

financepage[location:location+7] #how should I pick location 

mypattern<-"<td>([^<]*)</td>" #where do I find what to search between 

datalines<-grep(mypattern, financepage[location:length(financepage)], value = TRUE)

datalines[]#finding only NAs




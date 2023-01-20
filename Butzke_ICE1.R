getwd()
setwd("/Users/aldenbutzke/Desktop/Datamining")
getwd()

library(lubridate)
library(svDialogs)
rm(list = ls())

user_input <- dlgInput("Enter your Birthday mm/dd/yyyy", Sys.info()["user"])$res
user_input<-mdy(user_input)

origin_year<-as.numeric(year(user_input))
origin_month<-as.numeric(month(user_input))
origin_day<-as.numeric(day(user_input))

dayofweek<-weekdays(as.Date(user_input))

print(paste0("You were born on a ", dayofweek))

origin_date<-Sys.Date()

difference<-julian(origin_date, user_input) #returns difference in days 

diff_days<-as.numeric(difference)
diff_weeks<- as.numeric(difference/7)
diff_years<-as.numeric(difference/364.25)


user_input1<- dlgInput(" Enter 1 for Years old, 2 for Weeks old, and 3 for Days old. ", Sys.info()["user"])$res

ifelse(as.numeric(user_input1) == 1, print(paste0("You are ", round(diff_years), " years old.")), 
         ifelse(as.numeric(user_input1) == 2, print(paste0("You are ", round(diff_weeks), " weeks old.")),
            print(paste0("You are ", diff_days, " days old" ))))

#{if(as.numeric(user_input1) == 2) {print(paste0("You are ", round(diff_weeks), " weeks old."))}

#if(as.numeric(user_input1) == 1) {print(paste0("You are ", round(diff_years), " years old"))}

#else {print(paste0("You are ", diff_days, " days old."))}}
                                                      




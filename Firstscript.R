# List of functions for R 

# right of pound symbol = comments, not code 

#FUNCTIONS USED 1/25/2022 
#getwd() gives current working directory 
#setwd() sets current working directory 
#print() tells console to print what's inside as text 


#NOTES 1/25/2022
#can use x<-value to set variables. these variables can be whole data sets 
#use comments to remember what you're doing in order to remember what values 
#are stored VERY IMPORTANT!! 
#can do computations inside a print function 
# = can be used o set data, but should only use it for conditional statements 
#ie, when y = 10.....
#use broom on environment to delete all stored variables 
#use help tab for finding functions 



getwd() #this function returns the working directory 
setwd("/Users/aldenbutzke/Desktop/Datamining/")
getwd()

#control + return executes one line of code at a time

print("I am coding")


x<-47+27*43-12 # the symbol <- is called set where "y<-10" means y = 10
x
y<-x-96
y

print(x)

# f<-a+25 these codes contain an error, because a needs to be defined first!
# a<-10 returns "object 'a' not found" will define a, but will not define f 
# if ran again, since a is now defined, f will be defined 

a<-10 #correct way to order the code 
f<-a+25

rm(list=ls()) ### really important code bc it clears the environment ###

x=2
y=101
z=200

Varsum<- x+y+z #this adds all variables 
ls() #this lists all variables currently stored 


rm(z) #removes variable (z) from the environment 

print(paste0("The Varsum is: ", Varsum)) #don't need to store print or paste functions 

###most common error is disorder, proper order is top to bottom, left to right 

a<-2
b<-100
c<-20
VarTum<-a+b+c #returns non-numeric argument because c isn't defined 
##c<- will work once ran once, but needs to move above line 20 to source on save 

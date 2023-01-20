## Operators Logical 

# < means less than 
# <= means less than or equal to 
# >= means greater than or equal to 
# == means exactly equal 
# != means not equal to 
# x | y means or 
# x & y means and 

x<- c(1:10) # colon means "through" 
y<- x <= 5 #applies this statement to each of the numbers 
z<- as.numeric(y)
k<- z*x


# combine the code above 
l<- (x<=5)*x


### define twp vectors 
a<- c(1:10)
b<-c(5:14)


print(paste0("The Length of a is ", length(a)))
print((paste0("The Length of b is ", length(b))))
print(paste0("Are a and b the same length? ", length(a) == length(b)))


# there is a function called all(), it checks if output is all TRUE 
# any() checks to see if any are true 
all(a<b)
any(a<b) 

x<- c(10:1)
y<- c(-4:5)
x<y
any(x<y)
all(x<y)

q<- c("ski poles", "skis", "ski jacket", "ski jacket", "ski boots", "snowboard") #saves as chr, which means character 

#sqaure brackets allow you to access specific point in data. goes, rows then columns 
q[4]
q[4:6]
q[c(4:6)]

#can use this to find locations in the data, like where there is a profit

#factorization, we assign a key of numbers tp text/types of categorizes where repsones = unqiue values 
q<-as.factor(q)
print(q)

q<-as.numeric(as.factor(q))

#useful to tally an amount of respones, for a histogram 

hist(q)

c(One="1", Two="2", Three="3")

df<-data.frame(CL1=c(1:10), CL2=c(10:1), CL3=c(11:20))
df["CL1"]

# missing data 
# comes with NA 

v<-c(1,10, NA, 8.1, NA, 14, 10)

#check for missing data, you are really checking for NAs 
is.na(v)
any(is.na(v))
mean(v, na.rm = TRUE) #na.rm is option to remove NAs from data 

?mean

#arguments are the main inputs it's expecting, 
#value shows what it expects 
#examples usually exist at the bottom 
#see also shows new functions that are related 

#how to count number of missing values 

sum(is.na(v))

#installs package, and argument dependencies also installs anything it may use 
#install.packages("dplyr", dependencies = TRUE)
#install.packages("magrittr", dependencies = TRUE)

### advanced R coding "pipes" or "piping

#initialize vector x 

x<-c(0.109,0.359,0.63,0.993,0.515,0.142,0.017,0.829,0.907)
#logarithm of x, return suitability lagged, iterated differences, 
#compute the exponential function, round the results to 1 decimal
#round(exp(diff(log(x))),1)
round(exp(diff(log(x))),1)

library(magrittr) #will noramlly get warning, run it twice and will gp away
library(dplyr)

# piping operator  %>% 
#says take the output of what's on the left and send it into what's on the right

x %>% log() %>% diff() %>%  exp() %>% round(1)


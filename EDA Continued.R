getwd()
setwd("/Users/aldenbutzke/Desktop/Datamining")
getwd()

library(readxl)

rm(list=ls())

College<-read.csv("College.csv")

pairs(College[,c(3,6)])
pairs(College[,2:3])


###### violin plot 
## basically just a different box plot 

# install.packages("vioplot", dependencies = T)
#install.packages("zoo", dependencies = T)
#install.packages("sm", dependencies = T)

library(vioplot)
library(sm)
library(zoo)

### this is how to look for specifc cases within a column based on another column 
# get cost column values when the city column value is 0 

x0<-College$Cost[College$City==0]
x1<-College$Cost[College$City==1]

## to isolate all columns based on another column, 
# then remove the column call before sqaure brackets 

# we want to isolate all rows where the city variable is 1 
y1<-College[College$City==1 , ]
y2<-College[College$City==1 , c(3,5)]

vioplot(x0,x1,
        names = c("City=0", "City=1"),
        main = "vioplot",
        col = "gold",
        xlab = "0 = rural, 1=urban",
        ylab = "Cost of college")
abline(h=15000, col="red")


# bottom is the minimum, 
# the box is not the mediam
# the shape of the violin is the accumulation of the data 
# in this plot, rural area has less obs in the middle and the city 
# more obs as you get higher 


# the ~ is running regression 
plot(College$Cost~College$Debt, type="p", ylab = "Cost of College", 
     xlab="Debt Rates in %") 

#   install.packages("aplpack", dependencies = TRUE)
#   library(aplpack)
#    b1<-aplpack::bagplot(College$Debt, College$Cost, xlab="Debt Rate", 
                    # ylab="Cost of College", main = "cost vs debt")

# can use to find outliers and the location fo outliers 
# b1$pxy.outlier

College$School[College$Debt==67 & College$Cost == 31293]

setwd("/Users/aldenbutzke/Desktop/Datamining")
getwd()
library(readxl)

Growth<- read_xlsx("EDA_Data.xlsx", sheet = "Growth_Value")
head(Growth, 4)

Growth$Value

mi<-min(Growth$Value)
ma<-max(Growth$Value)
R<- ma- mi

###returns the minimum and maximum 
R1<-range(Growth$Value)

R1

##accessing output, 
R1[1]
R1[2]

#### padding means filling in missing data, or creating additonal columns
## to combine  with other data 

### seq() is key function bc it allows you to create an iterater 
### cut() extremely useful bc it matches data to what you specify 

seq( min, max, by = iterator)

intervals<-seq(-50, 50, by = 5)
seq(0, 100, by=2.5)
cuts<-cut(Growth$Value, intervals, left = FALSE, right = TRUE)
cuts
cut.freq<-table(cuts)
cut.freq
View(cut.freq)

### now we create a visual 

library(ggplot2)

#ggplot(cut.freq)

barplot(cut.freq,
        main = "Histogram for annual returns for Value Fund (in %)",
        xlab = "Annual Returns (in %)",
        ylab = "Count",
        col = "steelblue2",
        cex.names = 0.5
        
        
        
        
        )
abline(h=0)

Promotion<- read_xlsx("EDA_Data.xlsx", sheet = "Marketing_Promo")
head(Promotion, 6)


#### contingency table , count of two variables at the same time 

ConTable<-table(Promotion$Purchase, Promotion$Region)
ConTable


##### converts our table into decimals/percentages/probabilities 

p<-prop.table(ConTable)
p

### generate a visual of our two dimensional contingency table 

barplot(ConTable,
        main = "Region and Purchase", col = c("blue", "red", "gray", "green"),
       legend=rownames(ConTable), 
        ylim = c(0,200),
        
         xlab = "Location",
        ylab = "Count",
  
  )
abline(h=0)

#### scatter plot 

plot(Growth$Value~Growth$Growth, #this tidle says what's before it = y, "run y against x"
     main = "Scatterplot of Value vs Growth",
     xlab= "Growth",
     ylab = "Value",
     col = "Chocolate",
     pch=19
     
     ) 
abline(h=0, v=0)


#### stacking the plot 

x<- 1:100 ## create a vector 
fy<- 10 +10*x #linear function 
gy<-0.2*x^2  #non-linear function, parabola 

### now we want to plot both fy and gy 

####### primary conditon = x must be the same size, same value to plot,
###### all dimensions must match 

plot(x, fy, col="red", type = "o", xlim=c(0,40), ylim = c(0,200),
     ylab = "Y", xlab = "X") ### type gives type of line, dots or line 

lines(x, gy, col = "blue") ## have to make changes to labels, etc on first plot, not line


#### new data and plot 
Birth<-read_xlsx("EDA_Data.xlsx", sheet = "Life_Expectancy")
head(Birth,3)

plot(Birth$`Birth Rate`~Birth$`Life Exp`, 
     main = "Scatterplot of Birth vs Life Expectancy",
     xlab= "Life Expectancy, Years",
     ylab="Birthrate, in %",
     pch=16,
     col= ifelse(Birth$Development == "Developing", "gray", "red"
     )
##### regression in one line  of code 

plot( Birth$`Life Exp`, Birth$`Birth Rate`, 
     main = "Scatterplot of Birth vs Life Expectancy",
     xlab= "Life Expectancy, Years",
     ylab="Birthrate, in %",
     pch=16,
     col= ifelse(Birth$Development == "Developing", "gray", "red"
     )

     
### line plots, common in business 
plot(Growth$Growth~Growth$Year,
     col="blue", 
     type="l") ## tells it is a line
lines(Growth$Value~Growth$Year, 
      col= "red", 
      type="l")     
abline(h=0)     
legend("bottom", legend = c("growth", "Value"), 
       col = c("blue", "Red"), lty = 1)

### gives you every summary stat for every column 
summary(Growth)



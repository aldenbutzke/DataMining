getwd()
setwd("/Users/aldenbutzke/Desktop/Datamining")
getwd()

rm(list=ls())

library(readxl)
library(dplyr)
library(tidyr)
library(ggplot2)

x<-read_excel("EDA6DATA.xlsx", sheet = "TShirts")
head(x)
#CT<-table(x$Size, x$Color)
#CT1<-table(x$Size, x$Quantity)
#head(CT)
#Ct<-as.data.frame(CT)
#CT
#Ct
#Ct1<-as.data.frame(CT1)
#CT1
#CT
#Ct$"Sum Sizes"<-rowsum(CT, )

## messing around with piping in code after talking w friends in class 

QuanSold<-x %>% group_by(Size, Color) %>% 
  summarise(Quantity_Sold = sum(Quantity), .groups = NULL) %>% 
  spread(key = Size, value = Quantity_Sold)

#matrix to table 
#QSold

QSold<-as.matrix(QuanSold)

QSoldTShirts<-as.table(QSold)

print(paste0("There were ", QSoldTShirts[4,3], " medium red shirts sold", "  and there were ", 
             QSoldTShirts[3,5], " XL purple shirts sold"))


X<-QSold[,1]
NumQMatrix<-QSold[,-1]

NumQMatrix <- apply(NumQMatrix, 2, as.numeric)

rownames(NumQMatrix)<- X
head(NumQMatrix)

Heatmap1<-heatmap(as.matrix(NumQMatrix), scale = "column", Colv = NA, Rowv = NA)

#####  HD and LOWES

HDLowes<-read_xlsx("EDA6Data.xlsx", sheet = "HDLowes")

head(HDLowes)

library(fBasics)

HDStats<-round(basicStats(HDLowes$HD), 2)
LowesStats<-round(basicStats(HDLowes$`Lowe's`), 2)

HDMean<-HDStats$X..HDLowes.HD[7]

LowesMean<-LowesStats$X..HDLowes..Lowe.s.[7]


print(paste0("Home Depot had a higher average revenue at $", HDMean, " compared to Lowes at $", LowesMean, ""))


boxHDLowes<-boxplot(HDLowes[,c("HD", "Lowe's")],
                    main = "Box-Plot of Revenue and Years",
                    col = c("orange", "blue4"),
                    horizontal = TRUE,
                    border = "brown",
                    xlab = "Revenue in Dollars ($)")

print(paste0( "There is an outlier in the Lowe's data at $", max(HDLowes$`Lowe's`), " in 2018"))


line1<-plot(HDLowes$HD~HDLowes$Year, main = "Home Depot and Lowe's Revenue",ylab = "Revenue in $", xlab = "Year", 
            col  = "firebrick2", 
            type = "l", 
            ylim = c(0,100905), lwd = 2.5) 
lines(HDLowes$`Lowe's`~ HDLowes$'Year', 
      col = "pink", 
      type= "l", lwd=2) 
abline(h=0) #
legend("bottom", 
       legend = c("Home Depot", "Lowes"), 
       col = c("firebrick2", "pink"), 
       lty = 1) 

###Varaince and STD Dev and Printing Stats

HDVariance<-HDStats$X..HDLowes.HD[13]

LowesVariance<-LowesStats$X..HDLowes..Lowe.s.[13]

print(paste0("Home Depot's variance is: ", HDVariance,  " and Lowes's variance is: ", LowesVariance))

HDsd<-round(sd(HDLowes$HD),2)

LowesSD<-round(sd(HDLowes$`Lowe's`),2)

print(paste0("Home Depot's standard deviation is ", HDsd, " and Lowes' standard deciation is ", 
             LowesSD, "."," Home Depot had more dispersion"))

print(HDStats)
print(LowesStats)

##### PRIME  

Prime<-read_xlsx("EDA6Data.xlsx", sheet = "Prime")

Primebox<-boxplot(Prime$Expenditures, main = "Expenditures in Dollars ($)",col = "steelblue2",horizontal = TRUE,
                  border = "brown", 
                  notch = TRUE) 


PStats<-basicStats(Prime$Expenditures)        

PMean<-PStats$X..Prime.Expenditures[7]


Summ<-summary(Prime$Expenditures)
Summ

Q1=as.numeric(Summ[2])
Q3=as.numeric(Summ[5])
IQR=Q3-Q1
LL=Q1-1.5*IQR
UL=Q3+1.5*IQR

max(Prime$Expenditures) < UL
min(Prime$Expenditures) > LL

if (max(Prime$Expenditures) < UL) {print(paste0("The box-plot does not indicate that outliers are present"))}

if (min(Prime$Expenditures) > LL) {print(paste0("There are no outliers present in the Expenditures variable"))}

print(paste0("The mean of the Expenditures observed is: $", PMean))

####### MIllenials 

Millenials<-read_xlsx("EDA6Data.xlsx", sheet = "Millennials")

head(Millenials)

MF<-table(Millenials$Faith)

print(paste0("The most common response to the survey is Not Religous with ", (max(MF)/sum(MF)*100), "% of the responses"))

barplot(MF, main = "Reponses to Survey", col = c("red", "blue", "green", "orange"), ylim = c(0,250))
abline(h=0)


print(paste0("The results appear to be in line beacuse ", (max(MF)/sum(MF)*100), "% Not Religious is the same as found by PEW"))


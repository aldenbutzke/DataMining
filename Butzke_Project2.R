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

###### above is part 1 

Is.Wine<-as.numeric(grepl("Wine", FinalDF$Category))

FinalDF$Is.Wine<-Is.Wine

WineData<-FinalDF[FinalDF$Is.Wine==1,]

#names(WineCat) 

WineData$Category<-c(sub("Wine > ", "", WineData$Category))

#View(WineData)

WineCat<-as.data.frame(table(WineData$Category))


ItemIDAgg<-WineData %>%
  group_by(Item.Id) %>%
 summarise(TotalMarginProfit= sum(Profit), TotalCOG = sum(Cost.Of.Goods.Sold), TotalSales= sum(Subtotal))

ItemIDAgg$Margin.Profit.Sales<- round((ItemIDAgg$TotalSales - ItemIDAgg$TotalCOG) / ItemIDAgg$TotalSales, 2)
ItemIDAgg$Margin.Profit.COG<- round((ItemIDAgg$TotalSales - ItemIDAgg$TotalCOG) / ItemIDAgg$TotalCOG, 2)


### above groups Wine by ID and creates profit column

#ItemIDAgg2<-aggregate(cbind(Subtotal, Cost.Of.Goods.Sold) ~Item.Id, WineData, sum)

#aggregate(WineData$Subtotal, by=list(WineData$Item.Id), FUN=sum)

### two alterative ways to find values 

CatAgg<-WineData %>%
  group_by(WineData$Category) %>%
  summarise(TotalMarginProfit= sum(Profit), TotalCOG = sum(Cost.Of.Goods.Sold), TotalSales= sum(Subtotal))

CatAgg$Margin.Profit.Sales<-round((CatAgg$TotalSales - CatAgg$TotalCOG) / CatAgg$TotalSales, 4)
CatAgg$Margin.Profit.COG<-round((CatAgg$TotalSales - CatAgg$TotalCOG) / CatAgg$TotalCOG, 4)




#### above sorts wine data by category 




#CatAggALL<-FinalDF %>%
#  group_by(FinalDF$Category) %>%
 # summarise(TotalProfit= sum(Profit), TotalCOG = sum(Cost.Of.Goods.Sold), TotalSales=sum(Subtotal))

#CatAggALL$Profit2<-round((CatAggALL$TotalSales - CatAggALL$TotalCOG) / CatAggALL$TotalSales, 2)
#CatAggALL$Profit3<-round((CatAggALL$TotalSales - CatAggALL$TotalCOG) / CatAggALL$TotalCOG, 2)


####3 above aggregates profit for all products sorted by category 


#IDAggALL<-FinalDF %>%
 # group_by(FinalDF$Item.Id) %>%
 # summarise(TotalProfit= sum(Profit), TotalCOG = sum(Cost.Of.Goods.Sold), TotalSales=sum(Subtotal))

#IDAggALL$Profit2<-round((IDAggALL$TotalSales - IDAggALL$TotalCOG) / IDAggALL$TotalSales, 2)
#IDAggALL$Profit3<-round((IDAggALL$TotalSales - IDAggALL$TotalCOG) / IDAggALL$TotalCOG, 2)



### above aggregates profit for all items by category 

##### above is not necessary for the assignment 

#FinalDF %>% filter(Item.Id == "2002")
 
library(RColorBrewer)

n <- 60
qual_col_pals = brewer.pal.info[brewer.pal.info$category == 'qual',]
col_vector = unlist(mapply(brewer.pal, qual_col_pals$maxcolors, rownames(qual_col_pals)))
#pie(rep(1,n), col=sample(col_vector, n))

### creates vector of colors 

library(dplyr)
library(tidyr)
library(ggplot2)

#d <- structure(list(author = structure(c(1L, 2L, 4L, 3L, 5L, 6L), 
          #.Label = c("Bahr et al", "Fuller et al", "Garbossa et al", "Gokhale et al", "Iuchi et al", "Lee et al"),
         # class = "factor"), nAE = c(22L, 34L, 158L, 90L, 70L, 41L), AE = c(3L, 1L, 7L, 1L, 3L, 10L), 
         # SAE = c(0L, 1L, 0L, 0L, 0L, 0L)), 
         # .Names = c("author", "nAE", "AE", "SAE"), class = "data.frame", row.names = c(NA, -6L))

#categories <- c("Adverse Effect", "No adverse effects", "Severe side effects")
#cols <- c("#E61515", "#105415", "#5121E0")

#d %>% 
 # gather(key, value, -author) %>% 
  #ggplot(aes(author, value, fill = key)) +
  #geom_col() + 
  #coord_flip() +
  #theme_bw() +
  #theme(legend.position = "top") +
  #scale_fill_manual(labels = categories, values = cols) +
  #labs(fill = "Authors")


Top10ID<- ItemIDAgg %>% top_n(10)

Top10Cat<-CatAgg %>% top_n(10)

Bot10Cat<-CatAgg %>% top_n(-10)

Bot10ID<- ItemIDAgg %>% top_n(-10)
### separates out the top ten wines by Marginal profit/COG


names(CatAgg)[1]<-"Category"
names(Top10Cat)[1]<-"Category"
names(Bot10Cat)[1]<-"Category"



## renames column 1

#Top10CatNamesandMargin<-cbind(Top10Cat$Category, Top10Cat$Margin.Profit.COG)

#Top10IDnamesandmargin<-cbind(Top10ID$Item.Id, Top10ID$Margin.Profit.COG)



big<-rbind.data.frame(Bot10Cat, Top10Cat)

big.a<-big[order(big$Margin.Profit.COG),]

big1<-rbind.data.frame(Bot10ID, Top10ID)

big1.a<-big1[order(big1$Margin.Profit.COG),]

## creates dataframe with ten highest adn ten lowest marginal profit / cog 

barplot(big.a$Margin.Profit.COG,
        main = "MarginProfit vs COG per Wine Type",
        las = 2, cex.names = 0.8, names.arg = big.a$Category,
       ylab = "Marginal Profit", ylim = c(-0.2,0.5),
        col=ifelse(big$Margin.Profit.COG>0.3816, brewer.pal(Top10Cat$Category,"Greens"), brewer.pal(Bot10Cat$Category,"Reds")))
abline(h=-.222)
abline(v=12.1)
#axis(side=2, at=seq(-0.2,0.5, by =0.05))
legend("bottomright", legend = c("Reds = Bottom Ten Wines", "Greens = Top Ten Wines"))


### graphs 10 highest and 10 lowest wines in acsending order, red colors are lowest/
### and green colors are highest performer. abline divides them in the middle

#barplot(as.matrix(Top10IDnamesandmargin))



#barplot(Top10ID$, horiz = T, col = rainbow(length(row.names(Top10ID))) )

library(ggplot2)

#bp<-ggplot(data = Top10Cat, aes(x=reorder(Category, -TotalSales), y=TotalSales), fill = Category)
#y<- bp+ geom_bar(stat = "identity", color="black") + ggtitle("Amount of Wine Sold")
#z<- y+  theme_gray() + coord_flip()
#Z<-z  + scale_y_continuous(breaks = seq(0, 10000, by = 1000))
#bp

#barplot(big$Margin.Profit.COG,
      #  main = "MarginCOG per Wine Type",
      #  las = 2, cex.names = 0.5, names.arg = big$Category,
      #  col=ifelse(big$Margin.Profit.COG>0.3816, brewer.pal(Top10Cat$Category,"Greens"), brewer.pal(Bot10Cat$Category,"Reds")))
#abline(h=0)

print(paste0("The top 10 wines with the highest Marginal Profit/Cost of Goods are ", list(Top10Cat$Category) ))
print(paste0("The bottom 10 wines with the lowest Marginal Profit/Cost of Goods are ", list(Bot10Cat$Category) ))

print("These measures are a good representation of the data because they show that\
most of the wine categories are very close performers when it comes to relating profit\
to costs. It further shows that the Sherry Port lost money for some reason, and it\
indicates that the White-Rose may be something to hold less of during these months.\
The owners could hold and stock more green items during Q1 and less red to optimize invesntory.")
#### prints a list of the ten highest and ten lowerst marginal profit / cog wines


#plot(Top10Cat$TotalCOG, 
    # Top10Cat$TotalSales, col= ifelse(Top10Cat$TotalSales > mean(Top10Cat$TotalSales), "blue", "red"),
  #   xlab = "Cost of Good Per product",
  #   ylab = "Sales Per Product",
  #   lines(Top10Cat$TotalSales~Top10Cat$TotalCOG)
 #    )


#plot(Top10ID$TotalCOG, 
     #Top10ID$TotalSales, col= ifelse(Top10ID$TotalSales > mean(Top10ID$TotalSales), "blue", "red"),
    # xlab = "Cost of Good Per product",
    # ylab = "Sales Per Product",
   #  lines(Top10ID$TotalSales~Top10ID$TotalCOG)
     
     
#)

#lm(Top10Cat$TotalSales~Top10Cat$Margin.Profit.COG)

#Top10Cat %>%
 # gather(key,value,-Category) %>%
 # ggplot(aes(Category, value, fill= key)) +
  #geom_col()+
  #coord_flip() +
  #theme_bw() +
  #theme(legend.position = "top") +
  #scale_fill_manual(labels = Top10Cat$Category, values = cols) +
  #labs(fill = Category)

barplot(big1.a$Margin.Profit.COG,
        main = "MarginProfit vs COG per Wine-Item",
        las = 2, cex.names = 1.2, names.arg = big1.a$Item.Id,
        ylab = "Marginal Profit",
        col=ifelse(big1$Margin.Profit.COG>0, brewer.pal(Top10ID$Item.Id,"Blues"), brewer.pal(Bot10ID$Item.Id,"Oranges")))
abline(h=-1.1)
abline(v=13.22)
legend("bottomright", legend = c("Oranges = Bottom Ten Wine-Items", "Blues = Top Ten Wine-Items"))

print(paste0("The top 10 wine-items with the highest Marginal Profit/Cost of Goods are ", list(Top10ID$Item.Id) ))
print(paste0("The bottom 10 wine-items with the lowest Marginal Profit/Cost of Goods are ", list(Bot10ID$Item.Id )))

print("These measures are a good representation of the data because they show that\
there are 11 products that lost money or broke even. It further shows that Item 829\
made 100% of its costs, and item 2002 was just its costs.\
This indicates that there is something unusual going on with the data due to these anomolies\
It may be a data entry problem, or something else if the numbers are correct.")

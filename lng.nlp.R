setwd("/Users/ALDBUT/Desktop/")

library(readxl)
library(stringr)

library(corpus)

library(tidyverse)

library(tidytext)

library(dplyr)

library(tm)

library(quanteda)
library(SnowballC)

#install.packages("pdftools")
library(pdftools)
library("wordcloud")
library("RColorBrewer")
library("syuzhet")


df<- pdf_text("/Users/ALDBUT/Desktop/LNG-Industry-Magazine-Alaska-LNG-June-2022.pdf")
print(df)
  
df<-removePunctuation( df)
df<-removeNumbers( df)
df<-tolower( df)
df<-stem_snowball(df)
df<-str_replace( df, "\n", " " )

corp <- Corpus(URISource("LNG-Industry-Magazine-Alaska-LNG-June-2022.pdf"),
               readerControl = list(reader = readPDF))

opinions.tdm <- TermDocumentMatrix(corp, 
                                   control = 
                                     list(removePunctuation = TRUE,
                                          stopwords = TRUE,
                                          tolower = TRUE,
                                          stemming = TRUE,
                                          removeNumbers = TRUE))
inspect(opinions.tdm[1:10,])

corp <- tm_map(corp, removePunctuation, ucp = TRUE)
corp <- tm_map(corp, stripWhitespace)
corp <- tm_map(corp, removeWords, stopwords("english"))
corp <- tm_map(corp, removeWords, c("the", "also", "report")) 



opinions.tdm <- TermDocumentMatrix(corp, 
                                   control = 
                                     list(
                                          stopwords = TRUE,
                                          tolower = TRUE,
                                          stemming = TRUE,
                                          removeNumbers = TRUE))
inspect(opinions.tdm[1:10,])

findFreqTerms(opinions.tdm, lowfreq = 10, highfreq = Inf)

ft <- findFreqTerms(opinions.tdm, lowfreq = 10, highfreq = Inf)
as.matrix(opinions.tdm[ft,]) 

ft.tdm <- as.matrix(opinions.tdm[ft,])
sort(apply(ft.tdm, 1, sum), decreasing = TRUE)

TextDoc_dtm <- TermDocumentMatrix(corp)
dtm_m <- as.matrix(TextDoc_dtm)

dtm_v <- sort(rowSums(dtm_m),decreasing=TRUE)
dtm_d <- data.frame(word = names(dtm_v),freq=dtm_v)

barplot(dtm_d[1:5,]$freq, las = 2, names.arg = dtm_d[1:5,]$word,
        col ="steelblue", main ="Top 5 most frequent words",
        ylab = "Word frequencies")

set.seed(1234)
wordcloud(words = dtm_d$word, freq = dtm_d$freq, min.freq = 5,
          max.words=100, random.order=FALSE, rot.per=0.40, 
          colors=brewer.pal(8, "Dark2"))

findAssocs(TextDoc_dtm, terms = c("lng","Alaska","gas"), corlimit = 0)			
findAssocs(TextDoc_dtm, 
           terms = findFreqTerms(TextDoc_dtm, lowfreq = 50), corlimit = 0.25)

#syuzhet_vector <- get_sentiment(corp, method="syuzhet")
 #          head(syuzhet_vector)
#summary(syuzhet_vector)           
#bing_vector <- get_sentiment(corp, method="bing")
d<-get_nrc_sentiment(dtm_d$word)

#transpose
td<-data.frame(t(d))
#The function rowSums computes column sums across rows for each level of a grouping variable.
td_new <- data.frame(rowSums(td[2:253]))
#Transformation and cleaning
names(td_new)[1] <- "count"
td_new <- cbind("sentiment" = rownames(td_new), td_new)
rownames(td_new) <- NULL
td_new2<-td_new[1:8,]
#Plot One - count of words associated with each sentiment
quickplot(sentiment, data=td_new2, weight=count, geom="bar", fill=sentiment, ylab="count")+ggtitle("Report Sentiments")

barplot(
  sort(colSums(prop.table(d[, 1:8]))), 
  horiz = TRUE, 
  cex.names = 0.7, 
  las = 1, 
  main = "Emotions in Text", xlab="Percentage", 
  col = "steelblue"
)

neg<-sum(d$negative)
pos<-sum(d$positive)
nprT<-pos/(neg+pos)

### References 
# https://www.red-gate.com/simple-talk/databases/sql-server/bi-sql-server/text-mining-and-sentiment-analysis-with-r/
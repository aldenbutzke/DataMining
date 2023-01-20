rm(list=ls())
x<- seq(-10,10, by = .1)
y<- dnorm(x, mean = 2.5, sd=0.5)
plot(x,y)
z<-as.data.frame(x,y)
hist(y)
library(tidyverse)
z<-as.data.frame(cbind(x,y))


ggplot(data=z,aes(x,y)) + 
  geom_point(alpha = 0.5, size = 3, col="fire brick")
  
 install.packages("cowplot")
 p1 <- ggplot(data = data.frame(x = c(-3, 3)), aes(x)) +
   stat_function(fun = dnorm, n = 101, args = list(mean = 0, sd = 1)) + ylab("") +
   scale_y_continuous(breaks = NULL)
 p1
  
 p2 <- ggplot(data = data.frame(x = c(-3, 3)), aes((x), col="violetred2", lwd=1.5)) +
   stat_function(fun = dnorm, n = 101, args = list(mean = 0, sd = 1)) + ylab("") +
   scale_y_continuous(breaks = NULL)+
   theme_dark()
   
 
 p2 
 
 
  ggplot(x, aes( x = max.DrawD, y = cum.Return, label = Symbol)) +
    scale_y_continuous(breaks = c(seq(0, 10, 1)), limits = c(0,10)) + # outliers excluded
    scale_x_continuous(limit =c(0, 0.5)) +
    geom_histogram(aes(y = ..density..), binwidth = 0.02) +
    geom_text(size = 3) +
    stat_function(fun = dnorm, args = list(mean = mean(x$max.DrawD), sd = sd(x$max.DrawD)), colour = 'firebrick') +
    theme_classic()

MyChart

hist_with_density = function(data, func, start = NULL){
  # load libraries
  library(VGAM); library(fitdistrplus); library(ggplot2)
  
  # fit density to data
  fit   = fitdist(data, func, start = start)
  args  = as.list(fit$estimate)
  dfunc = match.fun(paste('d', func, sep = ''))
  
  # plot histogram, empirical and fitted densities
  p0 = qplot(data, geom = 'blank') +
    geom_line(aes(y = ..density..,colour = 'Empirical'),stat = 'density') +
    stat_function(fun = dfunc, args = args, aes(colour = func))  +
    geom_histogram(aes(y = ..density..), alpha = 0.4) +
    scale_colour_manual(name = '', values = c('red', 'blue')) + 
    opts(legend.position = 'top', legend.direction = 'horizontal')
  return(p0)  
p0  

data1 = sample(10:50,1000,rep=TRUE)
(hist_with_density(data1, 'gumbel', start = list(location = 0, scale = 1)))

data2 = rnorm(1000, 2, 1)
(hist_with_density(data2, 'norm'))


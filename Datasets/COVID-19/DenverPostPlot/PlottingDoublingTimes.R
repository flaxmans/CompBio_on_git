rm(list = ls())
# import:
setwd("~/compbio/CompBio_on_git/Datasets/COVID-19/DenverPostPlot/")
dpp <- read.csv( file = "RevisedData.csv", stringsAsFactors = F)
# convert date from char to date:
dpp$Date <- as.Date( dpp$Date, format = "%m/%d/%y" )
# I'm going to change the names slightly to make it easier to parse later ...
names(dpp)[2:3] <- c("Daily_Cases", "Daily_Deaths")
str(dpp)
head(dpp)

#############################################
## 1. Calculations of cumulative totals
#############################################

# need some new variables created for the cumulative counts.  
Total_Cases <- 1:nrow(dpp)
Total_Deaths <- 1:nrow(dpp)
for ( day in 1:(nrow(dpp)) ) {
  Total_Cases[day] <- sum(dpp$Daily_Cases[1:day])
  Total_Deaths[day] <- sum(dpp$Daily_Deaths[1:day])
}
dppWide <- cbind(dpp, Total_Cases, Total_Deaths)

###########################################################
## 2. Plotting cases with doubling time reference lines
###########################################################

thresh <- 25 # Pick a base number to start with; what's the total on day 0
# Subset data to have only those starting when the threshold was exceeded:
dataToPlot <- subset( dppWide, Total_Cases >= thresh )
# Make a new vector of "days since" reaching the threshold:
daysSince <- 0:(nrow(dataToPlot)-1)
dataToPlot <- cbind(dataToPlot, daysSince)
# What the actual total was on the first day exceeding the threshold:
init <- min(dataToPlot$Total_Cases)

# Here's a function to plot doubling reference lines:
doublingFunction <- function( t, period, init ) {
  return( init * ( 2^(t / period) ) )
  # t is time in days, period is doubling time in days
  # init is the starting abundance.
  # The sytax is set up in the way wanted by ggplot's stat_function(), 
  # where the first argument is the x-axis aesthetic
}


# building a plot:
require(ggplot2)
# first the data:
p <- ggplot( data = dataToPlot, aes( x = daysSince ) ) + 
  geom_line( mapping = aes( y = Total_Cases ) )
periods <- 2:7 # vector of days between doubling
# using a loop to sequentially add reference lines:
for ( i in 1:length(periods)) {
  period <- periods[i]
  p <- p + stat_function( fun = doublingFunction, 
                          args = list(period, init), 
                          linetype = "dashed")
}
# rescaling and adding labels:
p + scale_y_continuous( trans = "log10", 
                        limits = c(init, max(Total_Cases)) ) + 
  theme_bw() + 
  labs( x = paste("Days since ", thresh, "th case", sep = ""), y = "Total cases" )
  

############################################
## 3. Making generalizable functions
############################################

# Functions for adding doubling time reference lines to an existing plot:
source("../DoublingTimePlotFunctions.R")
  
# Some example calls:
doublingTimePlot( dppWide$Total_Cases, 25, c(2:7, 14, 30, 60), "case", "State of Colorado")  
doublingTimePlot( dppWide$Total_Deaths, 25, c(seq(3, 11, 2), 14, 30, 60), "death", "State of Colorado")  
  


                                                                
rm(list = ls())
# import:
dpp <- read.csv( file = "~/compbio/CompBio_on_git/Datasets/COVID-19/DenverPostPlot/RevisedData.csv", stringsAsFactors = F)
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
startVal <- min(dataToPlot$Total_Cases)

# Here's a function to plot doubling reference lines:
doublingFunction <- function( x, period, init ) {
  init * ( 2^(x / period) )
  # x is time in days, period is doubling time in days
  # init is the starting abundance.
  # The sytax is set up in the way wanted by ggplot's stat_function()
}


# building a plot:
require(ggplot2)
# first the data:
p <- ggplot( data = dataToPlot, aes( x = daysSince ) ) + 
  geom_line( mapping = aes( y = Total_Cases ) )
doublingPeriods <- 2:7 # vector of days between doubling
# using a loop to sequentially add reference lines:
for ( i in 1:length(doublingPeriods)) {
  doub <- doublingPeriods[i]
  p <- p + stat_function( fun = doublingFunction, 
                          args = list(doub, startVal), 
                          linetype = "dashed")
}
# rescaling and adding labels:
p + scale_y_continuous( trans = "log10", 
                        limits = c(startVal, max(Total_Cases)) ) + 
  theme_bw() + 
  labs( x = paste("Days since ", thresh, "th case", sep = ""), y = "Total cases" )
  

############################################
## 3. Making generalizable functions
############################################

# Function for adding doubling time reference lines to an existing plot:
addDoubRefLines <- function( dataToPlot, doublingPeriods, myylim, p ) {
  
  # arguments:
      # dataToPlot: data frame having real data that were used
      # doublePeriods: vector of double periods (in days) for reference lines
      # myylim: limits on y-axis display
      # p: the ggplot object that the lines should be added to
  
  # preallocate objects for end points
  endx <- rep(0, length(doublingPeriods))
  endy <- endx
  endPoints <- data.frame(endx, endy)
  
  # plot the reference lines
  nPeriods <- length(doublingPeriods)
  
  init <- dataToPlot$count[1] # initial abundance
  
  for ( i in 1:nPeriods ) {
    dp <- doublingPeriods[i] # focal doubling period
    # calculate ref lines:
    refx <- dataToPlot$days
    refy <- init * ( 2^(refx / dp) )
    keepThese <- refy <= myylim
    plotNow <- data.frame(refx, refy)
    plotNow <- subset( plotNow, refy <= myylim )
    p <- p + geom_line( data = plotNow, 
                        mapping = aes( x = refx, y = refy ), 
                        linetype = "dashed", 
                        color = "gray")
    endPoints[i, ] <- plotNow[ nrow(plotNow), ]
  }
  
  p <- p + geom_label( data = endPoints, 
                      mapping = aes( x = endx, y = endy ),
                      label = paste(doublingPeriods, "days"), 
                      color = "gray",
                      vjust = 0)
  
  return(p)
}

doublingTimePlot <- function( dataVec, thresh, doublingPeriods, varname, myTitle = NULL ) {
  # arguments: 
      # dataVec is a vector of daily time series data
      # thresh is the starting value of numbers of cases/deaths that will determine which day is "day 0"
      # doublingPeriods is a vector of user-desired doubling periods for reference lines
      # varname is a string for displays, such as "case" or "death"
      # myTitle is for adding a title to the graph
  
  # 1. threshold the data and set them up:
  dataVec <- dataVec[ dataVec >= thresh ]
  daysSince <- 0:(length(dataVec) - 1)
  dataToPlot <- na.omit( data.frame( count = dataVec,
                            days = daysSince ))

  # Some useful variables for customizing the plot:
  smallest <- min(dataToPlot$count)
  largest <- max(dataToPlot$count)
  smallestP10 <- floor( log10(smallest) )
  largestP10 <- round( log10( largest ) + 0.5 )
  myylims <- c(0.9*smallest, largest/0.9)
  myBreaks <- sort(c( 10^(smallestP10:largestP10), 
                      5*10^(smallestP10:largestP10), 
                      2*10^(smallestP10:largestP10) ))
  
  # 2. Create the plot of the actual real data:
  p <- ggplot() +
    geom_line( data = dataToPlot, mapping = aes( x = days, y = count ) ) 
    
  # 3. Add doubling reference lines using function above:
  p <- addDoubRefLines( dataToPlot, doublingPeriods, myylims[2], p )
  
  # 4. finish up presentation aspects:
  p <- p + scale_y_continuous( trans = "log10", 
                               breaks = myBreaks,
                               minor_breaks = NULL,
                               limits = myylims ) + 
    theme_bw() + 
    labs( x = paste("Days since ", thresh, "th ", varname, sep = ""), 
          y = paste("Total ", varname, "s", sep = ""),
          title = myTitle)
  
  return(p)
}
  
# Some example calls:
doublingTimePlot( dppWide$Total_Cases, 25, c(2:7, 14, 30, 60), "case", "State of Colorado")  
doublingTimePlot( dppWide$Total_Deaths, 25, c(seq(3, 11, 2), 14, 30, 60), "death", "State of Colorado")  
  


                                                                
# How about some data from the world markets?

##############################################################################
# Here is one way to get a record of 6 months of prices of gold, for example:
##############################################################################
require(quantmod)
oandaData <- getMetals("XAU", verbose = T, auto.assign = F) # function from quantmod library
# make it a data frame:
goldDF <- as.data.frame(oandaData)
head(goldDF)
str(goldDF)
# turns out there is only one "variable" and the dates are stored as the row names!
# make a date variable: 
goldDF$date <- as.Date(row.names(goldDF))

################################################################
# Here's a way to calculate 7-day rolling window averages:
################################################################
calcWindowIndexes <- function( ny, position, windowSize ) {
  hws <- floor(windowSize / 2) # half window size
  myMin <- max(1, position - hws)
  myMax <- min( ny, position + hws )
  return( myMin:myMax )
}

calcRollingAvg <- function( y, stratifyby = NULL, windowsize = 7 ) {
  rollingAvg <- y # preallocate
  ny <- length(y)
  if ( is.null(stratifyby) ) {
    # no subgroups
    for ( i in 1:length(y) ) {
      rollingAvg[i] <- mean( y[ calcWindowIndexes(ny, i, windowsize) ])
    }
  } else {
    subgroups <- unique(stratifyby)
    n <- length(subgroups)
    for ( j in 1:n ) {
      wg <- subgroups[j] # working group
      wi <- which( stratifyby == wg ) # working indexes
      nwi <- length(wi) # number of working indexes
      wvec <- y[wi] # working vector of raw data
      results <- wvec # preallocate a temp object for rolling avg calcs
      for ( i in 1:nwi ) {
        results[i] <- mean( wvec[ calcWindowIndexes(nwi, i, windowsize)] )
      } # end inner for loop over i
      # match up data to proper indexes:
      rollingAvg[wi] <- results
    } # end outer for loop over j
  } # end subgroup handling else clause
  return( rollingAvg )
}

######################################################
## Now actuall calculate the rolling averages:
######################################################

goldDF$rollingAvg <- calcRollingAvg( goldDF$XAU.USD, windowsize = 7)

# take a look with points and a smoothed line:
require(ggplot2)
goldPricePlot <- ggplot( data = goldDF, mapping = aes( x = date, y = XAU.USD) ) + 
  # geom_smooth() + 
  geom_point() +
  geom_line( aes( x = date, y = rollingAvg )) + 
  labs(x = "Date", y = "Price per Troy ounce, USD") + 
  theme_bw()
goldPricePlot


# how about reference lines for minimum and maximum price days, and then horizontal lines on those days?
# First, find the days:
lowDayIndex <- which( goldDF$XAU.USD == min(goldDF$XAU.USD) )
highDayIndex <- which( goldDF$XAU.USD == max(goldDF$XAU.USD) )

refDates <- goldDF$date[c(lowDayIndex,highDayIndex)]
refPrices <- goldDF$XAU.USD[c(lowDayIndex, highDayIndex)]
                        

# Then add the lines as new geoms:
refLineColor <- c("red", "dark green")
goldPricePlot <- goldPricePlot + 
  geom_vline( xintercept = refDates, 
              linetype = "dashed", 
              color = refLineColor ) + 
  geom_hline( yintercept = refPrices,
              linetype = "dashed", 
              color = refLineColor )  
goldPricePlot


# want some auto generated text?  Again, no magic numbers!
labelsText <- paste( "$", round(refPrices), " on ", refDates, sep = "")
goldPricePlot <- goldPricePlot + 
    geom_label( data = data.frame(refDates, refPrices, labelsText), 
                mapping = aes(x = refDates, y = refPrices, label = labelsText), 
                hjust = c(0,1), 
                color = refLineColor)

show(goldPricePlot)
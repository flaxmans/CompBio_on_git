# How about some data from the world markets?
# Here is one way to get a record of 6 months of prices of gold, for example::
require(quantmod)
oandaData <- getMetals("XAU", verbose = T, auto.assign = F) # function from quantmod library
# make it a data frame:
goldDF <- as.data.frame(oandaData)
head(goldDF)
str(goldDF)
# turns out there is only one "variable" and the dates are stored as the row names!
# make a date variable: 
goldDF$date <- as.Date(row.names(goldDF))

# take a look with points and a smoothed line:
require(ggplot2)
goldPricePlot <- ggplot( data = goldDF, mapping = aes( x = date, y = XAU.USD) ) + 
  geom_smooth() + 
  geom_point() +
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
goldPricePlot + 
    geom_label( data = data.frame(refDates, refPrices, labelsText), 
                mapping = aes(x = refDates, y = refPrices, label = labelsText), 
                hjust = c(0,1), 
                color = refLineColor)


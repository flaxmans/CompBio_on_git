# re-creating something like the Denver Post plots from 
# https://www.denverpost.com/2020/03/06/coronavirus-map-colorado/
# see also different examples at 
# https://github.com/flaxmans/CompBio_on_git/tree/master/Datasets/COVID-19/DenverPostPlot 
rm(list = ls())
# import:
dpp <- read.csv( file = "~/compbio/CompBio_on_git/Datasets/COVID-19/DenverPostPlot/RevisedData.csv", stringsAsFactors = F)
# convert date from char to date:
dpp$Date <- as.Date( dpp$Date, format = "%m/%d/%y" )
# I'm going to change the names slightly to make it easier to parse later ...
names(dpp)[2:3] <- c("Daily_Cases", "Daily_Deaths")
str(dpp)
head(dpp)


# How to proceed?   We need to answer the following questions 
# before we can even start to plot:
# 1. What do we need to calculate to complete the data set?
# 2. How should we assemble the different metrics into a single data frame?


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

###############################################################
## 2. Building data frames that work nicely for ggplot
###############################################################

## Method 1 for building one data frame: "spread out" or "wide form"
dppWide <- cbind(dpp, Total_Cases, Total_Deaths)
# note that every method of counting is in its own column/variable

## Method 2: stacked or "long form" using tidyr's "pivot_longer()"; 
# pivot_longer() is a sort of updated version of gather().  See the
# vignette at https://tidyr.tidyverse.org/articles/pivot.html 
 
# note the pattern: two variables stored in four names, separated by underscores
require(tidyr)


##################################################################
## 3. Actually Plotting
##################################################################

require(ggplot2)

# Sometimes, the spread form is nice, like when you only want 
# to plot a subset of the data.  Note that data differentiation
# occurs through calls to multiple geom's:



# The "stacked" form is nice when you want to let ggplot do the work of 
# choosing colors, linetypes, etc., and you want all data to be displayed
# with the SAME GEOM:



# Which would be better/easier for reconstructing the Denver Post's plots?
# And, how would we do it?


require(cowplot)
#plot_grid()  # getting multiple separate graphics objects in one plot
  
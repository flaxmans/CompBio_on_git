# re-creating something like the Denver Post plots from 
# https://www.denverpost.com/2020/03/06/coronavirus-map-colorado/
# see also different examples at 
# https://github.com/flaxmans/CompBio_on_git/tree/master/Datasets/COVID-19/DenverPostPlot 
rm(list = ls())
# import:
dpp <- read.csv( file = "~/compbio/CompBio_on_git/Datasets/COVID-19/DenverPostPlot/COVID-19_DenverPost_data.csv", stringsAsFactors = F)
# convert date from char to date:
dpp$Date <- as.Date( dpp$Date, format = "%m/%d/%y" )
# take a look:
head( dpp )
# I'm going to change the names slightly to make it easier to parse later ...
names(dpp)[2:3] <- c("New_Cases", "New_Deaths")
head(dpp)


# how to proceed? 




# need some new variables created for the cumulative counts.  
# We'll look at two ways of assembling a data frame
# after doing the necessary calculations:
Total_Cases <- dpp$New_Cases      # preallocate with correct number in position 1
Total_Deaths <- dpp$New_Deaths    # preallocate with correct number in position 1
for ( day in 2:nrow(dpp) ) {
  # loop to calculate cumulative totals
  Total_Cases[day] <- sum(dpp$New_Cases[1:day])
  Total_Deaths[day] <- sum(dpp$New_Deaths[1:day])
}

###############################################################
## Building data frames that work nicely for ggplot
###############################################################

## Method 1 for building one data frame: "spread out" or "wide form"
dppSpread <- cbind(dpp, Total_Cases, Total_Deaths)
head(dppSpread)
# note that every method of counting is in its own column/variable

## Method 2: stacked or "long form" using tidyr's "pivot_longer()"; 
# pivot_longer() is a sort of updated version of gather().  See the
# vignette at https://tidyr.tidyverse.org/articles/pivot.html 
names(dppSpread) # note the pattern: two variables stored in four names, 
# with variable values separated by underscore

require(tidyr)

dppStacked <- dppSpread %>%
  pivot_longer( cols = 2:5,
                names_to = c("CountType", "Outcome"),
                names_sep = "_",
                values_to = "Count")

head(dppStacked)

##################################################################
## Actually plotting
##################################################################
# Sometimes, the spread form is nice, like when you only want 
# to plot a subset of the data.  Note that data differentiation
# occurs through calls to multiple geom's:
require(ggplot2)
ggplot( dppSpread ) +
  geom_line( aes(x = Date, y = Total_Cases), color = "blue") + 
  geom_bar( aes(x = Date, y = New_Cases ), stat = "identity", fill = "blue")

# The "stacked" form is nice when you want to let ggplot do the work of 
# choosing colors, linetypes, etc., and you want all data to be displayed
# with the SAME GEOM:
ggplot( dppStacked ) + 
  geom_line( aes(x = Date, y = Count, linetype = CountType, color = Outcome)) +
  facet_wrap( ~Outcome, nrow = 2) 

# Which would be better/easier for reconstructing the Denver Post's plots?
# And, how would we do it?
  
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
head(dpp)
# "long form" data frame with ONLY daily counts:
dailyData <- pivot_longer(data = dpp, 
                         cols = 2:3, 
                         names_to = "Cases or Deaths", 
                         values_to = "count" )

# "long form" data frame with ONLY cumulative totals:
cumulativeData <- 
  data.frame(Date = dpp$Date, 
             Total_Cases, 
             Total_Deaths) %>%
  pivot_longer( cols = 2:3,
                names_to = "Cases or Deaths", 
                values_to = "Cumulative count" )

# data frame with all of it in long form:
head(dppWide)
# FILL IN CODE HERE:
dppLong <- dppWide %>%
  pivot_longer( cols = 2:5,
                names_to = c("Daily or Total", "Cases or Deaths"),
                values_to = "Count",
                names_sep = "_")
dppLong

##################################################################
## 3. Actually Plotting
##################################################################

require(ggplot2)
DPcolors <- c("#5C8BBC", "#C26064") # found using "Colorzilla" tool

## PLOTTING WITH "WIDE" or "SPREAD" FORM:
# Sometimes, the spread form is nice, like when you only want 
# to plot a subset of the data.  Note that data differentiation
# occurs through calls to multiple geom's:

ggplot( data = dppWide, mapping = aes( x = Date) ) + 
  geom_bar( aes(y = Daily_Cases), 
            stat = "identity", 
            fill = DPcolors[1], 
            width = 0.5)  + 
  geom_bar( aes( y = Daily_Deaths ),
            stat = "identity",
            fill = DPcolors[2],
            width = 0.5)
  # + FILL IN CODE HERE FOR SECOND SET OF BARS


## PLOTTING WITH "LONG" OR "STACKED" FORMS
# The "stacked" form is nice when you want to let ggplot do the work of 
# choosing colors, linetypes, etc., and you want all data to be displayed
# with the SAME GEOM:

# ADD MORE CODE HERE TO MAKE DAILY BAR PLOTS with dailyData:
p1 <- ggplot( data = dailyData ) +
  geom_bar( aes( x = Date, y = count, fill = `Cases or Deaths`),
            stat = "identity",
            width = 0.5,
            position = "dodge") +
  scale_fill_manual( values = DPcolors) +
  theme_bw()

p1

# ADD MORE CODE HERE TO MAKE CUMULATIVE POINT AND LINE PLOTS with cumulativeData
p2 <- ggplot( data = cumulativeData, 
              aes( x = Date, y = `Cumulative count`, color = `Cases or Deaths`) ) +
  geom_point( size = 1.25 ) + 
  geom_line() + 
  scale_color_manual(values = DPcolors) + 
  theme_bw()
p2


# Which would be better/easier for reconstructing the Denver Post's plots?
# And, how would we do it?


require(cowplot)
#plot_grid()  # getting multiple separate graphics objects in one plot
plot_grid( p1, p2, nrow = 2 )


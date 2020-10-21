# Script for looking at COVID-19 data as provided in multiple files by CDPHE
# See Shell script for aggregation of data from separate files into a single file

#########################
## STEP 1: Get the data
#########################

# before we read in the data, we want them to be current, which means
# we need to rerun the shell script
rm(list = ls())
setwd("~/compbio/CompBio_on_git/Datasets/COVID-19/CDPHE_Data/")
system("sh GreppingOnRawData.sh", intern = T)

# Boulder County Data
Boulder_WildCard_data <- read.csv("Boulder_WildCardGrep.csv", stringsAsFactors = F, header = F)
str(Boulder_WildCard_data)
names(Boulder_WildCard_data) <- c("Date", "Description", "Attribute", "Metric", "Number")
Boulder_WildCard_data$Date <- as.Date(Boulder_WildCard_data$Date)

#####################################
## STEP 2: Inspect and clean the data
#####################################
# see what we have:
# Options include unique(), table(), summarize()
require(dplyr)
Boulder_WildCard_data %>%
  group_by( Attribute, Description, Metric ) %>%
  summarize( NumberOfRows = n() )

# remove rows with missing descriptors:
filteredData <- Boulder_WildCard_data %>%
  filter( Attribute != "" & Description != "" & Metric != "" )
any(is.na(filteredData))

# see what we've got for "Description":
unique(filteredData$Description)

# change names to reflect our data on only Boulder County:
changeCase <- grepl( pattern = "Case Counts by County", 
                     x = filteredData$Description, 
                     ignore.case = T )
filteredData$Description[changeCase] <- "Cases in Boulder County"

changeCase <- grepl( pattern = "Deaths", 
                     x = filteredData$Description, 
                     ignore.case = T )
filteredData$Description[changeCase] <- "Deaths in Boulder County"
filteredData$Metric[changeCase] <- "Deaths"

# "Attribute" column is useless for one county alone, so we will remove it:
filteredData$Attribute <- NULL

# Let's see how we're doing:
filteredData %>%
  group_by( Description, Metric ) %>%
  summarize( NumberOfRows = n() )

# final step to clean up "Description" would be to fix entries for Rates per 100000
ratePer100k <- filteredData$Metric == "Rate Per 100000"
filteredData$Description[ ratePer100k ] <- "Case Rate Per 100000 in Boulder County"

# note that at this point, the Description and Metric columns are completely redundant;
# Metric is just a shorter version of description

head(filteredData)
unique(filteredData$Metric)

# examine daily changes
source("../DoublingTimePlotFunctions.R")
require(tidyr) 
BoulderDailies <- filteredData %>%
  filter( Metric %in% c("Cases", "Deaths") ) %>%
  select( Date, Metric, Number ) %>%
  pivot_wider( id_cols = Date, 
               names_from = Metric,
               values_from = Number) %>% 
  arrange( Date )

BoulderDailies$DailyCases <- BoulderDailies$Cases
BoulderDailies$DailyDeaths <- BoulderDailies$Deaths
n <- nrow(BoulderDailies)
BoulderDailies$DailyCases[2:n] <- BoulderDailies$Cases[2:n] - BoulderDailies$Cases[1:(n-1)]
BoulderDailies$DailyDeaths[2:n] <- BoulderDailies$Deaths[2:n] - BoulderDailies$Deaths[1:(n-1)]

BoulderDailies <- BoulderDailies %>%
  select( Date, DailyCases, DailyDeaths ) %>%
  pivot_longer( cols = c(DailyCases, DailyDeaths), 
                names_to = "Metric", 
                values_to = "Number")

BoulderDailies$Number[ BoulderDailies$Number < 0 ] <- 0
BoulderDailies$rollingAvg <- calcRollingAvg( y = BoulderDailies$Number, stratifyby = BoulderDailies$Metric, windowsize = 7 )
BoulderDailies$Metric[ BoulderDailies$Metric == "DailyCases" ] <- "Cases"
BoulderDailies$Metric[ BoulderDailies$Metric == "DailyDeaths" ] <- "Deaths"

######################
## STEP 3: PLOTTING
######################

require(ggplot2)
# Plot only cases over time:
casesOnly <- ggplot( data = subset(filteredData, Metric == "Cases"),
                     mapping = aes(x = Date, y = Number)) +
  geom_line() + 
  geom_point() + 
  labs( y = "Number of cases in Boulder County") + 
  scale_y_log10() + 
  geom_smooth()
show(casesOnly)

# plot cases and deaths but not rates per 100000
CandD <- ggplot( data = subset(filteredData, Metric %in% c("Cases","Deaths")), 
        mapping = aes(x = Date, y = Number, color = Metric)) +
  geom_smooth() +
  geom_point() + 
  facet_wrap( ~Description, scales = "free_y", nrow = 2 ) + 
  labs( y = "Number" ) + 
  theme_bw() +
  scale_color_manual( values = c("blue", "red")) +
  theme(legend.position="none")
show(CandD)

source("../DoublingTimePlotFunctions.R")
dtp <- subset(filteredData, Metric == "Cases")
show( doublingTimePlot( dtp$Number, 50, c(3,5,7, 10, 14, 30, 60), "case", "Boulder County") )


firstDate <- min(BoulderDailies$Date)
lastDate <- max(BoulderDailies$Date)

# bar plots for daily tallies:
dppColors <- c("#5C8BBC", "#C26064")
lineColors <- c("blue", "magenta")
dailyPlot <- ggplot( data = BoulderDailies, 
                     mapping = aes( x = Date, y = Number )) + 
  geom_bar( aes(fill = Metric), stat = "identity" ) + 
  geom_line( aes( y = rollingAvg, color = Metric )) +
  #geom_smooth() + 
  facet_wrap( ~Metric, nrow = 2, scales = "free_y" ) + 
  scale_fill_manual( values = dppColors ) +
  scale_color_manual( values = lineColors ) +
  theme_bw() + 
  scale_x_date( breaks = seq(firstDate, lastDate, (lastDate - firstDate)/10)) +
  guides( fill = F, color = F ) + 
  labs( title = paste("Boulder County Daily Data with 7-day averages"), fill = "Metric" )
show(dailyPlot)

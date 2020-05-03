# Plot most recently obtained COVID-19 data from CDPHE
rm(list = ls())
setwd("~/compbio/CompBio_on_git/Datasets/COVID-19/CDPHE_Data/RawData_csv_files/")
mostRecentFile <- system("ls -t *.csv | head -n 1", intern = T)
# defaultFile <- "covid19_case_summary_2020-04-21.csv"
require(stringr)
dateOfFile <- (str_extract( string = mostRecentFile, 
                           pattern = "2020-[0-9]*-[0-9]*"))

allData <- read.csv( mostRecentFile, stringsAsFactors = F )

# subset to those following the pattern we want.  Unfortunately the 
# descriptors vary a bit from day to day!
onsetByDateRows <- 
  grepl( pattern = "Cumulative Number.*Onset", 
         x = allData$description,
         ignore.case = T ) | 
  grepl( pattern = "Cumulative Number.*of Illness", 
         x = allData$description, 
         ignore.case = T )

# rename and reformat:
onsetData <- allData[ onsetByDateRows, ]
names(onsetData) <- c("description", "date", "metric", "number")
require(lubridate)
onsetData$date <- parse_date_time(x = onsetData$date, orders = c("Y-m-d", "m/d/y"), quiet = F )
onsetData <- na.omit(onsetData)

# make sure data are sorted by date:
require(dplyr)
onsetData <- arrange(onsetData, date)

descriptors <- unique(onsetData$description)
if ( length(descriptors) != 3 ) {
  stop("Error! Only expected three types of descriptors!")
} else {
  cat("\nFound the following descriptors:\n")
  cat(paste("\t", descriptors, "\n"))
}

# Make names shorter in description column:
searchTerms <- c("of Cases", "Hospitaliz", "Deaths")
myLabels <- c("Cases", "Hospitalizations", "Deaths")
allDailyData <- onsetData # preallocate
rowCount <- 1 # counter variable for storing new data
for ( i in 1:length(searchTerms) ) {
  indexes <- grepl( pattern = searchTerms[i], 
                      x = onsetData$description, 
                      ignore.case = T )
  onsetData$description[indexes] <- paste("Total", myLabels[i])
  
  # While we've already got the loop for subsetting, we could also
  # calculate daily cases from the cumulative data:
  dailyData <- onsetData[ indexes, ] # first make a copy
  dailyData$description <-  paste("Daily", myLabels[i]) # change descriptor
  cumulativeTotals <- onsetData$number[indexes] # relevant totals
  for ( i in 2:length(cumulativeTotals) ) {
    dailyData$number[i] <- cumulativeTotals[i] - cumulativeTotals[(i - 1)]
  }
  # now add the new data to the data frame (long form)
  allDailyData[ rowCount:(rowCount + length(cumulativeTotals) - 1), ] <- dailyData
  rowCount <- rowCount + length(cumulativeTotals)
}

unique(onsetData$description)
unique(allDailyData$description)

# reorder descriptions as factors for order of plotting:
allDailyData$descriptionf <- factor(allDailyData$description, 
                                    levels = paste("Daily", myLabels))

onsetData$descriptionf <- factor(onsetData$description, 
                                    levels = paste("Total", myLabels))

# Now we have two data frames
require(ggplot2)

# bar plots for daily tallies:
dppColors <- c("#5C8BBC", "#FCCB88", "#C26064")
dailyPlot <- ggplot( data = allDailyData, 
        mapping = aes( x = date, y = number )) + 
  geom_bar( aes(fill = descriptionf), stat = "identity" ) + 
  facet_wrap( ~descriptionf, nrow = 3, scales = "free_y" ) + 
  scale_fill_manual( values = dppColors ) + 
  theme_bw() + 
  guides( fill = F ) + 
  labs( title = paste("CDPHE data as of", dateOfFile), fill = "Metric" )
show(dailyPlot)

# lines and points for cumulative:
totalsPlot <- ggplot ( data = onsetData,
                       mapping = aes( x = date, y = number, color =  descriptionf)) + 
  geom_line() + 
  geom_point() + 
  theme_bw() + 
  labs( color = "Count", title = paste("CDPHE data as of", dateOfFile) ) +
  scale_color_manual( values = dppColors ) + 
  theme(legend.position = c(0.15, 0.8))
show(totalsPlot)

# doubling time plots?
# get the functions:
source("../../DoublingTimePlotFunctions.R")
totalCases <- filter( onsetData, description == "Total Cases" )
totalDeaths <- filter( onsetData, description == "Total Deaths")

show( doublingTimePlot( totalCases$number, 50, c(2:7, 10, 14, 30, 60), "case", "State of Colorado") )

show( doublingTimePlot( totalDeaths$number, 50, c(2:7, 10, 14, 30, 60), "death", "State of Colorado") )

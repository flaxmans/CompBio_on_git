# Plot most recently obtained COVID-19 data from CDPHE
rm(list = ls())
setwd("~/compbio/CompBio_on_git/Datasets/COVID-19/CDPHE_Data/RawData_csv_files/")
mostRecentFile <- system("ls -t *.csv | head -n 1", intern = T)
defaultFile <- "covid19_case_summary_2020-04-21.csv"

allData <- read.csv( defaultFile, stringsAsFactors = F)

# subset to those following the pattern we want:
onsetByDateRows <- grepl( pattern = "Cumulative Number.*Onset", 
                          x = allData$description, 
                          ignore.case = T )

# rename and reformat:
onsetData <- allData[ onsetByDateRows, ]
names(onsetData) <- c("description", "date", "metric", "number")
onsetData$date <- as.Date(onsetData$date)
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
searchTerms <- c("Cases", "Hospitalizations", "Deaths")
allDailyData <- onsetData # preallocate
rowCount <- 1 # counter variable for storing new data
for ( i in 1:length(searchTerms) ) {
  indexes <- grepl( pattern = searchTerms[i], 
                      x = onsetData$description, 
                      ignore.case = T )
  onsetData$description[indexes] <- paste("Total", searchTerms[i])
  
  # While we've already got the loop for subsetting, we could also
  # calculate daily cases from the cumulative data:
  dailyData <- onsetData[ indexes, ] # first make a copy
  dailyData$description <-  paste("Daily", searchTerms[i]) # change descriptor
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
                                    levels = paste("Daily", searchTerms))

onsetData$descriptionf <- factor(onsetData$description, 
                                    levels = paste("Total", searchTerms))

# Now we have two data frames
require(ggplot2)

# bar plots for daily tallies:
dppColors <- c("#5C8BBC", "#FCCB88", "#C26064")
ggplot( data = allDailyData, 
        mapping = aes( x = date, y = number )) + 
  geom_bar( aes(fill = descriptionf), stat = "identity" ) + 
  facet_wrap( ~descriptionf, nrow = 3, scales = "free_y" ) + 
  scale_fill_manual( values = dppColors ) + 
  theme_bw() + 
  guides( fill = F )


# lines and points for cumulative:
ggplot ( data = onsetData, 
         mapping = aes( x = date, y = number, color =  descriptionf)) + 
  geom_line() + 
  geom_point() + 
  theme_bw() + 
  labs( color = "Count" ) +
  scale_color_manual( values = dppColors )


# Time differences:
rm(list = ls())

### ------------ Get the data ---------------------------###
# make use of UNIX-parsed 4-digit year file:
camData <- read.csv("CusackDataFourDigitYears.csv", stringsAsFactors = F)
camData$DateTime <- strptime(camData$DateTime, format = "%d/%m/%Y %H:%M", tz = "Africa/Dar_es_Salaam")
# just to make sure import of years was good:
tail(camData$DateTime) #Yes, and shows "EAT" for time zone, which is East Africa Time
# Thanks to Bridget for finding the right string argument for the tz = "Africa/Dar_es_Salaam"!
allYears <- as.numeric(format(camData$DateTime, "%Y"))
all(allYears == 2013 | allYears == 2014)


### ------- Sorting the data only once may lead to gains in efficiency -------- ###
# Does sort work on times?  Let's try a toy example:
# First, from ?sort, we learn we need to use order() for a data frame
smallData <- tail(camData)
# the order command gives INDEXES, it doesn't change your data by itself
sortedOrder <- order(smallData$DateTime)
smallData[ sortedOrder, ]
# Note that this appears to behave as expected, and it preserves the "reference" and "row names"
# So, we could re-sort back to the original at ANY time using those as the order.

camData <- camData[ order(camData$DateTime), ]
head(camData)
tail(camData)
# This shows us what we expect, but also reveals a very extreme outlier in time:
# The very first data point is from 7 months before any of the others.  We would be fully
# justified in removing it for an analysis of time intervals:
trimmedData <- camData[2:nrow(camData), ]

# the sort also enables us to do some more validation steps.  E.g., meta data tell us that 
# all dry correspond to 2013 and wet season to 2014:
dryToWet <- c(tail(which(trimmedData$Season == "D")), head(which(trimmedData$Season == "W")))
dryToWet
# the tail of one + the head of the other should produce a consecutive series of integers
# if ALL the dry season observations truly come before all the wet ones in time
trimmedData[ dryToWet, ]
# consistent with the meta-data, the last dry season observation is in november of 2013, and the
# first wet season observation is in December of 2013

###############################################################################
########### ------------- Some Analyses of Time Intervals ------------ ########
###############################################################################

### -------  Overall times between intervals at all stations combined ------ ##
# Suppose we just wanted the OVERALL time gaps between observations in seasons:
dryObs <- which(trimmedData$Season == "D")  # row indexes for dry season
nDryObs <- length(dryObs) # number of obs total
dryData <- trimmedData[dryObs, ] # subset of data
# now do a vectorized subtraction:
?difftime
DryObsDiffs <- difftime(dryData$DateTime[2:nDryObs], dryData$DateTime[1:(nDryObs-1)], units = "mins")
mean(DryObsDiffs) == mean(as.numeric(DryObsDiffs))  # numeric is as expected
mean(DryObsDiffs)

# seeing that the above works, we could copy and paste, or replace and extend it with a loop:
meanObs <- data.frame("D" = 0, "W" = 0) # make a place for means
Season <- rep("", nrow(trimmedData) - 2) # -2 for loss of two rows due to taking differences
TimeInterval <- rep(0, nrow(trimmedData) - 2)
rowcount <- 1 # to help with indexing
for ( seas in c("D", "W") ) {
  obsRows <- which(trimmedData$Season == seas)
  nObs <- length(obsRows)
  # get the right data:
  workingData <- trimmedData$DateTime[obsRows]
  # fill nObs-1 entries with the time differences using vectorized subtraction:
  myDiffs <- as.numeric(difftime(workingData[2:nObs], workingData[1:(nObs-1)], units = "mins"))
  TimeInterval[rowcount:(rowcount + nObs - 2)] <- myDiffs
  # e.g., if nObs = 10 and rowcount = 1, then we fill rows 1:9, i.e., rows rowcount:(rowcount + 10 - 2)
  meanObs[1, seas] <- mean(myDiffs)
  Season[rowcount:(rowcount + nObs - 2)] <- seas
  rowcount <- rowcount + nObs - 1 #increment the row counter to the first unused row in the objects
}
dfTimeIntervals <- data.frame(Season,TimeInterval, stringsAsFactors = F)

# put the mean observations into a format that can be used intelligently with ggplot:
meanObs <- data.frame(Season = c("D", "W"), Avg = c(meanObs[1,"D"], meanObs[1,"W"]))

# plot the distributions of time intervals between consecutive camera observations
# and draw a vertical line at the mean for each
library(ggplot2)
ggplot(dfTimeIntervals, aes(x = TimeInterval, fill = Season, color = Season)) + 
  geom_histogram() + 
  geom_vline(data = meanObs, aes(xintercept = Avg)) +
  facet_wrap(~Season, scales = "free_x") +
  scale_y_log10() +
  xlab("Time Interval (mins)")


       
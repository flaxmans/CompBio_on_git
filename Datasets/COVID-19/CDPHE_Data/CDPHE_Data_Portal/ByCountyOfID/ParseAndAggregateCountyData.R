# Colorado Data By County.  Each file has different headers potentially
rm(list = ls())

##################################
## Needed packages
##################################
require("stringr")
require("dplyr")
require("lubridate")
require("ggplot2")
require("tidyr")

##########################################
## Get the data
##########################################

setwd("~/compbio/CompBio_on_git/Datasets/COVID-19/CDPHE_Data/CDPHE_Data_Portal/ByCountyOfID/")

# A bash script gets all the headers into a single file for inspection
system("bash ScriptToCheckAndClean.sh", intern = T)
headersOnly <- read.table("allHeadersOnly.csv",
                        header = F,
                        stringsAsFactors = F)

# take a look at how many different sets of headers we have
unique(headersOnly)
table(headersOnly) # check that it is the same as the return from the system call above

# here's one way to parse to figure out columns in common
headsInCommon <- unlist(str_split(headersOnly[1,], pattern = ","))
allHeads <- headsInCommon
numRows <- nrow(headersOnly)
excluded <- vector(mode = "character")
for ( i in 2:numRows ) {
  # get current row as separate strings:
  thisRow <- unlist(str_split(headersOnly[i,1], pattern = ","))
  # record which will be dropped by intersect():
  excluded <- unique(c( excluded, setdiff(thisRow, headsInCommon), setdiff(headsInCommon, thisRow) )) 
  # note that we have to check both ways with setdiff() function
  # keep list of all headers used:
  allHeads <- union( thisRow, allHeads )
  # record those that intersect:
  headsInCommon <- intersect(headsInCommon, thisRow)
}

# inspect and check results of header parsing:
headsInCommon
excluded
allHeads
length(allHeads) == length( c(excluded, headsInCommon) )
setdiff( allHeads, c(excluded,headsInCommon))
setdiff( c(excluded,headsInCommon), allHeads )

nHeadCols <- length(allHeads) # useful count for later code

###########################################################################
## Now to actually aggregating the data
###########################################################################

## Let's look at two ways to aggregate the data

## For either method, let's get the names of the raw data files:
dataFileNames <- system('ls | grep "202[01]-[0-9][0-9]-[0-9][0-9].csv"', intern = T)

## AGGREGATION METHOD 1:  Suppose NO joining functions.  Note this method includes some validation steps
system.time({
  # pre-allocate a common data frame for import and storage:
  numLinesTotal <- as.integer(system("wc $(ls | grep '202[01]-[0-9][0-9]-[0-9][0-9].csv') | tail -n 1 | awk '{print $1}'", intern = T))
  aggregatedData <- as.data.frame( 
    matrix( 
      ncol = nHeadCols, 
      nrow = numLinesTotal  # should be more than needed; avoids dynamic allocation
    ), 
    stringsAsFactors = F
  )
  names( aggregatedData ) <- allHeads
  aggregatedData$sourceFile <- rep(NA, numLinesTotal)
  
  # Use loop to move one file at a time and concatenate rows by matching column names
  firstRow <- 1
  noNewLineAtEndOfFile <- 0 # validating line counts
  linesAsExpected <- 0
  
  for ( fileName in dataFileNames ) {
    oneFileOfData <- read.csv( fileName, stringsAsFactors = F )
    syscmd <- paste("wc -l", fileName, "| awk '{print $1}'")
    lineCount <- as.integer(system( syscmd, intern = T))
    nrhere <- nrow(oneFileOfData)
    if ( nrhere == lineCount ) {
      # would mean no new line at end of file because header row should subtract one
      noNewLineAtEndOfFile <- noNewLineAtEndOfFile + 1 
    } else if ( nrhere == (lineCount - 1) ) {
      linesAsExpected <- linesAsExpected + 1
    }
    lastRow <- firstRow + nrhere - 1 # last row index for this data set
    namesHere <- names(oneFileOfData)
    for ( j in namesHere ) {
      aggregatedData[ firstRow:lastRow, j ] <- oneFileOfData[ , j ]
    }
    aggregatedData$sourceFile[ firstRow:lastRow ] <- fileName # record source file
    firstRow <- lastRow + 1
  }
  
  # validation steps on row/line counts:
  nHeadRowsExpected <- length(dataFileNames) # one line from each raw data file is a header
  nRowsLeft <- numLinesTotal - lastRow # how many rows unused in pre-allocated data frame
  nRowsLeft == nHeadRowsExpected - noNewLineAtEndOfFile # 
  linesAsExpected + noNewLineAtEndOfFile == length(dataFileNames)
  
  # remove unused rows:
  all(is.na(aggregatedData[firstRow:numLinesTotal, ])) # this is a check on what we expect
  dim(aggregatedData)
  aggregatedData <- aggregatedData[ -(firstRow:numLinesTotal), ]
  print(dim(aggregatedData))
})

## AGGREGATION METHOD 2.
# let's try the same thing we did above but with full_join()
system.time({
  # start with one data frame prior to looping:
  aggData2 <- read.csv(dataFileNames[1], stringsAsFactors = F)
  aggData2$sourceFile <- dataFileNames[1]  # this adds one column: recording source file name
  # loop the joining operation over all remaining files:
  for ( fileName in dataFileNames[2:length(dataFileNames)]) {
    newData <- read.csv( fileName, stringsAsFactors = F )
    newData$sourceFile <- fileName
    aggData2 <- full_join(aggData2, newData, by = intersect(names(aggData2), names(newData)) )
    # specifying the "by" argument in the previous line suppresses a lot of printed messages
  }
})


## Now compare the results of the two methods:

# let's see if we can test for equivalence:
dim(aggregatedData) == dim(aggData2)
all(sort(names(aggData2)) == sort(names(aggregatedData)))

# 1 way:  Check the inner_join() to see if it has the same amount of data as either data frame:
dim(inner_join(aggData2, aggregatedData)) == dim(aggData2)
dim(semi_join(aggData2, aggregatedData)) == dim(aggData2)
dim(semi_join(aggregatedData, aggData2)) == dim(aggData2)

# 2: check for exact equivalence.  This requires sorting the same way and removing NAs
aggData2sort <- aggData2[ , names(aggregatedData) ] # reorder columns to match order
# replace NAs with zeros for equivalence testing:
ad1NoNA <- aggregatedData
ad2NoNA <- aggData2sort
ad2NoNA[ is.na(ad2NoNA) ] <- 0  
ad1NoNA[ is.na(ad1NoNA) ] <- 0 

all(ad1NoNA == ad2NoNA)

## Are there any duplicates in the data?
# Duplicates may arise if my data collection algorithm sometimes 
# copied the same data to multiple files.
# remove duplicate rows:   
dups <- duplicated(aggregatedData[ , 1:nHeadCols ])
aggregatedData <- aggregatedData[ !dups, ]
dim(aggregatedData)


#####################################################################################
## Making dates usable:
# parse dates as given in file
aggregatedData$datesParsed <- aggregatedData$Date_Data_Last_Updated %>%
  str_extract( pattern = "\\b[A-Za-z]+ [0-9]{1,2}, 202[01]" ) %>%   # regular expression month day, year
  parse_date_time( orders = "b! d, Y", tz = "")     # order format is MonthName day, 4-digit-year


###############################################################################
## Some initial visualization
# Here's a plot that demonstrates what ggplot can do pretty readily, though 
# it's too much to be very useful
p <- ggplot( data = aggregatedData ) +
  geom_point( mapping = aes( x = datesParsed, y = County_Rate_Per_100_000, color = log10(County_Population)) )
p

#p + facet_wrap( ~COUNTY )



#####################################################
## Next up:  cleaning & filtering

# 1. Sam had a lapse in collecting data: there are a number of missing dates, and one 
# especially large gap.
# 1a. filter/subset the data to only include data from on/after 8/26/20
# 1b. Time permitting: How, with code, could you pinpoint the missing dates to discover that 
# 8/26 was the first date after the big gap?  write some pseudocode and, if you have time,
# some ideas for actual code


# 2. There are 64 actual counties in Colorado, but 
# in the COUNTY column, there are three designations that appear
# in the data frame that are not names of real Colorado counties.  What are they? 
# How would you filter/subset the data to exclude the rows that have those designations?


# 3. 64 counties is a lot to look at all at once.  
# Suppose we wanted to look at subsets by population size.  
# 3a. From the aggregatedData, how could you 
# create a data frame of just COUNTY and County_Population, sorted by population?
# For clarity that data frame should only have ONE row for each county.  Note also
# that County_Population is included in the data for nearly every day.
# 3b. Time permitting: What are the 8 counties with the largest population sizes?
# What are the 8 counties with the smallest population sizes?  Create two data frames 
# that have the corresponding subsets of data.


# 4.  Find the day on which each COUNTY had its greatest number of new cases, 
# as given by the variable County_Pos_Cases_Change






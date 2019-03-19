#####################################################################
##########  Some ideas harvested from lab 9  ########################
#####################################################################
rm(list = ls())

# NOTE about Time Zones: I force "GMT" in most places below for comparability between methods

# NOTE about contributors: over 20 students' ideas are represented here, kept anonymous
# just in case no one wants to be named.  Thank you ALL!

### ---------- Part 1: Converting strings to datetime objects: -----#

# customize the next line as needed:
setwd("~/compbio/CompBio_on_git/Datasets/Cusack_et_al/") # set for your clone of Sam's repo
# get the data
camData <- read.csv("Cusack_et_al_random_versus_trail_camera_trap_data_Ruaha_2013_14.csv", stringsAsFactors = F)
smallStringVec <- tail(camData$DateTime)
oneStringDate <- smallStringVec[1]

# check out strptime(): it does for a CONSISTENT format...
smallDates <- strptime(smallStringVec, format = "%d/%m/%Y %H:%M", tz = "GMT") 
smallDates # note last year produced is literally 13
oneDate <- strptime(oneStringDate, format = "%d/%m/%Y %H:%M", tz = "GMT")
# as.Date does NOT work for strings with hours and minutes
as.Date(oneDate, '%d/%m/%Y %H:%M')
# as.Date extracted the date but we lost the time!

# so, suppose we did this:
allStrpDates <- strptime(camData$DateTime, format = "%d/%m/%Y %H:%M", tz = "GMT")


# Learning about functions and objects:
?POSIXlt
?strptime
?as.POSIXlt


## ------------ Part 2: Some ways people tried to find "bad" dates --------- ##
# Here, "bad dates" are dates with two digit years that were converted as
# literally being in the first century!

# look at some formats and parsings that various folx tried:
# on the original data:
nchar(smallStringVec)  # can delineate by character count less than 16
substr(x = smallStringVec, start = 7, stop = 10) # string diffs apparent
substr(x = smallStringVec, start = 5, stop = 6) # string diffs apparent
strsplit(x = smallStringVec, split = "/") # manual string parsing; generates list to parse
t(as.data.frame(strsplit(x = smallStringVec, split = " "))) # separate date from time and make data frame!

# here's a way from the tidyr package:
library(tidyr)
# Split column Datetime into 2 columns
camData2 <- separate(data = camData, col = DateTime, into = c("Date", "Time"), sep = " ")
camData2 <- separate(data = camData2, col = Date, into = c("Day", "Month", "Year"), sep = "/")
head(camData2)
# Year is now a character vec all on it's own!

# on the datetime format itself
format(smallDates, "%Y") 
as.numeric(smallDates) # date in seconds since 1/1/1970, so years before 1970 make this negative!
as.numeric( format(smallDates, "%Y") ) # years not 2013 or 2014 are "bad"
substr(format(smallDates, '%Y'), start = 1, stop = 2) == '00' # finds years starting with 00! Nice!


# in the end, many ways were found.  Some elegant vectorized ways.  Keep
# in mind that the meta-data told us that the years of collection were ONLY
# 2013 and 2014
justYears <- as.numeric( format(allStrpDates, "%Y") )
badYearIndexes <- which( justYears != 2013 & justYears != 2014)
length(badYearIndexes)
simplerFindIndexes <- which(allStrpDates < 0) # less amiguous to use years than this, but it works!
all(simplerFindIndexes == badYearIndexes)
# turns out you can also compare strings!
length(which(allStrpDates < "2013-01-01" | allStrpDates > "2014-12-31"))
strCompBadDates <- which(allStrpDates < "2013-01-01" | allStrpDates > "2014-12-31")
all(strCompBadDates == badYearIndexes)

# or, working with strings and logical indexes:
problemYearsLogicalIndexes <- substr(format(allStrpDates, '%Y'), start = 1, stop = 2) == '00'
all(which(problemYearsLogicalIndexes) == badYearIndexes)  # confirms same results!

# or, using working with the format itself:
tail(allStrpDates$year)
badYearIndexes2 <- which( allStrpDates$year < 0 )

# OR, suppose you started with the two year format, lower-case y:
strptime(smallStringVec, format = "%d/%m/%y %H:%M", tz = "GMT")
# Note that now the bad ones are NAs, so...
TwoYrDatesFirst <- strptime(camData$DateTime, format = "%d/%m/%y %H:%M", tz = "GMT")
badTwoYearIndexes <- which(is.na(TwoYrDatesFirst))
length(badTwoYearIndexes)
# check that all are accounted for:
length(badTwoYearIndexes) + length(badYearIndexes) == nrow(camData)
# note that we now know for sure the positions fo all two and four year dates!  That's useful!!


## -------Part 3: Some ways people tried to fix it --------------- ###


# what about arithmetic?
oneDate
oneDate + 100 # adds 100 seconds; works but VERY hard to calculate how many to add!
# need to manipulate the year in a POSIXlt object.  See ?POSIXlt


# How about using a loop with indexing to fix it?
# Could do it with a loop, for sure:
loopDates <- strptime(camData$DateTime, format = "%d/%m/%Y %H:%M", tz = "GMT")
for (x in 1:length(camData$DateTime)) {
  if(nchar(camData$DateTime[x]) < 15){
    loopDates[x] <- strptime(camData$DateTime[x], format = "%d/%m/%y %H:%M", tz = "GMT")
  }
}
# takes a little while to run, but does not generate errors...

# a second kind of loop, changing the year directly:
loopDates2 <- strptime(camData$DateTime, format = "%d/%m/%Y %H:%M", tz = "GMT")
tail(loopDates2$year)  # bad entries are negative, but weird numbers!!
for (i in badYearIndexes2) {
  loopDates2$year[i] <- loopDates2$year[i] + 2000
}
# That was reasonably fast!
tail(loopDates2$year)

# Here's the same idea with a vectorized operation:
allStrpDates2 <- strptime(camData$DateTime, format = "%d/%m/%Y %H:%M", tz = "GMT")
allStrpDates2$year[badYearIndexes2] <- allStrpDates2$year[badYearIndexes2] + 2000
unique(allStrpDates2$year)  # note NON-intuitive output!


# here are some additional vectorized ways with a different conditional
# note that what makes all the bad years "bad" is the consistent pattern of a two year format, so ...
# note lower case y in next command:
allStrpDates[badYearIndexes] <- strptime(camData$DateTime[badYearIndexes], format = "%d/%m/%y %H:%M", tz = "GMT")

# that used numerical indexes.  How about logical indexes?
allStrpDates3 <- strptime(camData$DateTime, format = "%d/%m/%Y %H:%M", tz = "GMT")
allStrpDates3[problemYearsLogicalIndexes] <- strptime(camData$DateTime[problemYearsLogicalIndexes], format = "%d/%m/%y %H:%M", tz = "GMT")

# with some intermediate objects: 
allStrpDates4 <- strptime(camData$DateTime, format = "%d/%m/%Y %H:%M", tz = "GMT")
twoYearStrings <- camData$DateTime[badYearIndexes]
#assign two year format to logical index of lines with 2 year formats
FormatDateTwoYear  <- strptime(twoYearStrings, format = "%d/%m/%y %H:%M", tz = "GMT")
head(FormatDateTwoYear)
#replace values in FormatDate with indexes from Wrong years with values from FormatDate
allStrpDates4 <- replace(allStrpDates4, badYearIndexes, FormatDateTwoYear)

# here's a way with string parsing and a function called gsub()
allStrpDates5 <- strptime(camData$DateTime, format = "%d/%m/%Y %H:%M", tz = "GMT")
?gsub
gsub("0013", 2013, smallDates)
str(gsub("0013", 2013, smallDates)) # makes times back into strings! so ... back and forth:
# AND note that the indexing is NOT necessary, because gsub only changes the ones that match!
# do the 13's:
allStrpDates5 <- strptime(gsub("0013", 2013, allStrpDates5), format = '%Y-%m-%d %H:%M:%S', tz = "GMT")
# and the 14's:
allStrpDates5 <- strptime(gsub("0014", 2014, allStrpDates5), format = '%Y-%m-%d %H:%M:%S', tz = "GMT")

# here's a way using a function like one of you wrote, taking advantage of substring:
# one of you made a function for the latter:
fourDigitYearFromTwo <- function(posixDTvec, prefix = "20", mytz = "GMT") {
  charVec <- as.character(posixDTvec)
  for(i in 1:length(charVec)) {
    if(substr(charVec[i], 1, 2)=="00") {
      substr(charVec[i], 1, 2) <- prefix
    }
  }
  # Convert back to POSIXlt data type
  posixDTvec <- as.POSIXlt(charVec, tz = mytz)
  return(posixDTvec)
}
allStrpDates6 <- strptime(camData$DateTime, format = "%d/%m/%Y %H:%M", tz = "GMT")
allStrpDates6 <- fourDigitYearFromTwo( allStrpDates6 )

# OR, finally, if you started with the two year format:
# Note capital Y:
TwoYrDatesFirst[badTwoYearIndexes] <- strptime(camData$DateTime[badTwoYearIndexes], format = "%d/%m/%Y %H:%M", tz = "GMT")


# let's see if it worked:
allYears <- as.numeric(format(allStrpDates, "%Y")) # get 4-digit year
all( allYears == 2013 | allYears == 2014 )

# check if we arrived at the same result:
all(TwoYrDatesFirst == allStrpDates) # Yep!  Starting with two-year data worked!
all(loopDates == allStrpDates) # Yep! Loop based on char length worked!
all(loopDates2 == allStrpDates)  # Yes! Loop with $year worked
all(allStrpDates2 == allStrpDates) # Yes, vectorized manipulating $year worked!
all(allStrpDates3 == allStrpDates) # Yes! substring '00' matching worked!
all(allStrpDates4 == allStrpDates) # Yes!
all(allStrpDates5 == allStrpDates) # Yes!  gsub() worked!
all(allStrpDates6 == allStrpDates) # Yes! function with substring worked!



#######################################################################
### ---------------- some other alternatives ---------------------- ###
#######################################################################


## ----------- First alternative: as.POSIXlt() ---------- ##
## See https://stat.ethz.ch/R-manual/R-devel/library/base/html/as.POSIXlt.html
# this function appears to be able to try multiple formats:
as.POSIXlt(smallStringVec[1], tryFormats = c("%d/%m/%y %H:%M", "%d/%m/%Y %H:%M"))
as.POSIXlt(smallStringVec[length(smallStringVec)], tryFormats = c("%d/%m/%y %H:%M", "%d/%m/%Y %H:%M"))
# BUT this doesn't work quite right on vectors; seems to apply one format to ALL
as.POSIXlt(smallStringVec, tryFormats = c("%d/%m/%y %H:%M", "%d/%m/%Y %H:%M"))
# Note that the output of the vectorized option (last one) was wrong for last entry
# Solution: Loop so it does one at a time!
dtdatastrings <- camData$DateTime
firstDate <- as.POSIXlt(dtdatastrings[1], tryFormats = c("%d/%m/%y %H:%M", "%d/%m/%Y %H:%M"), tz = "GMT")
allAsPosDates <- rep(firstDate, length(dtdatastrings))
for ( i in 1:length(dtdatastrings)){
  allAsPosDates[i] <- as.POSIXlt(dtdatastrings[i], tryFormats = c("%d/%m/%y %H:%M", "%d/%m/%Y %H:%M"), tz = "GMT")
} 
# that was slow but did not generate any errors. Took about 7 seconds on my computer
# Validation:
myyears <- as.numeric(format(allAsPosDates, "%Y"))
all(myyears == 2013 | myyears == 2014)

# is the same as above?
all(allStrpDates == allAsPosDates)
# YES!  Independent confirmation; another method that yields the exact same result

## -------------- Second alternative: lubridate ----------------- ##
# install.packages("lubridate") # if needed
library("lubridate")
# lubridate contains a number of functions to try:
?lubridate::lubridate
# let's try dmy(); looks easy:
dmy(smallStringVec)
# NOPE, gave us all NA's; let's try parse_date_time(); it lets us try multiple formats:
parse_date_time(smallStringVec, orders = c("dmYHM", "dmyHM"), tz = "GMT") 
# THAT appeared to work AND allow vectorization.  Let's try it on the whole thing:
lbdDates <- parse_date_time(camData$DateTime, orders = c("dmYHM", "dmyHM"), tz = "GMT") 
# Now let's see if it worked: validation.  Note lubridate includes a year function too! That's
# a few keystrokes more convenient then the above "format" commands:
all(year(lbdDates) == 2013 | year(lbdDates) == 2014)
# WORKED!
# Does it give the same results?
all(allStrpDates == lbdDates) # YES!  But we did force same time zones;  note that
# parse_date_time() defaults to time zone UTC, but strptime() to local time zone



##########################################################################
############ --------- CONCISE start to finish ---------- ################
####### -------- AND account for proper time zones! ---------- ###########
##########################################################################
rm(list = ls())
camData <- read.csv("Cusack_et_al_random_versus_trail_camera_trap_data_Ruaha_2013_14.csv", stringsAsFactors = F)
datesTimes <- camData$DateTime
datesTimes <- paste(datesTimes, "+0300") # account for time zone, East Africa Time, GMT + 0300

# If using strptime():
datesTimesSTRP <- strptime(datesTimes, format = "%d/%m/%Y %H:%M %z", tz = "GMT")
reformatThese <- which(as.numeric(datesTimesSTRP) < 0 )
datesTimesSTRP[reformatThese] <- strptime(datesTimes[reformatThese], format = "%d/%m/%y %H:%M %z", tz = "GMT")

# If using lubridate's parse_date_time():
library("lubridate")
datesTimeLBD <- parse_date_time(datesTimes, orders = c("dmYHMz", "dmyHMz"), tz = "GMT")

# validate similarity:
all(datesTimeLBD == datesTimesSTRP)


#####################################################################
##### ---------------- Command line parsing! ------------------ #####
#####################################################################

# You can also solve it with parsing in the terminal, using this command to the shell:
# sed 's/\/13 /\/2013 /' Cusack_et_al_random_versus_trail_camera_trap_data_Ruaha_2013_14.csv | sed 's/\/14 /\/2014 /' > CusackDataFourDigitYears.csv
# check out man sed in your terminal to see what sed is
sedParsedData <- read.csv("CusackDataFourDigitYears.csv", stringsAsFactors = F)
sedParsedDates <- strptime(sedParsedData$DateTime, format = "%d/%m/%Y %H:%M", tz = "GMT")
all(sedParsedDates == allStrpDates)
sedParsedYears <- as.numeric(format(sedParsedDates, "%Y"))
all(sedParsedYears == 2013 | sedParsedYears == 2014)



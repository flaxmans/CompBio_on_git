# Refresher and tips for Lab 11:

# To start with, let's get some data to work with.  How about our old familiar friend, the camera trap 
# data set from Cusack et al.

camData <- read.csv("~/compbio/CompBio_on_git/Datasets/Cusack_et_al/IdeasFrom2019/CusackDataFourDigitYears.csv", stringsAsFactors = F)

###############################
## SUBSETTING 
###############################
# suppose we wanted to subset the data?  Here are some reminders about ways to do that.
# Let's say we wanted data only on bush pigs and honey badgers.  Here are three ways:
# 1. Use combinations of simple logicals and indexing to find the rows
keepTheseRows <- (camData$Species == "Bush pig") | (camData$Species == "Honey badger")
subsetMethod1 <- camData[ keepTheseRows, ]

# 2. Use the subset function.  Note similarities with parts of method #1
subsetMethod2 <- subset( camData, Species == "Bush pig" | Species == "Honey badger" )
  
# 3. Use %in% rather than == and | .  Again note some similarities to methods above
myFavoriteSpecies <- c("Bush pig", "Honey badger")
subsetMethod3 <- subset( camData, Species %in% myFavoriteSpecies )

# Are they all the same?  let's check...
all( subsetMethod1 == subsetMethod2 )
all( subsetMethod1 == subsetMethod3 )

# I see "TRUE" in my consolve for both those lines.  All good.

# to reduce typing, I'm going to rename:
myData <- subsetMethod1

######################################
## Summarizing and counting
######################################

# let's just take a look at what we got
myData

# here's a way to look at some summaries using summarise() from dplyr
# 1. Suppose we wanted just counts of species.
# base R:
speciesCounts1 <- as.data.frame( table(myData$Species), stringsAsFactors = F)
speciesCounts1
# here's the same operation using dplyr's summarise()
require(dplyr)
speciesCounts2 <- summarize( group_by(myData, Species), myFreq = n() ) # n() gets you counts!
speciesCounts2

# 2. Suppose we wanted counts of species by station:
# in base R, we could do another cross tabulation because this is still counting
speciesByStation <- summarize( group_by(myData, Species, Station), myFreq = n() )
speciesByStation
# NOTE that dplyr's summarize() omits rows from the results with a count of zero.  In
# other words, not all possible combinations of species and station are represented.

# 3. Suppose we wanted means or some other summary statistic.  This is no longer
# a simple cross tabulation, but it is possible with summarize().  In our example, 
# this is a trivial exercise, but it's only meant to be a demonstration.
meanObsPerStation <- summarize( group_by(speciesByStation, Species), myMean = mean(myFreq), nStations = n())
meanObsPerStation
# So, from that we know that Bush pigs were observed at 3 different stations, a mean of 2.67 times at each.
# Honey badgers were observed at 11 different stations, but with a mean of only 1.45 times at each.
# Note that the power of summarize() is to preserve the attributes and cross-classifying factors
# that we want, and create any kind of summary statistic we want with the others!  And, we can 
# have multiple summary statistics.
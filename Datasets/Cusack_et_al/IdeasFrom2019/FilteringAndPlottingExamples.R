rm(list = ls())
setwd("~/compbio/CompBio_on_git/Datasets/Cusack_et_al/IdeasFrom2019/") # set for your clone of Sam's repo
camData <- read.csv("CusackDataFourDigitYears.csv", stringsAsFactors = F)
# NOTE, this uses file with two digit years replaced to be four-digits

###############################################################################
# -------- PART 1: Filtering and analyzing with basic functions ------------- #
# -------------------- This is a "Bite-Sized Warmup" ------------------------ #
###############################################################################

# get rows of data for elephants in the wet season:
# use row indexing with vectorized conditionals
elephantsWet <- camData[camData$Species == "Elephant" & camData$Season == "W", ]

# here's an alternative using the subset function
# elephantsWet2 <- subset(camData, Species == "Elephant" & Season == "W")
# all(elephantsWet == elephantsWet2)  # check that results are the same

# cross tabulate:
eletab <- with(elephantsWet, table(Station, Placement))
# take a look:
ftable(eletab)    # ftable() makes a more "attractive" looking output
# looks like a table with a bunch of rows corresponding to station names, and 
# then columns for placement: one for the random and one for the trail for each station.
# Coercing to data frame can help analysis:
eleframe <- as.data.frame(eletab)
# take a look and commpare with the table above:
eleframe
# boxplot can split frequencies by any variable in the data frame:
boxplot(eleframe$Freq ~ eleframe$Placement)

# as.data.frame() stacked the data.  Suppose I want it unstacked?
# first, get the frequency data:
elemat <- matrix(as.numeric(eletab), ncol = ncol(eletab))
# make a data frame with those data plus the station names as a variable:
eleframe <- data.frame(row.names(eletab), elemat)
# add column names:
colnames(eleframe) <- c("Station", dimnames(eletab)$Placement)
# take a look:
eleframe
# same boxplot as above, but with separate columns now:
boxplot(eleframe$Random, eleframe$Trail)
# finally, how about true pairwise comparisons, within "Station"
boxplot(eleframe$Random - eleframe$Trail)
# the latter shows that the large majority are negative, i.e., trail observations
# tend to be greater than random, controlling for location (by making the comparison
# within data pairs)

# that was 12 lines of code total to get all of that, with nothing beyond base R
# and three of those lines are just prints to the console, so it's only 9 lines of actual code!

###############################################################################
# ------------------------------- PART 2 ------------------------------------ #
# --------------------- How about more variables at once? --------------------#
###############################################################################

# cross tabulate for Species and Placement:
allTab <- with(camData, table(Species,Placement))
ftable(allTab) # shows a single data point per placement
# Given that this only gives a single data point per placement type,
# we realize we have lost the Station information, and thus this is NOT what we want.

# Re-do the crosstabulation with station information:
allTab <- with(camData, table(Species,Station,Placement))
ftable(allTab) # each species has multiple data points, one
               # per recording station
# Convert to data.frame for more ease of analysis:
alldf <- as.data.frame(allTab)
# make plotting easy with ggplot:
library("ggplot2")
ggplot(alldf, aes(x = Placement, y = Freq)) + 
  geom_boxplot() + 
  facet_wrap(facets = ~Species, scale="free")
# interpretation of ggplot command:
  # line 1: make a ggplot object, with 
    # x axis variable = Placement
    # y axis variable = Freq (frequency count)
    
  # line 2: make a boxplot type of plot
  # line 3: make a multi-panel plot, where each panel 
      # corresponds to a different species, and let the y-axis
      # scaling vary between plots

# That was a crazy amount of plots!  And it only took TWO lines of
# code followed by a 3-line ggplot() command!!  

###############################################################################
#### ------------------------------ PART 3 ------------------------------- ####
#### ------------------ subsetting AND cross-tabulation ------------------ ####
###############################################################################

# Given that the last part made a crazy number of plots, 
# how about the 12 most common species?
# And how about splitting up the data for wet and dry seasons?

topNum <- 12  # number of species to keep
# first, figure out most common species observations.
# frequency count by species:
speciesCounts <- table(camData$Species) 
# sort them:
speciesCounts <- sort(speciesCounts, decreasing = T)
# take a look:
show(speciesCounts)
# get the names of the most common species:
topSpecies <- names(speciesCounts[1:topNum])
# take a look:
topSpecies
# now subset the data:
keepRows <- (camData$Species %in% topSpecies)
cat(paste("\nNumber of observations kept = ", sum(keepRows), "\n"))
topSpeciesData <- camData[keepRows, ]
# make a cross tabulation using all variables except 
# Reference and DateTime:
allTab <- with(topSpeciesData, table(Species,Station,Placement,Season))
# convert to data frame:
alldf <- as.data.frame(allTab)

# Note that the previous 10 lines of code, minus commands that print to screen, could
# be easily turned into a function for subsetting the data by species. Only 7
# lines of actual code do all that work!

# use ggplot to break it down by species, placement, and season:
ggplot(alldf, aes(x = Season, y = Freq, fill = Placement)) + 
  geom_boxplot() + 
  facet_wrap(facets = ~Species, scale="free")

###############################################################################
# ------------------------------- PART 4 -------------------------------------#
# ------- Pairwise DIFFERENCES for numbers of observartions by placement, ----#
# ---------------------- species, and station ------------------------------- #
###############################################################################

calcPairwisePlacementDiffs <- function( data ){
  # function to make it easy to calculate pairwise diffs for numbers of 
  # observations of a species at a given station, where the pair of observations
  # is from the "Random" and "Trail" placements for a given station.
  # Note that because all the data are assumed to subsetted upon input (see code
  # below), what we need now is merely a count of the trail vs. random
  
  places <- data$Placement
  nRandomObs <- sum(places == "Random")
  nTrailObs <- sum(places == "Trail")
  # some error checking and validation:
  # total obs should account for all rows of data
  if ( nRandomObs + nTrailObs != nrow(data) ) {
    # Some informative messages in case our data don't conform to our expectations:
    cat("\nError in calcPairwisePlacementDiffs()!\n\t")
    cat("Unexpected value in Placement data:\n\t")
    oddPlaces <- which( !(places == "Random" | places == "Trail") )
    cat(paste("at postion(s)", oddPlaces, "I found:\n\t"))
    cat(places(oddPlaces))
    cat("\n\tReturning NaN\n")
    return( NaN )
  } else {
    # note that data frame expects Random - Trail
    return( nRandomObs - nTrailObs )
  }
  # note that in the absence of errors and comments, this function amounts to only 
  # four very simple lines of code
}


# First, make a data structure to hold pairwise diffs, consisting of 
# Season, Station, Species, RandomTrailDiff
# how many combinations are there?
dataToUse <- topSpeciesData 
 # create a new varible, "dataToUse" so we can do the following
 # with the whole data set or just some subset of it having the same
 # variables.  This would ALSO make it very easy to turn this all into a 
 # function later on if we wanted to!

seasons <- unique(dataToUse$Season)
nSeasons <- length(seasons)
stations <- unique(dataToUse$Station)
nStations <- length(stations)
species <- unique(dataToUse$Species)
nSpecies <- length(species)
# total number of combinations:
nComb <- nSeasons * nStations * nSpecies

# pre-allocate a data frame
PairwiseDiffs <- data.frame( Season = rep("", nComb), Station = rep("", nComb), Species = rep("", nComb), Random_minus_Trail = rep(0, nComb), stringsAsFactors = F)

rowCount <- 1 # placement of data in pre-allocated structure
for ( sp in species ) {
  data_sp <- dataToUse[dataToUse$Species == sp, ]
  # successive steps of filtering lead to less repetitions and smaller
  # structures for R to handle
  for ( st in stations ) {
    data_st <- data_sp[data_sp$Station == st, ]
    for ( seas in seasons ) {
      data_seas <- data_st[data_st$Season == seas, ]
      # need to account for possibility of NO observations at a station:
      if (nrow(data_seas) == 0 ) {
        pairDiff <- NA
      } else {
        pairDiff <- calcPairwisePlacementDiffs(data_seas)
      }
      if ( is.nan(pairDiff) ) {
        cat("\nError encountered in calcPairwisePlacementDiffs()!\n\t")
        cat("You need to fix your data on:\n\t")
        cat(paste(sp, st, seas))
      }
      # next command: important to get order right in list!
      PairwiseDiffs[rowCount, ] <- list(seas, st, sp, pairDiff)
      # lastly, increment row counter for next trip through loop
      rowCount <- rowCount + 1 
    }
  }
}

# Test if counting worked out correctly for combinations:
# This should evaluate to TRUE
(rowCount - 1) == nComb

ggplot(PairwiseDiffs, aes(x = Season, y = Random_minus_Trail)) + 
  geom_boxplot() + 
  facet_wrap(facets = ~Species, scale="free")


##############
# here's another way to get pairwise diffs with NO loops!

#camData <- read.csv("~/compbio/CompBio_on_git/Datasets/Cusack_et_al/CusackDataFourDigitYears.csv", stringsAsFactors = F)

counts <- as.data.frame(with(camData, table(Placement,Season,Station,Species)), stringsAsFactors = F)

# a check on how big it should be 
nrow(counts) == 2 * 2 * length(unique(camData$Species)) * length(unique(camData$Station))

# take a look:
head(counts, n = 21)
# note regular structure to the data in the "counts" data frame:
# odd rows are "Random"; even are "Trail"
# Dry/wet alternate in groups of two
# stations alternate in groups of four
# that nice structure suggests an easy way to do pairwise comparisons by station!
# note that we got that kind of structure because of the order of arguments passed to 
# the table() function on line 3 above
n <- nrow(counts)
randomRows <- seq(from = 1, to = n-1, by = 2)
trailRows <- randomRows + 1

# check:
all(counts$Placement[randomRows] == "Random")
all(counts$Placement[trailRows] == "Trail")
randomCounts <- counts[randomRows, ]
trailCounts <- counts[trailRows, ]
all(randomCounts[,2:4] == trailCounts[, 2:4]) #these should be identical if the 
# ordering is true and accurate to the pattern noted above.  
# if not, we can't use this method.

# unstacked:
pairCounts <- data.frame(Season = randomCounts$Season,
                         Station = randomCounts$Station,
                         Species = randomCounts$Species,
                         RandomCount = randomCounts$Freq,
                         TrailCount = trailCounts$Freq,
                         TotalStationCount = randomCounts$Freq + trailCounts$Freq,
                         RandomMinusTrail = randomCounts$Freq - trailCounts$Freq,
                         stringsAsFactors = F)

# find most common species:
library("dplyr")  # for arrange() function and summarise() function
speciesCountsD <- summarise(group_by(pairCounts, Species), totalObs = sum(TotalStationCount))
speciesCountsSortedD <- arrange(.data = speciesCountsD, desc(totalObs))
speciesCountsSortedD     

top12 <- speciesCountsSortedD$Species[1:12]
reducedPairCounts <- subset(pairCounts, Species %in% top12, RandomCount > 0 & TrailCount > 0)

ggplot(reducedPairCounts, aes(x = Season, y = RandomMinusTrail)) + 
  geom_boxplot() + 
  facet_wrap(~Species, scales = "free")


### Validation with loop method above:
nrow(PairwiseDiffs) == nrow(reducedPairCounts)

rpcs <- arrange(reducedPairCounts, Species, Station, Season)
pds <- arrange(PairwiseDiffs, Species, Station, Season)
all(pds$Species == rpcs$Species)
all(pds$Season == rpcs$Season)
all(pds$Station == rpcs$Station)
# pds has NAs; rpcs have all zeros in those spots
remove <- is.na(pds$Random_minus_Trail)
sum(remove)
keep <- !remove
sum(keep)
all(rpcs$RandomMinusTrail[remove] == 0)
pds <- pds[keep, ]
rpcs <- rpcs[keep, ]

all(pds$Random_minus_Trail == rpcs$RandomMinusTrail)


############
# and finally a tidyverse way
library("tidyr")

#camData <- read.csv("~/compbio/CompBio_on_git/Datasets/Cusack_et_al/CusackDataFourDigitYears.csv", stringsAsFactors = F)

counts4tidy <- as.data.frame(with(camData, table(Placement,Season,Station,Species)), stringsAsFactors = F)

countsSpread <- spread(counts4tidy, Placement, Freq)

# validate:
countsSpreadSorted <- arrange(countsSpread, Species, Station, Season)
pairCountsSorted <- arrange(pairCounts, Species, Station, Season)

nrow(countsSpreadSorted) == nrow(pairCountsSorted)
all(pairCountsSorted$RandomCount == countsSpreadSorted$Random)
all(pairCountsSorted$TrailCount == countsSpreadSorted$Trail)

css <- subset(countsSpreadSorted, Species %in% topSpecies)
rpcs <- arrange(reducedPairCounts, Species, Station, Season)
all(css$Season == rpcs$Season)
all(css$Station == rpcs$Station)
all(css$Random == rpcs$RandomCount)
all(css$Trail == rpcs$TrailCount)

# let's let ggplot do the calculation for us:
ggplot(css) + 
  geom_boxplot(aes(x = Season, y = Random - Trail)) + 
  facet_wrap( ~Species, scales = "free")
# that plot includes the zeros when BOTH placements for a station had 
# NO observations for a given species in a given season

# compare to first method with loops where NO obs led to NAs:
cssNoZeros <- subset(css, Random != 0 | Trail != 0)
PairwiseDiffsNoNAs <- subset(PairwiseDiffs, !is.na(Random_minus_Trail))
pdnna <- arrange(PairwiseDiffsNoNAs, Species, Station, Season)
all(cssNoZeros$Season == pdnna$Season)
all(cssNoZeros$Station == pdnna$Station)
all(cssNoZeros$Species == pdnna$Species)
cssDiffs <- cssNoZeros$Random - cssNoZeros$Trail
all(cssDiffs == pdnna$Random_minus_Trail)

ggplot(cssNoZeros) + 
  geom_boxplot(aes(x = Season, y = Random - Trail)) + 
  facet_wrap( ~Species, scales = "free")
# latter plot looks exactly like the one produced from the loop method above!

###############################################################################
# ---------------------------------- PART 5 --------------------------------- #
# --MORE VALIDATION!  How can we check if we did what we THINK we did? ------ #
# ---- Compare results from part 1 with part 4 to check for consistency ----- #
###############################################################################

# get data on just wet season for elephants from data.frame created in part 4:
justEle <- PairwiseDiffs[(PairwiseDiffs$Species == "Elephant" & PairwiseDiffs$Season == "W"), ]
# remove NA's since the cross-tabulation in part 1 automatically did that:
justEle <- justEle[!is.na(justEle$Random_minus_Trail), ]
# check numbers:
nrow(justEle) == nrow(eleframe)  # should be TRUE if we have the same AMOUNT of data
# check for identical stats on pairwise diffs:
summary(justEle$Random_minus_Trail) == summary(eleframe$Random - eleframe$Trail)

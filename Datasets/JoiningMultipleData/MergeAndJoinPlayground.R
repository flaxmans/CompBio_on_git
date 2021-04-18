# Some exercises to learn about joining and merging
rm(list = ls())
setwd("~/compbio/CompBio_on_git/Datasets/JoiningMultipleData/")

# Load in some fake data on some imaginary field sites and experiments

Sites1 <- read.csv( "Sites1.csv", stringsAsFactors = F)
Sites2 <- read.csv( "Sites2.csv", stringsAsFactors = F)
Sites2b <- read.csv( "Sites2b.csv", stringsAsFactors = F)
Sites3 <- read.csv( "Sites3.csv", stringsAsFactors = F)


# take a look at each
Sites1
Sites2
Sites2b
Sites3

# What do we know about these 4 mock datasets?



#############################################################
## Part 1. Base R's rbind(): Try some basic concatenations

rbind( Sites1, Sites2 ) # seems like it should work?

rbind( Sites1, Sites2b ) # does this work? what do the results tell us about rbind()

rbind( Sites1, Sites3 ) # does this work?  what do the results tell us about rbind()

################################################################
## Part 2.  Some joining operations in dplyr

require("dplyr")

# the four most common types of "joins"
# taken one at a time, what do we learn from each?
# note we are not even telling  dplyr's functions what to join "by"
inner_join( Sites1, Sites3 )
inner_join( Sites3, Sites1 )

right_join( Sites1, Sites3 )
right_join( Sites3, Sites1 )

left_join( Sites1, Sites3 )
left_join( Sites3, Sites1 )

full_join( Sites1, Sites3 )
full_join( Sites3, Sites1 )

###############################################################################
## For this data set, what makes the most sense in terms of joining all three?

## let's make a data set called "allSites"






################################################################################
##  Suppose we had some updates
## Would any of the following help?

SitesUpdate <- read.csv("SitesUpdate.csv", stringsAsFactors = F)
# note it has updates to some rows and some brand new sites

inner_join( allSites, SitesUpdate )

full_join( allSites, SitesUpdate )

right_join( allSites, SitesUpdate )

left_join( allSites, SitesUpdate )

inner_join( allSites, SitesUpdate, by = "SiteID" )

full_join( allSites, SitesUpdate, by = "SiteID" )

right_join( allSites, SitesUpdate, by = "SiteID" )

left_join( allSites, SitesUpdate, by = "SiteID" )


anti_join( SitesUpdate, allSites, by = "SiteID" )
anti_join( allSites, SitesUpdate, by = "SiteID" )

semi_join( allSites, SitesUpdate, by = "SiteID" )
semi_join( SitesUpdate, allSites, by = "SiteID" )

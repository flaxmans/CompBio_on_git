# Some exercises to learn about joining and merging
rm(list = ls())

# change the next line to work for your computer:
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
inner_join( x = Sites1, y = Sites3 ) # inner_join is also sometimes called "natural join"
inner_join( x = Sites3, y = Sites1 ) # occassionally inner_join is called "join"

right_join( x = Sites1, y = Sites3 ) # also sometimes called "right outer join"
right_join( x = Sites3, y = Sites1 )

left_join( x = Sites1, y = Sites3 ) # also sometimes called "left outer join"
left_join( x = Sites3, y = Sites1 )

full_join( x = Sites1, y = Sites3 ) # full_join is also sometimes known as "outer join" or "full outer join"
full_join( x = Sites3, y = Sites1 )



###############################################################################
## For this data set, what makes the most sense in terms of joining all three?

## let's make a data frame called "allSites"










##########################################################################
## Changing the "by" argument.  Compare:

full_join( x = Sites1, y = Sites3, by = "SiteID" )
full_join( x = Sites1, y = Sites3, by = c("SiteID", "AvgTempC" ))
full_join( x = Sites1, y = Sites3 )



##################################################################################
## What about some different columns

ExperimentalData <- read.csv("ExperimentalData.csv")
allSites
ExperimentalData

ij <- inner_join(allSites, ExperimentalData, by = "SiteID")
rj <- right_join(allSites, ExperimentalData, by = "SiteID")
lj <- left_join(allSites, ExperimentalData, by = "SiteID")
fj <- full_join(allSites, ExperimentalData, by = "SiteID")

ij 
rj
lj
fj

ij[ is.na(ij) ] <- 0
rj[ is.na(rj) ] <- 0
all(ij == rj)

################################################################################
##  Suppose we had some updates
## Would any of the following help?

SitesUpdate <- read.csv("SitesUpdate.csv", stringsAsFactors = F)
# note it has updates to some rows and some brand new sites

# None of the basic joins give us exactly what we might want, though we could work with them.
# Look at the results of each:
inner_join( allSites, SitesUpdate )

full_join( allSites, SitesUpdate )

right_join( allSites, SitesUpdate )

left_join( allSites, SitesUpdate )

inner_join( allSites, SitesUpdate, by = "SiteID" )

full_join( allSites, SitesUpdate, by = "SiteID" )

right_join( allSites, SitesUpdate, by = "SiteID" )

left_join( allSites, SitesUpdate, by = "SiteID" )


# Here is another join offered by dplyr.  Could we use this for updating?

anti_join( x = SitesUpdate, y = allSites )  # rows unique to x
anti_join( x = SitesUpdate, y = allSites, by = "SiteID" )  # rows with SiteID unique to x
anti_join( x = allSites, y = SitesUpdate )
anti_join( x = allSites, y = SitesUpdate, by = "SiteID" )

# Here's one idea

NoChangeSites <- anti_join( allSites, SitesUpdate, by = "SiteID" )
NoChangeSites
UpdatedAllSites <- full_join( NoChangeSites, SitesUpdate ) %>% arrange( SiteID )
UpdatedAllSites

#################################################################
## APPENDIX

#############################################
## some basic set operations

x <- LETTERS[1:4]
y <- LETTERS[3:7]

x
y
intersect( x, y )
setdiff( x, y )
setdiff( y, x )
union( x, y )

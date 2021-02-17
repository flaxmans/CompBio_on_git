# Some data on rainfall averages by state across the USA:
rainfall <- read.csv( file = "~/compbio/CompBio_on_git/Datasets/AverageRainfallByState/AverageRainfallByState.csv", stringsAsFactors = F)

# General kind of problem:  Subset the data based upon the numbers

# Here are some questions to answer using conditionals:
# How many states receive an average annual rainfall of more than 1 meter, and which states are they?
# Which states are closest to the median rainfall among all states?
# What are the 10 states that get the least rainfall?

# Is a sort necessary?
# Millimeters to meters conversion
# Find rows where millimeters > 1000
rainThreshold <- 1000 # 1 meter is 1000 millimeters
# Look at third column (Millimeters) and Find rows where millimeters > 1000

rainfall[,3] > rainThreshold
rainfall$Millimeters > rainThreshold

# Cross-reference rows from previous step to State names
# get the indexes that satisfy previous line
indexes <- which(rainfall$Millimeters > rainThreshold)

logicalIndexes <- rainfall$Millimeters > rainThreshold

# use indexes to get the states
states1 <- rainfall[ indexes, 1 ]
states2 <- rainfall$State[ indexes ]
states3 <- rainfall$State[ logicalIndexes ]


# Count number states satisfying our criterion
numStates <- length( states1 )

# Print out the names
cat(paste("There are", numStates, "states with average annual rainfall greater than", rainThreshold, "milimeters\n"))
cat("Those states are:\n")
cat(paste("\t",states3,"\n", sep = ""))

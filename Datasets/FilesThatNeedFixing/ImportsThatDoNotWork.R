rm(list = ls())
setwd("~/compbio/CompBio_on_git/Datasets/FilesThatNeedFixing/")

# Try each and inspect the results
# see the README at https://github.com/flaxmans/CompBio_on_git/tree/main/Datasets/FilesThatNeedFixing for more details


edgeList <- read.table("EdgeList.txt", sep = "\t") # should import with three columns

mooresLawData <- read.csv("moore.csv") # should import with six columns

chromosomeNumbers <- read.table("ChromosomeNumber.txt", sep = "\t") # should import with six columns

catAndDogePreClean <- read.csv("DoubleSpacedWindowsNewlines.txt", stringsAsFactors = F)
catAndDoge <- read.csv("CleanedUpGameResults.csv", stringsAsFactors = F)  

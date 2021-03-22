rm(list = ls())
setwd("~/compbio/CompBio_on_git/Datasets/FilesThatNeedFixing/")

# Try each and inspect the results
# see the README at https://github.com/flaxmans/CompBio_on_git/tree/main/Datasets/FilesThatNeedFixing for more details

edgeList <- read.table("EdgeList.txt", sep = "\t") # should import with three columns
chromosomeNumbers <- read.table("ChromosomeNumber.txt", sep = "\t") # should import with six columns
catAndDoge <- read.csv("DoubleSpacedWindowsNewlines.txt", stringsAsFactors = F)

mooresLawData <- read.csv("moore.csv", stringsAsFactors = F) # should import with six columns
mooresLawData <- read.table("moore.csv", 
                            sep = "\t",
                            stringsAsFactors = F) # should import with six columns

mooresLawData <- read.csv("cleaned_moore.csv")



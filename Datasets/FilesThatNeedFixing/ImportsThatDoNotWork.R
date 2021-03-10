rm(list = ls())
setwd("~/compbio/CompBio_on_git/Datasets/FilesThatNeedFixing/")

# Try each and inspect the results
# see the README at https://github.com/flaxmans/CompBio_on_git/tree/main/Datasets/FilesThatNeedFixing for more details

edgeList <- read.table("EdgeList.txt", sep = "\t")

mooresLawData <- read.csv("moore.csv")

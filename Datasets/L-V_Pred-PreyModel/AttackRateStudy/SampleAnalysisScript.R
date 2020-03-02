# example script of how all these files make our life easy
rm(list = ls()) # clear all variables just to make the point that
    # there is nothing in memory

# set the working directory"
setwd("~/compBio/Models/L-V_Pred-PreyModel/AttackRateStudy/")

# get the data:
preyData <- read.csv("PreyDataAttackRateStudy.csv")
predData <- read.csv("PredatorDataAttackRateStudy.csv")

# get the parameters:
source("parameters.R")

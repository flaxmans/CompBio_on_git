# Working with some data from the Colorado Department of Public Health
# and Environment (CDPHE) on COVID-19 in Colorado.

# Change the next line to work for YOUR OWN computer:
setwd("~/compbio/CompBio_on_git/Datasets/COVID-19/CDPHE_Data/CDPHE_Data_Portal/")

stateStatsData <- read.csv("DailyStateStats2/CDPHE_COVID19_Daily_State_Statistics_2_2021-04-02.csv", 
                           stringsAsFactors = F)


####################################################
## Explore the data
####################################################
# here are some suggestions for simple exploration , but please use your own ideas!
names(stateStatsData) 
str(stateStatsData)
summary(stateStatsData)
unique(stateStatsData$Name)
unique(stateStatsData$Desc_)
table(stateStatsData$Name)



##################################################################
##  Tasks
##################################################################

# try to figure out ways to do all of the following using functions 
# from the Tidyverse

# 1. subset the data so that we only keep the rows where the text in the column (variable) named "Name" is "Colorado"

# 2. subset to keep (select) only the columns "Date", "Cases", and "Deaths"

# 3. change the data in the "Date" column to be actual dates rather than a character

# 4. sort the data so that the rows are in order by date from earliest to latest

# 5. subset the data so that we only have dates prior to May 15th, 2020
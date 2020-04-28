# Script for looking at COVID-19 data as provided in multiple files by CDPHE
# See Shell script for aggregation of data from separate files into a single file

#########################
## STEP 1: Get the data
#########################

# before we read in the data, we want them to be current, which means
# we need to rerun the shell script
rm(list = ls())
setwd("~/compbio/CompBio_on_git/Datasets/COVID-19/CDPHE_Data/")
system("sh IdeasForAnalyses.sh", intern = T)

# Boulder County Data
Boulder_WildCard_data <- read.csv("~/compbio/CompBio_on_git/Datasets/COVID-19/CDPHE_Data/Boulder_WildCardGrep.csv", stringsAsFactors = F, header = F)
str(Boulder_WildCard_data)
names(Boulder_WildCard_data) <- c("Date", "Description", "Attribute", "Metric", "Value")
Boulder_WildCard_data$Date <- as.Date(Boulder_WildCard_data$Date)

#####################################
## STEP 2: Inspect and clean the data
#####################################
# see what we have:
# Options include unique(), table(), summarize()
require(dplyr)
Boulder_WildCard_data %>%
  group_by( Attribute, Description, Metric ) %>%
  summarize( NumberOfRows = n() )

# remove rows with missing descriptors:
filteredData <- Boulder_WildCard_data %>%
  filter( Attribute != "" & Description != "" & Metric != "" )
any(is.na(filteredData))

# see what we've got for "Description":
unique(filteredData$Description)

# change names to reflect our data on only Boulder County:
changeCase <- grepl( pattern = "Case Counts by County", 
                     x = filteredData$Description, 
                     ignore.case = T )
filteredData$Description[changeCase] <- "Cases in Boulder County"

changeCase <- grepl( pattern = "Deaths", 
                     x = filteredData$Description, 
                     ignore.case = T )
filteredData$Description[changeCase] <- "Deaths in Boulder County"
filteredData$Metric[changeCase] <- "Deaths"

# "Attribute" column is useless for one county alone, so we will remove it:
filteredData$Attribute <- NULL

# Let's see how we're doing:
filteredData %>%
  group_by( Description, Metric ) %>%
  summarize( NumberOfRows = n() )

# final step to clean up "Description" would be to fix entries for Rates per 100000
ratePer100k <- filteredData$Metric == "Rate Per 100000"
filteredData$Description[ ratePer100k ] <- "Case Rate Per 100000 in Boulder County"

# note that at this point, the Description and Metric columns are completely redundant;
# Metric is just a shorter version of description

######################
## STEP 3: PLOTTING
######################

require(ggplot2)
# Plot only cases over time:
casesOnly <- ggplot( data = subset(filteredData, Metric == "Cases"),
                     mapping = aes(x = Date, y = Value)) +
  geom_line() + 
  geom_point() + 
  labs( y = "Number of cases in Boulder County")
show(casesOnly)

# plot cases and deaths but not rates per 100000
CandD <- ggplot( data = subset(filteredData, Metric %in% c("Cases","Deaths")), 
        mapping = aes(x = Date, y = Value, color = Metric)) +
  geom_smooth() +
  geom_point() + 
  facet_wrap( ~Description, scales = "free_y", nrow = 2 ) + 
  labs( y = "Number" ) + 
  theme_bw() +
  scale_color_manual( values = c("blue", "red")) +
  theme(legend.position="none")
show(CandD)


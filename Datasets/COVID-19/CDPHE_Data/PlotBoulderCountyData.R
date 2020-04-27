# Script for looking at COVID-19 data as provided in multiple files by CDPHE
# See Shell script for aggregation of data from separate files into a single file

# before we read in the data, we want them to be current, which means
# we need to rerun the shell script
setwd("~/compbio/CompBio_on_git/Datasets/COVID-19/CDPHE_Data/")
system("sh IdeasForAnalyses.sh", intern = T)

# Boulder County Data
Boulder_WildCard_data <- read.csv("~/compbio/CompBio_on_git/Datasets/COVID-19/CDPHE_Data/Boulder_WildCardGrep.csv", stringsAsFactors = F, header = F)
str(Boulder_WildCard_data)
names(Boulder_WildCard_data) <- c("Date", "Description", "Attribute", "Metric", "Value")
Boulder_WildCard_data$Date <- as.Date(Boulder_WildCard_data$Date)



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
changeCase <- filteredData$Description == "Case Counts by County"
filteredData$Description[changeCase] <- "Cases in Boulder County"
changeCase <- filteredData$Description == "Deaths"
filteredData$Description[changeCase] <- "Deaths in Boulder County"

require(ggplot2)
# Plot only cases over time:
ggplot( data = subset(filteredData, Metric == "Cases" & Description == "Cases in Boulder County") ) +
  geom_line( mapping = aes(x = Date, y = Value))

# plot cases and deaths but not rates per 100000
ggplot( data = subset(filteredData, Metric == "Cases"), 
        mapping = aes(x = Date, y = Value)) +
  geom_smooth() +
  geom_point() + 
  facet_wrap( ~Description, scales = "free_y", nrow = 2 ) + 
  labs( y = "Number" ) + 
  theme_bw()
  



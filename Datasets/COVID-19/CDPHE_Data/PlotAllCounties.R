####################################
# Make sure data are current:
####################################
rm(list = ls())
setwd("~/compbio/CompBio_on_git/Datasets/COVID-19/CDPHE_Data/")
system("sh GreppingOnRawData.sh", intern = T)

#####################################
# Read and clean data
#####################################

CountiesData <- read.csv("AllCounties_WildCardGrep.csv", stringsAsFactors = F, header = F)
str(CountiesData)
names(CountiesData) <- c("Date", "Description", "County", "Metric", "Number")
CountiesData$Date <- as.Date(CountiesData$Date)
# This time, values were imported as characters, so we need to coerce them to numeric:
CountiesData$Number <- as.numeric(CountiesData$Number)

# see what we have:
# Options include unique(), table(), summarize()
require(dplyr)
CountiesData %>%
  group_by( County, Description, Metric ) %>%
  summarize( NumberOfRows = n() )

UnknownCounties <- grepl( pattern = "unknown",
                        x = CountiesData$County, 
                        ignore.case = TRUE )
CountiesData <- CountiesData[ !UnknownCounties, ]

any(is.na(CountiesData))

# remove rows with missing descriptors and also NAs:
filteredData <- CountiesData %>%
  filter( County != "" & Description != "" & Metric != "" ) %>%
  na.omit()

# check:
any(is.na(filteredData))

# did we get what we expected for County?
sort(unique(filteredData$County))

# How to deal with some entries that have "County" and some that don't?
filteredData$County <- gsub(" County", "", filteredData$County)
sort(unique(filteredData$County))

# Colorado has 64 counties according to 
# https://simple.wikipedia.org/wiki/List_of_counties_in_Colorado
# So, why are we getting more?


# other checks/cleaning:
unique(filteredData$Description)
unique(filteredData$Metric)

# is there a complete, unambiguous correspondence?
# Deaths appear to be the problem from the plots first made.  So,
# let's do some exploration of data
# 
deathsInDescription <- grepl( pattern = "Death", x = filteredData$Description)
deathsInMetric <- grepl( pattern = "Deaths", x = filteredData$Metric)
all(deathsInDescription == deathsInMetric)
sum(deathsInDescription)
sum(deathsInMetric)
missingFromMetric <- deathsInDescription & !deathsInMetric
sum(missingFromMetric)
missingFromDescription <- !deathsInDescription & deathsInMetric
sum(missingFromDescription)

filteredData$Metric[ deathsInDescription ] <- "Deaths"


########################################
# Make some plots.  Step 1: Subset data
########################################

# Suppose we wanted to plot rates for the counties that most recently had the highest per capita rate:
mostRecentDate <- max(filteredData$Date)
rankedCountiesByRate <- filteredData %>% 
  filter( Date == mostRecentDate & Metric == "Rate Per 100000") %>%
  arrange( desc(Number) )

nToKeep <- 5
highestCounties <- c(rankedCountiesByRate$County[1:nToKeep], "Douglas", "Boulder", "Jefferson", "Weld")
# highestCounties <- c(rankedCountiesByRate$County[1:nToKeep], "Boulder")

plottingData <- filteredData %>%
  filter( County %in% highestCounties )



############################################
# Make some plots.  Step 2: Actual plotting
############################################

require(ggplot2)
# plot
show( 
  ggplot( data = plottingData, 
        mapping = aes(x = Date, y = Number, color = County, linetype = County) ) + 
  # geom_smooth() +
  geom_line( size = 1.25 ) + 
  facet_wrap( ~Metric, nrow = 3, scales = "free_y" ) + 
  theme_bw() 
)
# The first time I made this plot, it showed a problem with the data ... 

show(
  ggplot( data = filter(plottingData, Metric != "Rate Per 100000"),
          mapping = aes(x = Date, y = Number, color = Metric, linetype = Metric) ) +
    geom_line( size = 1.5 ) +
    facet_wrap( ~County ) +
    scale_y_log10() +
    theme_bw() )

cat("\ntop 5 counties are:\n\t")
cat(rankedCountiesByRate$County[1:nToKeep])
cat("\n\n")

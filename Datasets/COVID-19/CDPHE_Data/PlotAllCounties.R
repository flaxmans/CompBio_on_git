CountiesData <- read.csv("~/compbio/CompBio_on_git/Datasets/COVID-19/CDPHE_Data/AllCounties_WildCardGrep.csv", stringsAsFactors = F, header = F)
str(CountiesData)
names(CountiesData) <- c("Date", "Description", "County", "Metric", "Value")
CountiesData$Date <- as.Date(CountiesData$Date)
# This time, values were imported as characters, so we need to coerce them to numeric:
CountiesData$Value <- as.numeric(CountiesData$Value)

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


# other cleaning:
unique(filteredData$Description)
unique(filteredData$Metric)

# is there a complete, unambiguous correspondence?
# DEATHS FIRST:
all( (filteredData$Description == "Number of Deaths by County") == (filteredData$Metric == "Deaths"))
# YES!
# Rates per 100000:
all( (filteredData$Description == "Case Rates Per 100,000 People in Colorado by County") == (filteredData$Metric == "Rate Per 100000"))
# NO!
# Metric seems least ambiguous, so let's use that.  We could clean up description, or just ignore it

# Suppose we wanted to plot rates for the counties that most recently had the highest per capita rate:
mostRecentDate <- max(filteredData$Date)
rankedCountiesByRate <- filteredData %>% 
  filter( Date == mostRecentDate & Metric == "Rate Per 100000") %>%
  arrange( desc(Value) )

nToKeep <- 10
highestCounties <- rankedCountiesByRate$County[1:nToKeep]

plottingData <- filteredData %>%
  filter( County %in% highestCounties )






plot
ggplot( data = subset(filteredData, Metric == "Cases" & Value >= 10), 
        mapping = aes(x = Date, y = Value, color = County) ) + 
  geom_line() + 
  scale_y_log10()

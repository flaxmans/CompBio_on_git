# A "tidy" example for pairwise differences:

rm(list = ls())  # start with a clean workspace

# Get data.  
setwd("~/compbio/CompBio_on_git/Datasets/Cusack_et_al/")
camData <- read.csv("CusackDataFourDigitYears.csv", stringsAsFactors = F)

# cross-tabulate to get count data:
counts <- as.data.frame(with(camData, table(Placement,Season,Station,Species)), stringsAsFactors = F)

# spread the data to enable pairwise comparisons by Placement:
library("tidyr")
countsSpread <- spread(data = counts, key = Placement, value = Freq)

# stations that never observed a species should not count as actual "samples"
countsSpread <- subset(countsSpread, Random != 0 | Trail != 0)

# subset further to most common 12 species:
# tabulate counts ONLY by species:
countSpecies <- as.data.frame(table(camData$Species), stringsAsFactors = F)
library("dplyr")
# sort descending on counts:
sortedSpeciesCounts <- arrange(countSpecies, desc(Freq))
numSpeciesToKeep <- 12
top12 <- sortedSpeciesCounts$Var1[1:numSpeciesToKeep]
dataToPlot <- subset(countsSpread, Species %in% top12)

# plot it:
library("ggplot2")
ggplot(data = dataToPlot, mapping = aes(x = Season, y = Random - Trail)) + 
  geom_boxplot() + 
  facet_wrap( ~Species, scales = "free")

### -------  Just for exploring ggplot, various commands below ------------- ###

# let's build a ggplot step by step, and see how it looks after each.  
# NOTE that some of these steps are intentially error-producing

# let's make a smaller example
dataToPlot <- subset(dataToPlot, Species == "Zebra" | Species == "Spotted hyena")

myPlot <- ggplot(data = dataToPlot)
myPlot # blank plot because NOTHING specifed yet about appearance
myPlot <- myPlot + geom_boxplot()
myPlot
# ERROR!  "stat_boxplot requires the following missing aesthetics: y"
# Let's start over.  We never specified an aesthetic!

myPlot <- ggplot(data = dataToPlot, mapping = aes(Season, Trail))
# note in the previous line: we can give ggplot a calculation to do!
# in this case, it was the subtraction
myPlot  # note this shows axes with NO data plotted?  Why?  Because we need
    # to specify a geom of some kind.  HOW are the data supposed to be shown?
myPlot <- myPlot + geom_boxplot()
myPlot # now we see all the data in just two boxes
myPlot <- myPlot + facet_wrap(facets = ~Species)
myPlot # now we see facets

## other options we could try:
ggplot(data = dataToPlot, mapping = aes(Season, Trail, color = Species)) + 
  geom_boxplot()
# now we see the same data but without facets.  Instead of facet_wrap(), we added one
# more dimension to the mapping argument specified with aes()


# what happens if we don't specify an x axis?  A boxplot doesn't actually 
# have to have one... 
myPlot <- ggplot(data = dataToPlot, mapping = aes(y = Trail, color = Season)) + 
  geom_boxplot() + 
  facet_wrap( ~Species, scales = "free")
myPlot
# But note that we get meaningless x axes ticks!
# Web search for "ggplot no ticks" revealed this solution:
# https://stackoverflow.com/questions/35090883/remove-all-of-x-axis-labels-in-ggplot#35090981 
myPlot + theme(axis.title.x=element_blank(),
      axis.text.x=element_blank(),
      axis.ticks.x=element_blank())
# for more on theme(), see https://ggplot2.tidyverse.org/reference/theme.html
# for more on element_blank(), see https://ggplot2.tidyverse.org/reference/element.html 

# to understand aes even a bit more, compare these three plots:

plot1 <- ggplot(data = dataToPlot, mapping = aes(x = Season, y = Trail, color = Season)) + 
  geom_boxplot() + 
  facet_wrap( ~Species )
plot1
# Season is used to separate data to be mapped into D and W, and they are 
# given different colors

ggplot(data = dataToPlot, mapping = aes(x = Season, y = Trail, color = "purple", fill = "gold")) + 
  geom_boxplot() + 
  facet_wrap( ~Species )
# the legend of the latter is complete nonsense!  Why?  Because the strings
# we gave for color and fill were INSIDE aes().  They don't correspond to data,
# but aes() is for creating a mapping of the data, not its colors per se

ggplot(data = dataToPlot, mapping = aes(x = Season, y = Trail)) + 
  geom_boxplot(color = "purple", fill = "gold") + 
  facet_wrap( ~Species )
# now colors are actually colors, because they are given as an option to 
# the geom_boxplot(), and are NOT inside the aes()

# and finally, note that the following two plots are identical:
plot1  # from a few lines above

ggplot(data = dataToPlot) + 
  geom_boxplot(mapping = aes(x = Season, y = Trail, color = Season)) + 
  facet_wrap( ~Species )
# sincde the boxplots are the only geom in this ggplot object, it doesn't matter
# whether the aesthetic is specified in the ggplot() call or in the
# geom_boxplot() call.  geom_boxplot() automatically (by default) "inherits"
# the aesthetic from the corresponding ggplot() call, if one has been specified


# and if you want to see some details of how R stores all this information:
typeof(plot1)
class(plot1)
str(plot1)



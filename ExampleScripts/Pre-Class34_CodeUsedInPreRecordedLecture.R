############################################
## Example 1: Basic Exponential Growth
############################################

expGrowth <- function(r, nInit, nGens){
  # r is growth rate, nInit is abundance at time 1
  # nGens is number of generations to model
  time <- 0:nGens
  abundance <- nInit * exp( r * time )
  return(data.frame(time,abundance))
}
expGrowthData <- expGrowth(r = 0.25, 
                           nInit = 10, 
                           nGens = 50)
require(ggplot2)
ggplot(data = expGrowthData, 
       mapping = aes(x = time, y = abundance)) + 
  geom_point() + 
  geom_line() + 
  scale_y_log10() # keep or remove this last line to see differences

##############################################
## Example 2: Returning to Moore's law
##############################################

# clean and get the data:
setwd("~/compbio/CompBio_on_git/Datasets/FilesThatNeedFixing/")
system("bash cleanUpMooreData.sh") 
mooreData <- read.csv("cleaned_moore.csv")
ggplot( data = mooreData, 
        mapping = aes( x = Year, y = TransistorCount )) + 
  geom_point() + 
  geom_smooth( method = "lm") + 
  scale_y_log10() + # keep or remove this line to see differences
  labs(title = "Moore's Law Data and Linear Fit")

#################################################
## Example 3:  A doubling Reference
#################################################
doublingTime <- 2 # years for Moore's law
timeZero <- min(mooreData$Year) # year zero for nInit
nInit <- mooreData$TransistorCount[ mooreData$Year == timeZero ]
# note previous line works because there is only one entry for that year
maxTime <- max(mooreData$Year) # final relevant year
TimePoints <- seq(from = timeZero, 
                  to = maxTime,
                  by = doublingTime)
doublingEvents <- 0:(length(TimePoints) - 1)
DoubleRefNums <- 2^(doublingEvents) * nInit 
# see PowerPoint for derivation of formula on prev. line
# make a data frame for plotting:
ReferenceData <- data.frame(TimePoints, DoubleRefNums)
ggplot(ReferenceData, aes(x = TimePoints, y = DoubleRefNums)) + 
  geom_point() + 
  geom_line() + 
  scale_y_log10()

####################################################
## Example 4: Put it all together for Moore's law
####################################################

ggplot(data = mooreData, 
       mapping = aes( x = Year, y = TransistorCount )) + 
  geom_point( ) + 
  geom_smooth( method = lm ) + 
  geom_line( data = ReferenceData, 
             mapping = aes(x = TimePoints, y = DoubleRefNums),
             color = "maroon", 
             linetype = "dashed" ) +
  theme_bw() +
  scale_y_log10() + 
  labs(title = "Moore's Law Data and Reference Line")

linearFitMoores <- lm( log(TransistorCount) ~ Year, data = mooreData )
linearFitMoores$coefficients
confint(linearFitMoores, 'Year')
linearFitReference <- lm( log(DoubleRefNums) ~ TimePoints, data = ReferenceData )
linearFitReference$coefficients
# note that the slope coefficients are nearly identical, and
# the confidence interval around the former includes the latter.
# Conclusion?

# OR more like the NY Times Doubling Plot:
ggplot(data = mooreData, 
       mapping = aes( x = Year - timeZero, y = TransistorCount )) + 
  geom_point( ) + 
  geom_smooth( method = lm ) + 
  geom_line( data = ReferenceData, 
             mapping = aes(x = TimePoints - timeZero, y = DoubleRefNums),
             color = "maroon", 
             linetype = "dashed" ) +
  theme_bw() +
  scale_y_log10() + 
  labs(x = paste("years since", nInit, "transistors"),
       y = "transistor count",
       title = "Moore's Law Data and Reference Line")



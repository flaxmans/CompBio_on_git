# Ricker Model: A discrete-time density dependent model of population growth

# Ricker model equation as explained at:
# https://en.wikipedia.org/wiki/Ricker_model

# See also:
# Ricker, W. E. (1954) Stock and Recruitment Journal of the Fisheries Research Board of Canada, 11(5): 559-623. doi:10.1139/f54-039

# parameters:
startTime <- 0
endTime <- 150
initialAbundance <- 100
carryingCap <- 1000
growthRate <- 0.05

# make data objects:
time <- startTime:endTime
abundance <- rep(initialAbundance, times = length(time)) # pre-allocation

# loop to calculate:
for ( i in 2:length(time) ) {   
  # note that we start at index 2, because index 1 is the initial
  # abundance at time zero; put another way, note that 
  # length(time) is endTime + 1 because startTime is zero
  
  # this is the Ricker equation from the link above:
  abundance[i] <- abundance[i-1] * exp( growthRate * (1 - (abundance[i-1]/carryingCap)) )

}

# visualize results with base R:
plot( time, abundance, type = "b")

# visualize with ggplot:
library(ggplot2)
ggplot( data = data.frame(time,abundance) ) +
  geom_line( mapping = aes( x = time, y = abundance) )

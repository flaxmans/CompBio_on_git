# Ricker Model:

# parameters:
startTime <- 0
endTime <- 150
initialAbundance <- 100
carryingCap <- 1000
growthRate <- 0.05

# make data objects:
time <- startTime:endTime
abundance <- rep(initialAbundance, times = length(time))

# loop to calculate:
for ( i in 2:length(time) ) {
  # Ricker model equation as explained at:
  # https://en.wikipedia.org/wiki/Ricker_model
  abundance[i] <- abundance[i-1] * exp( growthRate * (1 - (abundance[i-1]/carryingCap)) )
  
  # See also:
  # Ricker, W. E. (1954) Stock and Recruitment Journal of the Fisheries Research Board of Canada, 11(5): 559???623. doi:10.1139/f54-039Ricker, W. E. (1954) Stock and Recruitment Journal of the Fisheries Research Board of Canada, 11(5): 559???623. doi:10.1139/f54-039
}

# visualize results:
plot( time, abundance, type = "b")


# With ggplot:
library(ggplot2)
ggplot( data = data.frame(time,abundance) ) +
  geom_line( mapping = aes( x = time, y = abundance) )

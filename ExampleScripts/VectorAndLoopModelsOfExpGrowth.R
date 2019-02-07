# Model of exponential population growth
# 100 units of time with 0.5% increase during each unit 
# of time, with "samples" taken every 20 time units

# parameters:
initPopSize <- 5000 	# start time
growthRate <- 1.005 	# 5% growth rate per time unit
timeSamples <- seq(from = 20, to = 100, by = 20)

# calculations:
abundances <- initPopSize * (growthRate ^ timeSamples)

# display results:
print(abundances)
plot(timeSamples, abundances, xlab = "Time", ylab = "Population abundance")

###########
# same thing but with a for loop and preallocation:

# use parameters to pre-allocate data storage so that
# the following code works even if parameters above are changed
numTimes <- length(timeSamples) # NO magic numbers! :-)
abundances2 <- rep(0,numTimes)

# calculations:
for ( i in 1:numTimes ) {
  abundances2[i] <- initialPopSize * (growthRate ^ timeSamples[i])
}
print(abundances2)
plot(timeSamples, abundances2, xlab = "Time", ylab = "Population abundance")

# check equivalence of outputs of two methods:
all(abundances == abundances2)

# Lab 12 suggested code

# Exercise #1: Stochastic version of the logistic growth model
stochLog <- function(r = 0.1, k = 100, n0 = 10, gens = 100){
  n <- rep(n0, gens) # preallocate data storage vector
  # loop over generations
  for ( i in 2:gens ) {
    # first calculate the expected abundance:
    expect <- n[i-1] + r * n[i-1] * (k - n[i-1])/k
    # use the Poisson distribution to get a realized value
    n[i] <- rpois(n = 1, lambda = expect)
  }
  return(n)
}

# 2. make some example plots:
par(mfrow = c(2,2)) # 2 x 2 grid of plots
gens <- 100
for ( i in 1:4 ) {
  n <- stochLog(gens = gens)
  plot(1:gens, n, type = "l", xlab = "generation", ylab = "abundance", ylim = c(0,160))
}

# Problem #3
# First, assign parameter values:
r <- 0.1 # intrinsic growth rate
k <- 100 # carrying capacity
n0 <- 10 # initial population size
expectn2 <- n0 + r * n0 * (k - n0)/k # expected population size at generation 2
# 3(i) Probability of no change:
e10 <- dpois(x = n0, lambda = expectn2) # probabilty of staying the same
e10 # display value --> 0.1204182 with defaults
# 3(ii) Probability of shrinking:
eUnder10 <- ppois(q = (n0 - 1), lambda = expectn2) # probability of shrinking
eUnder10 # display value --> 0.3514611
# 3(iii) Probability of increasing:
eAbove10 <- 1 - ppois(q = n0, lambda = expectn2) # probability of growing
eAbove10 # display value --> 0.5281207
eAbove10alt <- ppois(q = n0, lambda = expectn2, lower.tail = F) # alternate method for same as previous
eAbove10alt # display value; yup, it's the same
# check sum to 1:
mySum <- eUnder10 + e10 + eAbove10
if (mySum != 1) {  
  cat(paste("Sum is not 1, but instead", mySum, "\n"))
} else {
  cat("Yes, numbers sum to 1 as expected\n")
}
# 3(iv): probability of being in the range 15 - 25
e15to25 <- sum(dpois(x = 15:25, lambda = expectn2)) 
e15to25 # display value: 0.1387093
# 3(v): probabilty of going immediately extinct:
eextinct <- dpois(x = 0, lambda = expectn2)
eextinct # display value: 1.845823e-05

# 4: My long run expectation is that the population will fluctuate around 
# carrying capacity *if* it does not go extinct!

# 5: A function that orchestrates replicates of the model from Exercise #1:
repStochLog <- function(r = 0.1, k = 100, n0 = 10, gens = 100, nreps = 1000) {
  # in my mind, I envision the replicates in a matrix called "allReps"
  # each row of the the matrix is a replicate
  # each column of the matrix is a time step
  allReps <- matrix(data = NA, nrow = nreps, ncol = gens)
  # now use a loop to generate the replicates:
  for ( i in 1:nreps ) {
    allReps[i,] <- stochLog(r = r, k = k, n0 = n0, gens = gens)
  }
  # return the data:
  return(allReps)
}

# 6. Generate 1000 replicates:
r <- 0.1 # intrinsic growth rate
k <- 100 # carrying capacity
n0 <- 10 # initial population size
gens <- 100 # number of total generations
nreps <- 1000 # number of replicates
# just for fun, let's see how long this takes to run:
system.time(allReps <- repStochLog(r = r, k = k, n0 = n0, gens = gens, nreps = nreps))
# not bad, about 0.4 seconds is all!

# 7. Use the data from exercise 6:
# 7(i) Calculate and plot the mean abundance over time
# I did a search for a function that would do all columns at once:
meanAbund <- colMeans(allReps)
par(mfrow = c(1,1))
plot(1:gens, meanAbund, xlab = "generation", ylab = "mean abundance",
     type = "l", col = "red", ylim = c(0, 1.5*k))
# add a reference line at carrying capacity, just for fun:
abline(h = k, lty = 2)
# Comment on results: the line asymptotes considerably below the carrying capacity
# I presume this is due to the presence of some "0"s due to extinctions
# 7(ii) Estimated probability that a population characterized by the default parameters 
# would go extinct within 25 generations:
pExtinct25 <- sum(allReps[,25] == 0) / nreps
pExtinct25 # Display value: ~15% from my first set of results
# 7(iii) probability that a population would have an abundance of half of its carrying 
# capacity or more at the end of 100 generations:
pHalfOrMoreOfK <- sum(allReps[,gens] >= (k/2)) / nreps
pHalfOrMoreOfK # about 78% in my results
# 7(iv) estimated 95% confidence interval for the population at each time step:
probs <- c(0.025, 0.975)
# make a place to store all the quantiles:
quants <- matrix(nrow = length(probs), ncol = gens)
# use a loop since quantile() works on vectors (not matrices)
for ( i in 1:gens ) {
  quants[,i] <- quantile(x = allReps[,i], probs = probs)
}
# the first row of "quants" is the 2.5% quantile
# the second row of "quants is the 97.5% quantile
lines(1:gens, quants[1,], lty = 3, col = "blue")
lines(1:gens, quants[2,], lty = 3, col = "blue")
# for fun, let's do the interquartile range, i.e., 25% and 75% quantiles:
for ( i in 1:gens ) {
  quants[,i] <- quantile(x = allReps[,i], probs = c(0.25,0.75))
}
lines(1:gens, quants[1,], lty = 3, col = "green", lwd = 2)
lines(1:gens, quants[2,], lty = 3, col = "green", lwd = 2)


# 8.  Repeat # 7 with the extinctions filtered out
# first, get indexes of reps that did NOT end in extinction:
notExtinctReps <- allReps[,gens] > 0
# just curious: how many NOT extinct:
nReduced <- sum(notExtinctReps) # shows 833 from my working set of runs
# now filter the data:
reducedData <- allReps[notExtinctReps, ]

# 8(i)
meanAbund <- colMeans(reducedData)
par(mfrow = c(1,1))
plot(1:gens, meanAbund, xlab = "generation", ylab = "mean abundance",
     type = "l", col = "red", ylim = c(0, 1.5*k))
# add a reference line at carrying capacity, just for fun:
abline(h = k, lty = 2)
# Comment on results: 

# Note: part (ii) of 7 is not applicable

# 8(iii) probability that a population would have an abundance of half of its carrying 
# capacity or more at the end of 100 generations:
pHalfOrMoreOfK <- sum(reducedData[,gens] >= (k/2)) / nreps
pHalfOrMoreOfK # about 78% in my results
# 7(iv) estimated 95% confidence interval for the population at each time step:
probs <- c(0.025, 0.975)
# make a place to store all the quantiles:
quants <- matrix(nrow = length(probs), ncol = gens)
# use a loop since quantile() works on vectors (not matrices)
for ( i in 1:gens ) {
  quants[,i] <- quantile(x = reducedData[,i], probs = probs)
}
# the first row of "quants" is the 2.5% quantile
# the second row of "quants is the 97.5% quantile
lines(1:gens, quants[1,], lty = 3, col = "blue")
lines(1:gens, quants[2,], lty = 3, col = "blue")
# for fun, let's do the interquartile range, i.e., 25% and 75% quantiles:
for ( i in 1:gens ) {
  quants[,i] <- quantile(x = reducedData[,i], probs = c(0.25,0.75))
}
lines(1:gens, quants[1,], lty = 3, col = "green", lwd = 2)
lines(1:gens, quants[2,], lty = 3, col = "green", lwd = 2)

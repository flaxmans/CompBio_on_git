# Lab 11, Computational Biology
# Suggested code (by Sam)

# For the following three problems, suppose that the probability of getting the 
# flu is 40% if you do NOT get the flu vaccine, and 15% if you do get the vaccine.

vacProb <- 0.15
unvacProb <- 0.4

# Exercise A2: simulate the number of people who get the flu in a sample of 20 vaccinated people.
vacGotFlu <- rbinom(n = 1, size = 20, prob = vacProb)

# Exercise A3: simulate the number of people who get the flu in a sample of 20 unvaccinated people.
unvacGotFlu <- rbinom(n = 1, size = 20, prob = unvacProb)

# Exercise A4: create 30 replicates of the scenario described above in A2, 30 replicates of A3, 
# and make frequency histograms of the outcomes of each.
reps <- 30
vacReps <- rbinom(n = reps, size = 20, prob = vacProb)
unvacReps <- rbinom(n = reps, size = 20, prob = unvacProb)
hist(vacReps)
hist(unvacReps)
hist(unvacReps - vacReps) # compare how often unvac might be less than vac

# A model of genetic drift
popSize <- 500 # number of individuals in each generation
initFreq <- 0.55 # initial frequency of "a" allele
# Exercise A5: one generation:
nextFreq <- rbinom(n = 1, size = popSize, prob = initFreq)/popSize
print(nextFreq)
# Exercise A6: 1000 generations
gens <- 1000 # total time to iterate
alleleFrequency <- rep(initFreq, gens) # preallocate vector for storage
for ( i in 2:gens ) {
  oldFreq <- alleleFrequency[(i-1)]
  alleleFrequency[i] <- rbinom(n = 1, size = popSize, prob = oldFreq)/popSize
}
# Exercise A7: Make a plot of the results
generations <- 1:1000
plot(generations, alleleFrequency, type = "l", col = "red")
# Exercise A8: Replicates and more
# use a function for the basic mechanics:
driftModel <- function(gens = 1000, initFreq = 0.55) {
  alleleFrequency <- rep(initFreq, gens) # preallocate vector for storage
  for ( i in 2:gens ) {
    oldFreq <- alleleFrequency[(i-1)]
    alleleFrequency[i] <- rbinom(n = 1, size = popSize, prob = oldFreq)/popSize
  }
  return(alleleFrequency)
}
# another function for creating replicates
repDriftModel <- function(gens = 1000, initFreq = 0.55, nReps = 100) {
  # let each column be a replicate
  # let each row be a time step
  allReps <- matrix(data = NA, nrow = gens, ncol = nReps)
  for ( i in 1:nReps ) {
    allReps[,i] <- driftModel(gens = gens, initFreq = initFreq)
  }
  return(allReps)
}
# (i) plot 10 reps
gens <- 1000
nReps <- 100
initFreq <- 0.55
allReps <- repDriftModel(gens = gens, initFreq = initFreq, nReps = nReps)
myColors <- rainbow(10) # random colors for lines
time <- 1:gens
plot(time, allReps[,1], type = "l", col = myColors[1]) # first line
for ( i in 2:10 ) {
  lines(time, allReps[,i], col = myColors[i])
}
# (ii) Number with allele a fixed:
num.a.fixed <- sum(allReps[gens,] == 1)
print(num.a.fixed)
# (iii) Number with allele b fixed:
num.b.fixed <- sum(allReps[gens,] == 0)
print(num.b.fixed)
# (iv) Number with no fixation: 
num.no.fix <- sum(allReps[gens,] > 0 & allReps[gens,] < 1)
print(num.no.fix)
# Check sum: 
if ( num.a.fixed + num.b.fixed + num.no.fix != nReps ) {
  print("Numbers don't add up!")
} else {
  print("All reps accounted for")
}


####################

# B1: Random dessert order:
kids <- c("Blair", "Frankie", "Kim", "Morgan")
sample(kids)

# B2: 13 rolls of a fair 6-sided die
die <- 1:6
rolls <- sample(x = die, size = 13, replace = T)
hist(rolls, breaks = seq(0.5,6.5, 1))

# B3: biased die
rolls <- sample(x = die, size = 14, replace = T, prob = c(rep(1/7, 5), 2/7) )
hist(rolls, breaks = seq(0.5,6.5, 1))

# B4: randomly re-arrange the rows of a matrix
reorderRows <- function( myMat ) {
  nr <- nrow(myMat)
  newOrder <- sample(1:nr)
  return(myMat[newOrder,])
}
testMat <- as.matrix(read.csv("testMatrix.csv"))
reorderRows( testMat )

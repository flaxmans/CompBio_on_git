predPreyModel <- function(gens = 1000, initPrey = 100, 
                          initPred = 10, a = 0.01, r = 0.2, 
                          m = 0.05, cc = 0.1) {
  # Lotka-Volterra predator-prey model
  # gens = total number of time steps
  # initPrey and initPred are intial population sizes
  # a = attack rate
  # r = growth rate 
  # m = predator mortality rate
  # cc = conversion constant (converting prey consumed into predator births)
  prey <- rep(initPrey, gens)  # pre-allocate array for results on prey abundance
  pred <- rep(initPred, gens) # results on predator abundance
  for ( i in 2:gens ) {
    # main loop to iterate population dynamics
    prey[i] <- prey[i-1] + r * prey[i-1] - a*pred[i-1]*prey[i-1]
    if ( prey[i] < 0 ) { #check if prey are extinct
      prey[i] <- 0
    }
    pred[i] <- pred[i-1] + cc*a*pred[i-1]*prey[i-1] - m*pred[i-1]
    if ( pred[i] < 0 ) { # check if predators are extinct
      pred[i] <- 0
    }
  }
  return(cbind(prey,pred))
}

# a parameter study of the attack rate:
aRange <- seq(from = 0.001, to = 0.1, by = 0.001)
nReps <- length(aRange)
timeSteps <- 1000
preyData <- matrix(data = 0, nrow = timeSteps, ncol = nReps) # preallocate
predData <- preyData # preallocate
for ( i in 1:nReps ) {
  aval <- aRange[i] # working value of attack rate
  results <- predPreyModel(a = aval) # run the model 
  preyData[,i] <- results[,"prey"] # store results
  predData[,i] <- results[,"pred"]
}

# write the data from the parameter study to a .csv
# first, make column headers:
preyColNames <- rep("", nReps)
predColNames <- preyColNames
for ( i in 1:nReps ) {
  preyColNames[i] <- paste("prey.a.", aRange[i], sep = "")
  predColNames[i] <- paste("pred.a.", aRange[i], sep = "")
}
# use headers:
colnames(preyData) <- preyColNames
colnames(predData) <- predColNames
# create a vector of time steps:
time <- 1:timeSteps
# create one object with all the data:
allData <- cbind(time,preyData,predData)
# write the data to a .csv:
setwd("~/Documents/Teaching/Computational_Biology/CompBio_on_git/Models/L-V_Pred-PreyModel/")
mySafeWriteCSV(data = allData, namebase = "PredPreyAttackRateStudy")



# how about a second parameter study, looking at variation in two parameters?
# first parameter: growth rate:
rvals <- seq(from = 0.01, to = 0.1, by = 0.01)
numRvals <- length(rvals)
#second parameter: predator mortality:
mvals <- seq(from = 0.01, to = 0.1, by = 0.01)
numMvals <- length(mvals)
# other parameters:
a <- 0.001
cc <- 0.1
initPrey <- 150
initPred <- 50
gens <- 1000
# preallocate data structures:
totalNumRuns <- numRvals * numMvals
preyData <- matrix(data = 0, ncol = totalNumRuns, nrow = gens)
predData <- preyData
preyHeaders <- rep("", totalNumRuns)
predHeaders <- preyHeaders
# two-parameter study calls for nested for loops:
count <- 1
for ( i in 1:numRvals ){
  rval <- rvals[i]
  for ( j in 1:numMvals ) {
    mval <- mvals[j]
    results <- predPreyModel(r = rval, m = mval) # run the model 
    preyData[,count] <- results[,"prey"] # store results
    predData[,count] <- results[,"pred"]
    
    # make data headers (column names):
    preyHeaders[count] <- paste("prey.r.", rval, ".m.", mval, sep = "")
    predHeaders[count] <- paste("pred.r.", rval, ".m.", mval, sep = "")
    
    # increment counter variable that keeps place in results arrays:
    count <- count + 1
  }
}
# assign column names:
colnames(preyData) <- preyHeaders
colnames(predData) <- predHeaders
# create data object for writing to .csv:
time <- 1:gens
allData <- cbind(time, preyData, predData)
setwd("~/Documents/Teaching/Computational_Biology/CompBio_on_git/Models/L-V_Pred-PreyModel/")
mySafeWriteCSV(data = allData, namebase = "PredPreyStudyrAndm")

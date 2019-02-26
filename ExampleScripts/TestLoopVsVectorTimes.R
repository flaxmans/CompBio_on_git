# large array with every other element changed:
rm(list = ls()) # start with clean memory so objects are definitely allocated at run time

# size of array:
numElements <- 1000000

# number of comparsions
numMethods <- 4
methodNames <- c("For loop", "Vector indexing", "Vector multiplication", "Dynamic growth")
methodResults <- rep(0, numMethods)

# Task: make a large array and then make every-other element negative of what it was
# i.e., x[i] should become -x[i] for all even values of i in the set of integers
# 1, 2, ..., numElements

# Method 1: for loop
methodResults[1] <- system.time({
  myArray <- 1:numElements
  for ( i in seq(2, numElements, 2 ) ) {
    myArray[i] <- -myArray[i]
  }
})[[1]]

# Method 2: vectorize using indexes
methodResults[2] <- system.time({
  myArray2 <- 1:numElements
  myIndexes <- seq(2, numElements, 2)
  myArray2[myIndexes] <- -myArray2[myIndexes]
})[[1]]

# Method 3: vectorize using element-wise multiplication
methodResults[[3]] <- system.time({
  myArray3 <- 1:numElements
  myMultiplier <- rep( c(1,-1), numElements/2 )
  myArray3 <- myArray3 * myMultiplier
})[[1]]

# Method 4: dynamic array sizing (DON'T do this!)
methodResults[[4]] <- system.time({
  myArray4 <- 1
  for ( i in seq(3,numElements,2) ) {
    myArray4[i] <- i
  }
  for ( i in seq(2, numElements,2) ){
    myArray4[i] <- -i
  }
})[[1]]

# Check that all results are equivalent:
if ( !all( c(all(myArray == myArray2), all(myArray2 == myArray3), all(myArray3 == myArray4)) ) ) {
  cat("\nError!  Not all equal!!\n")
}

# display results in console:
decimalPlaces <- 3  # number of desired decimal places in time outputs
multiplier <- 10 ^ decimalPlaces
methodResults <- round(methodResults * multiplier) / multiplier
for ( i in 1:numMethods ){
  cat(paste("\n\t", methodNames[i], ":\n\t\ttime = ", methodResults[i], "s\n", sep = ""))
}


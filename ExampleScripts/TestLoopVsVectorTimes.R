# large array with every other element changed:
rm(list = ls()) # start with clean memory so objects are definitely allocated at run time

# size of array:
numElements <- 1000000

# Task: make a large array and then make every-other element negative of what it was
# i.e., x[i] should become -x[i] for all even values of i in the set of integers
# 1, 2, ..., numElements

# Method 1: for loop
system.time({
  myArray <- 1:numElements
  for ( i in seq(2, numElements, 2 ) ) {
    myArray[i] <- -myArray[i]
  }
})

# Method 2: vectorize using indexes
system.time({
  myArray2 <- 1:numElements
  myIndexes <- seq(2, numElements, 2)
  myArray2[myIndexes] <- -myArray2[myIndexes]
})

# Method 3: vectorize using element-wise multiplication
system.time({
  myArray3 <- 1:numElements
  myMultiplier <- rep( c(1,-1), numElements/2 )
  myArray3 <- myArray3 * myMultiplier
})

# Method 4: dynamic array sizing (DON'T do this!)
system.time({
  myArray4 <- 1
  for ( i in seq(3,numElements,2) ) {
    myArray4[i] <- i
  }
  for ( i in seq(2, numElements,2) ){
    myArray4[i] <- -i
  }
})

# Check that all results are equivalent:
all(myArray == myArray2)
all(myArray2 == myArray3)
all(myArray3 == myArray4)

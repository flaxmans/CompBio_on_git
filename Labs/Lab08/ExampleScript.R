# Example Script for Lab 8 including
# 1. a function definition
# 2. a function that makes a plot and returns data
# 3. writing data to a file

# a toy function involving creating
# two vectors:
happyFunction <- function( n, mult ){
  # make two vectors:
  myVec <- 1:n
  secondVec <- mult * myVec
  
  plot(myVec, secondVec) # plot results
  
  # make a matrix of results:
  myMatrix <- cbind(myVec, secondVec)
  return(myMatrix) # return results
}

#call function and get plot made AND results returned
results <- happyFunction(10, 2)
colnames(results) <- c("time", "abundance")
# NOTE: set working directory before writing files!
# setwd("~/path/to/dir/")
write.csv(x = results, file = "myfile.csv", row.names = FALSE)
## Below are three ways to write an absolute value function, all of which show something
# about problem-solving and data structures in R.  All three are built to be robust to 
# scalar and vector inputs, and also to be robust to the presence of NAs and NaNs.

# 1.  the most elegant absolute value function, perhaps?
myAbs1 <- function( x ){
  return( sqrt(x^2) )
}

# 2.  with a for loop
myAbs2 <- function( x ){
  for ( i in 1:length(x) ){
    if ( is.numeric(x[i]) & !is.nan(x[i]) & !is.na(x[i])  ) {
      if ( x[i] < 0 )
        x[i] <- -x[i]
    }
  }
  return( x )  
}

# 3. with a vectorized conditional:
myAbs3 <- function( x ){
  negs <- which(x < 0)
  x[negs] <- -x[negs]
  return( x )  
}

## ------ test all three functions -------------- ##

# Now here is a function for testing the functions:
testCalls <- function( fncName, testCases ){ 
  # input the function name as a STRING (i.e., in quotes)
  # testCases should be a list:
  for ( i in 1:length(testCases)) {
    cmd <- paste(fncName, "(", testCases[i], ")", sep = "")
    ans <- eval(parse(text = cmd))
    show(ans)
  }
}

# construct scalar and vector test cases, which include NA and NaN:
testCases <- list(NA, 5, -2.3, c(0, 1, 2.3, NA, -34, NaN, -8.1, 12))

cat(paste("\nThe", length(testCases), "test cases are:\n"))
show(testCases)

cat("\nTesting sqrt of square method:\n")
testCalls("myAbs1", testCases)
cat("\nTesting for loop method:\n")
testCalls("myAbs2", testCases)
cat("\nTesting vectorized conditional method:\n")
testCalls("myAbs3", testCases)

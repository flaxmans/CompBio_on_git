# This script, as it existed in its earliest state, was meant to serve as a demonstration
# platform for real-time examples in class

# get the absolute value of a number WITHOUT using R's built-in abs() function:
myAbs <- function( x, NAFlag = F ) {
  if ( NAFlag ) {
    if ( any(is.na(x)) ) {
      cat("\nError! NA's found in x input!\nAborting!\n")
      return( NULL )
    }
  }
  # need to go element-wise on x
  # work on all the elements at once?
  x[which(x < 0)] <- -x[which(x < 0)]
  # now return the whole vector
  return( x )
}

# try it out:
x <- c(2, -3.2, 0)
myAbs( x )

# What about an all positive vector?
# Would it work on a matrix?
# NA's and zeros?
x <- c(2, -3.2, 0, NA, -2.9)
myAbs( x )

myAbs( NA )












##----------- Some more use cases: ----------##
# all positive:
x <- c(5, 4, 2)
myAbs( x )

# NAs:
myAbs( NA )
x <- c(NA, 3.2, NA, -2)
myAbs( x )


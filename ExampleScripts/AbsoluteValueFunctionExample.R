# This script, as it existed in its earliest state, was meant to serve as a demonstration
# platform for real-time examples in class

# get the absolute value of a number WITHOUT using R's built-in abs() function:
myAbs <- function( x ) {
  if ( x < 0 ) {
    return( -x )
  } else {
    return( x )
  }
}

# try it out:
x <- c(2, -3.2, 0)
myAbs( x )

















##----------- Some more use cases: ----------##
# all positive:
x <- c(5, 4, 2)
myAbs( x )

# NAs:
myAbs( NA )
x <- c(NA, 3.2, NA, -2)
myAbs( x )


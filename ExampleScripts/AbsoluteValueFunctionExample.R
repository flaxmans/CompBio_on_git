myAbs <- function( x ) {
  if ( x < 0 ) {
    return( -x )
  } else {
    return( x )
  }
}

x <- c(2, -3.2, 0)
myAbs( x )


















# all positive:
x <- c(5, 4, 2)
myAbs( x )

# NAs:
myAbs( NA )
x <- c(NA, 3.2, NA, -2)
myAbs( x )


# Things you can do with functions:
# 1. multiple return statements can exist.  For example, suppose you wanted
# to make a function to test if a value was above some threshold
testFn1 <- function( x, threshold = 0 ) {
  if ( x > threshold ) {
    return( TRUE )
  } else {
    return( FALSE )
  }
}
# note that whenever a return statement is reached, R exits the function
# and returns whatever object you told it to with the given return statement

# 2.  The example above shows that default values can be defined, but
# also, specifying default values is optional.  The first argument has NO default; the 
# second argument has a sensible default

# 3.  The example above also shows that a function can return any kind of object.  Also,
# "returning" an object is usually preferable to printing an object

# 4. Even a simple function like that above can be called in many different ways.
# Here are some example ways of calling the function that are all valid:
result <- testFn1(5.1) # use default value of one variable
show(result)
result <- testFn1(x = 5.1) # name your argument
show(result)
result <- testFn1(2.2, 3) # use both arguments
show(result)
result <- testFn1(x = 2.2, threshold = 3) # name and use both arguments
show(result)

# 5. You can pass variables, too, of course:
myDoodz <- 80
myGoal <- 12
testFn1(x = myDoodz, threshold = myGoal)

# 6. And you can do anything with your own functions that you might
# do with any other function:
if ( !testFn1(x = myDoodz, threshold = myGoal) ) {
  cat("\nDarn it!\n\n")
} else {
  cat( "\nSweet!  Level up!!!\n\n")
}

# 7. Assigning results (the "return") of your function to a variable is 
# optional; it all depends upon how you want to use it.  #4 above shows 
# assignments; #5 shows NOT assigning; and #6 shows using the result without an 
# assignment per se.  Again, these are all probably things that you are used to doing
# with R's built-in functions.

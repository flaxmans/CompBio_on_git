#################################################
## ---  Demonstrating Simple Logical Tests --- ##
# Suggested use of this script: evaluate one line at a time 
# and see if you can predict what will display in the console before you do.
#################################################

# Demonstrating what happens with NA:
var1 <- 5  # here are two simple variables
varNA <- NA
var1 > varNA

# Demonstrating what happens with a couple of simple numbers:
var2 <- 6       # here is another variable to use 
# and here are some logical tests using var1 and var2:
var1 == var2    # Are the value in these two variables equal?
var1 >= var2    # Is var1 greater than or equal to var2?
var1 > var2     # Is var1 greater than var2?
var1 <= var2    # Is var1 less than or equal to var2?
var1 < var2     # Is var1 less than var2?
var1 != var2    # Are the two values in these variables UNequal?
!(var1 == var2) # example of logical negation
!(var1 < var2)  # another example of logical negation

# Vectorizing conditional tests:
myVec <- c(2, 8, 12.2, 0, -3, 7, NA, 1)
myThreshold <- 1
myVec >= myThreshold

# Demonstrating "logical indexing" (note I got rid of the NA):
myVec <- c(2, 8, 12.2, 0, -3, 7, 1)
myThreshold <- 1
testResults <- myVec >= myThreshold
myVec; testResults
myVec[ testResults ]

# Demonstrating numeric indexing with the which() function:
myVec <- c(2, 8, 12.2, 0, -3, 7, 1)
myThreshold <- 1
testResults <- which(myVec >= myThreshold)
myVec; testResults
myVec[ testResults ]

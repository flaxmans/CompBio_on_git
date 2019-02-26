# Example script setup for Lab #7 (= Assignment #6) 
# Sam Flaxman
# February 25, 2019

############
## Note to students:
## This file is meant to demonstrate how Sam suggests you set up the file of your code
## when you are writing your own functions
############


# For a given problem, first write the function:

# Hypothetical Problem (NOT a real problem in the actual lab)
# Write a function that calculates the hypotenuse of a right triangle
# when given the other two sides:
pythagTheorem <- function( side1 = NA, side2 = NA ) {
  return( sqrt( (side1 ^ 2) + (side2 ^ 2) ) )
}

# THEN, give test cases of the function's usage:

# Demonstrate that it works:
# Suppose a triangle with sides 3 and 4; we expect the hypotenuse to be 5
pythagTheorem( 3, 4 )
pythagTheorem( 30, 40 )

# Then, move on to the next problem

#########

# Problem 1.  Area of a triangle when given base and height

# Function definition:


# Demonstration of usage:



########

# Problem #2.  Our own absolute value function
# and so on ....
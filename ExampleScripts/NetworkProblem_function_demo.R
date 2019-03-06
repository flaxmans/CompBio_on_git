###############################################
## PART 1: Define functions you want to use: ##
###############################################

# here's a function that takes pairwise interaction data in the form of three
# vectors, and converts them into a pairwise interaction matrix.
# The first two arguments are character vectors of people's names
# or identifiers of individuals, expected to be character strings.
# The third argument is expected to be a vector of interaction values.
# Note that the assumption here is that the ith position of each vector corresponds 
# to the ith position of the other two vectors, and thus all three vectors 
# must be of the same length.
# There is no error checking on user input.
makeInteractionMatrix <- function( Person1, Person2, 
                                   InteractionStrength, symmetric = T ) {
  people <- unique(c(Person1, Person2)) # a vector of names
  nPeople <- length(people) # the number of distinct people
  socialNetMat <- matrix(data = NA, nrow = nPeople, ncol = nPeople)
  row.names(socialNetMat) <- people
  colnames(socialNetMat) <- people
  nDataPoints <- length(InteractionStrength)
  for ( i in 1:nDataPoints ) {
    # Loop over rows of data from 3-col form, using names as indexes 
    interactionValue <- InteractionStrength[i]
    # step 4: use the names to index, and put the value in:
    socialNetMat[Person1[i], Person2[i]] <- interactionValue
    if ( symmetric ) {
      # since this is a symmetric matrix do the following also:
      socialNetMat[Person2[i], Person1[i]] <- interactionValue
    }
  }
  return( socialNetMat )
}

###################################################
## PART 2: Use the functions however you see fit ##
###################################################

# Make up some imaginary data for test purposes:
# 3-column format:
# Person1	Person2	InteractionStrength
# Kira		Nader		0.5
# Kira		Tom		  0.1
# Kira		Soo		  0.05
# Nader		Tom		  0.6
# Nader		Soo		  0.001
# Tom		  Soo		  0.001
Person1 <- c(rep("Kira", 3), rep("Nader", 2), "Tom")
Person2 <- c("Nader", "Tom", "Soo", "Tom", "Soo", "Soo")
InteractionStrength <- c(0.5, 0.1, 0.05, 0.6, 0.001, 0.001)

# Call the function
myTestMatrix <- makeInteractionMatrix( Person1, Person2, InteractionStrength )
show(myTestMatrix)

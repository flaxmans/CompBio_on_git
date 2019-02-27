# Here are my data:
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
ThreeColNetwork <- data.frame(Person1, Person2, InteractionStrength)

# take a look with our own eyes; uncomment the following two lines if output is desired:
# show(ThreeColNetwork)
# str(ThreeColNetwork)

# get the names from the data (with some code), make sure we get each unique individual represented once
# work with columns of names as vectors and somehow find unique entries, looking for unique character strings
people <- unique(c(Person1, Person2)) # a vector of people's names
nPeople <- length(people) # the number of distinct people

# make a matrix that will store values (pre-allocation step), put NAs on diagonal (at least)
socialNetMat <- matrix(data = NA, nrow = nPeople, ncol = nPeople)

# Make it possible to use names for indexing: name rows and columns
row.names(socialNetMat) <- people
colnames(socialNetMat) <- people
# assigning people's names as the row name and column names creates an unambiguous
# cross-referencing system that we can use for indexing!

# each row of the data frame is a unique interaction, so the number of unique data points is:
nDataPoints <- length(InteractionStrength)
for ( i in 1:nDataPoints ) {
  # Use the indexes to get the data from the three column form and put it into the RIGHT spots in the matrix
  # get name 1
  name1 <- Person1[i]
  # get name 2
  name2 <- Person2[i]
  # get interaction value
  interactionValue <- InteractionStrength[i]
  # use the names to index, and put the value in:
  socialNetMat[name1, name2] <- interactionValue
  # since this is a symmetric matrix do the following also:
  socialNetMat[name2, name1] <- interactionValue
}

# display the results:
cat("\nHere is the resulting matrix:\n\n")
show(socialNetMat)
cat("\n")


#################################
## Some follow-up thoughts are below ... ##
#################################

### "Fixing" the data frame so you don't have to deal with "factors":
# Here's one way, assuming the data frame already exists:
ThreeColNetwork$Person1 <- as.character(Person1)
ThreeColNetwork$Person2 <- as.character(Person2)
# I find that slightly cumbersome, so ... 
# Here's a second way, which could be used to replace line 14, above.  
# I'd call this the "preferred" way:
ThreeColNetwork <- data.frame(Person1, Person2, InteractionStrength, stringsAsFactors = FALSE)
    # note use of stringsAsFactors argument.  How did I find that?  
    # I used the command ?data.frame in the console and then looked at the help window
  
### Thoughts on building the for loop:  
# Just like the overall problem itself, for loops can be reverse engineered, with the "guts"
# or key operations built first, and then the necessary support pieces added in around them





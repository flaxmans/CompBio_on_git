# make groups of people at random from a list of names

groupPeopleRandomly <- function( filename = "~/Documents/Teaching/Computational_Biology/Students.csv", 
      mingroupsize = 2, returnlist = T ) {
  classList <- read.csv( filename ) #assumes a list of names as a column with a header
  classnames <- as.character(classList[[1]]) # extract names as character vector
  
  nstudents <- length(classnames) # determine number of people
  
  randomorder <- sample( classnames, size = nstudents, replace = F ) # create a random ordering
  
  ngroups <- floor( nstudents/mingroupsize ) # number of working groups
  groupsize <- floor( nstudents / ngroups ) # in case the group size needs to be increased 
  # e.g., 12 students in groups of 5 each, actually needs to be two groups of 6 each
  
  allGroupings <- vector(mode = "character", length = ngroups)
  
  numextra <- nstudents %% groupsize # use modulus operator to figure out uneven groups
  
  count <- 1
  for ( i in 1:ngroups ) {
    # make groups one at a time
    grpname <- ""
    cat(paste("Group #", i, ":\t", sep = ""))
    for ( j in 1:groupsize ){
      # add people one at a time
      if ( j >1 ) {
        grpname <- paste(grpname, ", ", sep = "")
      }
      grpname <- paste(grpname, randomorder[count], sep = "")
      # we can do this in order because that order was already randomized
      count <- count + 1 # increment counter
    }
    if ( i <= numextra ) {
      # add one extra person as needed so that everyone has a group
      grpname <- paste(grpname, ", ", randomorder[count], sep = "")
      count <- count + 1
    }
    allGroupings[i] <- grpname
    cat(paste(grpname, "\n", sep = ""))
  }
  
  if ( returnlist ) {
    allGroupings <- charVecToList(allGroupings)
  }
  
  return(allGroupings)
}

# if you prefer a nested list structure rather than a character vector
charVecToList <- function( groupings = allGroupings, mysep = ", " ) {
  allGrpsList <- as.list( groupings )
  n <- length(groupings)
  for ( i in 1:n ) {
    allGrpsList[i] <- strsplit(groupings[i], mysep)
    names(allGrpsList)[i] <- paste("group", i, sep = "")
  }
  return(allGrpsList)
}

allGroupings <- groupPeopleRandomly()
#allGroupings <- groupPeopleRandomly(mingroupsize = 3)

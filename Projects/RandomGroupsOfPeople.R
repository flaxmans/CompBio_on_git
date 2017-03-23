# make groups of people at random from a list of names

groupPeopleRandomly <- function( filename = "~/Documents/Teaching/Computational_Biology/Students.csv", mingroupsize = 2 ) {
  classList <- read.csv( filename ) #assumes a list of names as a column with a header
  classnames <- as.character(classList[[1]]) # extract names as character vector
  
  nstudents <- length(classnames) # determine number of people
  
  randomorder <- sample( classnames, size = nstudents, replace = F ) # create a random ordering
  
  ngroups <- floor( nstudents/mingroupsize ) # number of working groups
  groupsize <- floor( nstudents / ngroups ) # in case the group size needs to be increased 
  # e.g., 12 students in groups of 5 each, actually needs to be two groups of 6 each
  
  numextra <- nstudents %% groupsize # use modulus operator to figure out uneven groups
  
  count <- 1
  for ( i in 1:ngroups ) {
    # make groups one at a time
    cat(paste("Group #", i, ":\t", sep = ""))
    for ( j in 1:groupsize ){
      # add people one at a time
      if ( j >1 ) {
        cat(", ") # make it easy to read
      }
      cat(randomorder[count])
      # we can do this in order because that order was already randomized
      count <- count + 1 # increment counter
    }
    if ( i <= numextra ) {
      # add one extra person as needed so that everyone has a group
      cat(paste(",", randomorder[count]))
      count <- count + 1
    }
    cat("\n")
  }
  return(randomorder)
}

myorder <- groupPeopleRandomly()

# pair up students at random!

pairStudentsRandomly <- function( filename = "~/Documents/Teaching/Computational_Biology/Students.csv", mingroupsize = 2 ) {
  classList <- read.csv( filename ) #assumes a list of names as a column with a header
  classnames <- as.character(classList[[1]]) # extract names as vector
  
  nstudents <- length(classnames)
  
  randomorder <- sample( classnames, size = nstudents, replace = F )
  
  ngroups <- floor( nstudents/mingroupsize ) # number of working groups
  groupsize <- floor( nstudents / ngroups ) # in case the group size needs to be increased 
  # e.g., 12 students in groups of 5 each, actually needs to be two groups of 6 each
  
  numextra <- nstudents %% groupsize # use modulus operator to figure out uneven groups
  
  count <- 1
  for ( i in 1:ngroups ) {
    for ( j in 1:groupsize ){
      cat(paste(randomorder[count], "\t\t", sep = ""))
      count <- count + 1
    }
    if ( i <= numextra ) {
      cat(paste(randomorder[count], "\t\t"))
      count <- count + 1
    }
    cat("\n")
  }
  return(randomorder)

}

myorder <- pairStudentsRandomly()

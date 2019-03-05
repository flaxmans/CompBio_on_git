mySafeWriteCSV <- function ( data = NULL, namebase = NULL, writeRowNames = FALSE ) {
  # function that makes sure "write.csv" does not over-write existing data files
  if ( is.null( namebase ) ) {  # check if a file name was actually given
    warning("Error!  No file name given!\n")
  } else if ( is.null(data) ) {  # check if data were actually given
    warning("Error!  No data given!\n")
  } else {
    # strip off file extension if present:
    filename <- getUnusedFilename(namebase, ".csv")
    cat(paste("Writing file to '", filename, "'\n", sep = ""))
    # finally, actually write the data to a file:
    write.csv(data, filename, row.names = writeRowNames)
  }
}

getUnusedFilename <- function(namebase, fileext = NA) {
  # function for finding file names that are not currently in use
  mystr <- strsplit(namebase, "\\.")[[1]]
  namebase <- mystr[1] # strip off extension (if it was there)
  if ( length(mystr) > 1 && is.na(fileext)) {
    # if file extension was included in file name
    fileext <- paste(".", mystr[length(mystr)], sep = "")
  } else if ( is.na(fileext) ) {
    # define default behavior when there is no obvious extension given: 
    fileext <- ".txt"
  } else {
    # deal with ext whether user gave "." or not
    fileext <- strsplit(fileext, "\\.")[[1]]
    fileext <- paste(".", fileext[length(fileext)], sep = "")
  }
  # create first name to try with extension:
  filename <- paste(namebase, fileext, sep = "") 
  counter <- 1 # variable for making new names in a logical sequence
  # use a while loop to find an unused name:
  while ( file.exists(filename) ) {
    filename <- paste(namebase, counter, fileext, sep = "")
    counter <- counter + 1
  }
  return(filename)
}

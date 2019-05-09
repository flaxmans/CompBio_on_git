# script to generate emails to students with results of final exam

################################
##  FUNCTIONS ##################
################################

## ------------- create message body ------------------ ##
createMessageBody <- function( studentName, scoreBreakdown )
{
  salutation <- paste("Dear ", studentName, ",\n\n", sep = "")
  
  msg <- "Below please find a breakdown of your final exam score, point by point.  The first column denotes the question, the second gives the maximum possible points, and the third gives your actual points earned on that question/part.  The last two lines indicate point totals and overall percentage, respectively.  Please note that I decreased the weighting of the parts of question 16 based upon feedback that question 16 was very hard.  Please let me know if you have any questions or concerns.\n\nHave a great summer,\nSam\n\n"
  
  postscript <- "\nP.S. My final challenge for myself was writing a script to generate these emails from the exam data.  If you're curious, check out https://github.com/flaxmans/CompBio_on_git/blob/master/ExampleScripts/FinalExamScoreEmails.R\n\n"
  
  msg <- paste(salutation, msg, scoreBreakdown, "\n", postscript, sep = "")
  
  return( msg )
}

# the following is a barely modified version of create.post.  
# The simple idea was to eliminate some of the messages that were unnessary for 
# my purposes
create.email.msg <- function (instructions = character(), 
                              description = "post", 
                              subject = "", 
                              method = getOption("mailer"), 
                              address = "the relevant mailing list", 
                              ccaddress = getOption("ccaddress", ""), 
                              filename = "R.post", info = character() ) 
{
  method <- if (is.null(method)) 
    "none"
  else match.arg(method, c("mailto", "mailx", "gnudoit", "none", 
                           "ess"))
  open_prog <- if (grepl("-apple-darwin", R.version$platform)) 
    "open"
  else "xdg-open"
  if (method == "mailto") 
    if (!nzchar(Sys.which(open_prog))) {
      browser <- Sys.getenv("R_BROWSER", "")
      if (!nzchar(browser)) {
        warning("cannot find program to open 'mailto:' URIs: reverting to 'method=\"none\"'")
        flush.console()
        Sys.sleep(5)
      }
      else {
        message("Using the browser to open a mailto: URI")
        open_prog <- browser
      }
    }
  body <- c(instructions, 
            "", info)
  none_method <- function() {
    disclaimer <- paste0("# Your mailer is set to \"none\",\n", 
                         "# hence we cannot send the, ", description, " directly from R.\n", 
                         "# Please copy the ", description, " (after finishing it) to\n", 
                         "# your favorite email program and send it to\n#\n", 
                         "#       ", address, "\n#\n", "######################################################\n", 
                         "\n\n")
    cat(c(disclaimer, body), file = filename, sep = "\n")
    cat("The", description, "is being opened for you to edit.\n")
    flush.console()
    file.edit(filename)
    cat("The unsent ", description, " can be found in file ", 
        sQuote(filename), "\n", sep = "")
  }
  if (method == "none") {
    none_method()
  }
  else if (method == "mailx") {
    if (missing(address)) 
      stop("must specify 'address'")
    if (!nzchar(subject)) 
      stop("'subject' is missing")
    if (length(ccaddress) != 1L) 
      stop("'ccaddress' must be of length 1")
    cat(body, file = filename, sep = "\n")
    cat("The", description, "is being opened for you to edit.\n")
    file.edit(filename)
    if (is.character(ccaddress) && nzchar(ccaddress)) {
      cmdargs <- paste("-s", shQuote(subject), "-c", shQuote(ccaddress), 
                       shQuote(address), "<", filename, "2>/dev/null")
    }
    else cmdargs <- paste("-s", shQuote(subject), shQuote(address), 
                          "<", filename, "2>/dev/null")
    status <- 1L
    answer <- readline(paste0("Email the ", description, 
                              " now? (yes/no) "))
    answer <- grep("yes", answer, ignore.case = TRUE)
    if (length(answer)) {
      cat("Sending email ...\n")
      status <- system(paste("mailx", cmdargs), TRUE, 
                       TRUE)
      if (status) 
        status <- system(paste("Mail", cmdargs), TRUE, 
                         TRUE)
      if (status) 
        status <- system(paste("/usr/ucb/mail", cmdargs), 
                         TRUE, TRUE)
      if (status == 0L) 
        unlink(filename)
      else {
        cat("Sending email failed!\n")
        cat("The unsent", description, "can be found in file", 
            sQuote(filename), "\n")
      }
    }
    else cat("The unsent", description, "can be found in file", 
             filename, "\n")
  }
  else if (method == "ess") {
    cat(body, sep = "\n")
  }
  else if (method == "gnudoit") {
    cmd <- paste0("gnudoit -q '", "(mail nil \"", address, 
                  "\")", "(insert \"", paste(body, collapse = "\\n"), 
                  "\")", "(search-backward \"Subject:\")", "(end-of-line)'")
    system(cmd)
  }
  else if (method == "mailto") {
    if (missing(address)) 
      stop("must specify 'address'")
    if (!nzchar(subject)) 
      subject <- "<<Enter Meaningful Subject>>"
    if (length(ccaddress) != 1L) 
      stop("'ccaddress' must be of length 1")
    # cat("The", description, "is being opened in your default mail program\nfor you to complete and send.\n")
    arg <- paste0("mailto:", address, "?subject=", subject, 
                  if (is.character(ccaddress) && nzchar(ccaddress)) 
                    paste0("&cc=", ccaddress), "&body=", paste(body, 
                                                               collapse = "\r\n"))
    if (system2(open_prog, shQuote(URLencode(arg)), FALSE, 
                FALSE)) {
      cat("opening the mailer failed, so reverting to 'mailer=\"none\"'\n")
      flush.console()
      none_method()
    }
  }
  invisible()
}


composeMessage <- function( studentFirstName, studentEmail, scoreBreakdown ) {
  msg <- createMessageBody( studentFirstName, scoreBreakdown )
  create.email.msg( address = studentEmail, 
                    subject = "Final exam breakdown for Computational Biology", 
                    instructions = msg, 
                    info = NULL)
}

dataFrameAsOneString <- function( mydf ) {
  # turn an entire  data frame into something that 
  # can be printed as characters
  myStr <- ""  # make an object that will grow dynamically
  for ( i in 1:length(names(mydf))) {
    myStr <- paste(myStr, names(mydf)[i]) # get the header
  }
  myStr <- paste(myStr, "\n", sep = "") # new line
  for ( i in 1:nrow(mydf) ) { # row-by-row
    for ( j in 1:ncol(mydf) ) { # column-by-column
      myStr <- paste(myStr, mydf[i,j], "\t") # tab delimited printing
    }
    myStr <- paste(myStr, "\n", sep = "") # newline
  }
  return(myStr)
}


main <- function( studentNamesEmails, studentFinalScores, 
                  metaCols, DEBUG = F,
                  SEND_EMAILS = T, MAKE_CANVAS_UPLOAD = T ) {
  
  if ( MAKE_CANVAS_UPLOAD ) {
    # take all columns but email address:
    canvasUpload <- data.frame(studentNamesEmails[, 1:ncol(studentNamesEmails)-1], FinalExam = rep(0, nrow(studentNamesEmails)))
    totalRowIndex <- grep("Raw Points", studentFinalScores$Question)
  }
  
  # loop over student ID info:
  for ( i in 1:nrow(studentNamesEmails)) {
    # parse first and last names
    firstName <- strsplit(studentNamesEmails$Student[i], ", ")[[1]][2]
    lastName <- strsplit(studentNamesEmails$Student[i], ", ")[[1]][1]
    email <- studentNamesEmails$email[i]
    
    # which column of final exam data to use:
    workingColumn <- which(names(studentFinalScores) == lastName)
    
    # create score breakdown for only this student:
    # and make it into one long string:
    scoreBreakdown <- dataFrameAsOneString(studentFinalScores[ , c(metaCols, workingColumn)])
    
    
    if( DEBUG ) {
      cat(paste(i, firstName, lastName, email, workingColumn, "\n", scoreBreakdown))
      #show(scoreBreakdown)
    }
    
    if ( SEND_EMAILS ) {
      composeMessage(studentFirstName = firstName, 
                     studentEmail = email, 
                     scoreBreakdown = scoreBreakdown)
    }
    if ( MAKE_CANVAS_UPLOAD ) {
      canvasUpload$FinalExam[i] <- studentFinalScores[totalRowIndex, workingColumn]
    } 

  }
  if ( MAKE_CANVAS_UPLOAD ) {
    return(canvasUpload)
  } else {
    return(NULL)
  }
}

# test:
# main( studentNamesEmails[1:2, ], studentFinalScores, metaCols, DEBUG = T )

####################################################
###      ACTIONS             #######################
####################################################


# exam score data:
studentFinalScores <- read.csv("~/compbio/Private_Files/FinalExamIdeas/FinalExamPointByPointGrading.csv", stringsAsFactors = F)

# get names and contact info:
studentNamesEmails <- read.csv("~/compbio/Private_Files/CanvasStudentData.csv", stringsAsFactors = F)
canvasColumnNames <- names(studentNamesEmails)
emailAddresses <- paste(studentNamesEmails$SIS.Login.ID, "@colorado.edu", sep = "")
studentNamesEmails <- data.frame(studentNamesEmails, email = emailAddresses)

# check that all students are accounted for in both data sets:
metaCols <- 1:2 # column indexes in studentFinalScores with metadata
numMetaCols <- length(metaCols)
nrow(studentNamesEmails) == (ncol(studentFinalScores) - numMetaCols)

## test it:
# myGradeSummary <- main( studentNamesEmails[1:2, ], studentFinalScores, metaCols, DEBUG = T )

## Run it!:
myGradeSummary <- main( studentNamesEmails, studentFinalScores, metaCols, SEND_EMAILS = F )
namesOfCols <- names(myGradeSummary)
names(myGradeSummary) <- gsub("\\.", " ", namesOfCols) # get rid of periods that read.csv() put in names
head(myGradeSummary)

# canvas names for uploads:
write.csv(myGradeSummary, file = "~/compbio/Private_Files/FinalExamCanvasUpload.csv", row.names = F)




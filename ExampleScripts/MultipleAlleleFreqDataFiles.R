## ----- number of variable loci over time ----- ##
combineNumVarTimeSeries <- function( mydir = "~/playground/bu2splay/", rundirs = NULL ) {
  orig <- getwd() # so we can get back to our starting point
  setwd( mydir ) # where the data directories should be
  
  if( is.null(rundirs) ) {
    rundirs <- list.dirs(recursive = F) # look at all directories by default
    print(rundirs)
  }
  myNames <- c("dir", "MutationTime", "nVariable", "m", "s", "N", "mut_per_gen")
  nVarTS <- as.data.frame(matrix(nrow = 0, ncol = length(myNames)))
  colnames(nVarTS) <- myNames
  for ( i in rundirs ){
    filename <- paste(i, "/", "NumberVariableLoci.txt", sep = "")
    zippedName <- paste(filename, ".bz2", sep = "")
    if ( file.exists(zippedName) ) {
      system(paste("bunzip2", zippedName))
    }
    # get data
    myData <- read.table(file = filename, header = F, sep = " ", stringsAsFactors = F)
    nobs <- nrow(myData)
    
    paramfile <- paste(i, "/", "testRconversion.R", sep = "")
    source(paramfile, local = T)
                        
    if ( exists("MUTATIONS_PER_GENERATION", envir = environment()) ) {
      myData[,1] <- myData[,1] * MUTATIONS_PER_GENERATION # standardize "time"
      mpg <- rep(MUTATIONS_PER_GENERATION, nobs)
      rm("MUTATIONS_PER_GENERATION")
    } else {
      mpg <- rep(1, nobs)
    }
    
    newdf <- data.frame(rep(i, nobs), 
                        myData[, 1:2],
                        rep(SD_MOVE, nobs), 
                        rep(MEAN_S, nobs), 
                        rep(N, nobs), 
                        mut_per_gen = mpg)
    rm(list = c("SD_MOVE", "MEAN_S", "N"))
    colnames(newdf) <- myNames
    
    
    nVarTS <- rbind(nVarTS, newdf)
  }
  setwd(orig) # return to staring directory
  return(nVarTS)
}

testNvar <- combineNumVarTimeSeries()

library(ggplot2)
ggplot( data = testNvar ) +
  geom_point( aes(x = MutationTime, y = nVariable, color = dir)) + 
  theme_gray(base_size = 18)


# try it with more data, a bunch of replicates
paramCombos <- read.csv(file = "~/playground/bu2splay/ParameterSummaryOfRuns.csv", stringsAsFactors = F)
# standardize time for different mutation rates:
paramCombos$mut_per_gen[is.na(paramCombos$mut_per_gen)] <- 1
mutationTime <- paramCombos$total_gens * paramCombos$mut_per_gen
paramCombos <- data.frame(paramCombos, mutationTime)

# pick a few values based upon previous experience:
mvals <- 0.1
svals <- c(0.01, 0.02)
Nvals <- c(4000, 40000)


# figure out which runs match using the parameter combo summary:
library(dplyr)
matchingRunDirs <- paramCombos %>%
  filter(m %in% mvals & s %in% svals & N %in% Nvals & !is_neutral_model & !is_allopatry_model & fracSelLoci < 1 & endPerAllo <= 0 & startPerAllo <= 0 & secCntctMut <= 0 & mut_per_gen %in% c(10, 100))

nrow(matchingRunDirs)
# looks like 71 directories
system.time( nVarTS <- combineNumVarTimeSeries(mydir = "/Volumes/4TB_USB_SG2/", rundirs = matchingRunDirs$Directory) )

ggplot( data = nVarTS ) +
  geom_point( aes(x = MutationTime, y = nVariable, color = dir)) + 
  facet_grid( rows = vars(N), cols = vars(s), scales = "free") +
  geom_smooth( aes(x = MutationTime, y = nVariable, linetype = as.factor(mut_per_gen)) ) + 
  guides(color = F) + 
  theme_gray(base_size = 16) +
  theme(legend.position="top")  +
  xlab("time x mutations/gen") + 
  ylab("number of variable sites in genome")
  # scale_y_log10()


## ----------------------------------------------------------------------##


# allele frequency differences:

testAF <- read.table(file = "~/playground/bu2splay/Run206600/afts.txt", sep = " ", stringsAsFactors = F, header = T)
head(testAF)

library(ggplot2)
ggplot(testAF, aes(x = totalGenerationsElapsed, y = AFdiff)) +
  geom_point()

ggplot(testAF, aes(x = totalGenerationsElapsed, y = abs(AFdiff))) +
  geom_point()

library(dplyr)
testAF %>%
  group_by(totalGenerationsElapsed) %>%
  summarise(meanAFD = mean(abs(AFdiff))) %>%
  ggplot( aes(x = totalGenerationsElapsed, y = meanAFD)) +
    geom_point() + 
    geom_smooth()

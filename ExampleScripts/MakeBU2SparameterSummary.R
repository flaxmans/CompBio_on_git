makeParameterSummary <- function( dirname = "~/playground/bu2splay/", DEBUG = T) {
  
  setwd( dirname )
  dirsHere <- read.table("dirsHere.txt", header = F, stringsAsFactors = F)[,1]
  nDirs <- length(dirsHere)
  
  # pre-allocate places for parameter values to go:
  s_coeffs <- rep(0, nDirs) # mean selection coefficients
  mig_rates <- rep(0, nDirs) # migration probability per individual
  total_gens <- rep(0, nDirs) # actual duration of a simulation
  total_muts <- rep(0, nDirs) # actual number of mutations introduced
  mut_per_gen <- rep(0, nDirs) # mutations introduced per generation
  ri_status <- rep(F, nDirs) # whether or not RI threshold was reached
  total_pop_size <- rep(0, nDirs) # population size across all demes
  is_neutral_model <- rep(F, nDirs) # if a model had NO selection
  is_allopatry_model <- rep(F, nDirs) # if a model NEVER had migration
  gpm <- rep(0, nDirs) # gamete production mode (beanbag, meiosis, or meiosis with chromosomes)
  
  
  # loop over directories
  for ( i in 1:nDirs ) {
    dirname <- dirsHere[i]
    # source the values from the readable script
    source(paste(dirname,"/testRconversion.R", sep = ""), local = T)
    
    # add the data to the arrays
    s_coeffs[i] <- MEAN_S
    mig_rates[i] <- SD_MOVE
    total_gens[i] <- totalGenerationsElapsed
    total_muts[i] <- totalMutationsIntroduced
    total_pop_size[i] <- N
    gpm[i] <- GAMETE_PRODUCTION_MODE
    ri_status[i] <- RI_REACHED == 1
    
    # some directories/runs didn't have certain parameters
    # these discovered from error messages
    if ( exists( "PURE_NEUTRAL_MODEL" ) ) {
      is_neutral_model[i] <- PURE_NEUTRAL_MODEL == 1
    } else {
      is_neutral_model[i] <- NA
    }
    if ( exists("PURE_ALLOPATRY_MODEL")) {
      is_allopatry_model[i] <- PURE_ALLOPATRY_MODEL == 1
    } else {
      is_allopatry_model[i] <- NA
    }
    if ( exists("MUTATIONS_PER_GENERATION")) {
      if ( DEBUG ) {
        # some debugging stuff:
        mut_per_gen[i] <- MUTATIONS_PER_GENERATION
        expected1 <- (MUTATIONS_PER_GENERATION * totalGenerationsElapsed + MUTATIONS_PER_GENERATION - 1)
        expected2 <- totalGenerationsElapsed * MUTATIONS_PER_GENERATION
        if ( totalMutationsIntroduced != expected1 & totalMutationsIntroduced != expected2 ) {
          cat("\nIn: ")
          cat(dirname)
          cat("\nBad totalMutationsIntroduced value: showing totMut, Mut/gen, totGen\n\t")
          cat(c(totalMutationsIntroduced, MUTATIONS_PER_GENERATION, totalGenerationsElapsed))
          cat("\n")
        }
        # end debugging stuff
      }
    } else {
      mut_per_gen[i] <- NA
    }
    
    
    
    # clean up to be sure we don't copy wrong data
    # "ListOfParameterNames.txt" produced from shell script named:
    #     "CompBio_on_git/ExampleScripts/ParameterParsing.sh"
    parameterNames <- read.table(paste(dirname,"/ListOfParameterNames.txt", sep = ""), 
                                 header = F, 
                                 stringsAsFactors = F)[,1]
    rm(list = parameterNames)
  }
  
  parameterCombos <- data.frame(Directory = dirsHere, 
                                s = s_coeffs, 
                                m = mig_rates, 
                                total_gens = total_gens,
                                total_mutations = total_muts,
                                N = total_pop_size,
                                is_neutral_model = is_neutral_model,
                                is_allopatry_model = is_allopatry_model,
                                gpm = gpm,
                                mut_per_gen = mut_per_gen,
                                RI = ri_status)
  return(parameterCombos)
  
}

testParameterCombos <- makeParameterSummary()

testParameterCombos

system.time( allParameterCombos <- makeParameterSummary("/Volumes/4TB_USB_SG2/"))
# first try took 129 seconds and returned no errors!

head(allParameterCombos, n = 50)


# visualize some results for fun:
# RI reached or not by s and m
myjit <- 0.001
library(ggplot2)
ggplot(allParameterCombos, mapping = aes(x = s, y = m)) + 
  geom_jitter(aes(color = RI), height = myjit, width = myjit)

# subset data for more manageable analysis
mySubset <- subset( allParameterCombos, m > 0.001 & s > 0 & (is.na(is_neutral_model) | !is_neutral_model) &  (is.na(is_allopatry_model) | !is_allopatry_model) & ( N %in% c(400, 4000, 40000)))

myjit <- 0.001
ggplot(mySubset, mapping = aes(x = s, y = m)) + 
  geom_jitter(aes(color = RI), height = myjit, width = myjit)

ggplot(mySubset, mapping = aes(x = s, y = (total_mutations))) + 
  geom_smooth(aes(color = as.factor(m)), method = lm) + 
  facet_wrap( ~ N )

#############################################################
# machine learning with support vector machines:
library(e1071)
myData = data.frame(s = mySubset$s, 
                 m = mySubset$m,
                 RI = as.factor(mySubset$RI))
svmfit = svm(RI ~ m + s, data = myData, kernel = "radial", cost = 10)
print(svmfit)
plot(svmfit, myData)





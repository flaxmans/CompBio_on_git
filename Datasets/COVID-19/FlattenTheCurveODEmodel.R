# Toy Model of Social Distancing and Flattening the Curve

# DISCLAIMER:  This is a **TOY** model.  It is a very simple model inspired by recent events, but 
# not meant in any way to reflect paramters associated with these events, as such parameters are 
# still being investigated by epidemiologists.
# Thus, the purposes of this code are ONLY to: 
    #   (1) show how a simple model can illustrate "flattening the curve" via social distancing
    #   (2) show how to use the ode() solver in R for a basic epidemiological model

# This code is provided with absolutely NO warranty of any kind.  No fitness of this code
# for any applied use is claimed or intended.  In other words, don't use this code to make  
# claims about real life.  


####################################################################################################

# The model is an SIIR model: Individuals that are susceptible to infection can become infected
# by coming into contact with individuals in either the "incubating and symptom free" (henceforth, "incubating")
# class or the "infectious and sick with symptoms" (henceforth, "sick") class.  
# Individuals transition from the incubating class to the sick class, and from the sick class to the 
# recovered class.  There is no death in this model.  There are no births, immigration, or emigration.
# Transmission is by mass action.
# The model has 6 parameters:
  # beta1 = transmission rate constant between susceptible and incubating; has units of 1/(days * persons)
  # beta2 = transmission rate between susceptible and sick; has units of 1/(days * persons)
  # reduce1 = potential reduction in transmission (0 = complete reduction, 1 = none) due to social distancing of susceptible and incubating; unitless (proportion between 0 and 1)
  # reduce2 = potential reduction in transmission (0 = complete reduction, 1 = none) due to social distancing of susceptible and sick; unitless (proportion between 0 and 1)
  # sickenRate = rate at which incubating transition to sick; has units of 1/days
  # recoveryRate = rate at which sick transition to recovered; has units of 1/days

#############################################################################
##   FUNCTIONS DEFINED FOR LATER USE
#############################################################################

# function expressing the ODE model
siirModel <- function(t, y, parms) {
  # 4-D system, y[1] is susceptible, y[2] incubating and infectious, 
  # y[3] sick and infectious, y[4] recovered
  
  # the ODEs:
  # losses only from Susceptible, y[1], from infection by two infectious classes
  dy1dt <- -(parms$beta1 * parms$reduce1 * y[1] * y[2]) - (parms$beta2 * parms$reduce2 * y[1] * y[3]) 
  # gains from susceptible, losses from becoming sick
  dy2dt <- (parms$beta1 * parms$reduce1 * y[1] * y[2]) + (parms$beta2 * parms$reduce2 * y[1] * y[3]) - (parms$sickenRate * y[2])
  # gains from those that sicken
  dy3dt <- (parms$sickenRate * y[2]) - (parms$recoveryRate * y[3])
  dy4dt <- (parms$recoveryRate * y[3])
  
  
  # the function must return a list
  # return( list( susceptible = dy1dt, incubating = dy2dt, sick = dy3dt, recovered = dy4dt ) )
  return( list( c( dy1dt, dy2dt, dy3dt, dy4dt ) ) )
}

# convenient way to create list of default parameters
defaultParameters <- function() {
  beta1 <- 0.000003 # mass action constant
  beta2 <- beta1
  reduce1 <- 1 # no reduction
  reduce2 <- 0.5 # obviously sick reduce infectious through behavior
  sickenRate <- 1/5 # five days average incubating before sick
  recoveryRate <- 1/7 # seven days average obviously sick and potentially infectious
  
  parameters <- list( beta1 = beta1,
                      beta2 = beta2, 
                      reduce1 = reduce1,
                      reduce2 = reduce2,
                      sickenRate = sickenRate,
                      recoveryRate = recoveryRate )
  
  return( parameters )
}


# some potentially useful prints
printReport <- function(solution, context){
  
  recoveredCol <- 5
  sickCol <- 4
  
  cat(paste("\nOverall percentage that got sick with ", 
            context, 
            " = ", 
            round(100 * solution[nrow(solution), recoveredCol] / nTotal, digits = 1), 
            "%\n", 
            sep = "" ))
  
  maxSymptoms <- (max(solution[, sickCol]))
  
  dayMax <- which((solution[, sickCol]) == maxSymptoms)
  
  cat(paste("\nmax num with symptoms in one day with ",
            context,
            " = ", 
            round(max(solution[, sickCol])), 
            " on day ", 
            dayMax, 
            "\n", 
            sep = "" ))
  
}

#############################################################################
##   ESTABLISH INITIAL CONDITIONS
#############################################################################
# initial conditions:
nTotal <- 100000 # suppose a city of 100000
initIncubating <- 5 # 5 initially infectious people incubating
initSick <- 5 # number with symptoms
initRecovered <- 0
n0 <- c( (nTotal - (initIncubating + initSick + initRecovered)), initIncubating, initSick, initRecovered )

totalTime <- 365 # days
timeIncrement <- 1 # one day at a time
times <- seq(from = 0, to = totalTime, by = timeIncrement)

# package needed:
require("deSolve")

#############################################################################
##   BASE CASE: NO SOCIAL DISTANCING
#############################################################################
parameters <- defaultParameters()
parameters$reduce1 <- 1 # no social distancing
# call the solver:
NoDistancing <- ode(y = n0, times = times, func = siirModel, parms = parameters)
# note about results in NoDistancing object: column 1 = time, column 2 = susceptible, 
# column 3 = incubating, column 4 = sick, column 5 = recovered

#############################################################################
##   SOCIAL DISTANCING
#############################################################################
parameters <- defaultParameters()
parameters$reduce1 <- 0.5 # 50% effective social distancing
Distancing <- ode(y = n0, times = times, func = siirModel, parms = parameters)
# note about results in Distancing object: column 1 = time, column 2 = susceptible, 
# column 3 = incubating, column 4 = sick, column 5 = recovered


#############################################################################
##   EXAMINING RESULTS
#############################################################################
printReport( NoDistancing, "no distancing" ); printReport( Distancing, "distancing")


# Get data in shape for a nice ggplot:
plotResults <- data.frame( time = NoDistancing[,1], 
                           no_distancing = NoDistancing[,4], 
                           distancing = Distancing[,4])
require("tidyr")
myData <- gather( plotResults, no_distancing, distancing, key = "model", value = "num.sick")

# make a plot:
require("ggplot2")
ggplot( myData, aes( x = time, y = num.sick ) ) + 
  geom_line( aes( col = model )) + 
  geom_polygon( aes( fill = model ), alpha = 0.5 ) +
  labs( x = "Days", y = "Number sick on given day", title = "Flattening the curve") + 
  theme_classic()


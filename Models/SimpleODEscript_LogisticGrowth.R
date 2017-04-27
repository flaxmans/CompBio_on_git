library("deSolve")

# parameters and initial states
r <- 2.8
k <- 1000
n0 <- 10
endTime <- 25
timeIncrement <- 0.01

# objects required by the solver:
times <- seq(from = 0, to = endTime, by = timeIncrement)
parms <- list(r,k)
names(parms) <- c("r","k")

# function required by the solver:
myLogisticODE <- function(t, y, parms) {
  # to use with ode(), this function MUST have at  
  # least three arguments, and they MUST be in the order shown (t, y, parms)
  
  # here is the ODE: 
  dydt <- y * parms$r * (( parms$k - y ) / parms$k)
  
  # the function must return a list
  return( list(dydt) )
}

# call solver:
solution <- ode(y = n0, times = times, func = myLogisticODE, parms = parms)
# visualize results
plot(solution[,1], solution[,2], type = "l", xlab = "time", ylab = "abundance")

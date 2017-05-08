########################
# a 2-D ODE model: the logistic competition model
competitionODE <- function(t, y, parms) {
  #since this is a 2-D system, y should be a 2-element vector
  # the ODEs:
  dy1dt <- y[1] * parms$r1 * (( parms$k1 - y[1] - parms$a21*y[2] ) / parms$k1)
  dy2dt <- y[2] * parms$r2 * (( parms$k2 - y[2] - parms$a12*y[1] ) / parms$k2)
  
  # the function must return a list
  return( list(c(dy1dt, dy2dt)) )
}

# set parameters and intial conditions:
r1 <- 0.1 # intrinsic rate of increase
r2 <- r1 # make it the same for simplicity for now
k1 <- 1000 # carrying capacity
k2 <- k1 # make it the same for now for simplicity
a12 <- 0.8 # competition coefficients
a21 <- 0.7
logisticParms <- as.list(c(r1, k1, r2, k2, a12, a21))  
# add names. make sure order is correct compared to previous line!!
names(logisticParms) <- c("r1", "k1", "r2", "k2", "a12", "a21") 
n0 <- c(10,20) # initial values

times <- seq(from = 0, to = 400, by = 0.01) # time vector

# call the ode solver:
solution <- ode(y = n0, times = times, func = competitionODE, parms = logisticParms)
# check out some properties of what you get back from the solver:
dim(solution)
str(solution)
# graphics:
sp1col = "red"
sp2col = "blue"
par(mfrow = c(1,1))
plot(solution[,1], solution[,2], type = "l", 
     xlab = "time", ylab = "abundance", col = sp1col, 
     ylim = c(0,max(k1,k2)))
lines(solution[,1], solution[,3], col = sp2col)
legend(x = 0, y = min(k1,k2), legend = c("species 1", "species 2"), 
       lty = c(1,1), col = c(sp1col, sp2col))


###########
# compare two parameter cases:
# set parameters and intial conditions:
r1 <- 0.1 # intrinsic rate of increase
r2 <- r1 # make it the same for simplicity for now
k1 <- 1000 # carrying capacity
k2 <- k1 # make it the same for now for simplicity
a12 <- c(0.8, 1.2) # competition coefficients
a21 <- c(0.7, 1.3) # 
n0 <- c(10,85) # initial values
times <- seq(from = 0, to = 400, by = 0.01) # time vector
par(mfrow = c(1,length(a12)))
sp1col = "red"
sp2col = "blue"

for ( i in 1:length(a12) ) {
  logisticParms <- as.list(c(r1, k1, r2, k2, a12[i], a21[i]))  
  # add names. make sure order is correct compared to previous line!!
  names(logisticParms) <- c("r1", "k1", "r2", "k2", "a12", "a21") 
  # call the ode solver:
  solution <- ode(y = n0, times = times, func = competitionODE, parms = logisticParms)
  
  # graphics:
  plot(solution[,1], solution[,2], type = "l", 
       xlab = "time", ylab = "abundance", col = sp1col, 
       ylim = c(0,max(k1,k2)))
  lines(solution[,1], solution[,3], col = sp2col)
  title(main = paste("a12 = ", a12[i], ", a21 = ", a21[i], sep = ""))
  if ( i == 1 ) {
    legend(x = 0, y = min(k1,k2), legend = c("species 1", "species 2"), 
           lty = c(1,1), col = c(sp1col, sp2col))
  }
  
}


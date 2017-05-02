# Make your own Lorenz attractor beautiful "butterfly" diagrams
# with lots of help from: https://cran.r-project.org/web/packages/deSolve/vignettes/deSolve.pdf 

library(deSolve)

# paramters:
a <- -8/3
b <- -10
cc <- 28
parms <- list(a, b, cc)
names(parms) <- c("a", "b", "cc")

#time vector
timePoints <- seq(0, 100, 0.01)

# initial conditions for 3-dimensional system
y0 <- c(1, 1, 1)

# ODE function giving the three equations
myLorenz <- function(t, y, parms) {
  dX <- (parms$a * y[1]) + (y[2] * y[3])
  dY <- parms$b * ( y[2] - y[3] )
  dZ <- -(y[1] * y[2]) + (parms$cc * y[2]) - y[3] 
  return(list(c(dX, dY, dZ)))
}

# call it:
sols <- ode(y = y0, times = timePoints, func = myLorenz, parms = parms)

# first make plots of each variable as a function of time:
par(mfrow = c(3,1))
plot(sols[,1], sols[,2], type = "l", col = "red", xlab = "time", ylab = "X")
plot(sols[,1], sols[,3], type = "l", col = "red", xlab = "time", ylab = "Y")
plot(sols[,1], sols[,4], type = "l", col = "red", xlab = "time", ylab = "Z")

# now make the famous parametric plots (time implicit)
par(mfrow = c(2,2))
plot(sols[,3], sols[,2], type = "l", col = "red", xlab = "Y", ylab = "X")
plot(sols[,3], sols[,4], type = "l", col = "red", xlab = "Y", ylab = "Z")
plot(sols[,4], sols[,2], type = "l", col = "red", xlab = "Z", ylab = "X")

# get funky:
library("plot3D")
par(mfrow = c(1,1))
lines3D(x = sols[,4], y = sols[,3], z = sols[,2], xlab = "Z", ylab = "Y", zlab = "X", colvar = sols[,1])
# here, time is color variable, with "bluer" times being earlier and "redder" times being later
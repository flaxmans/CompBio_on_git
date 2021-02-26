# Create a variable named x and assign a numeric value of your choosing to it. 
# On the next line of code, write an if-else statement that checks if the value is larger than 5. 
# Your code should print a message about whether the value is larger or smaller than 5.

# simplest example of "if"
x <- 22
if ( x > 5 ) {
  print("x is greater than 5")
}

# how about adding else?
x <- 3
if ( x > 5 ) {
  print("x is greater than 5")
} else {
  print("x is not greater than 5")
}

# how about doing away with magic numbers?
x <- 22
threshold <- 5
if ( x > threshold ) {
  print(paste("x ( =",x,") is greater than", threshold))
} else {
  print(paste("x ( =",x,") is NOT greater than", threshold))
}

# How about a vector for comparison, and with a loop?
x <- seq(from = 0.5, to = 10.5, by = 1)
threshold <- 5
for( i in 1:length(x) ) {
  if ( x[i] > threshold ) {
    print(paste("x[",i,"] ( =", x[i],") is greater than", threshold))
  } else {
    print(paste("x[",i,"] ( =", x[i],") is less than or equal to", threshold))
  }
}

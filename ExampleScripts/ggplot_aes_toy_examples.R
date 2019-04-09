# make a small data frame to play with:
var1 <- 1:10
var2 <- 11:20
mytreatment <- c(rep("A",5), rep("B",5))
mydata <- data.frame(var1 = var1, var2 = var2, treatment = mytreatment)
head(mydata)

#############################################################
## Some intial plots of a couple types to demonstrate aes():
library("ggplot2")
# boxplot by treatment:
p1 <- ggplot(mydata, aes(x = treatment, y = var2)) + geom_boxplot()
# another way of doing a similar plot to p1:
p1g <- ggplot(mydata, aes(group = treatment, y = var2)) + geom_boxplot()
# standard y ~ x plot using continuous variables:
p2 <- ggplot(mydata, aes(x = var1, y = var2)) + geom_line()

# view plots:
p1
p1g # note differences from p1: x axis is given arbitrary values!
p2

# adding another dimension to the mapping:
p3 <- ggplot(mydata, aes(x = var1, y = var2, color = treatment)) + 
  geom_line()
p3

# viewing multiple plots in a single object for comparison:
cowplot::plot_grid(p1,p2,p3, nrow = 1)

# a silly example that proves you can use categorical variables 
# on any axis:
ggplot(mydata, aes(y = treatment, x = var2)) + geom_line()

# this works, but it shouldn't
ggplot(mydata, aes(y = var2, LOLCATS = treatment)) + 
  geom_boxplot()

# this makes the same plot as the previous one, but at least it gives
# a warning message
ggplot( mydata ) + 
  geom_boxplot( aes(y = var2, LOLCATS = treatment) )

#################################################################
# playing with mappings vs. appearances:
# two lines:
p1 <- ggplot(mydata, aes(x = var1, y = var2, linetype = treatment)) + geom_line()
p2 <- ggplot(mydata, aes(x = var1, y = var2)) + geom_line( linetype = "dashed")
cowplot::plot_grid(p1,p2, nrow = 1)

# a few different boxplots:
b1 <- ggplot(mydata) + 
  geom_boxplot(aes(y = var2, linetype = treatment))

b2 <- ggplot(mydata) + 
  geom_boxplot(aes(x = treatment, y = var2))

b3 <- ggplot(mydata) + 
  geom_boxplot(aes(treatment, var2, linetype = treatment))

b4 <- ggplot(mydata) + 
  geom_boxplot(aes(treatment, var2), linetype = "dashed")

cowplot::plot_grid( b1, b2, b3, b4, labels = letters[1:4])

# Two ways to NOT get a legend:
b3 + scale_linetype_discrete(guide = F)
b3 + guides( linetype = F )


###################################################################
## More aesthetics inside and outside of mappings

treat2 <- c("D","D", rep("C", 5), rep("D", 3))
mydata <- data.frame(x = sin(var1), y = cos(var1), treatment1 = mytreatment, treatment2 = treat2)
head(mydata)

# Here is a typical example of mapping with aesthetics.  
# Note use of objects in aes() call:
p1 <- ggplot(mydata) + 
  geom_line(aes( x, y, color = treatment1, linetype = treatment2 )) +
  geom_point( aes( x, y, shape = treatment2 ))

# Here is a typical example of optional aesthetic arguments 
# given outside of aes().  
# Note use of values as part of optional arguments:
p2 <- ggplot(mydata) + 
  geom_line( aes( x, y ), 
             color = "red", linetype = "dashed" ) +
  geom_point( aes( x, y ), shape = 12 ) + 
  
cowplot::plot_grid(p1,p2)

###########################################################
## Demonstrating Inheritance of aes() mappings

# error-producing code:
ggplot( mydata ) + 
  geom_line( aes( x, y, color = treatment1 ) ) +
  geom_point( aes( shape = treatment2 ) )
# that produces the following error:
# Error: geom_point requires the following missing aesthetics: # x, y


# But the following will run without errors:
ggplot( mydata, aes(x, y) ) + 
  geom_line( aes( color = treatment1 ) ) +
  geom_point( aes( shape = treatment2 ) )



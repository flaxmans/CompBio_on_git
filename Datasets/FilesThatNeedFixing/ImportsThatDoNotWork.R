rm(list = ls())
setwd("~/compbio/CompBio_on_git/Datasets/FilesThatNeedFixing/")

# Try each and inspect the results
# see the README at https://github.com/flaxmans/CompBio_on_git/tree/main/Datasets/FilesThatNeedFixing for more details

edgeList <- read.table("EdgeList.txt", sep = "\t") # should import with three columns
chromosomeNumbers <- read.table("ChromosomeNumber.txt", sep = "\t") # should import with six columns
catAndDoge <- read.csv("DoubleSpacedWindowsNewlines.txt", stringsAsFactors = F)

mooresLawData <- read.csv("moore.csv", stringsAsFactors = F) # should import with six columns
mooresLawData <- read.table("moore.csv", 
                            sep = "\t",
                            stringsAsFactors = F) # should import with six columns


###################################################################################
## Exercises with cleaned up moore's law data:
###################################################################################
system("bash cleanUpMooreData.sh") # needed to make the .csv used in next command
mooresLawData <- read.csv("cleaned_moore.csv", stringsAsFactors = F) # that works!
# make a plot to demonstrate moore's law
# It says that the number of transistors per dense integrated circuit doubles about once every two years, which would mean exponential growth:
ggplot( data = mooresLawData, mapping = aes(x = Year, y = TransistorCount) ) +
  geom_point( ) +
  labs(x = "year", y = "transistor count", title = "note exponential growth")

# exponential growth should be linear on a log scale:
ggplot( data = mooresLawData, mapping = aes(x = Year, y = log(TransistorCount)) ) +
  geom_point( ) +
  geom_smooth( method = "lm" ) +
  labs(x = "year", y = "ln(transistor count)", title = "Exponential growth appears linear on log scale")

# our model from the last plot:  log(trcount) = slope * year + intercept
# with model given above, let's solve for doubling time and see if the data support Moore's law
# first equation:  log(trcount) = slope * year + intercept
  # rearranged: trcount = exp(slope * year + intercept)
# Second equation represents time to doule from first time:
  # log(2 * trcount) = slope * (year + doublingTime) + intercept
# rearrange second equation:
  # trcount = exp(slope * (year + doublingTime) + intercept)/2
  # substitute that result into the rearranged first equation:
# after substitution:
  # exp(slope * year + intercept) = exp(slope * (year + doublingTime) + intercept)/2
  # take log of both sides to remove exp:
  # slope * year + intercept = slope * (year + doublingTime) + intercept - log(2)
  # rearranging that by subtracting intercept from both sides and then dividing both sides by slope:
    # year = year + doublingTime - log(2)/slope
    # and thus:  log(2)/slope = doublingTime
x <- mooresLawData$Year
y <- log(mooresLawData$TransistorCount)
mooreFit <- lm(formula = y ~ x) # basic linear regression
slope <- mooreFit$coefficients['x']
doublingTime <- log(2)/slope # see preceding comments for derivation
cat(paste("\nDoubling time from linear regression is: ", doublingTime, "years \n\n"))
cat(paste("\nR-squared is :", summary(mooreFit)$r.squared, "\n\n" ))

# Note how close that is to two years!
# confidence interval on slope expressed in doubling time:
log(2) / confint(mooreFit, 'x')



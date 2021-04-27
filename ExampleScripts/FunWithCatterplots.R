# fun with CatterPlots

# all of the following adopted from the examples given at the CatterPlots home page:
# https://github.com/Gibbsdavidl/CatterPlots 

# if you need to install the CatterPlots package, uncomment and run the following:
# library(devtools)
# install_github("Gibbsdavidl/CatterPlots")

makeImportantFigures <- function(){
  x <- -3:5
  meow1 <- CatterPlots::rainbowCats(x, -sin(x), ptsize=2, 
                                    catshiftx=0.7, catshifty = 0.5,
                                    canvas = c(0, 1.75, -0.5, 1.5))
  
  x <- seq(from = 0, to = 1, by = 0.02)
  y <- rnorm(length(x))
  y <- y - min(y)
  y <- y / (max(y))
  
  meow2 <- CatterPlots::multicat(xs=x, ys=y,
                                 cat=1:11,
                                 catcolor=list('#33FCFF', '#78ace8', '#ff0000', 
                                               '#ffff00', '#0000ff', '#ffa500', 
                                               '#008000', '#283445'),
                                 canvas=c(-0.1,1.1, -0.1, 1.1),
                                 xlab="Meow", ylab="Purr", main="Random Cats Wish You All the Best!")
}

makeImportantFigures()


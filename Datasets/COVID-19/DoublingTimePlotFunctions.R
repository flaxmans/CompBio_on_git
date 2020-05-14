addDoubRefLines <- function( dataToPlot, doublingPeriods, myylim, p ) {
  
  # arguments:
  # dataToPlot: data frame having real data that were used
  # doublePeriods: vector of double periods (in days) for reference lines
  # myylim: limits on y-axis display
  # p: the ggplot object that the lines should be added to
  
  # preallocate objects for end points
  endx <- rep(0, length(doublingPeriods))
  endy <- endx
  endPoints <- data.frame(endx, endy)
  
  # plot the reference lines
  nPeriods <- length(doublingPeriods)
  
  init <- dataToPlot$count[1] # initial abundance
  
  for ( i in 1:nPeriods ) {
    dp <- doublingPeriods[i] # focal doubling period
    # calculate ref lines:
    refx <- dataToPlot$days
    refy <- init * ( 2^(refx / dp) )
    keepThese <- refy <= myylim
    plotNow <- data.frame(refx, refy)
    plotNow <- subset( plotNow, refy <= myylim )
    p <- p + geom_line( data = plotNow, 
                        mapping = aes( x = refx, y = refy ), 
                        linetype = "dashed", 
                        color = "gray")
    endPoints[i, ] <- plotNow[ nrow(plotNow), ]
  }
  
  p <- p + geom_label( data = endPoints, 
                       mapping = aes( x = endx, y = endy ),
                       label = paste(doublingPeriods, "days"), 
                       color = "gray",
                       vjust = 0)
  
  return(p)
}

doublingTimePlot <- function( dataVec, thresh, doublingPeriods, varname, myTitle = NULL ) {
  # arguments: 
  # dataVec is a vector of daily time series data
  # thresh is the starting value of numbers of cases/deaths that will determine which day is "day 0"
  # doublingPeriods is a vector of user-desired doubling periods for reference lines
  # varname is a string for displays, such as "case" or "death"
  # myTitle is for adding a title to the graph
  
  # 1. threshold the data and set them up:
  dataVec <- dataVec[ dataVec >= thresh ]
  daysSince <- 0:(length(dataVec) - 1)
  dataToPlot <- na.omit( data.frame( count = dataVec,
                                     days = daysSince ))
  
  # Some useful variables for customizing the plot:
  smallest <- min(dataToPlot$count)
  largest <- max(dataToPlot$count)
  smallestP10 <- floor( log10(smallest) )
  largestP10 <- round( log10( largest ) + 0.5 )
  myylims <- c(0.9*smallest, largest/0.9)
  myBreaks <- sort(c( 10^(smallestP10:largestP10), 
                      5*10^(smallestP10:largestP10), 
                      2*10^(smallestP10:largestP10) ))
  
  # 2. Create the plot of the actual real data:
  p <- ggplot() +
    geom_line( data = dataToPlot, mapping = aes( x = days, y = count ) ) 
  
  # 3. Add doubling reference lines using function above:
  p <- addDoubRefLines( dataToPlot, doublingPeriods, myylims[2], p )
  
  # 4. finish up presentation aspects:
  p <- p + scale_y_continuous( trans = "log10", 
                               breaks = myBreaks,
                               minor_breaks = NULL,
                               limits = myylims ) + 
    theme_bw() + 
    labs( x = paste("Days since ", thresh, "th ", varname, sep = ""), 
          y = paste("Total ", varname, "s", sep = ""),
          title = myTitle)
  
  return(p)
}

calcWindowIndexes <- function( ny, position, windowSize ) {
  hws <- floor(windowSize / 2) # half window size
  myMin <- max(1, position - hws)
  myMax <- min( ny, position + hws )
  return( myMin:myMax )
}


calcRollingAvg <- function( y, stratifyby = NULL, windowsize = 7 ) {
  rollingAvg <- y # preallocate
  ny <- length(y)
  if ( is.null(stratifyby) ) {
    # no subgroups
    for ( i in 1:length(y) ) {
      rollingAvg[i] <- mean( y[ calcWindowIndexes(ny, i, windowsize) ])
    }
  } else {
    subgroups <- unique(stratifyby)
    n <- length(subgroups)
    for ( j in 1:n ) {
      wg <- subgroups[j] # working group
      wi <- which( stratifyby == wg ) # working indexes
      nwi <- length(wi) # number of working indexes
      wvec <- y[wi] # working vector of raw data
      results <- wvec # preallocate a temp object for rolling avg calcs
      for ( i in 1:nwi ) {
        results[i] <- mean( wvec[ calcWindowIndexes(nwi, i, windowsize)] )
      } # end inner for loop over i
      # match up data to proper indexes:
      rollingAvg[wi] <- results
    } # end outer for loop over j
  } # end subgroup handling else clause
  return( rollingAvg )
}

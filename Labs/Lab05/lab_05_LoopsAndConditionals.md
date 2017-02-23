#Lab 05: Loops and Conditionals###ObjectivesThe main learning goals of this lab activity are to:  1.	Understand how to implement an "if" statement in your code2.	Write loops that perform calculations AND check the validity of them3.	Use a loop to perform iterative (recursive) calculations of the type that are common in models of population biologySome broad (course-level, semester-long) learning goals that this exercise may relate to:1.	Be able to create and use data structures to store data from your own computer programs2.	Translate words into equations3.	Translate words and equations into working lines of computer code###Cheat SheetHere are some commands that we will use today.  Anything shown in italics here is a placeholder for something you provide.  Stuff that is not in italics must be written as shown (i.e., it is required syntax).Command, usage, and what it doesBasic for loop syntax:
	for( i in sequence ) {		command1			command2			...			}	Basic if statement syntax:
	if( condition ) {		command1			command2			...			}	`seq(i, j)`: create a sequence of integers starting with integer i and ending with integer j`data <- rep(0, n)`: create a vector of zeros as a place to store some data later.  This vector will have n entries (i.e., the vector has 0 repeated n times).`plot(time, data)`: make a standard x vs. y scatter-plot (e.g., time on the x-axis and data on the y-axis)
`lines(x, y)`: add an x vs. y plot to an existing plot
`setwd("~/path/to/directory/")`: set working directory to be wherever you want it to be.  By default, RStudio starts in your home directory (i.e., `~`)
`write.csv(x = myDataObject, file = "MyFileName.csv")`: save a .csv version of a myDataObject to the current working directory, in a file named "MyFileName.csv"###Lab problems and questions: 
####Do all your work in an R script. Follow best practices (no magic numbers; label parts; use ample comments)
Complete as many of the following as you can.  Be prepared to share your work with the class, even if your code isn’t working!  Do NOT copy and paste your code from one question to the next; type it fresh each time to reinforce the ideas for yourself.####Part I.  Practice some simple conditionals.1.	Create a variable named `x` and assign a numeric value of your choosing to it.  On the next line of code, write an if-else statement that checks if the value is larger than 5.  Your code should print a message about whether the value is larger or smaller than 5.2.	From Sam's github folder for Lab05, obtain and import the file "Vector1.csv".    
	2a. Using a `for()` loop, write code that checks each value in the imported data and replaces every negative value with `NA`.  
	2b. Using a `which()` statement (not a loop), replace all those `NA` values with zeroes.  
	2c. Using any method of your choice, create a new vector of data that has all the values from the imported data that fall in the range between 50 and 100. 
	
3. Import the data on CO2 emissions from last week ("CO2_data_cut_paste.csv" from Lab04).  Use code to answer the following questions.  Hint: you do NOT need to use any loops here.  Use `which()` and indexing:
	3a. What was the first year for which data on "Gas" emissions were non-zero?
	3b. During which years were "Total" emissions between 200 and 300 million metric tons of carbon?

<hr>

####Part II. Loops + conditionals + biology

A simple but very famous model of predator-prey dynamics is the "Lotka-Volterra" predator-prey model.  You can read all about it at [https://en.wikipedia.org/wiki/Lotka-Volterra_equations](https://en.wikipedia.org/wiki/Lotka-Volterra_equations) if you are curious.  In discrete time, this model can be represented as follows:

	n[t] <- n[t-1] + (r * n[t-1]) - (a * n[t-1] * p[t-1])
	p[t] <- p[t-1] + (k * a * n[t-1] * p[t-1]) - (m * p[t-1])

In this model, `n[t]` represents the abundance of prey at time `t`, and `p[t]` the abundance of predators at time `t`.  Prey increase in abundance due to exponential growth, represented by the term `(r * n[t-1])`, where `r` is the intrinsic growth rate.  Prey decrease due to consumption by predators, represented by the term `(a * n[t-1] * p[t-1])`, where `a` represents the "attack rate" of predators on prey.  Predators increase in abundance due to consumption of prey, represented by the term `(k * a * n[t-1] * p[t-1])`, where `k` is a conversion constant representing the conversion of consumed prey into biomass of predators.  Predators die at a constant mortality rate, represented by the term `(m * p[t-1])`, where `m` is the intrinsic mortality rate.

Write code that calculates abundances of predators and prey over time according to this model. 

First, set up parameter values.  Use the following: 


	totalGenerations <- 1000
	initPrey <- 100 	# initial prey abundance
	initPred <- 10		# initial predator abundance
	a <- 0.01 		# attack rate
	r <- 0.2 		# growth rate of prey
	m <- 0.05 		# mortality rate of predators
	k <- 0.1 		# conversion constant of prey into predators
	
Second, create a "time" vector, and make two additional vectors to store results, one for the values of `n` over time, and the other to store values of `p`.

Third, write a loop that implements the calculations.

Fourth, in this model it is possible that the predators may kill off all the prey.  Due to the discrete nature of how time is considered in this model (time proceeds in discrete jumps from one generation to the next), it is possible that the calculations as given can result in negative numbers.  So, add some `if` statements to your code to check for negative numbers each generation.  If, for example, a given value of prey abundance is negative, then that value should be set to be zero.

Fifth (I meant to say this in the first draft of this assignment, but forgot to), make a plot of the abundances of prey and predators over time (see cheat sheet above for using `plot()` and `lines()`).  If you didn't do this step, no problem; that was my fault.
<hr>####Complete all of the above in an R script file (with good comments on all steps) and push that file to your Github repo for this class.  Turning in WORKING code counts as Assignment 06. 
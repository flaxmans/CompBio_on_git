# Lab 07: "Put the FUN in FUNction! :-)"
## Writing Your Own Functions### ObjectivesThe main learning goals of this lab activity are to:  1.	Practice the basics of writing a `function` in R2.  Write functions that work for a variety of inputs### Cheat SheetHere are some commands that we will use today.  Anything shown in italics here is a placeholder for something you provide.  Command, usage, and what it doesBasic syntax of defining a function:
	myFunction <- function(arg1, arg2){
		# step 1:
		
		# step 2:
		
		return(results)	}### Lab problems and questions: 
#### Do all your work in an R script. Follow best practices (no magic numbers; label parts; use ample comments)##### Problem #1Recall the "Fibonacci sequence" we worked with a few weeks ago: According to [Wikipedia](https://en.wikipedia.org/wiki/Fibonacci_number) (https://en.wikipedia.org/wiki/Fibonacci_number):    >the Fibonacci numbers are the numbers in the following integer sequence, called the Fibonacci sequence, and characterized by the fact that every number after the first two is the sum of the two preceding ones:
1 , 1 , 2 , 3 , 5 , 8 , 13 , 21 , 34 , 55 , 89 , 144 , ...   
Often, especially in modern usage, the sequence is extended by one more initial term:  0 , 1 , 1 , 2 , 3 , 5 , 8 , 13 , 21 , 34 , 55 , 89 , 144 , ...  
By definition, the first two numbers in the Fibonacci sequence are either 1 and 1, or 0 and 1, depending on the chosen starting point of the sequence, and each subsequent number is the sum of the previous two.
Using the information given in that quote (and using a for loop), write a function that returns a vector of the first `n` Fibonacci numbers, where `n` is any integer >= 3.  Your function should take **two** arguments: the user's desired value of `n` and the user's desired starting number (either 0 or 1 as explained in the quote above).
*Bonus 1a*: make your function work for any number n, including n < 3.
*Bonus 1b*: make your function check user input, e.g., if a user enters a negative number, or a non-integer number, the function should check that and give an appropriate message.
##### Problem #2Recall the discrete-time logistic growth model that we have worked with in previous labs on looping:
	n[t] = n[t-1] + ( r * n[t-1] * (K - n[t-1])/K )where n[t] is the abundance of the population at time t, n[t – 1] is the abundance of the population in the previous time step, r is the intrinsic growth rate of the population, and K is the environmental carrying capacity for the population.  

Write a function that implements this model.  The function should do the following:

a. Take parameters as arguments (inputs).  This includes the following as parameters: initial population size (`n[1]`), total number of generations, `r`, `K`.  b. have default values for each of the arguments  
c. iterate the model  
d. make a plot with axes properly labeled.  
e. return the abundance data.  

##### Problem #3
Social networks are very much "in vogue" these days, being used in many fields to understand all sorts of problems, from the transmission of disease to the spread of memes.  There are two very common ways that simple network data can be represented.  

(a) An "adjacency matrix": 	Suppose there are `n` individuals.  Then a matrix with `n` rows and `n` columns can be constructed.  The entry in the matrix at position `[i,j]` (i.e., the ith row and jth column) is zero if there is no interaction between individuals i and j.  If those two individuals do interact then the entry at position `[i,j]` is a number representing the strength or nature of the interaction.  In a very simple matrix, it could just be a "1" if there is an interaction of any kind, and a zero otherwise.

(b) A table listing all non-zero pairwise interactions.  This is an `m x 3` matrix (`m` rows and 3 columns) in which the first column is the index or ID of a "row" individual, the second column is the index or ID of a "column" individual, and the third column is the number that represents the strength/nature of the interaction between these two individuals.

Write **two** functions.  The first function should take a square matrix of any size and turn it's contents into the pairwise table form.  The second function should do the reverse (i.e., take a pairwise interaction table and turn it into a square matrix).  **The first function is required.  The second function is a bonus problem.**

Examples:

Function #1 should take this:

| 0 | 1 | 1 |  
|---|---|---|  
| 1 | 0 | 0 |  
| 1 | 0 | 0 |  

And turn it into this:  

|row|column|value|
|---|---|---|
|1|2|1|
|1|3|1|
|2|1|1|
|3|1|1|

Function #2 should do the reverse.  Note that the pairwise table form only includes the non-zero entries of the matrix.
 
To test that your functions work, import the data given in the Lab07 folder in the file called "SmallAdjacencyMatrix.csv".  Try converting those data with the first funcion.  Then, if the results look fine, try to recreate the SmallAdajcencyMatrix by using your second function on the return from the first. <hr>#### Complete all of the above in an R script file (with good comments on all steps) and push that file to your Github repo for this class.  Turning in WORKING code counts as Assignment 07. 
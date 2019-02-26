# Lab 07: "Put the FUN in FUNction! :-)"
## Writing Your Own Functions, Part 1

### Objectives
The main learning goals of this lab activity are to:  

1.	Practice the basics of writing a `function` in R
2.  Write functions that work for a variety of inputs

### Cheat Sheet: Basic syntax of defining a function
```
myFunction <- function(arg1 = defaultVal, arg2 = defaultVal) {
    # step 1:
		
    # step 2:
        
    # etc.... 
		
    return(results)
}
```

### Some basic vocabulary:
+ "argument" = an input to a function.  For example, in the command `myVec <- rep(0, 10)`, "0" and "10" are the arguments.  Note that arguments are separated by commas.  Depending upon the function, some of its arguments may be optional, while others may be required.  It depends upon the function.
+ "return" = what a function gives back as results to the user; in other words, the ouput of a function.  For example, if you execute the command `myVec <- rep(0, 10)`, the function "returns" a vector of 10 zeroes (which is then assigned to the variable named `myVec`).
+ "call" = to use or invoke a function.  For example, if you evalute the command `myVec <- rep(0, 10)` , you are "calling" the `rep` function.
+ "defining a function" = telling R what your function is (see the syntax given above).  Defining a function creates an object of class "function" and tells R what that object is and how it works.  A function MUST be defined before it can be called.  Defining a function does NOT call the function; defining a function just tells R that the function exists.  Function definitions must be evaluated just like any other piece of code.  



### Lab problems and questions: 

#### Do all your work in an R script. Follow best practices (no magic numbers; label parts; use ample comments).  Please refer to the [example script](https://github.com/flaxmans/CompBio_on_git/blob/master/Labs/Lab07/ExampleScriptSetup.R) provided in the Lab07 directory to see how you should organize your code for this lab.

<hr>

##### Problem #1
The area of a triangle can be calculated as `0.5 * base * height`.  Write a function named `triangleArea` that calculates and returns the area of a triangle when given two arguments (base and height).  

Demonstrate that your function works by calling it for an imaginary triangle that has a base of 10 units and a height of 9 units.

<hr>

##### Problem #2
R has a built in function called `abs()` that returns the absolute value of a number, or the absolute value of each number in a numeric vector.  Imagine that the `abs()` function did NOT exist.  Write a function named `myAbs()` that calculates and returns absolute values.
Show that your function works by using it on the following test cases:
1. the number `5`
2. the number `-2.3`
3. the vector `c(1.1, 2, 0, -4.3, 9, -12)`

Hint: Your function will almost certainly need to make use of some kind of conditional test.

<hr>

##### Problem #3
Recall the "Fibonacci sequence" we worked with a few weeks ago: According to [Wikipedia](https://en.wikipedia.org/wiki/Fibonacci_number) (https://en.wikipedia.org/wiki/Fibonacci_number, accessed Feb. 2017):    
>the Fibonacci numbers are the numbers in the following integer sequence, called the Fibonacci sequence, and characterized by the fact that every number after the first two is the sum of the two preceding ones:
1 , 1 , 2 , 3 , 5 , 8 , 13 , 21 , 34 , 55 , 89 , 144 , ...   
Often, especially in modern usage, the sequence is extended by one more initial term:  0 , 1 , 1 , 2 , 3 , 5 , 8 , 13 , 21 , 34 , 55 , 89 , 144 , ...  
By definition, the first two numbers in the Fibonacci sequence are either 1 and 1, or 0 and 1, depending on the chosen starting point of the sequence, and each subsequent number is the sum of the previous two.

Using the information given in that quote, write a function that returns a vector of the first `n` Fibonacci numbers, where `n` is any integer >= 3.  Your function should take **two** arguments: the user's desired value of `n` and the user's desired starting number (either 0 or 1 as explained in the quote above).


*Bonus 3a* (optional): make your function work for n = 1 and n = 2.  (Hint: add conditionals)

*Bonus 3b* (optional): make your function check user input, e.g., if a user enters zero, or a negative number, or a non-integer number, the function should check that and give an appropriate error/warning message.  (Hint: more conditionals)

<hr>

##### Problem #4
*Part 4a*.  Write a function that takes two numbers as its arguments and returns the square of the difference between them.  In other words, for any two numbers `x` and `y` your function should calculate and return the quantity `(x - y) ^ 2`. 

+ Demonstrate that your function works by calling it with the numbers 3 and 5.  (your function should return the number 4). 

+ Call your function where the first argument is the vector `c(2, 4, 6)` and the second argument is the number `4`.    Your function should return the vector `4 0 4`.  This is a demonstration of R's abilities to vectorize operations.


*Part 4b*.  Imagine that R did NOT have a function to calculate the average (i.e., arithmetic mean) of a vector of numbers.  Write a function of your own that calculates the average of a vector of numbers.  In other words, your function should take a vector of numbers as its argument, and it should return the average, but you can NOT use the `mean()` function.  *Hint*: you will probably want to make use of the `sum()` function for efficiency.

+ Demonstrate that your function works by calling it with the vector `c(5, 15, 10)`

+ Demonstrate that your function works by calling it with the data you will find in the "DataForLab07.csv" file found in Sam's Lab07 directory.  **Remember**: importing this data will, by default, create a data frame (not a vector).  If your function works properly, the answer it returns will be approximately `108.9457`.     


*Part 4c.*  A very common quantity in a number of statistical analyses is some form of a "sum of squares."  In technical terms, the sum of squares can be calculated as the sum of the squared deviations from the mean.  In  other words, for a given data set, one calculates the mean.  Then, for each data point, the mean is subtracted from the data point, and the resulting difference is squared.  All of these squared differences are then summed.  For a different explanation, see [this Wikipedia page on "Total Sum of Squares"](https://en.wikipedia.org/wiki/Total_sum_of_squares).  Write a function that calculates and returns the sum of squares as defined here.  Your function should take a vector of numeric data as its argument.  Note: please write your sum of squares function so that it makes use of the functions written for the previous two parts of this problem.  In other words, find a useful way to call those functions from within your sum of squares function.

Demonstrate that your sum of squares function works by calling it with the data provided in the file "DataForLab07.csv".  If your function works properly, the answer it returns will be approximately `179442.4`. 


<hr>

>Comment from Sam:  You might wonder: Why would Sam ask you to write these functions for Problem #4 when the entire thing, as encapsulated in Part 4c, can be done in a single line of code (in fact, pretty easily if you were "allowed" to use the `mean()` function that is built into R!)?   There are several reasons.  One is to practice writing functions by using examples involving cases for which you should be able to to have an expectation about "the answer"; you have an expectation about the behavior the function should have, so that hopefully leaves you free to focus on how to write the function rather than how to do the calculations per se.  Second is to emphasize that simple tools can be put together in myriad ways to accomplish many different kinds of useful, common tasks.  You have the power to create what you need even if it doesn't already exist!  Third is to contemplate the pathways of numbers through our scripts and to hopefully consider how a bit of code that works for one thing can be co-opted for something you might not have initially considered.


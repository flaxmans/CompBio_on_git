# Lab 11: Generating Pseudo-Random Numbers and Samples

### Goals for this lab:
1. Practice using tools in R for generating random numbers and random samples
2. Incorporate some of these tools into simple biological models

### Exercises

##### A. Meet the Binomial Distribution.
The binomial distribution is appropriate when you want to describe the outcome of an "either-or" process.  That is, for some number of chances, the binomial distribution describes the number of times that one outcome (or its alternative) is expected to occur.  Statisticians and probability theorists commonly refer to one of the two possible outcomes as a "success", so in the literature on the binomial distribution, you will commonly see the term "success".  You could use the binomial distribution to describe things such as (i) the number of heads obtained when flipping a coin some number of times, (ii) the number people for whom a vaccination will be effective in a group of some size of vaccinated people, or (iii) the number of students who will graduate within four years in a group of some number of first-year students.  The key features each of these examples has to have to make the binomial distribution appropriate are (i) each outcome must be independent of all other outcomes (e.g., each coin flip is independent of the others; each student's success is independent of the other students'), (ii) there is some probability, `p`, of "success" in each example, and this same probability applies to all individuals (the definition of "success" can be arbitrary), and (iii) there is some known, fixed, integer number of chances/individuals (i.e., the number of coin flips or the number of students).

Numbers following the binomial distribution can be generated in R with the `rbinom()` function.  The documentation for this function shows it like this:  

	rbinom(n, size, prob)
	
Note that in this case, `n` is the number of replicates (i.e., number of different random number draws) you want.  This can be confusing when you read the usual descriptions of the binomial distribution because many of these descriptions will say something like  

> The binomial distribution describes the probability of obtaining `k` successess in `n` trials when the probability of success on each trial is `p`.  

In the case of the `rbinom()` function, what R calls "size" is the number of trials.  So, let's say you wanted to generate ONE simulate instance of flipping a fair coin 10 times.  Suppose you call getting "tails" a success.  Then, you could do that in R with the following command:

	rbinom(n = 1, size = 10, prob = 0.5) # simulating 10 coin flips (once)

And you could simulate 8 replicates of flipping a coin 10 times with the following command:

	rbinom(n = 8, size = 10, prob = 0.5) # simulating 10 coin flips (8 times)

**A1.** Try each of these two commands (above) in your console and see what you get

For the following three problems, suppose that the probability of getting the flu is 40% if you do NOT get the flu vaccine, and 15% if you do get the vaccine. 

**A2.** In an R script, write a line of code that would simulate the number of people who get the flu in a sample of 20 vaccinated people.

**A3.** In the same R script, write a line of code that would simulate the number of people who get the flu in a sample of 20 *un*vaccinated people.

**A4.** Continuing in your script, write lines of code that would create 30 replicates of the scenario described above in A2, 30 replicates of A3, and make frequency histograms of the outcomes of each.  Hint: this should only take 4 lines of code total.  Hint: use `hist()`.  Comparing these two histograms, does anything surprise you about them?  

**A5.** Suppose you have a population of `N = 500` individuals with a fixed size in each generation, and generations are non-overlapping.  Suppose further that individuals are haploid, and that, at a given (focal) locus, there are two alleles currently in the population.  At some initial time point, one allele is present in 275 (55%) of the individuals, and thus the other allele is present in 45% of the individuals.  Let's call the more common allele _a_ and the less common allele _b_.  Assuing that the two alleles are neutral, simulate going forward one generation in time.  What is the frequency of the _a_ allele in the next generation in your results?

**A6.** Using the information given in problem A5, start from the same initial conditions, but go forward 1000 generations.  Hint: the `prob` parameter must be updated in each generation. Hint: this will require a loop.

**A7.** Plot your results from step A6. (x-axis = generations, y-axis = frequency of _a_ allele)

**A8.** Write additional code to create 100 replicates of the simulation in A6. Using the results from your 100 replicates, write code to (i) plot 10 replicates on one figure, (ii) determine how many replicates ended with the _a_ allele fixed, (iii) determine how many replicates ended with the _b_ allele fixed, and (iv) determine how many replicates ended with both alleles still present in the population.

<hr>

##### B. Sampling

"Random sampling" comes up in myriad applications in experimental design and data analysis.  There are some very easy ways to accomplish random sampling in R.  The `sample()` function is extremely useful for this purpose.  The help page for this function shows the following usage:

	sample(x, size, replace = FALSE, prob = NULL)

Assuming `x` is a vector, you can sample from it with or without replacement (default is without).  The default is that all elements of x have an equal likelihood of being chosen, but you can make the weights biased by setting `prob` equal to a vector of weights.  Note: `length(prob)` should equal `length(x)`.  Size is the number of samples you want.  A convenient feature is that `sample(x)` with no additional arguments will take the elements of `x` and return them in random order.

**B1.** Four siblings -- Blair, Frankie, Kim, and Morgan -- have been waiting patiently for their parents to bring dessert home.  Each of them wants to be the first to get dessert.  Use `sample()` to generate a random order of these four people's names for getting their dessert.

**B2.** Use `sample()` to simulate 13 rolls of a fair six-sided die.  Plot a histogram of the results.

**B3.** Use `sample()` to simulate 14 rolls of a biased six-sided die for which the probability of rolling a "6" is twice the probability of rolling any other number.  Make a histogram of the results.

**B4.** Write a function that randomly re-orders the rows of a matrix.  In other words, the function should preserve the integrity of rows, but randomize their top-to-bottom placement in the matrix.  For the purposes of testing your function, I created a data file called "[testMatrix.csv]()" in the Lab11 folder.








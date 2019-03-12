# Lab 09: Parsing Dates and Times from a Real Data File

The goal of this lab is to practice several skills at once:
+ finding and implementing new functions that help solve problems
+ using functions and skills we already know in new ways
+ combining the new and old skills creatively
+ wrestling with what may appear to be complex problems initially to figure out which pieces are truly complex, and which are not
+ realizing that even simple, beautiful, elegant end points are the result of struggle, trial, and error.
+ doing what humans are good at, i.e., asking "What if ...?" and "How about ...?"


Keep in mind: There are many ways to solve the problems below.  The idea is to be resourceful about finding some way that works.  You can look for built-in functions for parsing date and time data, you can look for functions that are part of libraries/packages that are not part of base R, and/or write your own code/functions.  All these types of approaches have value; all have their own limitations, costs, and benefits.    

Try simple things first, and try to use web searches to your advantage.  Experiment in the console with ways of converting data from one format/class into another.  See what happens with methods you know and with new ones you discover.  Feel free to talk to people too.  Chances are, even once you find some method that seems like it will work, you will still need to fine tune it to get it to work.

And finally, if you spend the entire two hours on nothing but Problem #1, don't worry; Sam spent at least that much time figuring out ways to approach it.

### Preliminary Step: import the camera trap data file
I suggest importing with the `stringsAsFactors` option set to `FALSE`, i.e., 
```
camData <- read.csv("Cusack_et_al_random_versus_trail_camera_trap_data_Ruaha_2013_14.csv", stringsAsFactors = F)
```  
(Note that the command as written above assumes your working directory in R is the `Cusack_et_al` directory found in the `Datasets`  directory of Sam's repo.)

### Problem 1
The import as written on above creates the `DateTime` column as characters.
Using the information at [https://www.stat.berkeley.edu/~s133/dates.html][timeLink], 
how could you convert those dates and times into actual objects that represent time (as we humans think about it)
rather than just being character strings?  I suggest you try to use `strptime()`, 
in which case the challenge will be to figure out how to use the `format` argument.  

Hints:
1. Use the info at the [link given above][timeLink] and also try `?strptime` in your console.  Remember that the import of the data creates the DateTime vector as a vector of character strings.  That is the starting point.
2. Don't try to work on the whole `DateTime` vector initially.  Try your methods on a small, bite sized piece of it.  For example, you could make a new variable such as:  
    `smallVec <- camData$DateTime[1:5]`  
    or  
    `oneDate <- camData$DateTime[1]`  
    and then just try lots of differerent ideas you have in your console with the `smallVec` and/or `oneDate` objects.  
3.  Once you think you have a working method (i.e., it seems to work on your small test object(s)), _then_ try to implement it on the whole `DateTime` vector and keep the working code in your script.

### Problem 2
Hopefully you completed problem number 1 using a command that operated on the
whole `DateTime` vector at once. Some of the years will be imported incorrectly
because the original data are inconsistently formatted.  Specifically, some
of the data (5645 entries) have a two-digit year format (e.g., `13` for the
year `2013`), whereas others (8959 entries) have the 4-digit format.  How could
you figure out which were NOT coverted properly by your method from problem 1?
Hint: the [link above][timeLink] provides information about how computers actually
keep time internally and how to see the internal form.  This can be useful
here, but there are, of course, many ways to approach this!  Sometimes an intermediate
step that has errors in it can still be useful if you know how to find them...


### Problem 3
How could you use your methods from problems 1 and 2 to create an ACCURATE
vector of dates and times?


### Problem 4
How could you create a function that took ANY two `DateTime` measurements (as converted to accurate dates and times above) and
computed the time elapsed between them in measurement units (days, hours, or minutes) of
the user's choice?


<hr>

### "Finishing" (or not) this lab:
**Please add, commit, and push whatever you have done by the end of the lab period to your GitHub repo, regardless of its completeness or functionality**.  Sam just wants to see what you did.   If you got NOTHING to work, put some examples of things you tried in your Lab 09 script, with comments about what didn't work and how you knew it didn't work.

Hence, you do NOT have to complete all the problems, nor submit fulling working code; Sam's expectation is that you will spend two hours of time doing what you can, and then we will be building on our collective ideas in class next week.  Of course, if you want to keep working on it after lab ends, please feel free!  Work for this lab will NOT be graded.  But your attendance and efforts are expected in lab, of course!  Thanks!






[timeLink]: https://www.stat.berkeley.edu/~s133/dates.html

# Lab 09: Open-Ended Challenge

### Goals for this lab:
* practice being resourceful to solve new challenges
* practice parsing input data and converting it to different data types
* practice writing your own functions
  
### Exercises:
1. Update your clone of my CompBio_on_git repository.  (hint: git pull)
2. Doing #1 should get you a copy of [the camera trap data file from Cusack et al](https://github.com/flaxmans/CompBio_on_git/blob/master/exampleData/Cusack_et_al/Cusack_et_al_random_versus_trail_camera_trap_data_Ruaha_2013_14.csv).  Open a new script in R/RStudio that starts with an import of these data.
3. Figure out code to parse the "DateTime" data (i.e., the sixth column) so that the data in that column can be used to calculate time intervals between observations.    
For example, suppose your import is called "`myData`".  Then you should be able to use your code to calculate the time elapsed between `myData$DateTime[2]` (19/09/2013  20:36) and `myData$DateTime[3]` (20/09/2013 01:26).  In this example, The answer should be 4.83333 hours or 0.20139 days.  In other words, the answer should be a decimal number that is easy to use in calculations (not an answer with separate days, hours, minutes).  
    There are many ways to solve this.  The idea is to be resourceful about finding some way that works.  You can look for built-in functions for parsing date and time data, or write your own.  Both types of approaches have value; both have their own limitations, costs, and benefits.  
    Try simple things first, and try to use web searches to your advantage.  Experiment in the console with ways of converting data from one format/class into another.  See what happens with methods you know and with new ones you discover.  Feel free to talk to people too.  Chances are, even once you find some method that seems like it will work, you will still need to fine tune it to get it to work.
4. Once you figure out how to solve the previous problem, make the steps of your method into a new function called `calcTimeDiff`.  The function should take two times as its arguments and return the difference in consistent units.
5. Write another function that takes four arguments: (i) the data (all the camera trap data), (ii) Placement, (iii) Season, and (iv) Station.  In other words it starts out lookign like this: `myfn <- function(data, Placement, Season, Station) { ... }`.  For a given Placement, Season, and Station, the function should return a vector of time intervals betweeen consecutive camera trappings.  You may be able to make life slightly easier on yourself by having this function repeatedly call the function you wrote for the previous problem.
6. Write a README.md to accompany the work you have done for Lab09.

### Completing the exercises above:
Completing the above exercises and pushing your work to Github constitutes Assignment 09.  Please complete this by next Friday.


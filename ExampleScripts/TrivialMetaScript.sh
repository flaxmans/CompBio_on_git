#!/bin/bash

# An example of a trivial meta-script

myVar=5.3
# suppose myVar is a variable that holds the value 5.3

echo "myVar <- $myVar" > SillyScript.R

# if you did that in the shell, then at any later time,
# in R, you could do this:
# 			source("SillyScript.R")
# and it would execute the following command in R:
# myVar <- 5.3
# giving you a usable record of what "myVar" was when
# the program that created SillyScript.R was run


#!/bin/bash

# try the following commands and note the differences in output
# of which lines you get from the test file named RegExpTestStrings.txt

printf "\nHere are the contents of the test file, RegExpTestStrings.txt:\n"
cat RegExpTestStrings.txt

# cat RegExpTestStrings.txt
printf "\nResult of: cat RegExpTestStrings.txt | grep myString\n"
cat RegExpTestStrings.txt | grep myString

printf "\nResult of: cat RegExpTestStrings.txt | grep my[Ss]tring\n"
cat RegExpTestStrings.txt | grep my[Ss]tring

printf "\nResult of: cat RegExpTestStrings.txt | grep my.tring\n"
cat RegExpTestStrings.txt | grep my.tring

printf "\nResult of: cat RegExpTestStrings.txt | grep my[A-Za-z]tring\n"
cat RegExpTestStrings.txt | grep my[A-Za-z]tring

printf "\nResult of: cat RegExpTestStrings.txt | grep my[A-Za-z]*tring\n"
cat RegExpTestStrings.txt | grep my[A-Za-z]*tring

printf "\nResult of: cat RegExpTestStrings.txt | grep m[A-Za-z]*g\n"
cat RegExpTestStrings.txt | grep m[A-Za-z]*g


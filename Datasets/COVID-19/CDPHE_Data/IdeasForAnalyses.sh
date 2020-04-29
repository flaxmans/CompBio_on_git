#!/bin/bash

##############################################
# how about some aggregated data on Boulder?
##############################################

# Method 1: Wildcard grep
grep "Boulder" RawData_csv_files/*.csv > Boulder_WildCardGrep.csv

# That works, but makes a lot of stuff with punctuation that could be hard to parse.
# We can use some tools to get rid of some unneeded bits:

grep "Boulder" RawData_csv_files/*.csv |        # get all the data
    sed 's/_/,/g' |                             # replace underscores with commas
    sed 's/:/,/g' |                             # replace colons with commas
    sed 's/.csv//g' > Boulder_WildCardGrep.csv  # remove instances of ".csv"

# now we have a lot of punctuation removed, and the first 4 "columns"
# are really unneed.  Useful info starts with the 5th "column"

# same pipeline as last one but with an addition:
grep "Boulder" RawData_csv_files/*.csv |        # get all the data
    sed 's/_/,/g' |                             # replace underscores with commas
    sed 's/:/,/g' |                             # replace colons with commas
    sed 's/.csv//g' |                           # remove instances of ".csv"
    cut -d, -f 5- > Boulder_WildCardGrep.csv
    
# Notice how the filenames from the original files are incorporated now as a useful
# column that can easily be converted to a date!

# Method 2: Loop over individual files and re-craft lines as desired
# it's a possibility, but we won't do it here (at least, not yet)

################################################
# How about aggregated on multiple counties?
################################################

# We could try the same thing?
grep -i "County" RawData_csv_files/*.csv |        # get all the data
    sed 's/_/,/g' |                             # replace underscores with commas
    sed 's/:/,/g' |                             # replace colons with commas
    sed 's/.csv//g' |                           # remove instances of ".csv"
    cut -d, -f 5- > AllCounties_WildCardGrep.csv



##############################################
# How about statewide data?
##############################################
grep "Statewide" RawData_csv_files/*.csv |        # get all the data
    sed 's/_/,/g' |                             # replace underscores with commas
    sed 's/:/,/g' |                             # replace colons with commas
    sed 's/.csv//g' |                           # remove instances of ".csv"
    cut -d, -f 5- > Statewide_WildCardGrep.csv

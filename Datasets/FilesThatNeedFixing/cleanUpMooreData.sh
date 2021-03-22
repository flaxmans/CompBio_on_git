#!/bin/bash

# script to clean up the file named "moore.csv" (in this same directory)
# Goals of this script are to correct the following issues with the original file:
    #Absence of headers (optional but nice)
    #Units messing up R's import/interpretation of numbers in last two columns (e.g., nm, mm2)
    #Actually tab- not comma-separated
    #Presence of commas in things that are numbers (will mess up R's import/interpretation)
    #References in square braces messing up R's import, e.g., [11]


# create a new file wit the right headers:
echo "Processor,MOS transistor count,Date of introduction,Designer,MOS process (nm),Area (mm2)" > cleaned_moore.csv




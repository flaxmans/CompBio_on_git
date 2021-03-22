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


cat moore.csv |
    sed -E 's/\[[0-9]{1,2}\]//g' |          # delete references
    tr -d ',' |                             # delete commas
    sed -E 's/ nm//g' |                     # delete nanometer units
    sed -E 's/ mm.$//g' |                   # delete mm units
    tr '\t' ',' |                           # make it a csv
    sed -E 's/cca |~//g' >> cleaned_moore.csv  # remove a couple other extraneous characters

# and redirect into a file as the last step

# note the final sed command uses the vertical bar as a logical OR operator:
# it searches for "cca " OR "~"




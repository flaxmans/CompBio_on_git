#!/bin/bash

# a script to make sense of multiple, heterogeneous files of data in this directory

# remove so as not to concatenate old with new
if [ -f "allHeadersOnly.csv" ]
then
    rm allHeadersOnly.csv
fi

# look at just the data files:
dataFiles=$(ls | grep "202[01]-[0-9][0-9]-[0-9][0-9].csv")

# look at the headers for consistency:
for i in $dataFiles
do
    fileType=$(file $i | grep "BOM")  # check for UNICODE file type
    if test "$fileType"
    then
        dos2unix $i  # convert to ascii from unicode if needed
    fi
    
    head -n 1 $i >> allHeadersOnly.csv # harvest only header to check heterogeneity of headers
    
done

# print a brief summary:
printf "\nUnique headers and counts:\n\n"
sort allHeadersOnly.csv | uniq -c
printf "\n"


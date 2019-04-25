#!/bin/bash

if [ "$1" == "test" ]
then
    cd ~/playground/bu2splay/
else
    # must have hard drive plugged in! :-)
    cd /Volumes/4TB_USB_SG2/
fi

# count of "Run" directories
printf "Count of run directories: \t"
ls | grep Run[12] | wc -l | awk '{print $1}'


# make a variable to store run directories:
RunDirs=$(ls | grep Run[12])
# also put the list of runs into a file:
ls | grep Run[12] > dirsHere.txt

# Validate:
for i in $RunDirs
do
    if [ ! -d $i ]      # check if $i is NOT a directory
    then
        echo "Warning: $i is NOT a directory"
    fi
done
# the validation above revealed that ALL were, in fact, directories
# so, there is no cleaning/filtering of the $RunDirs necessary yet


# Count number of files in total:
printf "\nCounting total number of files in RunDirs ...\n"
printf "\t... This will probably take a couple of minutes ...\n"
fileCount=0
for i in $RunDirs
do
    numhere=$(ls -R $i | grep -v ^$ | grep -v ":" | wc | awk '{print $1}') # -R is recursive
    fileCount=$(($fileCount+$numhere))
done
# that usually takes about 2 minutes
# report:
printf "\tCount of total number of files present: \t"
echo $fileCount


# Count megabytes of data:
printf "\nChecking disk usage of directories ...\n"
printf "\t... This will probably take a couple of minutes ...\n"
du -m -d0 $RunDirs > DirectorySizes.txt
printf "\tCount in megabytes is approximately: \t"
awk '{sum += $1} END {print sum}' DirectorySizes.txt
printf "\n"
# I confirmed that a for loop produces the same thing:
#for i in $RunDirs
#do
#    du -m -d0 $i >> DirectorySizes2.txt
#done
#awk '{sum += $1} END {print sum}' DirectorySizes2.txt



# Which directories have AlleleFrequencySpectrum?


# Which directories have JOINT allele frequency spectrum data?






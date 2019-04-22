#!/bin/bash

# must have hard drive plugged in! :-)
cd /Volumes/4TB_USB_SG2/

# count of "Run" directories
printf "Count of run directories:\n\t"
ls | grep Run[0-9] | wc -l


# make a variable to store run directories:
RunDirs=$(ls | grep Run[0-9])


# Validate:
for i in $RunDirs
do
    if [ ! -d $i ]      # check if $i is NOT a directory
    then
        echo "$i is NOT a directory"
    fi
done
# the validation above revealed that ALL were, in fact, directories
# so, there is no cleaning/filtering of the $RunDirs necessary yet


# Count number of files in total:
printf "Counting total number of files in RunDirs ...\n"
fileCount=0
for i in $RunDirs
do
    numhere=$(ls $i | wc | awk '{print $1}')
    fileCount=$(($fileCount+$numhere))
done
# report:
printf "Count of total number of files present:\n\t"
echo $fileCount


# Count megabytes of data:
printf "Checking disk usage of directories ...\n"
du -m -d0 $RunDirs > DirectorySizes.txt
printf "Count in megabytes is approximately:\n\t"
awk '{sum += $1} END {print sum}' DirectorySizes.txt
# I confirmed that a for loop produces the same thing:
#for i in $RunDirs
#do
#    du -m -d0 $i >> DirectorySizes2.txt
#done
#awk '{sum += $1} END {print sum}' DirectorySizes2.txt



# Which directories have AlleleFrequencySpectrum?


# Which directories have JOINT allele frequency spectrum data?






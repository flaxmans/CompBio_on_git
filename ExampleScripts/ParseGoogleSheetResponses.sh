#!/bin/bash

# script to parse output of Google form responses gathered 
# at https://docs.google.com/forms/d/e/1FAIpQLSfNiq_wvI-Dfi0C5t2kQF7-v3qBQSr-brgARnpJt9LfkD7Y5Q/viewform
# and then downloaded on MacOS as .csv

# cd to repo with student data:
thisDir=`pwd`
cd ~/compbio/Private_Files

# get rid of quotation marks and header
sed 's/"//g' StudentRepoLinks2020.csv | 	# remove "
	sed "s/'//g" |				# remove '
	tail +2 |				# remove header
	sed 's/ //g' |				# remove whitespace
	cut -f 2-5 -d, > tmp.csv		# remove Google timestamps

# make lastname_firstname,URL in a file, and remove duplicates:
awk -F, '{print $2"_"$1","$4}' tmp.csv | 
	sort | 					# sort entries for uniq
	uniq > NamesUrlsNotEdited.csv		# remove duplicates

# some stuff to deal with user dups and other extras:
echo "\n\tNOTE: You now need to edit out incorrect entries manually.\n"

# clean up
rm tmp.csv	# remove temporary file

# return to original directory
cd $thisDir


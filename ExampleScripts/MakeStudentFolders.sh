# script to make student folders from roster files
# This is an example of a "Shell Script"
# It can be run from Sam's computer with the command sh MakeStudentFolders.sh
# It can only be run once because it makes directories (and it can't overwrite them if they already exist)
# I checked every command individually in the UNIX terminal for accuracy before running it
# It's useful for concatenating rosters downloaded from CU's student
#   information system ("MyCUinfo") and for
#	creating directories for individual student work

# move to downloads directory (where I downloaded the rosters):
cd ~/Downloads

# get student data concatenated from grads and undergrads
cat EBIO-4420-010.csv > CompBioRoster.csv # undergrad roster in new file
tail -n +2 EBIO-5420-010.csv >> CompBioRoster.csv # grad students appended minus header

# get list of names with punctuation and header trimmed off
# and store the list in a variable for use in the shell
list=`tail -n +2 CompBioRoster.csv | cut -f 1-2 -d, | cut -f2 -d'"' | sed 's/, /_/'`
# this makes a list with each student represented as Lastname_Firstname

# make directories for student work using names
# do so in the directory I use for tracking student work
cd ~/Documents/Teaching/ComputationalBiology/StudentWork2019/
for i in $list
do
	mkdir $i # make directory for each student using their name
done

# save list of names in a file for future use:
echo $list > StudentNames.txt


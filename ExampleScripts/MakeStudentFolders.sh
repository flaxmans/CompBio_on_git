# script to make student folders from roster files
# This is an example of a "Shell Script"
# It can be run from Sam's computer with the command sh MakeStudentFolders.sh
# It can only be run once
# I checked every command individually in the UNIX terminal for accuracy before running it
# It's useful for concatenating rosters downloaded from CU's student
#   information system ("MyCUinfo") and for
#	creating directories for individual student work

# move to downloads directory (where I downloaded the rosters):
cd ~/Downloads

# get student data concatenated from grads and undergrads
cat EBIO-4420-010.csv > CompBioRoster.csv # undergrad roster in new file
tail -n +2 EBIO-5420-010.csv >> CompBioRoster.csv # grad students appended minus header

# get list of last names with punctuation and header trimmed off
# and store the list in a variable for use in the shell
list=`tail -n +2 CompBioRoster.csv | cut -f 1 -d, | cut -f 2 -d'"'`

# make directories for student work using last names
# do so in the directory I use for tracking student work
cd ~/Documents/Teaching/ComputationalBiology/StudentWork2018/
for i in $list
do
	mkdir $i # make directory for each student using their last name
done

# save list of last names in a file for future use:
echo $list > LastNames.txt


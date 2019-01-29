# simple shell script for listing the 
# file formats and displaying line endings
# for all the files in the directory

# get list of files:
fileList=`ls`

# loop over:
for i in $fileList
do
	file $i
	cat -e $i | head -n 3
	echo " "
done


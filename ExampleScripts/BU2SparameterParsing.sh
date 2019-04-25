#!/bin/bash


orig=$(pwd)

if [ $1 == "test" ]
then
    cd ~/playground/bu2splay/
elif [ -d $1 ]
then
    cd $1
else
    echo "Error!  Directory of runs not found!!"
    exit 1
fi

# get names of directories within:
dirList=$(ls | grep Run[12])



# converting parameters.m files from
# bu2s RunXXX directories into R-compatible scripts

for i in $dirList
do
    cat $i/parameters.m | 
	    sed 's/ = /<-/' | 
	    sed 's/%/#/' | 
	    sed 's/  */,/g' | 
	    sed 's/,]/)/' | 
	    sed 's/\[/c\(/' | 
	    sed 's/<-/ <- /' > $i/testRconversion.R
	
done




# make lists of names of parameters available:
for i in $dirList
do
	awk '{print $1}' $i/parameters.m | 
		grep -v "%" | 
		grep -v ^$ > $i/ListOfParameterNames.txt
done

# go back to original directory:
cd $orig


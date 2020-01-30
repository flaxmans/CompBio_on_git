#!/bin/bash
# previous line tells the shell explicitly 
# that this is a BASH script

# script for cloning and updating student repos based upon
# information provided by students

# script should be called with one argument: clone (first time) or pull (

if [ "$1" == "clone" -o "$1" == "pull" ]
then
    echo "Operation is $1"
else
    echo "Error!  Argument should be 'clone' or 'pull'"
    echo "\t... exiting ..."
    exit 1
fi

thisDir=`pwd` # so we can get back here when we're done

# data file of student repos is NOT in this dir 
# for data privacy reasons
cd ~/compbio/Private_Files
thisYearsWork="StudentWork2020"

# names and links are first and second
# columns in csv exported and parsed from
# Google form:
if [ "$1" == "clone" ]
then
    namesAndURLs=$(cat NamesURLsEdited.csv)
else
    cd ~/compbio/${thisYearsWork}
    namesAndURLs=$(tail +2 RepoNameList.csv)
    # this file with one extra column only exists after the first clone
    # also, it has a header row
fi

# move to dir where work is kept:
cd ~/compbio/${thisYearsWork}

if [ "$1" == "clone" ]
then
    # cloning causes us to generate a new or updated list of records:
    echo "Name,URL,RepoName" > RepoNameList.csv
fi

count=0
for i in $namesAndURLs
do
    echo " "
    echo "count is $((++count))"
    # directory to use it:
    dirname=`echo $i | cut -f1 -d,`
    URL=`echo $i | cut -f2 -d,`
    if [ "$1" == "clone" ]
    then
        if [ ! -d $dirname ]
        then
            echo "making directory: $dirname"
                mkdir $dirname

                cd $dirname
            echo " "

                # clone the repo:
                echo "attempting to clone $URL"
                git clone $URL
        else
            cd $dirname
            # check if directory is empty or not:
            if [ $(ls -A) ]
            then
                # not empty
                echo "Directory $dirname already exists and directory is NOT empty."
                    echo "\t ... skipping clone ... "
            else
                # empty
                echo "Directory $dirname exists but is empty."
                echo "attempting to clone $URL"
                        git clone $URL
            fi
            echoRepo=TRUE
        fi
    	RepoName=`ls`
        if [ "$echoRepo" == "TRUE" ]
        then
            echo "RepoName here is: $RepoName"
        fi
    	# move back to parent repo:
    	cd ..

    	# add to file for later pulls:
    	printf "$dirname,$URL,$RepoName\n" >> RepoNameList.csv
    else
        # we're doing a pull:
        echo "\nTrying to pull for student $dirname:"
        RepoName=`echo $i | cut -f3 -d,` # repo directory name should be in third field
        cd ${dirname}/${RepoName}
        hiyou=`pwd`
        echo "i am in $hiyou"
        echo "dirname = $dirname"
        echo "reponame = $RepoName"
        git stash
        git pull
        cd ~/compbio/${thisYearsWork}
    fi
done

#turns out Google Sheet export has some CR line returns:
#if [ "$1" == "clone" ]
#then
#	cat RepoNameList.csv | sed s/'
#'// > bar.txt
#	mv bar.txt RepoNameList.csv
#fi

cd $thisDir # back to where we started


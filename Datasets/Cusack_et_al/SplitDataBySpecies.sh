# an example shell script for making separate data files
# based upon filtering the data in the original file.
# In this case, our goal is to filter the data of Cusack et al.
# into different files that each represent data on a different species

# A general idea for approach is listed in steps of pseudo-code comments:

# 1. Figure out how many uniquely different species there are

# 2. For each species, get the lines of data that correspond to
# that species and redirect them into an appropriate named file

# The first main step implies a need to look at the column of species data and
# find the unique entries.
# The second main step above implies a need to use the output of the first step
# to LOOP over the species and get lines matching each species' name.

# STEP 1: Unique entries in a column
# The shell has a command called uniq, but it turns out to be a bit fussy
# because it only works on CONSECUTIVE unique entries, so we need to sort the entries.
# See https://stackoverflow.com/questions/618378/select-unique-or-distinct-values-from-a-list-in-unix-shell-script
# for some examples
# Note that Species is the 5th column of data in the Cusack data file,
# and also note that the header need to be trimmed off so that "Species" is not considered as the
# name of an actual species:

# Here's one idea:
# species=$(tail +2 Cusack_et_al_random_versus_trail_camera_trap_data_Ruaha_2013_14.csv | cut -f 5 -d, | sort | uniq)
# Turns out that KIND OF works, but not really, because there are spaces in the animals' names,
# so names with multiple words get treated as multiple species!!!  Solution is to get rid of spaces, which can be done
# with one more piped command, replacing spaces with underscores:

species=$(tail +2 Cusack_et_al_random_versus_trail_camera_trap_data_Ruaha_2013_14.csv | cut -f 5 -d, | sort | uniq | tr ' ' '_')

# STEP 2: Loop over species, and make sure to keep the header

# I'd like to put all the data into new files corresponding to species' 
# names, and I'd also like to have all those files in a directory.
# To do that, I'm going to have the shell make a directory, but I want the shell
# to first check if the directory exists.
# For this, I'll use an if statement:
myDirName="dataFilesBySpecies"
if [ ! -d "$myDirName" ]
then
	mkdir $myDirName
fi

# make a header for each new file created:
header=$(head -n 1 Cusack_et_al_random_versus_trail_camera_trap_data_Ruaha_2013_14.csv)
for i in $species
do
    # make a filename:
    filename=$i.csv
    # get the header:
    echo $header > $myDirName/$filename
    # species name with spaces for grep operation since originals have spaces:
    speciesName=$(echo $i | tr '_' ' ')
    # get the right lines of data:
    grep "$speciesName" Cusack_et_al_random_versus_trail_camera_trap_data_Ruaha_2013_14.csv >> $myDirName/$filename
done

# Note: the grep command is a very simple way to approach this; not the most efficient computationally
# but fine for this purpose.  Also, it only works because species' names ONLY appear where they are relevant
# trying to grep for Season, for example, probably wouldn't work because there are many instances of
# the letters "D" and "W" 


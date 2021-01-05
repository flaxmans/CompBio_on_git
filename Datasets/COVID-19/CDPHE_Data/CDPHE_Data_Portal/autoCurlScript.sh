#!/bin/bash

for (( i=1; i<=$1; i++ ))
do
	printf "\n\t*******************************\n\n\n\n\n"
	figlet "Round $i"
	echo " "
	date | figlet
	echo " "
	bash dataportalcurl.sh
	printf "\n\n\n"
	if [[ $i -lt $1 ]]
	then
		sleep $2
	fi
done



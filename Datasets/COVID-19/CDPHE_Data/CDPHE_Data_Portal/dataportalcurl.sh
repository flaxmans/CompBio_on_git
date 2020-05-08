#!/bin/bash

mydate=$(date "+%Y-%m-%d")
yesterday=$(date -j -v-1d '+%Y-%m-%d')

# URLs for arcgis data portal from CDPHE:
dailyStateStatURL="https://opendata.arcgis.com/datasets/da80229915e44b3db84f53e19647f261_0.csv?outSR=%7B%22latestWkid%22%3A4269%2C%22wkid%22%3A4269%7D"

byCountyOfIDURL="https://opendata.arcgis.com/datasets/7dd9bfa5607f4c70b2a7c9634ccdca53_0.csv?outSR=%7B%22latestWkid%22%3A3857%2C%22wkid%22%3A102100%7D"

stateodrURL="https://opendata.arcgis.com/datasets/882fd53e0c1b43c2b769a4fbdc1c6448_0.csv?outSR=%7B%22latestWkid%22%3A4269%2C%22wkid%22%3A4269%7D"

clinicalLabsURL="https://opendata.arcgis.com/datasets/3cccdf0a1ef04dbd8644eafc9351d341_0.csv?outSR=%7B%22latestWkid%22%3A4269%2C%22wkid%22%3A4269%7D"

countyodrURL="https://opendata.arcgis.com/datasets/199c1c4a0ece40078949cd24f743e5f4_0.csv?outSR=%7B%22latestWkid%22%3A4269%2C%22wkid%22%3A4269%7D"

testingSitesURL="https://opendata.arcgis.com/datasets/836372161f4f4f989fb826a6b78c1c67_0.csv?outSR=%7B%22latestWkid%22%3A3857%2C%22wkid%22%3A102100%7D"

# as an array:
URLs=($dailyStateStatURL $byCountyOfIDURL $stateodrURL $clinicalLabsURL $countyodrURL $testingSitesURL)

# note following names need to be in exact same order as URLs!
names=(CDPHE_COVID19_Daily_State_Statistics_
Colorado_COVID19_Positive_Cases_and_Rates_of_Infection_by_County_of_Identification_
CDPHE_COVID19_State-Level_Open_Data_Repository_
COVID19_Positivity_Data_from_Clinical_Laboratories_
CDPHE_COVID19_County-Level_Open_Data_Repository_
Community_Testing_Sites_)

# subdirs in same order too!
subdirs=(DailyStateStats
ByCountyOfID
StateLevelOpenDataRepo
ClinicalLabs
CountyLevelOpenDataRepo
CommunityTestingSites)

arrayLength="${#names[@]}"

# loop over each one and curl:
for (( i=0; i<$arrayLength; i++ ))
do
	echo $i
	fname="${names[$i]}${mydate}.csv"
	curl ${URLs[$i]} > tmp/${fname}
	echo " "
done

# diff them:
for (( i=0; i<$arrayLength; i++ ))
do
    newOne="tmp/${names[$i]}${mydate}.csv"
    recentOne=$(ls -t ${subdirs[$i]}/*.csv | head -n 1)
    nDiffs=$(diff $newOne $recentOne | wc | awk '{print $1}')
    if (( $nDiffs > 0 ))
    then
        echo "wc of new and old diffs: $nDiffs"
        echo "wc $newOne: $(wc $newOne)"
        echo "head -n 5 $newOne:"
        echo "$(head -n 5 $newOne)"
        echo " "
        echo "     ******"
        echo " "
        mv $newOne ${subdirs[$i]}/
    fi
done



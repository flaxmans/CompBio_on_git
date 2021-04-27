#!/bin/bash

mydate=$(date "+%Y-%m-%d")
yesterday=$(date -j -v-1d '+%Y-%m-%d')

# URLs for arcgis data portal from CDPHE:
dailyStateStatURL="https://opendata.arcgis.com/datasets/566216cf203e400f8cbf2e6b4354bc57_0.csv"

dailyStateStat2URL="https://opendata.arcgis.com/datasets/80193066bcb84a39893fbed995fc8ed0_0.csv"

byCountyOfIDURL="https://opendata.arcgis.com/datasets/222c9d85e93540dba523939cfb718d76_0.csv?outSR=%7B%22latestWkid%22%3A4326%2C%22wkid%22%3A4326%7D"

stateodrURL="https://opendata.arcgis.com/datasets/331ca20801e545c7a656158aaad6f8af_0.csv"
# maybe stateodr is deprecated?

clinicalLabsURL="https://opendata.arcgis.com/datasets/75d55e87fdc2430baf445fb29cec6de0_0.csv"

countyodrURL="https://opendata.arcgis.com/datasets/efd7f5f77efa4122a70a0c5c405ce8be_0.csv"

testingSitesURL="https://opendata.arcgis.com/datasets/836372161f4f4f989fb826a6b78c1c67_0.csv?outSR=%7B%22latestWkid%22%3A3857%2C%22wkid%22%3A102100%7D"

vaccineURL="https://opendata.arcgis.com/datasets/fa9730c29ee24c7b8b52361ae3e5ca53_0.csv"

stateLevExpCaseDataURL="https://opendata.arcgis.com/datasets/a0f52ab12eb4466bb6a76cc175923e62_0.csv"

wastewaterDashboardURL="https://opendata.arcgis.com/datasets/c6566d454edb47c680afe839a0b4fc26_0.csv"

cdcURL="https://data.cdc.gov/api/views/r8kw-7aab/rows.csv?accessType=DOWNLOAD"



# as an array:
URLs=($dailyStateStatURL $dailyStateStat2URL $byCountyOfIDURL $stateodrURL $clinicalLabsURL $countyodrURL $testingSitesURL $vaccineURL $stateLevExpCaseDataURL $wastewaterDashboardURL $cdcURL)

# note following names need to be in exact same order as URLs!
names=(CDPHE_COVID19_Daily_State_Statistics_
CDPHE_COVID19_Daily_State_Statistics_2_
Colorado_COVID19_Positive_Cases_and_Rates_of_Infection_by_County_of_Identification_
CDPHE_COVID19_State-Level_Open_Data_Repository_
COVID19_Positivity_Data_from_Clinical_Laboratories_
CDPHE_COVID19_County-Level_Open_Data_Repository_
Community_Testing_Sites_
Vaccine_Daily_Summary_Statistics_
State_Level_Expanded_Case_Data_
Wastewater_Dashboard_Data_
Provisional_COVID-19_Death_Counts_by_Week_Ending_Date_and_State_)


# subdirs in same order too!
subdirs=(DailyStateStats
DailyStateStats2
ByCountyOfID
StateLevelOpenDataRepo
ClinicalLabs
CountyLevelOpenDataRepo
CommunityTestingSites
VaccineDailySummary
StateLevelExpandedCaseData
WastewaterDashboardData
../../CDC_Data)


arrayLength="${#names[@]}"

# loop over each one and curl:
for (( i=0; i<$arrayLength; i++ ))
do
	echo $i
	fname="${names[$i]}${mydate}.csv"
	curl ${URLs[$i]} > tmp/${fname}
    echo "${URLs[$i]}"
	echo " "
done

# diff them:
newFileCount=0
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
	# insert some code here for error checking, like grep -i "error" $newOne
        mv $newOne ${subdirs[$i]}/
	dos2unix ${subdirs[$i]}/${names[$i]}${mydate}.csv
	git add ${subdirs[$i]}/${names[$i]}${mydate}.csv
	(( newFileCount++ ))
    fi
done

if (( $newFileCount > 0 ))
then
	echo "$newFileCount file(s) with new data created"
	git commit -m "$newFileCount data file(s) curled and auto-added and auto-committed"
fi


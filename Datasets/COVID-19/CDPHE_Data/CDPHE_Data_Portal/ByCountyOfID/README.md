# Data on COVID-19 in Colorado By County

Accessed during March 2020 and beyond at [https://data-cdphe.opendata.arcgis.com/datasets/colorado-covid-19-positive-cases-and-rates-of-infection-by-county-of-identification][sourcewebpage]

## Notes about the raw data and their source:

The "Custom License" shown at the website above (as accessed on 3/22/20) says:
> These data are published for informational purposes and there are no restrictions for using or disseminating this data set. Users of the data should consider factors such as the data source, time period, assignment of geography, statistical reliability, and/or calculation of rate. The State of Colorado, the Colorado Department of Human Services, and the Colorado Department of Public Health and Environment assumes no liability to the completeness, correctness, or fitness for use of this data set. Please contact the GIS Coordinator at the Colorado Department of Public Health and Environment for more information on how this data was assembled, using this data set, or to request additional access to this data.

Additional notes at the above web page (as accessed on 3/27/20):
> **As of 3/17/2020 this layer is updated daily around 4pm from https://covid19.colorado.gov/data.  This dataset contains the number of COVID-19 Positive *Cases by County of Identification and County Rate of Infection Per 100,000 Persons as well as Statewide COVID-19 Prevalence Data.  *Cases include people who test positive for COVID-19 AND people who have symptoms of COVID-19 and are a close contact to someone who tested positive.  Rates for those counties with less than 5 cases are suppressed (not shown).

There is also a "metadata" link from that webpage, which points to:  [https://www.arcgis.com/sharing/rest/content/items/fbae539746324ca69ff34f086286845b/info/metadata/metadata.xml?format=default&output=html][metadatalink].  Please visit [that link][metadatalink] for more information about the data themselves.

## Notes about files here
The raw data can be obtained from a link at [this page][sourcewebpage].  I obtained the raw data URL by clicking on the "Download" button and then getting the URL from the "Full Dataset > Spreadsheet" button that appeared.  That URL was put into the script I wrote called ["dataportcurl.sh"](https://github.com/flaxmans/CompBio_on_git/blob/main/Datasets/COVID-19/CDPHE_Data/CDPHE_Data_Portal/dataportalcurl.sh) for automation of data collection.  Names of .csv files indicate the dates on which they were obtained.

Note that the URL changes periodically (apparently without warning).  As such, I sometimes miss several days if I don't notice the error message generated.

## Additional Data Availability
Data from the Colorado Department of Public Health and Environment are also archived on Google Drive at [https://drive.google.com/drive/folders/11ulhC5FwnRhiKqxDl6_9PnSMOjCWnLPB?usp=sharing](https://drive.google.com/drive/folders/11ulhC5FwnRhiKqxDl6_9PnSMOjCWnLPB?usp=sharing).  That link was found at [https://covid19.colorado.gov/case-data](https://covid19.colorado.gov/case-data).

## No warranty
The data here are provided with absolutely no warranty with regard to their fitness for any kind of use.

[metadatalink]: https://www.arcgis.com/sharing/rest/content/items/fbae539746324ca69ff34f086286845b/info/metadata/metadata.xml?format=default&output=html

[sourcewebpage]: https://data-cdphe.opendata.arcgis.com/datasets/colorado-covid-19-positive-cases-and-rates-of-infection-by-county-of-identification

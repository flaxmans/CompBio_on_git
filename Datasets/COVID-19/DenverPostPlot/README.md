# Data and plots on new daily cases of COVID-19 in Colorado  

The data here were read and entered (by hand) from 
[https://www.denverpost.com/2020/03/06/coronavirus-map-colorado/][DenverPostPageLink], 
accessed periodically throughout March of 2020.

Data like these could be used to partially reconstruct a plot like the one shown below, which is a screenshot taken from the webpage above on March 21, 2020.

![COVID-19 cases over time in Colorado](COVID-19_DenverPost_ExamplePlot.png)


Starting around March 30th, the data were displayed in two separate plots as follows:

![COVID-19 cases over time in Colorado, second example](COVID-19_DenverPost_SecondExample.png)


## Note about data revision on April 9th:
On April 9th, the following note appeared on the [Denver Post page][DenverPostPageLink]:
> A note about the data released by the Colorado Department of Public Health and Environment on April 9:

> "You’ll notice a large spike in today’s case summary for Colorado. This is due to cases & deaths that occurred days and weeks prior, but not reported to the state until today. This could make it appear as though there are false spikes in day-to-day cases. [https://t.co/bnCHdYAtHA](https://t.co/bnCHdYAtHA)

> — Colorado Department of Public Health & Environment (@CDPHE) April 9, 2020"

> Data updated at 5:12 PM Apr 9

> Note: We have changed the way we present the daily data to match the Colorado Department of Public Health and Environment's revised figures. Reported data is through the previous day, which is reflected on the charts. Not all cumulative cases are active — the state has not released recovery data. Source for all data is the [CDPHE](https://www.colorado.gov/pacific/cdphe/2019-novel-coronavirus).


As such, the current version of the data are now in the a file named `RevisedData.csv`.  The original data were removed from subsequent commits but are in the history of commits.  Numbers were revised for dates starting on 3/19.


## Question:
How could we use the data here to reproduce the plots shown?



[DenverPostPageLink]: https://www.denverpost.com/2020/03/06/coronavirus-map-colorado/

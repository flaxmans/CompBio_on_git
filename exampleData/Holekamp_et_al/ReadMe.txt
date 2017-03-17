Data from:

Holekamp, Kay E., Jennifer E. Smith, Christopher C. Strelioff, Russell C. Van Horn, and Heather E. Watts. 2011. 
Society, demography and genetic structure in the spotted hyena. Molecular Ecology.

##
## Filename: "Holekampetal_data_Fig6.csv"
##

*Format: comma-delimited text file

*Description:  The data matrix consists of 4 columns (variables) and 13,826 rows (records) of data (and one header row), where each record represents a different dyad of spotted hyenas.

*Variables:
    
  "dyadtype"  = 1 of 6 categories of dyads of spotted hyenas, as defined in Van Horn et al. 2004.

  "firstID"   = ID is a unique identifier associated with different individual spotted hyenas. FirstID indicates the first individual hyena included in the dyad; in this file by convention the abbreviations of individuals within a dyad are ordered alphabetically.

  "secondID" = ID is a unique identifier associated with different individual spotted hyenas. SecondID indicates the second individual hyena included in the dyad.

  "pairwiseR" = the pairwise Queller and Goodnight (1989) R-value for the dyad, as calculated in Van Horn et al. 2004.

*Further Information:

Russ Van Horn, Ph.D.
Institute for Conservation Research
San Diego Zoo Global
15600 San Pasqual Valley Road
Escondido, CA 92027-7000
rvanhorn(at)sandiegozoo.org

*References:

These data were originally presented in Figures 2 of Van Horn et al. 2004:

Van Horn, Russell C., Anne L. Engh, Kim T. Scribner, Stephan M. Funk, and Kay E. Holekamp. 2004. Behavioural structuring of relatedness in the spotted hyena (Crocuta crocuta) suggests direct fitness benefits of clan-level cooperation. Molecular Ecology 13:449-458.


##
## Filename: "Holekampetal_data_Fig7.csv"
##

*Format: comma-delimited text file

*Description:  The data matrix consists of 6 columns (variables) and 30,135 rows (records) of data (and one header row), where each record represents a different dyad of spotted hyenas.

*Variables:

  "FirstClan" = clan (social group) membership of the first hyena in the dyad; there are 7 possible clans in this dataset.
  
  "FirstID" = ID is a unique identifier associated with different individual spotted hyenas. FirstID indicates the first individual spotted hyena included in the dyad.
  
  "SecondClan" = clan membership of the second hyena in the dyad.
  
  "SecondID" = ID is a unique identifier associated with different individual spotted hyenas. SecondID indicates the second individual spotted hyena included in the dyad.
  
  "ClanDistance" = the number of clan borders, or social boundaries, between the two hyenas in the dyad. Values for ClanDistance vary from 0 to 3, where a ClanDistance of 0 indicates two hyenas that belong to the same clan, a ClanDistance of 1 indicates that the two hyenas belong to neighboring clans, etc.
  
  "pairwiseR" = the pairwise Queller and Goodnight (1989) R-value for the dyad, as calculated in Van Horn et al. 2004.

*Further Information:

Russ Van Horn, Ph.D.
Institute for Conservation Research
San Diego Zoo Global
15600 San Pasqual Valley Road
Escondido, CA 92027-7000
rvanhorn(at)sandiegozoo.org

*References:

These data were originally presented in Figure 7 of Van Horn et al. 2004.

Van Horn, Russell C., Anne L. Engh, Kim T. Scribner, Stephan M. Funk, and Kay E. Holekamp. 2004. Behavioural structuring of relatedness in the spotted hyena (Crocuta crocuta) suggests direct fitness benefits of clan-level cooperation. Molecular Ecology 13:449-458.

##
## Filename: "Holekampetal_data_Fig8.csv"
##

*Format: comma-delimited text file

*Description:  The data matrix consists of 7 columns (variables) and 395 rows (records) of data (and one header row), where each record represents a different natal spotted hyena during a particular life history stage when prey were either locally abundant or scarce.

*Variables:

  "ID" = a unique identifier associated with each particular individual spotted hyenas. 
  
  "LifeHistory" = stage of ontogeny for natal animals (from early to late development: Den_cub, Den_graduate, or Adult).    
  
  "Sex" = male (m) or female (f).    
  
  "StStrength_Kin_LowPrey" = Standardized strength (mean association value) with natal kin animals during period of low density of local prey.
  
  "StStrength_Kin_HighPrey" = Standardized strength (mean association value) with natal kin animals during period of high density of local prey.
      
  "StStrength_Non-kin_LowPrey" = Standardized strength (mean association value) with natal non-kin animals during period of low density of local prey.
   
  "StStrength_Non-kin_HighPrey" = Standardized strength (mean association value) with natal kin animals during period of high density of local prey.

*Further Information:

Jennifer E. Smith, Ph.D. or Christopher C. Strelioff, Ph.D. 
Department of Ecology & Evolutionary Biology, 
University of California Los Angeles, 
621 Charles E. Young Drive South, 
Los Angeles, CA 90095-1606
  
smith.jennifer.elaine@gmail.com or chris.strelioff@gmail.com

##
## Filenames: Holekampetal_data_Fig9A.csv, Holekampetal_data_Fig9B.csv,
##           Holekampetal_data_Fig9C.csv
##

*Format: flat text file in pajek *.net format

*Description: Data set provides the information presented in panels of Figure 9.  Three files, one for each panel in the plot are provided.  The first part of the file provides information about the nodes/vertices that represent hyenas. The second part of the file provides all non-zero association indicies between hyena dyads.

*Variables (Top of file, under *Vertices):
  "Vertex number" = a unique integer number, assigned to each hyena in the network.
  
  "Hyena ID" = a unique label assigned to each hynea in the long-term Talek clan study.
  
  "Matriline" = rank of the matriline for the hyena.
  
  "Life history stage" =  this can be 1 (subadult) or 2 (adult).
  
*Variables (Bottom of file, under *Edges):
  "Vertex one" = the vertex number (see above) assigned to the first member of the dyad
  
  "Vertex two" = the vertex number (see above) assigned to the second member of the dyad
  
  "Edge weight" = the association index, as defined in the main text, for the hyenas at vertex one and two.

*Further Information:

Jennifer E. Smith, Ph.D. or Christopher C. Strelioff, Ph.D. 
Department of Ecology & Evolutionary Biology, 
University of California Los Angeles, 
621 Charles E. Young Drive South, 
Los Angeles, CA 90095-1606
  
smith.jennifer.elaine@gmail.com or chris.strelioff@gmail.com

##
## Filename: Holekampetal_data_Table2.csv
##

*Format: comma-delimited text file

*Description: Data set associated with the estimation of Nonacs binomial skew index B, and results for Crocuta presented in Table 2.  The data matrix consists of 3 columns (variables) and 121 rows (records) of data, where each record represents a different adult spotted hyena in the Talek clan.

*Variables:
  "sex" = the sex of the individual adult spotted hyena. There are two possible values: male, and female.
  
  "# of cubs" = the number of cubs assigned to the individual via genetic confirmation of maternity or via paternity analysis. Values range from 0 to 15 cubs.
   
  "tenure" = the tenure in months of the individual as an adult in the Talek clan during the study period. Values range from 0.03 to 157.1 months.

*Further Information:

Russ Van Horn, Ph.D.
Institute for Conservation Research
San Diego Zoo Global
15600 San Pasqual Valley Road
Escondido, CA 92027-7000
rvanhorn(at)sandiegozoo.org

##
## Filename: "Holekampetal_data_on_prob_of_remating.csv"
##

*Format: comma-delimited text file

*Description:  The data matrix consists of 3 columns (variables) and 30 rows (records) of data (and one header row), where each record represents a females' probability or remating with earlier sires, given 1 to 4 opportunities to do so.  A fourth column provides notes for some entries.  

These data are presented only in the text, and have no associated figure. The data are summarized in the "Results and Discussion" section entitled "Effects of dispersal, mate choice and reproductive skew on patterns of relatedness."

*Variables:
  "Female ID" = a unique identifier associated with each particular adult female spotted hyena present in the Talek clan during years when paternity analyses were conducted on litters conceived.

  "Number litters conceived where female might have mated again with a sire of an earlier successful litter" = The number of litters conceived during the years of our study period when paternities were known for which the female had one or more opportunities to mate again with a sire of one of her earlier litters.

  "Number litters sired by a male who sired an earlier successful litter" = The number of litters conceived during the years of our study period when paternities were known for which the female chose to mate again with a sire of one of her earlier litters.
  
  "Notes" = A notation regarding which male sired multiple litters conceived by Talek females in the three cases in which this occurred.
  
*Further Information:

Professor Kay E. Holekamp
Department of Zoology
Program in Ecology, Evolution, Biology & Behavior (EEBB)
303 Natural Science Building
Michigan State University
East Lansing, MI 48824-1115

holekamp@msu.edu


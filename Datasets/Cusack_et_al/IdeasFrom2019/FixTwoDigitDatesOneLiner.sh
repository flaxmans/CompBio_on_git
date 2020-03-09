# shell command to change two-digit years to four digit years:

sed 's/\/13 /\/2013 /' Cusack_et_al_random_versus_trail_camera_trap_data_Ruaha_2013_14.csv | sed 's/\/14 /\/2014 /' > CusackDataFourDigitYears.csv

# explanation of sed command:
# 's/\/13 /\/2013 /' means substitute occurrences of "/13 " with "/2013 ".  
# The extra backslashes are needed as "escape" characters so that the 
# forward slashes immediately following the back slashes 
# are interpreted as literal characters rather than as a separators 
# between parts of the command.  In other words, a forward slash is the 
# normal separator between parts of a sed command, i.e., syntax is:
# 's/searchFor/replaceWith/'
# The leading "s" means substitute.



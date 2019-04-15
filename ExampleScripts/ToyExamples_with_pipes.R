# toy examples with pipes

# a toy data frame:
x <- 1:10
treat1 <- c(rep("A",5), rep("B",5))
treat2 <- c("D","D", rep("C", 5), rep("D", 3))
mydata <- data.frame(var1 = sin(x), var2 = cos(x), treatment1 = treat1, treatment2 = treat2)
mydata

library("dplyr")
# sorting
# traditional syntax:
sort_t <- arrange( mydata, var1 )
# same thing with pipes:
sort_p <- mydata %>% arrange( var1 )
# validate:
all(sort_t == sort_p)
sort_p

# subset (filter) then sort on values of x for both operations:
# traditional syntax:
fts_t <- arrange( filter( mydata, var1 > 0 ), var1 )
# with pipes:
fts_p <- mydata %>% filter( var1 > 0 ) %>% arrange( var1 )
# validate:
all(fts_t == fts_p)
fts_p

# NOTE ABOUT LINE BREAKS:
# line breaks can be used in EITHER syntax and are
# completely optional
# In traditional syntax, line breaks can happen after a comma or 
# after an open parenthensis, or before a closing parenthesis:
fts_t2 <- arrange( 
  filter( mydata, var1 > 0 ), 
  var1 
  )

# with pipes, line breaks can ALSO happen after pipes:
fts_p2 <- mydata %>% 
  filter( var1 > 0 ) %>% 
  arrange( var1 )

all(fts_t2 == fts_t)
all(fts_p2 == fts_p)

# finally, note that line breaks with either syntax
# allow you to insert comments line-by-line if you wish.
# You obviously can NOT insert comments in the middle of 
# a single line command:

# this works:
fts_t3 <- arrange(               # comment 1
  filter( mydata, var1 > 0 ),    # comment 2
  var1                           # comment 3
)

# the following would NOT work:
## fts_t <- arrange( #comment1 filter( mydata, var1 > 0 ), var1 )


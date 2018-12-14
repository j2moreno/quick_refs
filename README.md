# quick_refs
A repo with handy one liners for text manipulation, python snippets, Snakemake docs, etc. 

### This can be used to get column number of a specific entry in a row

Ex:

A          B           C

123     345      678

If you wanted to know which column C was in (in this case it is 3) you write:

`awk 'FNR==<row_number>'  file | awk -F'<delimiter>'  ' { for (i = 1; i <= NF; ++i) print i, $i; exit } ' | grep 'C' `

***FNR*** = which row (in this example the first row)

***delimiter*** = how the file is formatted whether it be by tabs or spaces
and then do a grep for C and return the column number

***without grep you get all column numbers of entries in row in order

## This can be used to get column number of a specific entry in a row

Ex:

A       B        C

123     345      678

If you wanted to know which column C was in (in this case it is 3) you write:

`awk 'FNR==<row_number>'  file | awk -F'<delimiter>'  ' { for (i = 1; i <= NF; ++i) print i, $i; exit } ' | grep 'C' `

***FNR*** = which row (in this example the first row)

***delimiter*** = how the file is formatted whether it be by tabs or spaces
and then do a grep for C and return the column number

*** without grep you get all column numbers of entries in row in order

## In place line replacement using sed

`sed -i '34s/AAA/BBB/g' file_name`

## Insert line into speific line number

`sed -i '1s/AAAAA\n' file_name `

## Replace whole line

`sed -i '34s/.*/BBB':g file_name`

## Linux Commands

1. Python -m SimpleHTTPServer : Creates a simple web page for the current working directory over port 8000.
2. id : Print User and Group Id.
3. du -h –max-depth=1 Command : Outputs the size of all the files and folders within current folder, in human readable format.
4. ping -i 60 -a IP_address : Pings the provided IP_address, and gives audible sound when host comes alive.
5. strace : A debugging tool.
6. bind -p : Shows all the shortcuts available in Bash.
7. pdftk : A nice way to concatenate a lot of pdf files, into one.
8. ps -LF -u user_name : Outputs Processes and Threads of a user.

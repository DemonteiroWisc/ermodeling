#!/bin/bash
#this command parses the ebay_data folder and creates .dat files which are stored in this scripts directory
clear
sh ./runParser.sh
sort -u user.dat -o user.dat
#create the database "ebay"
echo "Creating Database ..."
sqlite3 ebay < create.sql
echo "Done creating database!"
# bulk load the .dat files from parsing into the database
echo "Loading Database ..."
sqlite3 ebay < load.txt
echo "Done loading database!"
# run the 7 queries on the database, which prints their output into the console
for i in {1..7}
do
    echo "Query $i:"
    sqlite3 ebay < query$i.sql
done
rm -f -- item.dat bid.dat user.dat cat.dat

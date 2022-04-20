#!/bin/bash
#this command parses the ebay_data folder and creates .dat files which are stored in this scripts directory
rm -f -- ebay
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
echo "Query 1:"
sqlite3 ebay < query1.sql
echo "Query 2:"
sqlite3 ebay < query2.sql
echo "Query 3:"
sqlite3 ebay < query3.sql
echo "Query 4:"
sqlite3 ebay < query4.sql
echo "Query 5:"
sqlite3 ebay < query5.sql
echo "Query 6:"
sqlite3 ebay < query6.sql
echo "Query 7:"
sqlite3 ebay < query7.sql
rm -f -- item.dat bid.dat user.dat cat.dat

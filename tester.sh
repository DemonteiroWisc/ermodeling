#!/bin/bash
#this command parses the ebay_data folder and creates .dat files which are stored in this scripts directory
rm -f -- item.dat bid.dat user.dat cat.dat
python3 my_parser.py ebay_data/items-0.json
#create the database "ebay"
sqlite3 ebay < create.sql
# bulk load the .dat files from parsing into the database
sqlite3 ebay < load.txt
# run the 7 queries on the database, which prints their output into the console
#for i in {1..7}
#    do
#        sqlite3 ebay < query$i.sql
#    done

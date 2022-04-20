sed -i 's+\r++' runParser.sh
rm -f -- item.dat bid.dat user.dat cat.dat
python3 my_parser.py ebay_data/items-*.json
cat user.dat | sort | uniq > result
rm -f user.dat
mv result user.dat
cat cat.dat | sort | uniq > result
rm -f cat.dat
mv result cat.dat
cat bid.dat | sort | uniq > result
rm -f bid.dat
mv result bid.dat
cat item.dat | sort | uniq > result
rm -f item.dat
mv result item.dat
dataFile="*.dat"
if [-f dataFile] then 
rm item.dat user.dat 
fi
python my_parser.py ebay_data/items-*.json

"""
FILE: skeleton_parser.py
------------------
Author: Firas Abuzaid (fabuzaid@stanford.edu)
Author: Perth Charernwattanagul (puch@stanford.edu)
Modified: 04/21/2014

Skeleton parser for CS564 programming project 1. Has useful imports and
functions for parsing, including:

1) Directory handling -- the parser takes a list of eBay json files
and opens each file inside of a loop. You just need to fill in the rest.
2) Dollar value conversions -- the json files store dollar value amounts in
a string like $3,453.23 -- we provide a function to convert it to a string
like XXXXX.xx.
3) Date/time conversions -- the json files store dates/ times in the form
Mon-DD-YY HH:MM:SS -- we wrote a function (transformDttm) that converts to the
for YYYY-MM-DD HH:MM:SS, which will sort chronologically in SQL.

Your job is to implement the parseJson function, which is invoked on each file by
the main function. We create the initial Python dictionary object of items for
you; the rest is up to you!
Happy parsing!
"""

import sys
from json import loads
from re import sub

columnSeparator = "|"

# Dictionary of months used for date transformation
MONTHS = {'Jan':'01','Feb':'02','Mar':'03','Apr':'04','May':'05','Jun':'06',\
        'Jul':'07','Aug':'08','Sep':'09','Oct':'10','Nov':'11','Dec':'12'}

"""
Returns true if a file ends in .json
"""
def isJson(f):
    return len(f) > 5 and f[-5:] == '.json'

"""
Converts month to a number, e.g. 'Dec' to '12'
"""
def transformMonth(mon):
    if mon in MONTHS:
        return MONTHS[mon]
    else:
        return mon

"""
Transforms a timestamp from Mon-DD-YY HH:MM:SS to YYYY-MM-DD HH:MM:SS
"""
def transformDttm(dttm):
    dttm = dttm.strip().split(' ')
    dt = dttm[0].split('-')
    date = '20' + dt[2] + '-'
    date += transformMonth(dt[0]) + '-' + dt[1]
    return date + ' ' + dttm[1]

"""
Transform a dollar value amount from a string like $3,453.23 to XXXXX.xx
"""

def transformDollar(money):
    if money == None or len(money) == 0:
        return money
    return sub(r'[^\d.]', '', money)

def transformStr(string):
    if string == None or len(string) == 0:
        return string
    return "\"{}\"".format(string.replace("\"", "\"\""))

"""
Parses a single json file. Currently, there's a loop that iterates over each
item in the data set. Your job is to extend this functionality to create all
of the necessary SQL tables for your database.
"""
def parseJson(json_file):
    with open(json_file, 'r') as f:
        items = loads(f.read())['Items'] # creates a Python dictionary of Items for the supplied json file
        itemF = open("item.dat", 'a')
        catF = open("cat.dat", 'a')
        bidF = open("bid.dat", 'a')
        userF = open("user.dat", 'a')
        for item in items:
            """
            TODO: traverse the items dictionary  extract information from the
            given `json_file' and generate the necessary .dat files to generate
            the SQL tables based on your relation design
            """
            seller = item["Seller"]
            userL_S = "{}|{}|{}|{}\n".format(transformStr(seller["UserID"]), transformStr(item["Location"]),
                                             transformStr(item["Country"]), seller["Rating"])
            userF.write(userL_S)
            if item["Bids"]:
                for bid_obj in item["Bids"]:
                    bid = bid_obj["Bid"]
                    bidder = bid["Bidder"]
                    userID = transformStr(bidder["UserID"])
                    bidL = "{}|{}|{}|{}\n".format(item["ItemID"], userID, transformDttm(bid["Time"]), transformDollar(bid["Amount"]))
                    bidF.write(bidL)
                    userL_B = "{}|".format(userID)
                    if "Location" in bidder.keys(): userL_B += "{}|".format(transformStr(bidder["Location"]))
                    else: userL_B += "null|"
                    if "Country" in bidder.keys(): userL_B += "{}".format(transformStr(bidder["Country"]))
                    else: userL_B += "null"
                    userL_B += "|{}\n".format(bidder["Rating"])
                    userF.write(userL_B)
            itemL = "{}|{}|{}|".format(item["ItemID"], transformStr(item["Name"]),
					transformDollar(item["Currently"]))
            if "Buy_Price" in item.keys():
                itemL += "{}|".format(transformDollar(item["Buy_Price"]))
            else:
                itemL += "null|"
            itemL += "{}|{}|{}|{}|{}|{}\n".format(transformDollar(item["First_Bid"]),
					item["Number_of_Bids"], transformDttm(item["Started"]), transformDttm(item["Ends"]),
                    transformStr(item["Description"]), transformStr(seller["UserID"]));
            itemF.write(itemL)
            # use set() to find unique categories
            for category in list(set(item["Category"])):
                catL = "{}|{}\n".format(item["ItemID"], transformStr(category))
                catF.write(catL)
        itemF.close()
        catF.close()
        bidF.close()
        userF.close()


"""
Loops through each json files provided on the command line and passes each file
to the parser
"""
def main(argv):
    if len(argv) < 2:
        print >> sys.stderr, 'Usage: python skeleton_json_parser.py <path to json files>'
        sys.exit(1)
    # loops over all .json files in the argument
    for f in argv[1:]:
        if isJson(f):
            parseJson(f)
            print("Success parsing " + f)

if __name__ == '__main__':
    main(sys.argv)

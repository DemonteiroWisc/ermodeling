drop table if exists Item;
drop table if exists Category;
drop table if exists Bid;
drop table if exists User;


create table Item (
    ItemID integer primary key,
    Name varchar(256),
    Currently double,
    Buy_Price double,
    First_Bid double,
    Number_of_Bids integer,
    Started varchar(256),
    Ends varchar(256),
    Description varchar(1000),
    SellerID varchar(256),
    foreign key(SellerID) references Users(UserID)
);

create table Category (
    ItemID integer,
    Description varchar(1000),
    primary key(ItemID, Description),
    foreign key(ItemID) references Item(ItemID)
);

create table Bid (
    ItemID integer,
    BidderID varchar(256),
    Time varchar(256),
    Amount double,
    primary key(ItemID, BidderID, Time),
    foreign key(ItemID) references Item(ItemID),
    foreign key(BidderID) references User(UserID)
);

create table User (
    UserID varchar(256) primary key,
    Location varchar(256),
    Country varchar(256),
    Rating integer
);
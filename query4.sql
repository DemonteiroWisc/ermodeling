WITH MaxBid as(
    SELECT MAX(Currently) as m
    FROM Item)
SELECT Item.ItemID
FROM Item, MaxBid
WHERE Item.Currently=MaxBid.m

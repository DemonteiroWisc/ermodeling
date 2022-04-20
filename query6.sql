WITH Sellers as(
    SELECT DISTINCT SellerID as ID
    FROM Item),
Bidders as(
    SELECT DISTINCT BidderID as ID
    FROM Bid)
SELECT COUNT(*)
FROM Bidders, Sellers
WHERE Sellers.ID = Bidders.ID

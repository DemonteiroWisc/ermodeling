WITH Sellers as(
    SELECT DISTINCT SellerID as ID
    FROM Item)
SELECT COUNT(*)
FROM Sellers, User
WHERE Sellers.ID = User.UserID AND User.Rating > 1000

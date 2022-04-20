SELECT COUNT(*)
FROM Item, User
WHERE Item.SellerID = User.UserID AND User.Rating > 1000
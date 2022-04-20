SELECT COUNT(*)
FROM Item, Bid, User
WHERE Item.SellerID = User.UserID AND Bid.BidderID = User.UserID
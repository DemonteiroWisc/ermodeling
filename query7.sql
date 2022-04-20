WITH Cats as (
    SELECT DISTINCT Category.Description as Cat
    FROM Item, Category
    WHERE Item.Currently > 100 AND Item.Number_of_Bids > 0 AND Item.ItemID=Category.ItemID)
SELECT COUNT(*)
FROM Cats

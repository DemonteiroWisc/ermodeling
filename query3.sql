WITH CatCount as (SELECT ItemID, COUNT(*) as c
    FROM Category
    GROUP BY ItemID)
SELECT COUNT(*)
FROM CatCount
WHERE c = 4;

#Q4
WITH topItems as (
    SELECT MAX(Currently), ItemID
    FROM Item
    GROUP BY ItemID
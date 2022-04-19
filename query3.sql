WITH CatCount as (SELECT ItemID, COUNT(*) as c
    FROM Category
    GROUP BY ItemID)
SELECT COUNT(*)
FROM CatCount
WHERE c = 4;
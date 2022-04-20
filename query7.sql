WITH Cats as (
    SELECT DISTINCT Category as Category
    FROM Item
    WHERE Currently > 100)
SELECT COUNT(*)
FROM Cats
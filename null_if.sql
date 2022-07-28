/*
* DB: Store
* Table: products
* Question: Show NULL when the product is not on special (0)
*/

SELECT
    p.title,
    NULLIF(p.special, 0) AS "On special"
FROM "public"."products" AS p;

-- or

SELECT prod_id, title, price, NULLIF(special, 0) as "special"
FROM products
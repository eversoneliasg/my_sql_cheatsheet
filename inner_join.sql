/*
* Inner join is considered to be a good practice
* Joining and filtering tables.
*/

SELECT  a.emp_no,
        CONCAT(a.first_name, ' ', a.last_name) as "name",
        b.salary,
        COALESCE(c.title, 'No title change'),
        COALESCE(c.from_date::text, '-') AS "Title taken on"
FROM "public"."employees" as a
INNER JOIN "public"."salaries" AS b ON a.emp_no = b.emp_no
INNER JOIN "public"."titles" AS c 
ON  c.emp_no = a.emp_no AND (
    c.from_date = (b.from_date + interval '2 days') OR
    c.from_date = b.from_date
)
ORDER BY a.emp_no;
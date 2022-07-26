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

/*
* DB: Store
* Table: orders
* Question: Get all orders from customers who live in Ohio (OH), New York (NY) or Oregon (OR) state
* ordered by orderid
*/

SELECT c.firstname, c.lastname, o.orderid FROM orders AS o
INNER JOIN customers AS c ON o.customerid = c.customerid
WHERE c.state IN ('NY', 'OH', 'OR')
ORDER BY o.orderid;


/*
* DB: Store
* Table: products
* Question: Show me the inventory for each product
*/

SELECT p.prod_id, i.quan_in_stock
FROM products as p
INNER JOIN inventory AS i oN p.prod_id = i.prod_id 


/*
* DB: Employees
* Table: employees
* Question: Show me for each employee which department they work in
*/

SELECT e.first_name, dp.dept_name
FROM employees AS e
INNER JOIN dept_emp AS de ON de.emp_no = e.emp_no
INNER JOIN departments AS dp ON dp.dept_no = de.dept_no
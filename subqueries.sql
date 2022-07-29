/*
* Show all employees older than the average age
*/

SELECT
    first_name,
    last_name,
    birth_date,
    AGE(birth_date)
FROM employees
WHERE AGE(birth_date) > (SELECT AVG(AGE(birth_date)) FROM employees);

/*
* Show the title by salary for each employee
*/

SELECT
    emp_no,
    salary,
    from_date,
    (SELECT title FROM titles AS t
    -- referencing outside = correlated subquery
    WHERE t.emp_no = s.emp_no
    AND (t.from_date = s.from_date + INTERVAL '2 days' OR t.from_date = s.from_date))
FROM salaries AS s
ORDER BY emp_no;

-- The query above works as a LEFT OUTER JOIN. So, it was a bad use of subqueries.

SELECT
    emp_no,
    salary,
    from_date,
    t.title
FROM salaries AS s
LEFT OUTER JOIN titles AS t USING(emp_no, from_date)
ORDER BY emp_no;

-- Query for most recent salary

SELECT
    emp_no,
    salary AS "most recent salary",
    from_date
FROM salaries AS s
WHERE from_date = (
    SELECT MAX(from_date)
    FROM salaries AS sp
    WHERE sp.emp_no = s.emp_no
    )
ORDER BY emp_no ASC;

/* TRY TO WRITE THESE AS JOINS FIRST */
/*
* DB: Store
* Table: orders
* Question: Get all orders from customers who live in Ohio (OH), New York (NY) or Oregon (OR) state
* ordered by orderid
*/

SELECT c.firstname, c.lastname, o.orderid 
FROM orders AS o, (
    SELECT customerid, state, firstname, lastname
    FROM customers
) AS c
WHERE  o.customerid = c.customerid AND 
c.state IN ('NY', 'OH', 'OR')
ORDER BY o.orderid;

/*
* DB: Employees
* Table: employees
* Question: Filter employees who have emp_no 110183 as a manager
*/

SELECT emp_no, first_name, last_name
FROM employees
WHERE emp_no IN (
    SELECT emp_no
    FROM dept_emp
    WHERE dept_no = (
        SELECT dept_no 
        FROM dept_manager
        WHERE emp_no = 110183
    )
)
ORDER BY emp_no

-- Written with JOIN
SELECT e.emp_no, first_name, last_name
FROM employees as e
JOIN dept_emp as de USING (emp_no)
JOIN dept_manager as dm USING (dept_no)
WHERE dm.emp_no = 110183
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
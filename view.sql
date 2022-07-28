/*
*  Create a view "90-95" that:
*  Shows me all the employees, hired between 1990 and 1995
*  Database: Employees
*/

CREATE VIEW "90-05" AS
SELECT
    e.emp_no,
    CONCAT(e.first_name, ' ', e.last_name) AS "Name",
    EXTRACT(YEAR FROM e.hire_date) AS "Year"
FROM "public"."employees" AS e
WHERE EXTRACT(YEAR FROM e.hire_date) BETWEEN 1990 AND 1995;

/*
*  Create a view "bigbucks" that:
*  Shows me all employees that have ever had a salary over 80000
*  Database: Employees
*/

CREATE VIEW "bigbucks" AS
SELECT e.emp_no, s.salary
FROM employees AS e
JOIN salaries AS s USING(emp_no)
WHERE s.salary > 80000
ORDER BY s.salary;
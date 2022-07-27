/*
*  How many people were hired on did we hire on any given hire date?
*  Database: Employees
*  Table: Employees
*/

SELECT hire_date, COUNT(emp_no) as "amount"
FROM employees
GROUP BY hire_date
ORDER BY "amount" DESC;

/*
*  Show me all the employees, hired after 1991 and count the amount of positions they've had
*  Database: Employees
*/

SELECT  e.emp_no, hire_date,
        CONCAT(e.first_name, ' ',e.last_name) AS "Employee name",
        COUNT(t.title) AS "Number of positions"
FROM "public"."employees" AS e
INNER JOIN "public"."titles" AS t ON e.emp_no = t.emp_no
where EXTRACT(YEAR FROM e.hire_date) > 1991
GROUP BY e.emp_no
ORDER BY e.emp_no ASC;

-- or

SELECT e.emp_no, count(t.title) as "amount of titles"
FROM employees as e
JOIN titles as t USING(emp_no)
WHERE EXTRACT (YEAR FROM e.hire_date) > 1991
GROUP BY e.emp_no
ORDER BY e.emp_no;

/*
*  Show me all the employees that work in the department development and the from and to date.
*  Database: Employees
*/

SELECT d.dept_no, d.dept_name, de.emp_no, de.from_date, de.to_date
FROM "public"."departments" AS d
INNER JOIN "public"."dept_emp" AS de ON d.dept_no = de.dept_no
WHERE dept_name = 'Development';

-- or

SELECT e.emp_no, de.from_date, de.to_date
FROM employees as e
JOIN dept_emp AS de USING(emp_no)
WHERE de.dept_no = 'd005'
GROUP BY e.emp_no, de.from_date, de.to_date
ORDER BY e.emp_no, de.to_date;
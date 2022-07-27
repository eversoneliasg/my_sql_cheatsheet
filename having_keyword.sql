/*
*  Show me all the employees, hired after 1991, that have had more than 2 titles
*  Database: Employees
*/

SELECT e.emp_no, count(t.title) as "amount of titles"
FROM "public"."employees" as e
INNER JOIN "public"."titles" AS t ON e.emp_no = t.emp_no
WHERE EXTRACT (YEAR FROM e.hire_date) > 1991
GROUP BY e.emp_no
HAVING count(t.title) > 2
ORDER BY e.emp_no;

/*
*  Show me all the employees that have had more than 15 salary changes that work in the department development
*  Database: Employees
*/

SELECT e.emp_no, 
    COUNT(s.salary) AS "Salary changes",
    de.dept_no,
    d.dept_name
FROM "public"."employees" AS e
INNER JOIN "public"."salaries" AS s ON s.emp_no = e.emp_no
INNER JOIN "public"."dept_emp" AS de ON de.emp_no = e.emp_no
INNER JOIN "public"."departments" AS d ON d.dept_no = de.dept_no
WHERE d.dept_name = 'Development'
group BY e.emp_no, de.dept_no, d.dept_name
having COUNT(s.salary) > 15
ORDER BY e.emp_no;

-- or

SELECT e.emp_no, count(s.from_date) as "amount of raises"
FROM employees as e
JOIN salaries as s USING(emp_no)
JOIN dept_emp AS de USING(emp_no)
WHERE de.dept_no = 'd005'
GROUP BY e.emp_no
HAVING count(s.from_date) > 15
ORDER BY e.emp_no;

/*
*  Show me all the employees that have worked for multiple departments
*  Database: Employees
*/

SELECT emp_no, COUNT(dept_no)
FROM "public"."dept_emp"
GROUP BY emp_no
HAVING COUNT(dept_no) > 1
ORDER BY emp_no;

-- or

SELECT e.emp_no, count(de.dept_no) as "worked for # departments"
FROM employees as e
JOIN dept_emp AS de USING(emp_no)
GROUP BY e.emp_no
HAVING count(de.dept_no) > 1
ORDER BY e.emp_no;
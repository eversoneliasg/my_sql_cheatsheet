/*
*  Calculate the total amount of employees per department using grouping sets
*  Database: Employees
*  Table: Employees
*/

SELECT de.dept_no, COUNT(de.emp_no) AS "Number of employees"
FROM "public"."dept_emp" AS de
GROUP BY de.dept_no;

select GROUPING(e.dept_no), e.dept_no, COUNT(e.emp_no)
FROM public.dept_emp as e
GROUP BY
	GROUPING SETS (
		(e.dept_no),
     		()
	)
order by e.dept_no

/*
*  Calculate the total average salary per department and the total using grouping sets
*  Database: Employees
*  Table: Employees
*/

SELECT GROUPING(de.dept_no), de.dept_no, AVG(s.salary)
FROM "public"."dept_emp" AS de
INNER JOIN "public"."salaries" AS s ON s.emp_no = de.emp_no
GROUP BY
    GROUPING SETS (
        (de.dept_no),
        ()
    )
ORDER BY de.dept_no;
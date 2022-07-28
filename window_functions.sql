-- Last salary from a employee

SELECT  DISTINCT e.emp_no,
        e.first_name,
        d.dept_name,
        LAST_VALUE(s.salary) OVER (
            PARTITION BY e.emp_no
            ORDER BY s.from_date
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        ) as "Currente Salary"

FROM salaries AS s

JOIN employees as e USING(emp_no)
JOIN dept_emp AS de USING(emp_no)
JOIN departments AS d USING(dept_no)

/*
*  Show the population per continent
*  Database: World
*  Table: Country
*/

SELECT
    DISTINCT c.continent,
    SUM(c.population) OVER (
        PARTITION BY c.continent
    ) AS "Total population"
FROM "public"."country" AS c;

/*
*  To the previous query add on the ability to calculate the percentage of the world population
*  What that means is that you will divide the population of that continent by the total population and multiply by 100 to get a percentage.
*  Make sure you convert the population numbers to float using `population::float` otherwise you may see zero pop up
*
*  Database: World
*  Table: Country
*/

SELECT
    DISTINCT c.continent,
    SUM(c.population) OVER(
        PARTITION BY c.continent
    ) AS "Continent population",
    CONCAT(
        ROUND(
            (
                SUM(c.population::float4) OVER(PARTITION BY c.continent) /
                SUM(c.population::float4) OVER()
            ) * 100
        ), '%'
    ) AS "Population percentage"
FROM "public"."country" AS c;

/*
*  Count the number of towns per region
*
*  Database: France
*  Table: Regions (Join + Window function)
*/

SELECT
    DISTINCT r.id,
    r.name,
    COUNT(t.id) OVER (
        PARTITION BY r.id
        ORDER BY r.name
    ) AS "# of towns"
FROM "public"."regions" AS r
INNER JOIN "public"."departments" AS d ON r.code = d.region
INNER JOIN "public"."towns" AS t ON d.code = t.department;

-- or

SELECT 
DISTINCT r.id, 
r."name", 
COUNT(t.id) OVER (
    PARTITION BY r.id
    ORDER BY r."name"
) AS "# of towns"
FROM regions AS r
JOIN departments AS d ON r.code = d.region 
JOIN towns AS t ON d.code = t.department
ORDER BY r.id;

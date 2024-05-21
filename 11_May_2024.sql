USE reviews;
DROP TABLE flights;
CREATE TABLE flights 
(
    cid VARCHAR(512),
    fid VARCHAR(512),
    origin VARCHAR(512),
    Destination VARCHAR(512)
);

INSERT INTO flights (cid, fid, origin, Destination) VALUES ('1', 'f1', 'Idr', 'Hyd');
INSERT INTO flights (cid, fid, origin, Destination) VALUES ('1', 'f2', 'Hyd', 'Del');
INSERT INTO flights (cid, fid, origin, Destination) VALUES ('2', 'f3', 'Mum', 'Blr');
INSERT INTO flights (cid, fid, origin, Destination) VALUES ('2', 'f4', 'Blr', 'Kol');

SELECT * FROM flights;

SELECT f1.cid , f1.origin, f2.Destination 
FROM flights f1
INNER JOIN flights f2
ON f1.Destination = f2.origin;  -- Tiger Analytics


-- NTILE

SELECT emp_no, department, salary,
NTILE(4) OVER(PARTITION BY department ORDER BY salary DESC) AS dept_salary_quartile
FROM employees;

-- FIRST_VALUE
SELECT emp_no, department, salary,
FIRST_VALUE(salary) OVER(PARTITION BY department ORDER BY salary DESC) as highest_salary_in_dept,
FIRST_VALUE(salary) OVER(ORDER BY salary) AS lowest_salary_in_firm
FROM employees;

-- LEAD/LAG
SELECT emp_no, department, salary,
salary - LAG(salary) OVER(ORDER BY salary DESC) AS salary_diff
FROM employees;

SELECT emp_no, department, salary,
salary - LEAD(salary) OVER(ORDER BY salary DESC) AS salary_diff,
salary - LAG(salary) OVER(PARTITION BY department ORDER BY salary DESC) AS dept_salary_diffference
FROM employees;

-- UNIONS

/* A union is how you combine the rows together 
you should keep it the same kind of data
*/

USE Parks_and_Recreation;

SELECT first_name, last_name FROM employee_demographics
UNION
SELECT occupation, salary FROM employee_salary;


SELECT first_name, last_name FROM employee_demographics
UNION
SELECT first_name, last_name FROM employee_salary;


SELECT first_name, last_name FROM employee_demographics
UNION DISTINCT
SELECT first_name, last_name FROM employee_salary;

SELECT first_name, last_name FROM employee_demographics
UNION ALL
SELECT first_name, last_name FROM employee_salary;

SELECT * FROM employee_demographics;

-- want to identify old employee and high paid employee
SELECT first_name, last_name, 'Retired' AS Label
FROM employee_demographics
WHERE age > 40
UNION
SELECT first_name, last_name, 'Highly Paid'
FROM employee_salary
WHERE salary > 70000;

-- String Functions

-- Length

SELECT LENGTH('shreyas');

SELECT first_name, LENGTH(first_name) as no_of_letter
FROM employee_demographics;

-- UPPER/LOWER
SELECT first_name, UPPER(first_name) as no_of_letter
FROM employee_demographics;

SELECT first_name, LOWER(first_name) as no_of_letter
FROM employee_demographics;

-- TRIM

SELECT LTRIM('   I love SQL');

SELECT RTRIM('I love SQL.    ');

SELECT TRIM('     helkdsokkda');


SELECT LTRIM('   I    love    SQL');

-- SUBSTRING

SELECT LEFT('Shreyas',5);

SELECT RIGHT('Shreyas',5);

SELECT SUBSTRING('Shreyas', 3, 2);

-- REPLACE

SELECT first_name,
    LEFT(first_name, 3) AS LeftPortionOfFirstName,
    RIGHT(first_name, 2) AS RightPortionOfLastName,
    SUBSTRING(first_name, 2, 2) AS SubstringOfFirstName,
    SUBSTRING(birth_date,1,4) AS birth_year,
    REPLACE(first_name,'o','a') AS vowel_replaced
FROM 
    employee_demographics;
    
    
-- LOCATE

SELECT first_name, LOCATE('An',first_name)
FROM employee_demographics;

-- CTE

WITH CTE_example AS (
SELECT gender, 
SUM(salary), MIN(age), MAX(age), AVG(salary) AS avg_sal
FROM employee_demographics AS dem
INNER JOIN employee_salary sal
ON dem.employee_id = sal.employee_id
GROUP BY dem.gender
)
SELECT gender, avg_sal FROM CTE_example;

WITH 
CTE_1 AS(
SELECT employee_id, gender, birth_date
FROM employee_demographics AS dem
WHERE birth_date > '1980-01-01'
) ,
CTE_2 AS (
SELECT employee_id, salary 
FROM employee_salary 
WHERE salary >= 50000)

SELECT *
FROM CTE_1 AS ONEE
INNER JOIN CTE_2 AS TWOO
ON ONEE.employee_id = TWOO.employee_id;


    

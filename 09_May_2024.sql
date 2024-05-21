-- VIEWS
USE reviews;

SELECT AVG(ratings) AS avg_rating FROM (
SELECT series.title, series.rating AS ratings
FROM reviews
INNER JOIN series
ON series.id = reviews.series_id
INNER JOIN reviewers
ON reviewers.id = reviews.reviewer_id );


CREATE VIEW entire_reviews AS
SELECT series.title, reviews.rating, reviewers.first_name, series.released_year
FROM reviews
INNER JOIN series
ON series.id = reviews.series_id
INNER JOIN reviewers
ON reviewers.id = reviews.reviewer_id ;

CREATE TABLE employees (
   emp_no INT PRIMARY KEY AUTO_INCREMENT,
   department VARCHAR(20),
   salary INT
);
 
INSERT INTO employees (department, salary) VALUES
('engineering', 80000),
('engineering', 69000),
('engineering', 70000),
('engineering', 103000),
('engineering', 67000),
('engineering', 89000),
('engineering', 91000),
('sales', 59000),
('sales', 70000),
('sales', 159000),
('sales', 72000),
('sales', 60000),
('sales', 61000),
('sales', 61000),
('customer service', 38000),
('customer service', 45000),
('customer service', 61000),
('customer service', 40000),
('customer service', 31000),
('customer service', 56000),
('customer service', 55000);


-- entire_reviews is a virtual table that you can use down below in this script

SELECT AVG(rating) FROM entire_reviews;

SELECT * FROM entire_reviews;

SELECT * FROM entire_reviews WHERE released_year >2000;


DROP VIEW entire_reviews;

CREATE OR REPLACE VIEW entire_reviews AS
SELECT series.title, reviews.rating, reviewers.first_name, series.released_year, series.genre
FROM reviews
INNER JOIN series
ON series.id = reviews.series_id
INNER JOIN reviewers
ON reviewers.id = reviews.reviewer_id ;


-- WITH ROLLUP

SELECT title, COUNT(rating) FROM entire_reviews
GROUP BY title
WITH ROLLUP;

SELECT AVG(rating) FROM entire_reviews;

SELECT released_year, genre, first_name, AVG(rating)
FROM
entire_reviews
GROUP BY released_year, genre, first_name
WITH ROLLUP;


-- WINDOW functions

SELECT * FROM employees;

SELECT emp_no, department, salary, AVG(salary) OVER()
FROM employees;

SELECT emp_no, salary,
MIN(salary) OVER(),
MAX(salary) OVER()
FROM employees;

SELECT emp_no, department, salary, department, AVG(salary) OVER(PARTITION BY department) AS dept_avg
FROM employees;

SELECT emp_no, department, salary,
SUM(salary) OVER(PARTITION BY department) AS dept_payroll,
SUM(salary) OVER() AS total_payroll
FROM employees;

-- ORDER BY with windows
SELECT emp_no, department, salary,
SUM(salary) OVER(PARTITION BY department ORDER BY salary) AS dept_payroll,
SUM(salary) OVER(PARTITION BY department) AS total_payroll
FROM employees;

SELECT emp_no, department, salary,
MIN(salary) OVER (PARTITION BY department ORDER BY salary DESC) AS min_rolling
FROM employees;

-- RANK, DENSE_RANK, ROW_NUMBER

SELECT 
emp_no,
department,
salary,
RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS dept_salary_rank,
RANK() OVER (ORDER BY salary DESC) as overall_rank,
DENSE_RANK() OVER (ORDER BY salary DESC) AS overall_dense_rank,
ROW_NUMBER() OVER(ORDER BY salary DESC) AS overall_rn
FROM employees
;



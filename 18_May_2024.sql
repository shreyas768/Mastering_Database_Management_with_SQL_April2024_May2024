USE reviews;

SELECT * FROM icc_world_cup;

WITH CTE AS (SELECT team_1, CASE WHEN team_1 = winner THEN 1 ELSE 0 END win_flag
FROM icc_world_cup
UNION ALL
SELECT team_2, CASE WHEN team_2 = winner THEN 1 ELSE 0 END win_flag
FROM icc_world_cup)
SELECT tab_1.*, (tab_1.no_of_match_played - no_of_win) AS no_of_loss FROM
(SELECT team_1 AS team, COUNT(*) no_of_match_played, SUM(win_flag) AS no_of_win
FROM CTE
GROUP BY team_1) tab_1;


SELECT * FROM COUNTRIES;
SELECT * FROM FAMILIES;

-- Each tour offers a discount if a min no of people book at the same time.
-- Write a query to print max no of discounted tours any 1 family in the FAMILIES table can choose from 


WITH CTE1 AS (SELECT f.name AS family_person, f.family_size, c.name as country_name,
c.min_size, c.max_size

FROM FAMILIES AS f, COUNTRIES AS C
WHERE f.family_size >= c.min_size AND f.family_size <= c.max_size
ORDER BY f.family_size DESC)

SELECT family_person, COUNT(country_name) AS max_discounted_tours
FROM CTE1
GROUP BY family_person
ORDER BY COUNT(country_name) ASC;



SELECT * FROM people;

WITH CTE AS(
SELECT
r.c_id, MAX(f.name) AS father_name, MAX(m.name) AS mother_name
FROM relations r
LEFT JOIN people f on r.p_id = f.id AND f.gender = 'M'
LEFT JOIN people m on r.p_id = m.id AND m.gender = 'F'
GROUP BY r.c_id)
SELECT p.name AS child_name, CTE.father_name, CTE.mother_name
FROM people p
INNER JOIN CTE
ON CTE.c_id = p.id
ORDER BY child_name ASC;


DROP TABLE orders;
CREATE TABLE Orders (
  Order_id INT PRIMARY KEY,
  Customer_id INT,
  Order_Date DATE,
  Amount DECIMAL(10, 2),
  Status VARCHAR(50)
);


INSERT INTO Orders (Order_id, Customer_id, Order_Date, Amount, Status)
VALUES 
  (1, 1, '2024-01-05', 100.00, 'Completed'),
  (2, 2, '2024-02-10', 150.00, 'Completed'),
  (3, 1, '2024-03-15', 200.00, 'Pending'),
  (4, 3, '2024-04-20', 75.00, 'Completed'),
  (5, 1, '2024-05-25', 300.00, 'Completed'),
  (6, 2, '2024-06-30', 120.00, 'Completed'),
  (7, 1, '2024-07-05', 250.00, 'Completed');


CREATE TABLE Customers (
  Customer_id INT PRIMARY KEY,
  Customer_Name VARCHAR(100),
  Join_Date DATE
);


INSERT INTO Customers (Customer_id, Customer_Name, Join_Date)
VALUES
  (1, 'Sophia Brown', '2024-01-01'),
  (2, 'Jane Smith', '2024-02-01'),
  (3, 'Alice Johnson', '2024-03-01');
  
SELECT c.customer_name, SUM(o.amount) AS total_amount, 
COUNT(o.order_id) AS no_of_orders
FROM orders AS o
INNER JOIN customers AS c
ON o.customer_id = c.customer_id
WHERE YEAR(c.join_date) = YEAR(current_date())
GROUP BY c.customer_name
HAVING COUNT(o.order_id) > 2 ;

SELECT * FROM customer_orders;



SELECT a.order_date, 
SUM(CASE WHEN a.order_date = a.first_order_date THEN 1 ELSE 0 END) AS new_customer,
SUM(CASE WHEN a.order_date != a.first_order_date THEN 1 ELSE 0 END) AS existing_customer
FROM
(SELECT customer_id, order_date, MIN(order_date) OVER(PARTITION BY customer_id) AS first_order_date
FROM customer_orders) a
GROUP BY a.order_date;

WITH CTE AS (SELECT customer_id, order_date, MIN(order_date) OVER(PARTITION BY customer_id) AS first_order_date
FROM customer_orders) 
SELECT order_date, 
SUM(CASE WHEN order_date = first_order_date THEN 1 ELSE 0 END) AS new_customer,
SUM(CASE WHEN order_date != first_order_date THEN 1 ELSE 0 END) AS extisting_customer
FROM CTE
GROUP BY order_date;
USE RBPL_IITR;

SELECT * FROM books;

-- HAVING (always used with GROUP BY)


SELECT author_lname, SUM(pages) AS total_pages
FROM books
WHERE author_fname LIKE 'D%'
GROUP BY author_lname
HAVING total_pages > 350;

-- Books table to use group by and having clauses

SELECT author_fname, released_year, SUM(stock_quantity) AS sm_sq, AVG(pages) AS av_pg
FROM books
WHERE stock_quantity > 50
GROUP BY author_fname, released_year
HAVING sm_sq > 100 AND av_pg < 400
ORDER BY sm_sq DESC;


-- AND/OR/NOT, ORDER BY, LIMIT, DESC + all above

SELECT released_year, COUNT(title) as no_of_books, MIN(pages) as min_pages
FROM books
WHERE stock_quantity < 1000 AND pages>300
GROUP BY released_year
HAVING released_year < 2005 OR min_pages>500
ORDER BY min_pages DESC
LIMIT 4;



SELECT COUNT(*) FROM books WHERE released_year>2000;


-- INNER JOIN
DROP TABLE customers;
DROP TABLE orders;
CREATE TABLE customers2 (
   id INT PRIMARY KEY AUTO_INCREMENT,
   first_name VARCHAR(50),
   last_name VARCHAR(50),
   email VARCHAR(50)
);
 
CREATE TABLE orders2 (
   id INT PRIMARY KEY AUTO_INCREMENT,
   order_date DATE,
   amount DECIMAL(8,2),
   customer_id INT,
   FOREIGN KEY (customer_id) REFERENCES customers(id)
);
 
INSERT INTO customers2 (first_name, last_name, email)
VALUES ('Boy', 'George', 'george@gmail.com'),
      ('George', 'Michael', 'gm@gmail.com'),
      ('David', 'Bowie', 'david@gmail.com'),
      ('Blue', 'Steele', 'blue@gmail.com'),
      ('Bette', 'Davis', 'bette@aol.com'),
      ('David','Steele','ds@gmail.com');
SET FOREIGN_KEY_CHECKS =0;
INSERT INTO orders2 (order_date, amount, customer_id)
VALUES ('2016-02-10', 99.99, 1),
      ('2017-11-11', 35.50, 1),
      ('2014-12-12', 800.67, 2),
      ('2015-01-09', 18.50, 6),
      ('2015-01-03', 12.50, 2),
      ('1999-04-11', 450.25, 5);
      
SELECT * FROM customers;
SELECT * FROM orders;


-- INNER JOIN
SELECT  orders.id AS order_id, first_name,email,order_date,customer_id
FROM customers
INNER JOIN orders
ON orders.customer_id = customers.id;

-- INNER JOIN with GROUP BY

SELECT  first_name, last_name, SUM(orders.amount) AS total
FROM customers
INNER JOIN orders
ON orders.customer_id = customers.id
GROUP BY customers.first_name, customers.last_name;


SELECT  orders.id AS order_id, first_name,last_name, email,order_date,amount , customer_id
FROM customers
INNER JOIN orders
ON orders.customer_id = customers.id
WHERE orders.amount > 50
ORDER BY amount
DESC;


-- LEFT JOIN

SELECT first_name, email, AVG(orders2.amount) AS avg_amt
FROM customers2
LEFT JOIN orders2
ON orders2.customer_id = customers2.id
GROUP BY first_name, email;
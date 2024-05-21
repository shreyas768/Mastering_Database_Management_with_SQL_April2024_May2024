USE RBPL_IITR;

-- LEFT JOIN

SELECT first_name, email, AVG(orders2.amount) AS avg_amt
FROM customers2
LEFT JOIN orders2
ON orders2.customer_id = customers2.id
GROUP BY first_name, email;

-- RIGHT JOIN 

SELECT *
FROM customers2
RIGHT JOIN orders2
ON customers2.id = orders2.customer_id;


SELECT STDDEV(orders2.amount) AS std_dev,first_name,last_name
FROM customers2
RIGHT JOIN orders2
ON orders2.customer_id = customers2.id
WHERE amount>30
GROUP BY orders2.customer_id
HAVING std_dev>10;

-- CROSS JOIN

SELECT * FROM customers2
CROSS JOIN orders2;


SELECT * FROM customers2, orders2;

-- OUTER JOIN

SELECT  *
FROM customers
FULL OUTER JOIN orders
ON orders.customer_id = customers.id;
-- JOINS Exercise

CREATE TABLE students (
   id INT PRIMARY KEY AUTO_INCREMENT,
   first_name VARCHAR(50)
);
 
 
CREATE TABLE papers (
   title VARCHAR(50),
   grade INT,
   student_id INT,
   FOREIGN KEY (student_id)
       REFERENCES students (id)
);



INSERT INTO students (first_name) VALUES
('Caleb'), ('Samantha'), ('Raj'), ('Carlos'), ('Lisa');
 
INSERT INTO papers (student_id, title, grade ) VALUES
(1, 'My First Book Report', 60),
(1, 'My Second Book Report', 75),
(2, 'Russian Lit Through The Ages', 94),
(2, 'De Montaigne and The Art of The Essay', 98),
(4, 'Borges and Magical Realism', 89);


SELECT * FROM papers;


-- first_name, title, grade of only those students who have published paper(s)

SELECT first_name, title, grade
FROM students
INNER JOIN papers
ON students.id = papers.student_id;

-- first_name of all the students and title, grade of their paper(s) , if any
SELECT first_name, IFNULL(papers.title,'MISSING'), IFNULL(papers.grade,0)
FROM students
LEFT JOIN papers
On papers.student_id = students.id;


SELECT first_name, AVG(IFNULL(p1.grade,0)) AS average_grade
FROM students AS s1
LEFT JOIN papers AS p1
On p1.student_id = s1.id
GROUP BY first_name;


-- first_name, average, passing_status if avg_grade > 75 then he is 'pass' otherwise 'fail'


SELECT
first_name, IFNULL(AVG(grade),0),
CASE WHEN IFNULL(AVG(grade),0) > 75 THEN 'PASS'
ELSE 'FAIL'
END AS passing_status
FROM students 
LEFT JOIN papers ON
students.id = papers.student_id
GROUP BY students.id;


-- Drop any pre-existing database with name 'reviews'
-- Create 'reviews' database
-- Use 'reviews' db
-- create all the tables and insert values

DROP DATABASE IF EXISTS reviews;
CREATE DATABASE reviews;
USE reviews;

CREATE TABLE reviewers (
   id INT PRIMARY KEY AUTO_INCREMENT,
   first_name VARCHAR(50) NOT NULL,
   last_name VARCHAR(50) NOT NULL
);
 
CREATE TABLE series (
   id INT PRIMARY KEY AUTO_INCREMENT,
   title VARCHAR(100),
   released_year YEAR,
   genre VARCHAR(100)
);
 
CREATE TABLE reviews (
   id INT PRIMARY KEY AUTO_INCREMENT,
   rating DECIMAL(2 , 1 ),
   series_id INT,
   reviewer_id INT,
   FOREIGN KEY (series_id)
       REFERENCES series (id),
   FOREIGN KEY (reviewer_id)
       REFERENCES reviewers (id)
);
 
INSERT INTO series (title, released_year, genre) VALUES
   ('Archer', 2009, 'Animation'),
   ('Arrested Development', 2003, 'Comedy'),
   ("Bob's Burgers", 2011, 'Animation'),
   ('Bojack Horseman', 2014, 'Animation'),
   ("Breaking Bad", 2008, 'Drama'),
   ('Curb Your Enthusiasm', 2000, 'Comedy'),
   ("Fargo", 2014, 'Drama'),
   ('Freaks and Geeks', 1999, 'Comedy'),
   ('General Hospital', 1963, 'Drama'),
   ('Halt and Catch Fire', 2014, 'Drama'),
   ('Malcolm In The Middle', 2000, 'Comedy'),
   ('Pushing Daisies', 2007, 'Comedy'),
   ('Seinfeld', 1989, 'Comedy'),
   ('Stranger Things', 2016, 'Drama');




INSERT INTO reviewers (first_name, last_name) VALUES
   ('Thomas', 'Stoneman'),
   ('Wyatt', 'Skaggs'),
   ('Kimbra', 'Masters'),
   ('Domingo', 'Cortes'),
   ('Colt', 'Steele'),
   ('Pinkie', 'Petit'),
   ('Marlon', 'Crafford');
  


INSERT INTO reviews(series_id, reviewer_id, rating) VALUES
   (1,1,8.0),(1,2,7.5),(1,3,8.5),(1,4,7.7),(1,5,8.9),
   (2,1,8.1),(2,4,6.0),(2,3,8.0),(2,6,8.4),(2,5,9.9),
   (3,1,7.0),(3,6,7.5),(3,4,8.0),(3,3,7.1),(3,5,8.0),
   (4,1,7.5),(4,3,7.8),(4,4,8.3),(4,2,7.6),(4,5,8.5),
   (5,1,9.5),(5,3,9.0),(5,4,9.1),(5,2,9.3),(5,5,9.9),
   (6,2,6.5),(6,3,7.8),(6,4,8.8),(6,2,8.4),(6,5,9.1),
   (7,2,9.1),(7,5,9.7),
   (8,4,8.5),(8,2,7.8),(8,6,8.8),(8,5,9.3),
   (9,2,5.5),(9,3,6.8),(9,4,5.8),(9,6,4.3),(9,5,4.5),
   (10,5,9.9),
   (13,3,8.0),(13,4,7.2),
   (14,2,8.5),(14,3,8.9),(14,4,8.9);
   
   
   SELECT * FROM reviewers;
   
   
   -- Get title and ratings
   -- Get title and avg_rating
   -- get first name, last name and rating
   -- all the title of unreviewed series (rating is NULL)
   -- Get all the genres and their average rating
   -- get title, rating, reviewer_name (first_name + ' ' + last_name)
   
   
   SELECT title AS unrated_series
   FROM
   reviews
   RIGHT JOIN
   series 
   ON reviews.series_id = series.id
   WHERE reviews.rating IS NULL;
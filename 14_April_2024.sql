USE RBPL_IITR;

-- author_fname, author_lname, no_of_books_written, latest_release, earliest_release

SELECT 
author_fname, 
author_lname, 
COUNT(*) AS no_of_books_written,
MAX(released_year) AS latest_release,
MIN(released_year) AS earliest_release
FROM books
GROUP BY author_lname, author_fname;

/*
1. get total count of the books
2. get released_year, count of the books in that year
3. get sum of stock quantity of the books
4. get full name and book with most number of pages for each author
5. get released year, avg number of pages in that year. top 5 entries with most number of pages
 */
 
 SELECT COUNT(*) AS total_books FROM books;
 
 SELECT released_year, COUNT(*)
 FROM books
 GROUP BY released_year;
 
 SELECT SUM(stock_quantity) FROM books;
 
 SELECT 
 CONCAT(author_fname, ' ', author_lname) AS author,
 MAX(pages)
 FROM books
 GROUP BY author;

SELECT
released_year, AVG(pages)
FROM books
GROUP BY released_year
ORDER BY AVG(pages) DESC
LIMIT 5;

-- COMPARISON AND LOGICAL OPERATOR

SELECT * FROM books
WHERE released_year != 2003;

SELECT * FROM books
WHERE released_year = 2003;

SELECT * FROM books
WHERE released_year > 2003;

SELECT * FROM books
WHERE released_year <= 2003;

SELECT * FROM books
WHERE title NOT LIKE '%The%';

SELECT * 
FROM books
WHERE CHAR_LENGTH(title) > 20;

-- LOGICAL OPERATORS: AND, OR, NOT, IN

SELECT author_fname, SUM(pages), SUM(stock_quantity)*2 
FROM books
WHERE CHAR_LENGTH(title) > 20
AND stock_quantity < 90
GROUP BY author_fname
ORDER BY SUM(pages)
DESC;


SELECT * FROM books
WHERE title LIKE '%stories%'
OR released_year > 2010;

SELECT * FROM books
WHERE author_lname IN ('Eggers','Carver','Harris')
OR pages > 200;

SELECT * FROM books
WHERE author_lname NOT IN ('Eggers','Carver','Harris')
OR pages > 200;


-- CASE
SELECT title, released_year,
CASE
WHEN released_year > 2000 THEN 'Gen Z book'
ELSE 'Millenial Book'
END AS 'genre'
FROM books;

SELECT 
title, released_year, stock_quantity, pages,
CASE 
WHEN stock_quantity <= 40 THEN '*'
WHEN stock_quantity <=70 THEN '**'
WHEN stock_quantity <= 100 THEN '***'
WHEN stock_quantity <= 130 THEN '****'
ELSE '*****'
END as 'rating'
FROM books
WHERE released_year > 2003
AND pages > 200;

SELECT * FROM books
WHERE pages BETWEEN 200 AND 300;

SELECT * FROM books
WHERE pages > 200 AND pages < 300;

/* Create a new column 'Genre'
1. 'stories' appear in title -->> 'Short stories'
2. 'Kids' appear in title -->> 'Memoir'
3. if title is 'The Namesake' -->> 'Legendary'
4. 'Novel' */

SELECT
title,
CASE
WHEN title LIKE '%stories%' THEN 'Short Stories'
WHEN title LIKE '%Kids%' THEN 'Memoir'
WHEN title = 'The Namesake' THEN 'Legendary'
ELSE 'Novel' END as 'Genre'
FROM books;

-- Constraints

CREATE TABLE contacts1(
name VARCHAR(25) UNIQUE,
phone VARCHAR(15) NOT NULL UNIQUE
);

INSERT INTO contacts1 (name, phone)
VALUES('Rahul','12345');

INSERT INTO contacts1 (name, phone)
VALUES('Rahul','12345');

DESC contacts1;

CREATE TABLE users(
username VARCHAR(20) NOT NULL,
age INT CHECK (age>0) -- Check should be boolean value (True or False)
);

INSERT INTO users(username,age)
VALUES('Rahul',-1);

CREATE TABLE palindrome(
word VARCHAR(25) CHECK(REVERSE(word)=word));

INSERT INTO palindrome(word)
VALUES('RACECAR');

INSERT INTO palindrome(word)
VALUES('NAMAN');


CREATE TABLE users2(
username VARCHAR(20) NOT NULL,
age INT,
CONSTRAINT age_above_18 CHECK(age>18));

INSERT INTO users2(username,age)
VALUES('Rahul',10);

-- ALTER

ALTER TABLE users
ADD COLUMN phone VARCHAR(10);

DESC users;

ALTER TABLE users
ADD COLUMN employee_perk VARCHAR(25) NOT NULL DEFAULT 'nothing';

ALTER TABLE users
DROP COLUMN employee_perk;

RENAME TABLE users
TO delete_users;

-- OR --

ALTER TABLE delete_users
RENAME TO users;

ALTER TABLE users
RENAME COLUMN phone TO phone_no;

-- Modify existing column

ALTER TABLE users
MODIFY username VARCHAR(25) DEFAULT 'unknown';

ALTER TABLE users
ADD CONSTRAINT age_constraint CHECK(age>15);


-- Revisiting Data Types
DROP TABLE IF EXISTS shirts;
CREATE TABLE shirts(
player_name VARCHAR(25),
size ENUM('XS','S','M','L','XL','XXL', 'Large'));

INSERT INTO shirts(player_name,size)
VALUES('Sachin','L');

INSERT INTO shirts(player_name,size)
VALUES('Rohit','Large');
SELECT * FROM shirts;

CREATE TABLE myset (
col SET('b','c','d','a'));

INSERT INTO myset(col)
VALUES('a,d,c'),('d,a,b');

SELECT * FROM myset; -- Unnormalized Table


SELECT CURTIME();

SELECT CURDATE();

SELECT NOW();

CREATE TABLE people(
name VARCHAR(25),
bdt DATE,
btime TIME,
bts DATETIME
);

INSERT INTO people
VALUES('Rahul', CURDATE(),CURTIME(),NOW());

SELECT * FROM people;
USE RBPL_IITR;
CREATE TABLE books
 (
  book_id INT AUTO_INCREMENT,
  title VARCHAR(100),
  author_fname VARCHAR(100),
  author_lname VARCHAR(100),
  released_year INT,
  stock_quantity INT,
  pages INT,
  PRIMARY KEY(book_id)
 );
 
INSERT INTO books (title, author_fname, author_lname, released_year, stock_quantity, pages)
VALUES
('The Namesake', 'Jhumpa', 'Lahiri', 2003, 32, 291),
('Norse Mythology', 'Neil', 'Gaiman',2016, 43, 304),
('American Gods', 'Neil', 'Gaiman', 2001, 12, 465),
('Interpreter of Maladies', 'Jhumpa', 'Lahiri', 1996, 97, 198),
('A Hologram for the King: A Novel', 'Dave', 'Eggers', 2012, 154, 352),
('The Circle', 'Dave', 'Eggers', 2013, 26, 504),
('The Amazing Adventures of Kavalier & Clay', 'Michael', 'Chabon', 2000, 68, 634),
('Just Kids', 'Patti', 'Smith', 2010, 55, 304),
('A Heartbreaking Work of Staggering Genius', 'Dave', 'Eggers', 2001, 104, 437),
('Coraline', 'Neil', 'Gaiman', 2003, 100, 208),
('What We Talk About When We Talk About Love: Stories', 'Raymond', 'Carver', 1981, 23, 176),
("Where I'm Calling From: Selected Stories", 'Raymond', 'Carver', 1989, 12, 526),
('White Noise', 'Don', 'DeLillo', 1985, 49, 320),
('Cannery Row', 'John', 'Steinbeck', 1945, 95, 181),
('Oblivion: Stories', 'David', 'Foster Wallace', 2004, 172, 329),
('Consider the Lobster', 'David', 'Foster Wallace', 2005, 92, 343), 
('10% Happier', 'Dan', 'Harris', 2014, 29, 256),
          ('fake_book', 'Freida', 'Harris', 2001, 287, 428),
          ('Lincoln In The Bardo', 'George', 'Saunders', 2017, 1000, 367);
          
SELECT * FROM books;


-- Refining selections
SELECT author_lname FROM books;

SELECT DISTINCT author_lname FROM books; -- DISTINCT

SELECT author_fname, author_lname FROM books; -- Multiple Columns

SELECT CONCAT(author_fname, ' ' , author_lname) AS full_name FROM books;

SELECT DISTINCT CONCAT(author_fname, ' ' , author_lname) AS full_name FROM books;

SELECT * FROM books 
ORDER BY pages;

SELECT * FROM books 
ORDER BY pages
DESC;

SELECT * FROM books 
ORDER BY author_lname DESC;
-- title of the books starting from latest one to earliest one

SELECT title, released_year FROM books
ORDER BY released_year DESC;

-- LIMIT
SELECT title, released_year FROM books
ORDER BY released_year DESC
LIMIT 5;

SELECT title, released_year FROM books
ORDER BY released_year DESC
LIMIT 5,4;

-- Get title and released year of top 5 books with most number of pages?
SELECT title, released_year, pages
FROM books
ORDER BY pages DESC
LIMIT 5;

-- Like
SELECT * FROM books
WHERE title LIKE '%The%';

SELECT * FROM books
WHERE title LIKE 'The%';

SELECT * FROM books
WHERE title LIKE '%le';

SELECT * FROM books
WHERE title LIKE '%:%'
ORDER BY stock_quantity;

-- Da in the beginning of the authors' first name

SELECT * FROM books
WHERE author_fname like 'Da%';

SELECT * FROM books
WHERE author_fname LIKE '____';

-- Wildcards
SELECT * FROM books
WHERE title LIKE '%\%%';

SELECT * FROM books
WHERE title LIKE '%\_%';

-- title - released_year as summary (latest 5 books)
SELECT CONCAT (title , ' - ', released_year) as summary
FROM books
ORDER BY released_year DESC
LIMIT 5;

-- Subqueries
SELECT * FROM books
WHERE
pages = (SELECT MAX(pages) FROM books);

SELECT * FROM books 
WHERE released_year = (SELECT MIN(released_year) FROM books);


-- Group By (always in conjuction with an aggregation function)

SELECT released_year, COUNT(*) AS no_of_books
FROM books
GROUP BY released_year;

SELECT author_lname, COUNT(*) AS no_of_books
FROM books
GROUP BY author_lname;

-- author last name and sum of pages of all his/her books

SELECT author_lname, SUM(pages) AS sum_of_pages
FROM books
GROUP BY author_lname;


-- author_fname, author_lname, no_of_books_written, latest_release, earliest_release

-- COUNT, AVG, MIN, MAX, SUM, STD 





/*
1. get total count of the books
2. get released_year, count of the books in that year
3. get sum of stock quantity of the books
4. get full name and book with most number of pages for each author
5. get released year, avg number of pages in that year. top 5 entries with most number of pages
 */
USE sakila;


-- Which actors have the first name 'Scarlett'

SELECT * FROM actor
WHERE first_name = 'Scarlett';

-- Display the first name and last name of actors whose actor_id is above 10 and below 40
--  in a single column in lower case letters. Name that column as actor_name

SELECT LOWER(CONCAT(first_name, ' ', last_name)) AS actor_name
FROM actor
WHERE actor_id > 10 AND actor_id <40;


-- country_id and country name of Afghanistan, Bangladesh, India and China

SELECT country_id, country AS country_name
FROM country
WHERE country IN ('Afghanistan','Bangladesh','India','China');

-- What is average length of all the films in this db?
SELECT * FROM film;
SELECT AVG(length) AS avg_length FROM film;

-- What is the average length of films by category?
SELECT c.name AS category_name, AVG(f.length) AS avg_length
FROM film f
INNER JOIN film_category fc   -- USING (film_id);
ON f.film_id = fc.film_id
INNER JOIN category c 
ON fc.category_id = c.category_id
GROUP BY c.category_id
ORDER BY avg(length) DESC;


-- Which actor has appeared in most films?
SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS film_count
FROM actor a
INNER JOIN film_actor fa 
ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
ORDER BY film_count DESC
LIMIT 1;



-- Which last_names are not repeated?
SELECT last_name FROM actor GROUP BY last_name
HAVING COUNT(*) = 1;

-- Display the total amount by each staff member in July and August 2005.

SELECT CONCAT(s.first_name,s.last_name) AS 'Staff_Member', SUM(p.amount) AS 'Total Amount'
FROM payment p
INNER JOIN staff s
ON p.staff_id = s.staff_id
WHERE p.payment_date LIKE '2005-07%'
OR p.payment_date LIKE '2005-08%'
GROUP BY p.staff_id;


-- List each film and the number of actors who are listed for that film

SELECT f.film_id, f.title, COUNT(fa.actor_id) AS 'No Of Actors'
FROM film f
INNER JOIN film_actor fa
ON f.film_id = fa.film_id
GROUP BY f.film_id;

-- How many copies of the film Hunchback Impossible exist in the inventory system?


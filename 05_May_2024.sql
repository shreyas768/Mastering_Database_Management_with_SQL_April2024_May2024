USE sakila;

-- Use subqueries to display all the actors names who appear in the film 'Alone Trip'.
SELECT CONCAT(first_name,' ',last_name) AS 'Actors in AT'
FROM actor
WHERE actor_id IN (SELECT actor_id from film_actor 
WHERE film_id = (SELECT film_id 
FROM film WHERE title = 'Alone Trip'));


-- Title of all the movies categorized as 'Family'
SELECT f.title
FROM film f
INNER JOIN film_category fc
ON f.film_id = fc.film_id
INNER JOIN category c
ON fc.category_id = c.category_id
WHERE c.name = 'Family';


-- full name of customers who have rented sci-fi movies more than two times. arrange these names in alphabetical order
SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer_name
FROM category cg
INNER JOIN film_category fc
ON cg.category_id = fc.category_id

INNER JOIN film f
ON fc.film_id = f.film_id

INNER JOIN inventory i
ON i.film_id = f.film_id

INNER JOIN RENTAL r
ON r.inventory_id = i.inventory_id



INNER JOIN customer c
ON c.customer_id = r.customer_id

WHERE cg.name = 'Sci-Fi'
GROUP BY c.customer_id
HAVING COUNT(r.rental_id) > 2
ORDER BY customer_name;



-- Write a query to find full name of the actor who has acted in 3rd most number of movies
SELECT CONCAT(a.first_name, ' ',a.last_name) AS actor_name
FROM actor a
LEFT JOIN film_actor fa
ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
ORDER BY COUNT(fa.film_id) DESC
LIMIT 2,1;


-- top 5 genre with highest gross revenue
SELECT c.name AS 'Genre', SUM(p.amount) AS 'Gross Revenue'
FROM category c
INNER JOIN film_category fc
ON fc.category_id = c.category_id
INNER JOIN inventory i
ON i.film_id = fc.film_id
INNER JOIN rental r
ON r.inventory_id = i.inventory_id
INNER JOIN payment p
ON p.rental_id = r.rental_id
GROUP BY c.name
ORDER BY sum(p.amount) DESC
LIMIT 5;


-- display the title of most rented movies

SELECT f.title AS 'Movie Name', COUNT(r.rental_date) AS 'No of Times Rented'
FROM film f
INNER JOIN inventory i 
ON f.film_id = i.film_id
INNER JOIN rental r
ON r.inventory_id = i.inventory_id
GROUP BY f.film_id
ORDER BY COUNT(r.rental_date) DESC
LIMIT 1;


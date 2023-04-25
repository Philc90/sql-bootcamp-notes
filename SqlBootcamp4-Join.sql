-- AS example
SELECT COUNT(amount) AS num_transactions
FROM payment;

-- NOTE: syntax error! total_spent is assigned at end,
-- so need to put SUM(amount) in HAVING clause (or WHERE clause)
SELECT customer_id,SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id
HAVING total_spent > 100;

-- INNER JOIN: info present on both tables
-- Note: won't see customers who haven't created any type of payment
-- NOTE: for INNER JOIN, symmetrical so can switch order of payment & customer
--       in FROM and INNER JOIN clauses and will get same output
SELECT payment_id,payment.customer_id,first_name,last_name
FROM payment
INNER JOIN customer
ON payment.customer_id = customer.customer_id;

-- OUTER JOIN: only present on one table
-- new privacy policy: ensure that we don't have
-- customers who haven't made a payment and payments not assoc with customer
SELECT * FROM customer
FULL OUTER JOIN payment
ON customer.customer_id = payment.customer_id
WHERE customer.customer_id IS null
OR payment.payment_id IS null

-- LEFT OUTER JOIN
-- films we don't have in stock in any store
SELECT film.film_id,film.title,inventory_id,store_id
FROM film
LEFT OUTER JOIN inventory ON
inventory.film_id = film.film_id
WHERE inventory.film_id IS null

-- CHAL: CA sales tax law changed, want to alert CA cust's thru email
SELECT district,email FROM address
INNER JOIN customer
ON address.address_id = customer.address_id
WHERE district = 'California';

-- CHAL: what movies have Nick Walhberg been in?
-- tables: actor, film, film_actor
SELECT title,first_name,last_name FROM (
	SELECT *
	FROM film
	INNER JOIN film_actor
	ON film.film_id = film_actor.film_id
	WHERE film_actor.actor_id = 2
) as WalhbergFilms
INNER JOIN actor
ON WalhbergFilms.actor_id = actor.actor_id;
-- alt answer
SELECT title,first_name,last_name FROM actor
INNER JOIN film_actor
ON actor.actor_id = film_actor.actor_id
INNER JOIN film
ON film_actor.film_id = film.film_id
WHERE first_name = 'Nick' AND last_name = 'Wahlberg';


-- params
SHOW ALL;

SHOW TIMEZONE;

-- timestamp
SELECT NOW();

-- more human readable
SELECT TIMEOFDAY();

SELECT CURRENT_TIME;
SELECT CURRENT_DATE;

-- EXTRACT: get parts of date type
-- YEAR, MONTH, DAY, WEEK, QUARTER
SELECT EXTRACT(YEAR FROM payment_date)
AS pay_year
FROM payment;

SELECT EXTRACT(QUARTER FROM payment_date)
AS pay_quarter
FROM payment;

SELECT AGE(payment_date)
FROM payment;

-- TO_CHAR: convert data types to text, also for formatting dates
-- NOTE: MONTH is blank-padded to 9 chars
-- see https://www.postgresql.org/docs/12/functions-formatting.html
SELECT TO_CHAR(payment_date,'MONTH-YYYY')
FROM payment;

SELECT TO_CHAR(payment_date,'Mon/dd/YYYY')
FROM payment;

SELECT TO_CHAR(payment_date,'dd-MM-YYYY')
FROM payment;

-- CHAL: which months did payments occur?
SELECT DISTINCT TO_CHAR(payment_date,'Month')
FROM payment;

-- CHAL: how many payments occurred on a Monday?
SELECT COUNT(*) FROM (
	SELECT RTRIM(TO_CHAR(payment_date,'Day'))
	FROM payment
) as _(pay_day)
WHERE pay_day='Monday';
-- alt answer
SELECT COUNT(*) FROM (
	SELECT EXTRACT(DOW FROM payment_date)
	FROM payment
) as _(pay_day)
WHERE pay_day=1; -- SUN = 0
-- alt answer (better)
SELECT COUNT(*)
FROM payment
WHERE EXTRACT(DOW FROM payment_date)=1;

-- Mathematical Functions & Operators
SELECT ROUND(rental_rate/replacement_cost,4) * 100 AS percent_cost
FROM film;
SELECT 0.1 * replacement_cost AS deposit
FROM film;

-- String Functions & Operators
SELECT first_name || ' ' || last_name AS full_name
FROM customer;
-- create emails from names
SELECT LOWER(LEFT(first_name,1)) || LOWER(last_name) || '@gmail.com' AS full_name
FROM customer;

-- Sub Query
SELECT title,rental_rate
FROM film
WHERE rental_rate > (SELECT AVG(rental_rate) FROM FILM);
-- films returned on certain date
SELECT film_id,title
FROM film
WHERE film_id IN (
	SELECT inventory.film_id
	FROM rental
	INNER JOIN inventory ON inventory.inventory_id = rental.inventory_id
	WHERE return_date BETWEEN '2005-05-29' AND '2005-05-30'
)
ORDER BY title;
-- customers who have at least 1 payment > 11
SELECT first_name,last_name
FROM customer AS c
WHERE EXISTS (
	SELECT * FROM payment AS p
	WHERE p.customer_id = c.customer_id
	AND amount > 11
);

-- Self Join: query joined to itself. Looks like a join of 2 copies of same table
-- (not actually copied)
-- pairs of films that have the same length
SELECT f1.title,f2.title,f1.length
FROM film AS f1
INNER JOIN film AS f2 ON
f1.film_id != f2.film_id
AND f1.length = f2.length;


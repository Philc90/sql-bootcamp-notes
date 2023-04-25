-- challenge
SELECT first_name,last_name,email FROM customer;

-- challenge: aus customer doesn't know ratings, what are the available ones?
SELECT DISTINCT(rating) FROM film;

SELECT COUNT(*) FROM payment;

SELECT COUNT(title) FROM film
WHERE rental_rate > 4 AND replacement_cost >= 19.99 AND rating='R' OR rating='PG-13';

SELECT COUNT(title) FROM film
WHERE rating='R' OR rating='PG-13';

-- challenge: find nancy thomas's email to return lost wallet
SELECT email FROM customer
WHERE first_name = 'Nancy' AND last_name = 'Thomas';

-- challenge: what's Outlaw Hanky about?
SELECT description FROM film
WHERE title='Outlaw Hanky';

-- CHAL: fone from addr
SELECT phone FROM address
WHERE address='259 Ipoh Drive'

SELECT * FROM payment
WHERE amount != 0.00
ORDER BY payment_date DESC
LIMIT 5;

-- use to quickly see format of table
SELECT * FROM payment LIMIT 1;

-- CHAL: first 10 paying cust's
SELECT customer_id FROM payment
WHERE amount != 0.00
ORDER BY payment_date ASC
LIMIT 10;

-- CHAL: titles 5 shortest movies
SELECT title FROM film
ORDER BY length ASC
LIMIT 5;

-- how many options <= 50 min?
SELECT COUNT(*) FROM film
WHERE length <= 50;

SELECT COUNT(*) FROM payment
WHERE amount NOT BETWEEN 8 AND 9;

-- 1st half of february. Note: 02-15 will select up to EOD 2-14
SELECT * FROM payment
WHERE payment_date BETWEEN '2007-02-01' AND '2007-02-15';

SELECT * FROM customer
WHERE first_name IN('John','Jake','Julie');

SELECT * FROM customer
WHERE first_name LIKE 'J%' AND last_name LIKE 'S%';

-- GENERAL CHAL
-- # payments > $5?
SELECT COUNT(*) FROM payment
WHERE amount > 5;
-- # actors with first name starts with P?
SELECT COUNT(*) FROM actor
WHERE first_name LIKE 'P%';
-- how many unique districts are our customers from?
SELECT COUNT(DISTINCT(district)) FROM address;
-- list of names for those unique districts
SELECT DISTINCT(district) FROM address;
-- how many films rating R and replacement cost between 5 & 15?
SELECT COUNT(*) FROM film
WHERE rating='R' AND replacement_cost BETWEEN 5 AND 15;
-- # of films with Truman in title
SELECT COUNT(*) FROM film
WHERE title LIKE '%Truman%';
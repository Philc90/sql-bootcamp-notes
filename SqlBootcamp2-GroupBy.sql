SELECT MIN(replacement_cost),MAX(replacement_cost) FROM film;

SELECT ROUND(AVG(replacement_cost),2) FROM film;

SELECT SUM(replacement_cost) FROM film;

-- when sorting results based on agg, make sure to ref entire funct (i.e. SUM(amount))
SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount)
LIMIT 5;

SELECT customer_id FROM payment
GROUP BY customer_id
ORDER BY customer_id;

-- cust spending most money?
SELECT customer_id, SUM(amount) FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC;

-- cust with most orders?
SELECT customer_id, COUNT(amount) FROM payment
GROUP BY customer_id
ORDER BY COUNT(amount) DESC;

-- how much each customer spent with each staff member?
-- NOTE: SELECT columns order doesn't matter, but GROUP BY cols order does matter
SELECT staff_id,customer_id,SUM(amount) FROM payment
GROUP BY staff_id,customer_id
ORDER BY customer_id;

-- GROUP BY DATE: because the timestamp is down to milliseconds so would not be
-- useful to GROUP BY since each would be a unique category
SELECT DATE(payment_date),SUM(amount) FROM payment
GROUP BY DATE(payment_date)
ORDER BY SUM(amount) DESC;

-- CHAL: want to give bonus to staff member who handled most # of payments
SELECT staff_id, COUNT(*) FROM payment
GROUP BY staff_id
ORDER BY COUNT(*) DESC;

-- CHAL: what's the avg replacement cost per MPAA rating?
SELECT rating, ROUND(AVG(replacement_cost),2) FROM film
GROUP BY rating;

-- CHAL: top 5 customers by amount spent?
SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 5;

SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 100;

SELECT store_id,COUNT(customer_id)
FROM customer
GROUP BY store_id
HAVING COUNT(customer_id) > 300;

-- CHAL: give platinum stat to customers with 40+ transaction payments
SELECT customer_id,COUNT(payment_id)
FROM payment
GROUP BY customer_id
HAVING COUNT(payment_id) >= 40;

-- CHAL: cust ids that spent more than 100 with staff id 2?
SELECT customer_id,SUM(amount)
FROM payment
WHERE staff_id=2
GROUP BY customer_id
HAVING SUM(amount) > 100;
/* like if/else. looks like substitute for another column call

CASE
	WHEN condition1 THEN result1
	ELSE other_result
END

-- CASE expression syntax. Less flexible, only for when you're only checking for equality
CASE expression
	WHEN value1 THEN result1
	ELSE other_result
END
*/

SELECT customer_id,
CASE
	WHEN (customer_id <= 100)THEN 'Premium'
	WHEN (customer_id BETWEEN 100 AND 200) THEN 'Plus'
	ELSE 'Normal'
END AS customer_class
FROM customer

SELECT customer_id,
CASE customer_id
	WHEN 2 THEN 'Winner'
	WHEN 5 THEN 'Second Place'
	ELSE 'Normal'
END AS raffle_results
FROM customer

-- used to count matches
SELECT
SUM(CASE rental_rate
	WHEN 0.99 THEN 1
	ELSE 0
END) AS bargains,
SUM(CASE rental_rate
	WHEN 2.99 THEN 1
	ELSE 0
END) AS regular,
SUM(CASE rental_rate
	WHEN 4.99 THEN 1
	ELSE 0
END) AS premium
FROM film

-- CHAL: films per movie rating
SELECT
SUM(CASE rating
   WHEN 'R' then 1
   ELSE 0
END) AS r,
SUM(CASE rating
   WHEN 'PG' THEN 1
   ELSE 0
END) AS pg,
SUM(CASE rating
   WHEN 'PG-13' THEN 1
   ELSE 0
END) AS pg13
FROM film;

/* 
COALESCE: returns first arg that's not null
used for tables w/ null vals, substitute values that are null w/ another value
*/

/*
CAST
function: SELECT CAST('5' AS INTEGER)
operator: SELECT '5'::INTEGER -- only in postgres
*/
SELECT CHAR_LENGTH(CAST(inventory_id AS VARCHAR)) FROM rental


/*
Views
- db object of a stored query
- can be accessed as a virtual table. Not a real table, it stores the query
*/
CREATE VIEW customer_info AS
SELECT first_name,last_name,address FROM customer
INNER JOIN address
ON customer.address_id=address.address_id

SELECT * FROM customer_info

-- alter an existing view
CREATE OR REPLACE VIEW customer_info AS
SELECT first_name,last_name,address,district0 FROM customer
INNER JOIN address
ON customer.address_id=address.address_id

-- remove view
DROP VIEW IF EXISTS customer_info

-- rename view
ALTER VIEW customer_info RENAME TO c_info


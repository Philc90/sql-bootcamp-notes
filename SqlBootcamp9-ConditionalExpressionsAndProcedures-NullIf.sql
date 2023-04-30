-- NULLIF
-- 2 inputs, NULL if both equal, otherwise 1st arg
-- used when NULL value would cause error or unwanted result

-- create db 'testme'
CREATE TABLE depts(
	first_name VARCHAR(50),
	department VARCHAR(50)
)

INSERT INTO depts(
	first_name,
	department
)
VALUES
('Vinton', 'A'),
('Lauren', 'A'),
('Claire', 'B')

SELECT * FROM depts

--get ratio b/t M & F members
SELECT (
	SUM(CASE WHEN department='A' THEN 1 ELSE 0 END)/
	SUM(CASE WHEN department='B' THEN 1 ELSE 0 END)
) AS department_ratio
FROM depts

--person left dept; have null val 
DELETE FROM depts
WHERE department='B'

-- department_ratio query will now have divide by zero error
-- fixed with NULLIF; dividing by null will give null instead of error
SELECT (
	SUM(CASE WHEN department='A' THEN 1 ELSE 0 END)/
	NULLIF(SUM(CASE WHEN department='B' THEN 1 ELSE 0 END), 0)
) AS department_ratio
FROM depts


/*
Import / Export from file
DOES NOT create table for you
*/
CREATE TABLE simple(
	a INTEGER,
	b INTEGER,
	c INTEGER
)

SELECT * FROM simple

-- right click simple table, select Import/Export
/*
CREATE TABLE table_name(
	column_name TYPE column_constraint,
	table_constraint
) INHERITS existing_table_name;
*/
CREATE TABLE account(
	user_id SERIAL PRIMARY KEY,
	username VARCHAR(50) UNIQUE NOT NULL,
	password VARCHAR(50) NOT NULL,
	email VARCHAR(250) UNIQUE NOT NULL,
	created_on TIMESTAMP NOT NULL,
	last_login TIMESTAMP
);

CREATE TABLE job(
	job_id SERIAL PRIMARY KEY,
	job_name VARCHAR(200) UNIQUE NOT NULL
);

CREATE TABLE account_job(
	user_id INTEGER REFERENCES account(user_id),
	job_id INTEGER REFERENCES job(job_id),
	hire_date TIMESTAMP
);

/*
INSERT INTO table(column_1,column_2,...)
SELECT column_1,column_2,...
FROM another_table
WHERE condition;

Need to provide mandatory values but not SERIAL values
*/
INSERT INTO account(username,password,email,created_on)
VALUES ('Jose','password','jose@mail.com',CURRENT_TIMESTAMP);

SELECT * FROM account;

INSERT INTO job(job_name)
VALUES('Astronaut');
INSERT INTO job(job_name)
VALUES('President');

SELECT * FROM job;

-- INSERT first job (Astronaut) for first user (Jose)
INSERT INTO account_job(user_id,job_id,hire_date)
VALUES(1,1,CURRENT_TIMESTAMP);

SELECT * FROM account_job;

/*
UPDATE table
SET column1=value1
WHERE condition
RETURNING column1; -- to see change

using another table's values (Update Join):

UPDATE TableA
SET original_col = TableB.new_col
FROM TableB
WHERE TableA.id=TableB.id;
*/
UPDATE account
SET last_login=CURRENT_TIMESTAMP
RETURNING *;

UPDATE account
SET last_login=created_on
RETURNING *;

UPDATE account_job
SET hire_date=account.created_on
FROM account
WHERE account_job.user_id=account.user_id
RETURNING *;

/*
DELETE FROM tableA
USING tableB
WHERE tableA.id=tableB.id

DELETE FROM table -- delete all rows
*/
INSERT INTO job(job_name)
VALUES('Cowboy');

DELETE FROM job
WHERE job_name='Cowboy'
RETURNING job_id,job_name;

/*
ALTER - change table structure

ALTER TABLE table
DROP/SET/ADD(action)

DROP: remove constraint
ADD: add constraint
*/
CREATE TABLE information(
	info_id SERIAL PRIMARY KEY,
	title VARCHAR(500) NOT NULL,
	person VARCHAR(50) NOT NULL UNIQUE
)
SELECT * FROM information

ALTER TABLE information
RENAME TO new_info;

ALTER TABLE new_info
RENAME COLUMN person TO people;

SELECT * FROM new_info;

-- fails because people has NOT NULL constraint
INSERT INTO new_info(title)
VALUES('new title')

-- remove constraint
ALTER TABLE new_info
ALTER COLUMN people DROP NOT NULL;

/*
DROP
- remove column
- in postgresql will also auto remove indexes and constraints
- does not remove columns used in views, triggers, or stored procedures w/o
  add. CASCADE clause
- common to add IF EXISTS to avoid error
*/
ALTER TABLE new_info
DROP COLUMN IF EXISTS people;

/*
CHECK constraint (CREATE TABLE)
*/
CREATE TABLE employees(
	emp_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	birthdate DATE CHECK(birthdate > '1900-01-01'),
	hire_date DATE CHECK(hire_date > birthdate),
	salary INTEGER CHECK(salary > 0)
);

-- will fail due to birthdate constraint
-- note: SERIAL will keep track of the failed attempts, e.g. if a successful
-- insert after this, the PK will be 2
INSERT INTO employees(first_name,last_name,birthdate,hire_date,salary)
VALUES('Jose','Portilla','1899-11-03','2010-01-01',100)

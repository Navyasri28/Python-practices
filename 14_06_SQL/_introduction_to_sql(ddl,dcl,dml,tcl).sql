-- introduction to sql 

-- datatypes
/* 
Numeric Data Types
1)integer
2)float
3)decimal or numeric

Character and string data types
1)char
2)varchar
3)text

date and time datatypes
1)data
2)time
3)datetime
4)timestamp
5)year

binary data types
1)binary
2)varbinary
3)blob

*/

CREATE TABLE example_table (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    birthdate DATE,
    salary DECIMAL(10, 2),
    is_active BOOLEAN,
    profile_picture BLOB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    preferences JSON,
    status ENUM('active', 'inactive', 'pending')
);

-- DDL:DDL (Data Definition Language) is a subset of SQL used to define, alter, and manage the structure of database objects, such as tables, indexes, and schemas.
-- Common DDL Commands:
-- CREATE: Defines new database objects like tables, indexes, or views.
-- ALTER: Modifies the structure of existing database objects.=
-- DROP: Deletes database objects.
-- TRUNCATE: Removes all records from a table, but the table structure remains.
-- RENAME: Renames a database object.
-- CREATE
-- Create a new table
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    position VARCHAR(50),
    salary DECIMAL(10, 2),
    hire_date DATE
);

-- Create a new index on the employees table
CREATE INDEX idx_position ON employees (position);

-- Create a new view
CREATE VIEW employee_view AS
SELECT id, name, position
FROM employees;
-- ALTER
-- Add a new column to the employees table
ALTER TABLE employees
ADD email VARCHAR(255);

-- Modify the data type of the salary column
ALTER TABLE employees
MODIFY COLUMN salary DECIMAL(12, 2);

-- Rename a column
ALTER TABLE employees
RENAME COLUMN position TO job_title;

-- Drop a column from the table
ALTER TABLE employees
DROP COLUMN email;

--DROP
-- Drop the employees table
DROP TABLE employees;

-- Drop the view
DROP VIEW employee_view;

-- TRUNCATE
-- Truncate the employees table
TRUNCATE TABLE employees;

-- RENAME
-- Rename the employees table to staff
ALTER TABLE employees
RENAME TO staff;

-- DML:Data Manipulation Language (DML) is a subset of SQL used to manage and manipulate data within database tables. 
-- Common DML Commands
-- SELECT: Retrieves data from one or more tables.
-- INSERT: Adds new rows to a table.
-- UPDATE: Modifies existing rows in a table.
-- DELETE: Removes rows from a table.
-- SELECT
-- Select all columns from the employees table
SELECT * FROM employees;

-- Select specific columns from the employees table
SELECT id, name, position FROM employees;

-- Select employees with a salary greater than 50000
SELECT * FROM employees WHERE salary > 50000;

-- Select employees ordered by their hire date
SELECT * FROM employees ORDER BY hire_date;

-- Select the top 5 highest paid employees
SELECT * FROM employees ORDER BY salary DESC LIMIT 5;
-- INSERT
-- Insert a new employee into the employees table
INSERT INTO employees (id, name, position, salary, hire_date)
VALUES (1, 'Navya', 'Developer', 65000.00, '22-02-24');

-- Insert multiple new employees into the employees table
INSERT INTO employees (id, name, position, salary, hire_date)
VALUES
    (2, 'Tejuuu', 'Manager', 80000.00, '26-02-24'),
    (3, 'Manu', 'Designer', 70000.00, '30-02-24');
--UPDATE
-- Update the salary of an employee
UPDATE employees
SET salary = 70000.00
WHERE id = 1;

-- Update the position and salary of an employee
UPDATE employees
SET position = 'Senior Developer', salary = 75000.00
WHERE id = 2;

-- Increase the salary of all employees by 5%
UPDATE employees
SET salary = salary * 1.05;
-- DELETE
-- Delete an employee from the employees table
DELETE FROM employees
WHERE id = 1;

-- Delete all employees hired before a specific date
DELETE FROM employees
WHERE hire_date < '2023-01-01';

-- Delete all rows from the employees table
DELETE FROM employees;

--DCL:Data Control Language (DCL) is a subset of SQL used to control access to data within a database. 
-- Common DCL Commands
-- GRANT: Grants specific privileges to users or roles.
-- REVOKE: Revokes specific privileges from users or roles.
-- GRANT 
-- syntax
GRANT privilege [, ...]
ON object
TO user_or_role [, ...]
[WITH GRANT OPTION];
-- example
-- Grant SELECT and INSERT privileges on the employees table to user 'john'
GRANT SELECT, INSERT
ON employees
TO john;

-- Grant ALL privileges on the employees table to user 'admin'
GRANT ALL PRIVILEGES
ON employees
TO admin;

-- Grant SELECT privilege on all tables in the database to user 'reporting'
GRANT SELECT
ON ALL TABLES IN SCHEMA public
TO reporting;

-- Grant SELECT privilege on the employees table to role 'data_analyst'
GRANT SELECT
ON employees
TO data_analyst;

-- Grant SELECT privilege on the employees table to user 'mary' with the ability to grant this privilege to others
GRANT SELECT
ON employees
TO mary
WITH GRANT OPTION;
-- REVOKE
-- syntax
REVOKE privilege [, ...]
ON object
FROM user_or_role [, ...];
-- example
-- Revoke INSERT privilege on the employees table from user 'john'
REVOKE INSERT
ON employees
FROM john;

-- Revoke ALL privileges on the employees table from user 'admin'
REVOKE ALL PRIVILEGES
ON employees
FROM admin;

-- Revoke SELECT privilege on all tables in the database from user 'reporting'
REVOKE SELECT
ON ALL TABLES IN SCHEMA public
FROM reporting;

-- Revoke SELECT privilege on the employees table from role 'data_analyst'
REVOKE SELECT
ON employees
FROM data_analyst;

-- TCL :Transaction Control Language (TCL) is a subset of SQL used to manage transactions in a database. Transactions are sequences of SQL operations that are executed as a single unit of work.
-- Common TCL Commands
-- COMMIT: Saves the changes made by the transaction permanently.
-- ROLLBACK: Undoes the changes made by the transaction.
-- SAVEPOINT: Sets a point within a transaction to which you can later roll back.
-- COMMIT 
-- The COMMIT statement saves all the changes made during the transaction and ends the transaction.
COMMIT;
-- example
BEGIN TRANSACTION;

UPDATE employees
SET salary = salary + 5000
WHERE department = 'Sales';

COMMIT;

-- ROLLBACK 
-- The ROLLBACK statement undoes all the changes made during the transaction and ends the transaction.
ROLLBACK;
-- example
BEGIN TRANSACTION;

UPDATE employees
SET salary = salary + 5000
WHERE department = 'Sales';

-- Decide to rollback the changes
ROLLBACK;

-- SAVEPOINT 
-- The SAVEPOINT statement sets a savepoint within the current transaction.
SAVEPOINT savepoint_name;
-- example
BEGIN TRANSACTION;

-- Step 1: Insert a new employee
INSERT INTO employees (id, name, position, salary, hire_date)
VALUES (10, 'Sarah Grey', 'HR Manager', 80000.00, '2024-06-15');

-- Step 2: Set a savepoint
SAVEPOINT sp_before_update;

-- Step 3: Update the department head count
UPDATE departments
SET head_count = head_count + 1
WHERE department_name = 'HR';

-- Decide to rollback to the savepoint
ROLLBACK TO SAVEPOINT sp_before_update;

-- Commit the transaction
COMMIT;

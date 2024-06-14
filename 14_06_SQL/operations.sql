-- introduction to operations

-- Operators in SQL

-- Operator: An operator is a symbol that directs the database management system to perform specific operations on data.
-- Operand: An operand is the data that is manipulated by an operator.
-- Expression: An expression is a combination of one or more values, operators, and SQL functions that evaluate to a value.

/* Types of Operators
SQL operators can be broadly categorized into four types:

Arithmetic Operators
Comparison Operators
Bitwise Operators
Logical Operators

*/
-- A) Arithmetic Operators
-- Arithmetic operators are used to perform mathematical operations. Here are the basic arithmetic operators:

-- Addition (+): Adds two operands.

SELECT 5 + 3 AS addition_result;

-- Subtraction (-): Subtracts the second operand from the first.

SELECT 5 - 3 AS subtraction_result;

-- Multiplication (*): Multiplies two operands.

SELECT 5 * 3 AS multiplication_result;

-- Division (/): Divides the first operand by the second.

SELECT 5 / 3 AS division_result;

-- Modulo (%): Returns the remainder of the division of the first operand by the second.

SELECT 5 % 3 AS modulo_result;

-- B) Comparison Operators

-- Comparison operators are used to compare two values. The result of a comparison is a boolean value (True or False).

-- Equals (=): Checks if two operands are equal

SELECT 5 = 5 AS is_equal;

-- Greater Than (>): Checks if the left operand is greater than the right operand.

SELECT 5 > 3 AS is_greater;

-- Less Than (<): Checks if the left operand is less than the right operand.

SELECT 3 < 5 AS is_lesser;

-- Greater Than or Equal To (>=): Checks if the left operand is greater than or equal to the right operand.

SELECT 5 >= 5 AS is_greater_or_equal;

-- Less Than or Equal To (<=): Checks if the left operand is less than or equal to the right operand.

SELECT 5 <= 6 AS is_less_or_equal;

-- Not Equal To (<> or !=): Checks if two operands are not equal.

SELECT 5 <> 6 AS is_not_equal;

-- C) Bitwise Operators

-- Bitwise operators perform operations on the binary representations of integers.

-- Bitwise AND (&): Performs a binary AND operation.

SELECT 59 & 47 AS bitwise_and_result;

-- Bitwise OR (|): Performs a binary OR operation.

SELECT 59 | 47 AS bitwise_or_result;

-- Bitwise XOR (^): Performs a binary XOR operation.

SELECT 59 ^ 47 AS bitwise_xor_result;

-- D) Logical Operators

-- Logical operators are used to combine multiple boolean expressions.

-- AND: Returns true if all the conditions separated by AND are true.

SELECT 4 != 6 AND 12 > 6 AS logical_and_result;

-- OR: Returns true if any of the conditions separated by OR is true.

SELECT 5 > 4 OR 10 = 6 AS logical_or_result;

-- NOT: Returns true if the condition is false.

SELECT NOT 3 < 5 AS logical_not_result;

-- LIKE: Returns true if the operand matches a pattern.

SELECT 'Hello' LIKE '%o' AS like_result;

-- BETWEEN: Returns true if the operand is within a range.

SELECT 5 BETWEEN 1 AND 10 AS between_result;

-- Arithmetic Operators

-- Write a query to find the average price of products in the products table?
SELECT AVG(price) AS average_price FROM products;

-- Write a query to double the price of all products and display the result.
SELECT pid, pname, price, (price * 2) AS double_price FROM products;

-- Write a query to calculate the difference between the highest and lowest prices of products.
SELECT (MAX(price) - MIN(price)) AS price_difference FROM products;

-- Comparison Operators

-- Write a query to retrieve all products whose price is less than 10000.
SELECT * FROM products WHERE price < 10000;

-- Write a query to find customers who are older than 25 years.
SELECT * FROM customer WHERE age > 25;

-- Write a query to retrieve all orders where the order amount is exactly 5000.
SELECT * FROM orders WHERE amt = 5000;

-- Bitwise Operators

-- Write a query to perform a bitwise AND operation between two integers, 6 and 3.
SELECT 6 & 3 AS bitwise_and_result;

-- Write a query to perform a bitwise OR operation between two integers, 6 and 3.
SELECT 6 | 3 AS bitwise_or_result;

-- Write a query to perform a bitwise XOR operation between two integers, 6 and 3.
SELECT 6 ^ 3 AS bitwise_xor_result;

-- Logical Operators

-- Write a query to retrieve the products that are either located in Delhi or have a stock level less than 5.
SELECT * FROM products WHERE location = 'Delhi' OR stock < 5;

-- Write a query to find customers who are not from Bangalore.
SELECT * FROM customer WHERE addr NOT LIKE '%Bangalore%';

-- Write a query to retrieve the orders where the status is either 'shipped' or 'delivered'.
SELECT * FROM orders WHERE status = 'shipped' OR status = 'delivered';

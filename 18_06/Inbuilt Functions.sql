/*Inbuilt Functions
String functions in SQL are essential tools for working with and manipulating textual data stored in a database. 
These functions can perform a variety of operations on string (character) data types, such as concatenating strings, extracting substrings, searching for patterns, and modifying string values. */
-- CHAR_LENGTH(str)

-- Purpose: Returns the length of the given string str in characters.
SELECT CHAR_LENGTH('gpvernment schools') AS length;
-- Output: 18
-- ASCII(str)

-- Purpose: Returns the ASCII code value of the leftmost character in the string str.
SELECT ASCII('A') AS ascii_value;
-- Output: 65

SELECT ASCII('abc') AS ascii_value;
-- Output: 97

Purpose of the CONCAT() function in SQL:
-- The CONCAT() function is used to concatenate (combine) two or more string values.
SELECT CONCAT('Government ', 'School') AS full_name;

Difference between LCASE() and LOWER() functions:
-- Both LCASE() and LOWER() convert a string to lowercase letters.
-- LOWER() is the standard SQL function, while LCASE() is a MySQL-specific alias.
-- It's generally recommended to use LOWER() for better portability across different databases.
SELECT LOWER('GOVERNMENT SCHOOL') AS lowercase_name;
SELECT LCASE('GOVERNMENT SCHOOL') AS lowercase_name; 

-- Extract a substring from the 5th position to the 10th position (inclusive) from the string "Government School":
SELECT SUBSTR('Government School', 5, 6) AS substring_result;
-- Output: "rnment"

Purpose of the LPAD() and RPAD() functions:
-- LPAD() pads a string on the left side with the padstr string repeated as many times as necessary.
SELECT LPAD('School', 10, '*') AS padded_left;
-- Output: "****School"

-- RPAD() pads a string on the right side with the padstr string repeated as many times as necessary.
SELECT RPAD('School', 10, '*') AS padded_right;
-- Output: "School****"

Trim both leading and trailing spaces from the string ' Government School ':
SELECT TRIM('  Government School  ') AS trimmed_string;
-- Output: "Government School"

Date and Time Functions

Difference between CURRENT_DATE() and SYSDATE() functions:
-- CURRENT_DATE() returns the current date.
SELECT CURRENT_DATE() AS today;

-- SYSDATE() returns the current date and time.
SELECT SYSDATE() AS current_timestamp;

Calculate the number of days between '2024-06-01' and '2024-07-01':
SELECT DATEDIFF('2024-07-01', '2024-06-01') AS day_difference;
-- Output: 30

Purpose of the LAST_DAY() function with an example:
-- LAST_DAY() returns the last day of the month for a given date.
SELECT LAST_DAY('2024-06-01') AS last_day_of_june;
-- Output: "2024-06-30"

Add 3 months to the current date:
SELECT ADDDATE(CURRENT_DATE(), INTERVAL 3 MONTH) AS three_months_later;

Extract the time component (hours, minutes, seconds) from a datetime value:
SELECT TIME('2024-06-01 14:23:45') AS time_component;
-- Output: "14:23:45"

Numeric Functions

Difference between AVG() and COUNT() functions:
-- AVG() calculates the average value of a set of values.
SELECT AVG(total_students) AS avg_students
FROM schools;

-- COUNT() returns the number of rows/values.
SELECT COUNT(*) AS total_schools
FROM schools;

Calculate the square root of 144:
SELECT SQRT(144) AS square_root;
-- Output: 12

Round the number 3.14159 to two decimal places:
SELECT ROUND(3.14159, 2) AS rounded_value;
-- Output: 3.14

Purpose of the MIN() and MAX() functions with an example:
-- MIN() returns the minimum value, and MAX() returns the maximum value in a group of values.
-- Example with GROUP BY:
SELECT MIN(age) AS min_age, MAX(age) AS max_age, school_id
FROM students
GROUP BY school_id;

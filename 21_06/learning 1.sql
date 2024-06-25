-- DELIMITER Command

-- Purpose:
-- The DELIMITER command is used to modify the default delimiter (commonly a semicolon ;) to a different character.

-- Usage:
-- It's particularly useful when defining stored procedures, functions, or other constructs that include semicolons within their body. By changing the delimiter, you avoid accidentally terminating the entire statement prematurely.

--Syntax:
--The command follows this syntax:
DELIMITER new_delimiter;

-- Example:
-- To change the delimiter to //, use:
DELIMITER //
CREATE PROCEDURE procedure_name()
BEGIN
-- SQL statements here
END //
DELIMITER ;

-- Resetting the Delimiter:
-- After creating the stored procedure or function, it's important to reset the delimiter back to the default semicolon using:
DELIMITER ;

-- DETERMINISTIC Keyword

-- The DETERMINISTIC keyword in SQL is used to specify that a function will always produce the same result given the same input parameters.

-- Purpose:
-- This keyword assures that for a given set of input values, the function's output will be consistent every time it is called.

-- Usage:
--It is used when creating a function to indicate its consistent behavior. If the function relies on operations or data that may change (such as random number generation or current timestamps), it should not be marked as DETERMINISTIC.

-- Non-Deterministic Functions:
-- If a function includes elements that can yield different results on each execution (like using RAND(), NOW(), or other similar functions), you should avoid using the DETERMINISTIC keyword.

-- Stored Procedures
-- A stored procedure is a collection of SQL statements that are saved in the database and can be executed as needed.

-- Reusable SQL Code:
-- Stored procedures allow you to save a block of SQL code that can be reused multiple times, saving time and reducing redundancy.

-- Parameters:
-- Procedures can accept input parameters (IN) and return output parameters (OUT), allowing you to pass values into the procedure and get results back.

-- No Return Value:
-- Unlike functions, stored procedures do not return a value. Instead, they perform actions such as modifying data or retrieving information based on the provided parameters.

-- Efficiency:
-- By using stored procedures, you can streamline your workflow for frequently executed SQL queries. Once a procedure is defined, you simply call it to run the pre-written SQL code.

-- Creating a Stored Procedure
-- Stored procedures in SQL let you group a series of SQL commands into a single, reusable unit.

-- Syntax Overview:
DELIMITER //
CREATE PROCEDURE procedure_name(parameter1 datatype, parameter2 datatype, ...)
BEGIN
    -- Procedure logic goes here
END //
DELIMITER ;
-- Step-by-Step Explanation:
-- Changing the Delimiter:
-- DELIMITER // is used to change the default delimiter (;) to //. This allows you to include semicolons within the procedure without ending the entire statement.

-- Creating the Procedure:
-- CREATE PROCEDURE procedure_name(parameter1 datatype, parameter2 datatype, ...) starts the definition of the procedure.
-- You specify the procedure name and any parameters it requires, each with its data type.

-- Procedure Logic:
-- BEGIN ... END encloses the body of the procedure, where you write the SQL statements that define the procedure's actions.

-- Resetting the Delimiter:
-- DELIMITER ; restores the default delimiter after the procedure is defined.

-- Executing Stored Procedures
-- Once you have created a stored procedure in SQL, you can run it using the CALL statement. Here’s how it works:

-- Execution Command:

-- The CALL statement is used to invoke a stored procedure.
-- Syntax: CALL procedure_name(parameter1, parameter2, ...);
-- Replace procedure_name with the name of the procedure you want to execute, and provide any necessary parameters.

CALL select_all_products();

-- DELIMITER COMMAND:
DELIMITER $$

use government_schools;
-- PROCEDURES
-- Creating a procedure to add a new school record
CREATE PROCEDURE add_school(
    IN school_name VARCHAR(100), 
    IN location VARCHAR(100), 
    IN established_year INT
)
BEGIN
    INSERT INTO government_schools (name, location, established_year)
    VALUES (school_name, location, established_year);
END$$

-- Creating a procedure to get details of a specific school
CREATE PROCEDURE get_school_details(IN school_id INT)
BEGIN
    SELECT * FROM government_schools WHERE id = school_id;
END$$

-- Creating a procedure to update the location of a school
CREATE PROCEDURE update_school_location(
    IN school_id INT, 
    IN new_location VARCHAR(100)
)
BEGIN
    UPDATE government_schools 
    SET location = new_location 
    WHERE id = school_id;
END$$

-- Creating a procedure to delete a school record
CREATE PROCEDURE delete_school(IN school_id INT)
BEGIN
    DELETE FROM government_schools WHERE id = school_id;
END$$

-- Creating a procedure with an OUT parameter to get the count of schools in a specific location
CREATE PROCEDURE get_school_count_by_location(
    IN location_name VARCHAR(100), 
    OUT school_count INT
)
BEGIN
    SELECT COUNT(*) INTO school_count 
    FROM government_schools 
    WHERE location = location_name;
END$$

-- FUNCTIONS
-- Creating a function to calculate the total number of schools established after a given year
CREATE FUNCTION total_schools_after_year(established_year INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_schools INT;
    SELECT COUNT(*) INTO total_schools 
    FROM government_schools 
    WHERE established_year > established_year;
    RETURN total_schools;
END$$

-- Creating a function to get the oldest school
CREATE FUNCTION get_oldest_school()
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE oldest_school VARCHAR(100);
    SELECT name INTO oldest_school 
    FROM government_schools 
    ORDER BY established_year ASC 
    LIMIT 1;
    RETURN oldest_school;
END$$

-- CURSOR
-- Creating a procedure to iterate through the schools and print the school names
CREATE PROCEDURE print_school_names()
BEGIN
    DECLARE school_name VARCHAR(100);
    DECLARE done INT DEFAULT FALSE;
    DECLARE school_cursor CURSOR FOR 
        SELECT name 
        FROM government_schools;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN school_cursor;

    get_names: LOOP
        FETCH school_cursor INTO school_name;
        IF done THEN
            LEAVE get_names;
        END IF;
        SELECT school_name;
    END LOOP get_names;

    CLOSE school_cursor;
END$$

-- Resetting the delimiter
DELIMITER ;

-- PRACTICE QUERIES
-- Adding a new school
CALL add_school('ABC Government School', 'New Delhi', 1990);

-- Getting details of a specific school
CALL get_school_details(1);

-- Updating the location of a school
CALL update_school_location(1, 'Mumbai');

-- Deleting a school record
CALL delete_school(2);

-- Getting the count of schools in a specific location
CALL get_school_count_by_location('New Delhi', @count);
SELECT @count AS total_schools_in_location;

-- Calculating the total number of schools established after 2000
SELECT total_schools_after_year(2000) AS total_schools_after_2000;

-- Getting the oldest school
SELECT get_oldest_school() AS oldest_school;

-- Printing the names of all schools
CALL print_school_names();

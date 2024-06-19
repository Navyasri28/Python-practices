-- Anomalies
--  Insertion Anomalies
-- Insertion anomalies occur when certain attributes cannot be inserted into the database without the presence of other attributes.

-- Update Anomalies
-- Update anomalies occur when changes to data in one place necessitate changes in multiple places to maintain consistency.

-- Deletion Anomalies
-- Deletion anomalies occur when deleting data about one entity inadvertently deletes data about another entity.

-- insertion anomaly
INSERT INTO schools (school_id, school_name, school_location)
VALUES 
(999, 'Unknown School', 'Unknown Location');

INSERT INTO students (student_id, student_name, school_id)
VALUES 
(4, 'Lisa Simpson', 999);

-- update anomaly
UPDATE students_and_schools
SET school_location = 'San Francisco'
WHERE school_name = 'Government High School';

-- deletion anomaly
DELETE FROM students
WHERE school_id = 1;

-- Candidate Key:
-- A candidate key is an attribute, or a set of attributes, that can uniquely identify a tuple (row) in a table.
-- Each table can have one or more candidate keys.

-- Primary Key:
-- A primary key is a special candidate key chosen by the database designer to uniquely identify tuples in the table.
-- A table can have only one primary key.

CREATE TABLE Schools (
    school_id INT PRIMARY KEY,
    school_name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    zipcode VARCHAR(10) NOT NULL
);

/* school_id: This uniquely identifies each school.
Alternative Candidate Keys: Depending on additional constraints, combinations like (school_name, address) could be considered, but typically, the school name and address may not be unique. */

-- Foreign keys
-- A foreign key is a column or a set of columns in a relational database table that establishes a link between the data in two tables.
-- Data Integrity: Ensures that the value in the foreign key column(s) must match a value in the referenced primary key column(s) or be NULL.
-- Relationship Establishment: Defines the relationships between tables, allowing complex queries that combine data from multiple tables.

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    dob DATE NOT NULL,
    gender CHAR(1) CHECK (gender IN ('M', 'F')),
    address VARCHAR(255),
    city VARCHAR(50),
    state VARCHAR(50),
    zipcode VARCHAR(10)
);

CREATE TABLE Teachers (
    teacher_id INT PRIMARY KEY,
    teacher_name VARCHAR(100) NOT NULL,
    subject VARCHAR(50) NOT NULL,
    hire_date DATE NOT NULL,
    school_id INT,
    FOREIGN KEY (school_id) REFERENCES Schools(school_id)
);

-- Here, school_id in Teachers is a foreign key referencing school_id in Schools. This establishes a relationship indicating which school each teacher belongs to.

-- database for government schools
CREATE TABLE Schools (
    school_id INT PRIMARY KEY,
    school_name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    zipcode VARCHAR(10) NOT NULL
);

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    dob DATE NOT NULL,
    gender CHAR(1) CHECK (gender IN ('M', 'F')),
    address VARCHAR(255),
    city VARCHAR(50),
    state VARCHAR(50),
    zipcode VARCHAR(10)
);

CREATE TABLE Teachers (
    teacher_id INT PRIMARY KEY,
    teacher_name VARCHAR(100) NOT NULL,
    subject VARCHAR(50) NOT NULL,
    hire_date DATE NOT NULL
);

CREATE TABLE Classes (
    class_id INT PRIMARY KEY,
    class_name VARCHAR(100) NOT NULL,
    school_id INT,
    teacher_id INT,
    FOREIGN KEY (school_id) REFERENCES Schools(school_id),
    FOREIGN KEY (teacher_id) REFERENCES Teachers(teacher_id)
);

CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    class_id INT,
    enrollment_date DATE NOT NULL,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (class_id) REFERENCES Classes(class_id)
);

-- normalisation:
-- normalisation tables for 1NF, 2NF , 3NF 
Example of Ensuring 1NF (Single Valued Attributes)
Each table above adheres to 1NF by ensuring each column contains only atomic values and no repeating groups.

Example of Ensuring 2NF (Removing Partial Dependencies)
If we consider Classes table, it has dependencies that should involve the primary key completely. For instance, if class_name depends on class_id and not just a part of a composite key:

-- The current schema already ensures 2NF because all non-key attributes depend on the whole primary key.

Example of Ensuring 3NF (Removing Transitive Dependencies)
If we want to ensure no transitive dependencies, consider a scenario where student information includes city, state, etc., which depends on student_id only and no other attribute:

-- The current schema already ensures 3NF because all non-key attributes directly depend on the primary key and no other non-key attribute.

Example of Ensuring BCNF (Removing Advanced Anomalies)
Lets consider a complex scenario where there might be more advanced dependencies.
-- If there are non-trivial functional dependencies, ensure that each determinant is a candidate key.
-- Our schema adheres to BCNF since every non-trivial functional dependency has a candidate key as its determinant.
-- Boyce-Codd Normal Form (BCNF)
-- BCNF requires that the table is in 3NF and for every non-trivial functional dependency X -> Y, X must be a super key.

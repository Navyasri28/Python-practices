-- joins : used to combine rows from two or more tables based on a related column between them.
-- joins are of six types

-- INNER JOIN 
--  Returns only the rows that have matching values in both tables.

-- LEFT (OUTER) JOIN
--  Returns all rows from the left table, and the matched rows from the right table. The result is NULL from the right side if there is no match.

-- RIGHT (OUTER) JOIN
--  Returns all rows from the right table, and the matched rows from the left table. The result is NULL from the left side when there is no match.

-- FULL (OUTER) JOIN
--  Returns rows when there is a match in one of the tables. This means it returns all rows from the left table and all rows from the right table, with NULLs in places where the join condition is not met.

-- CROSS JOIN
--  Returns the Cartesian product of the two tables, i.e., it combines each row of the first table with each row of the second table.

-- self join
--  A self join is a regular join but the table is joined with itself. This is useful when you need to compare rows within the same table.

-- creating database 
create database government_schools;

-- using database
use government_schools;

CREATE TABLE schools (
    school_id INT PRIMARY KEY,
    school_name VARCHAR(100) NOT NULL,
    location VARCHAR(100) NOT NULL,
    type ENUM('public', 'private') NOT NULL,
    total_students INT NOT NULL
);
INSERT INTO schools (school_id, school_name, location, type, total_students)
VALUES 
(1, 'Government High School', 'New Delhi', 'public', 500),
(2, 'Government Primary School', 'Mumbai', 'public', 300),
(3, 'Private International School', 'Bangalore', 'private', 200),
(4, 'Municipal School', 'Chennai', 'public', 450);

SELECT From * schools;

-- create table for students
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    gender ENUM('male', 'female', 'other') NOT NULL,
    school_id INT,
    FOREIGN KEY (school_id) REFERENCES schools(school_id)
);
INSERT INTO students (student_id, name, age, gender, school_id)
VALUES 
(1, 'Amit Sharma', 15, 'male', 1),
(2, 'Priya Singh', 14, 'female', 2),
(3, 'John Doe', 16, 'male', 3),
(4, 'Sita Ram', 13, 'female', 4);

SELECT From * schools;

-- create table for teachers
CREATE TABLE teachers (
    teacher_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    subject VARCHAR(100) NOT NULL,
    school_id INT,
    FOREIGN KEY (school_id) REFERENCES schools(school_id)
);

INSERT INTO teachers (teacher_id, name, subject, school_id)
VALUES 
(1, 'Rajesh Kumar', 'Mathematics', 1),
(2, 'Meena Gupta', 'Science', 2),
(3, 'Tom Hardy', 'English', 3),
(4, 'Lakshmi Iyer', 'History', 4);

SELECT From * teachers;

-- create table for results 
CREATE TABLE results (
    student_id INT,
    subject VARCHAR(100) NOT NULL,
    marks INT NOT NULL,
    PRIMARY KEY (student_id, subject),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

INSERT INTO results (student_id, subject, marks)
VALUES 
(1, 'Mathematics', 85),
(1, 'Science', 78),
(2, 'Mathematics', 92),
(2, 'Science', 81),
(3, 'Mathematics', 75),
(3, 'Science', 68),
(4, 'Mathematics', 80),
(4, 'Science', 72);

SELECT From * results;

-- Find all students and the names of the schools they attend.
SELECT students.name AS student_name, schools.school_name
FROM students
INNER JOIN schools ON students.school_id = schools.school_id;

-- List all teachers and the locations of the schools they work at.
SELECT teachers.name AS teacher_name, schools.location
FROM teachers
INNER JOIN schools ON teachers.school_id = schools.school_id;

-- Get the average marks in Mathematics for each school.
SELECT schools.school_name, AVG(results.marks) AS average_math_marks
FROM results
INNER JOIN students ON results.student_id = students.student_id
INNER JOIN schools ON students.school_id = schools.school_id
WHERE results.subject = 'Mathematics'
GROUP BY schools.school_name;

-- Find all students who have scored more than 80 in Science, along with their school's type (public/private).
SELECT students.name AS student_name, schools.type AS school_type, results.marks AS science_marks
FROM students
INNER JOIN results ON students.student_id = results.student_id
INNER JOIN schools ON students.school_id = schools.school_id
WHERE results.subject = 'Science' AND results.marks > 80;

-- Get the names of students and their respective teachers for Mathematics.
SELECT students.name AS student_name, teachers.name AS teacher_name
FROM students
INNER JOIN schools ON students.school_id = schools.school_id
INNER JOIN teachers ON schools.school_id = teachers.school_id
WHERE teachers.subject = 'Mathematics';

-- List all teachers and their respective students.
SELECT teachers.name AS teacher_name, students.name AS student_name
FROM teachers
INNER JOIN schools ON teachers.school_id = schools.school_id
INNER JOIN students ON schools.school_id = students.school_id;

-- Find all students, their school names, and their marks in Mathematics and Science.
SELECT students.name AS student_name, schools.school_name, r1.marks AS mathematics_marks, r2.marks AS science_marks
FROM students
INNER JOIN schools ON students.school_id = schools.school_id
LEFT JOIN results r1 ON students.student_id = r1.student_id AND r1.subject = 'Mathematics'
LEFT JOIN results r2 ON students.student_id = r2.student_id AND r2.subject = 'Science';

-- Find all schools with no students enrolled.
SELECT schools.school_name
FROM schools
LEFT JOIN students ON schools.school_id = students.school_id
WHERE students.student_id IS NULL;

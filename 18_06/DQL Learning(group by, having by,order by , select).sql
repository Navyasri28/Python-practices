-- create database in governments schools

 -- DQL -Data Query Language

-- is a subset of SQL (Structured Query Language) focused on querying and retrieving data from a database. 

-- create table for schools
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

-- Find the total number of students in each government school:
SELECT school_name, SUM(total_students) AS total_students
FROM schools
WHERE type = 'public'
GROUP BY school_name;

--Find the number of schools in each location:
SELECT location, COUNT(*) AS school_count
FROM schools
GROUP BY location;

-- Retrieve all schools ordered by the total number of students in descending order:
SELECT * 
FROM schools
ORDER BY total_students DESC;

-- Retrieve all teachers ordered by their subject in ascending order and then by their name in descending order:
SELECT * 
FROM teachers
ORDER BY subject ASC, name DESC;

-- Find the locations where the total number of students in government schools is greater than 1000:
SELECT location, SUM(total_students) AS total_students
FROM schools
WHERE type = 'public'
GROUP BY location
HAVING SUM(total_students) > 1000;

-- Find the subjects where the average marks of students are between 40 and 60:
SELECT s.school_name, AVG(st.age) AS avg_age
FROM students st
JOIN schools s ON st.school_id = s.school_id
GROUP BY s.school_name
HAVING AVG(st.age) > 15;



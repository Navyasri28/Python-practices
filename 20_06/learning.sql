-- Create database
CREATE DATABASE government_schools;
USE government_schools;

-- Schools - sid, sname, location (City A or City B)
CREATE TABLE schools (
    sid INT(3) PRIMARY KEY,
    sname VARCHAR(50) NOT NULL,
    location VARCHAR(30) CHECK(location IN ('City A', 'City B'))
);

-- Students - stid, sname, age, sid (foreign key to schools)
CREATE TABLE students (
    stid INT(3) PRIMARY KEY,
    sname VARCHAR(50) NOT NULL,
    age INT(3),
    sid INT(3),
    FOREIGN KEY(sid) REFERENCES schools(sid)
);

-- Teachers - tid, tname, subject, sid (foreign key to schools)
CREATE TABLE teachers (
    tid INT(3) PRIMARY KEY,
    tname VARCHAR(50) NOT NULL,
    subject VARCHAR(50),
    sid INT(3),
    FOREIGN KEY(sid) REFERENCES schools(sid)
);

-- Classes - cid, cname, tid (foreign key to teachers), sid (foreign key to schools)
CREATE TABLE classes (
    cid INT(3) PRIMARY KEY,
    cname VARCHAR(50) NOT NULL,
    tid INT(3),
    sid INT(3),
    FOREIGN KEY(tid) REFERENCES teachers(tid),
    FOREIGN KEY(sid) REFERENCES schools(sid)
);

-- Enrollment - eid, stid (foreign key to students), cid (foreign key to classes)
CREATE TABLE enrollment (
    eid INT(3) PRIMARY KEY,
    stid INT(3),
    cid INT(3),
    FOREIGN KEY(stid) REFERENCES students(stid),
    FOREIGN KEY(cid) REFERENCES classes(cid)
);

-- Inserting values into schools table
INSERT INTO schools VALUES (1, 'Government School A', 'City A');
INSERT INTO schools VALUES (2, 'Government School B', 'City B');

-- Inserting values into students table
INSERT INTO students VALUES (101, 'Navya', 14, 1);
INSERT INTO students VALUES (102, 'Bobby', 15, 1);
INSERT INTO students VALUES (103, 'ramani', 13, 2);
INSERT INTO students VALUES (104, 'tejjuu', 14, 2);

-- Inserting values into teachers table
INSERT INTO teachers VALUES (201, 'Mr. Smith', 'Math', 1);
INSERT INTO teachers VALUES (202, 'Ms. Johnson', 'Science', 1);
INSERT INTO teachers VALUES (203, 'Mr. Brown', 'Math', 2);
INSERT INTO teachers VALUES (204, 'Ms. Davis', 'English', 2);

-- Inserting values into classes table
INSERT INTO classes VALUES (301, 'Math Class', 201, 1);
INSERT INTO classes VALUES (302, 'Science Class', 202, 1);
INSERT INTO classes VALUES (303, 'Math Class', 203, 2);
INSERT INTO classes VALUES (304, 'English Class', 204, 2);

-- Inserting values into enrollment table
INSERT INTO enrollment VALUES (401, 101, 301);
INSERT INTO enrollment VALUES (402, 102, 302);
INSERT INTO enrollment VALUES (403, 103, 303);
INSERT INTO enrollment VALUES (404, 104, 304);

-- SUBQUERIES

-- Question 1: Find the name of the student enrolled in the class with the most students.
SELECT sname FROM students
WHERE stid = (
    SELECT stid
    FROM enrollment
    GROUP BY cid
    ORDER BY COUNT(stid) DESC
    LIMIT 1
);

-- Question 2: Retrieve the names of all students who are enrolled in classes taught by teachers from 'City A'.
SELECT sname
FROM students
WHERE sid = 1
AND stid IN (
    SELECT stid
    FROM enrollment
    WHERE cid IN (
        SELECT cid
        FROM classes
        WHERE sid = 1
    )
);

-- Question 3: Retrieve the names of all students who are enrolled in classes that have more students than the average number of students per class.
SELECT sname
FROM students s
WHERE EXISTS (
    SELECT 1
    FROM enrollment e
    WHERE e.stid = s.stid
    GROUP BY e.cid
    HAVING COUNT(e.stid) > (
        SELECT AVG(student_count)
        FROM (
            SELECT COUNT(stid) AS student_count
            FROM enrollment
            GROUP BY cid
        ) AS avg_counts
    )
);

-- JOINS

-- Question 4: Retrieve the names of students who are enrolled in classes with a teacher who teaches Math.
SELECT s.sname
FROM students s
INNER JOIN enrollment e ON s.stid = e.stid
INNER JOIN classes c ON e.cid = c.cid
INNER JOIN teachers t ON c.tid = t.tid
WHERE t.subject = 'Math';

-- Question 5: Retrieve the names of all students along with the total number of classes they are enrolled in, including students who are not enrolled in any classes.
SELECT s.sname, COALESCE(COUNT(e.cid), 0) AS total_classes
FROM students s
LEFT JOIN enrollment e ON s.stid = e.stid
GROUP BY s.sname;

-- Question 6: Retrieve all student details along with their corresponding class details, even if there are no corresponding classes, and display 'Not enrolled' instead of NULL.
SELECT s.stid, s.sname, s.age, s.sid,
       CASE
           WHEN e.cid IS NULL THEN 'Not enrolled'
           ELSE c.cname
       END AS class_name
FROM students s
LEFT JOIN enrollment e ON s.stid = e.stid
LEFT JOIN classes c ON e.cid = c.cid;

-- Advanced Functions

-- Question 7: Retrieve the names of students along with their ages and the ranking of each student based on their ages, where students are ranked in descending order of age.
SELECT sname, age, RANK() OVER (ORDER BY age DESC) AS age_rank
FROM students;

-- Question 8: Retrieve the names of students along with their ages and the dense ranking of each student based on their ages, where students are ranked in descending order of age.
SELECT sname, age, DENSE_RANK() OVER (ORDER BY age DESC) AS dense_age_rank
FROM students;

-- Question 9: Retrieve the names of students along with their ages and the row number of each student, where students are ordered by their ages in descending order.
SELECT sname, age, ROW_NUMBER() OVER (ORDER BY age DESC) AS row_num
FROM students;

-- Question 10: Retrieve the names of students along with their ages and the cumulative distribution of each student's age, indicating what fraction of students have ages less than or equal to the age of each student.
SELECT sname, age, CUME_DIST() OVER (ORDER BY age) AS cumulative_distribution
FROM students;

-- Question 11: Retrieve the names of students along with their ages and the age of the previous student in the list, ordered by age in ascending order.
SELECT sname, age, LAG(age) OVER (ORDER BY age) AS previous_age
FROM students;

-- Question 12: Retrieve the names of students along with their ages and the age of the next student in the list, ordered by age in ascending order.
SELECT sname, age, LEAD(age) OVER (ORDER BY age) AS next_age
FROM students;

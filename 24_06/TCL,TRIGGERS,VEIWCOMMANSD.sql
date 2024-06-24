-- Create database
create database government_schools;

use government_schools;

-- Schools - sid, sname, location, capacity
create table schools
(
    sid int(3) primary key,
    sname varchar(50) not null,
    location varchar(50) not null,
    capacity int(5)
);

-- Students - stid, sname, age, addr, sid (foreign key)
create table students
(
    stid int(3) primary key,
    sname varchar(50) not null,
    age int(3),
    addr varchar(100),
    sid int(3),
    foreign key(sid) references schools(sid)
);

-- Courses - cid, cname, duration, teacher
create table courses
(
    cid int(3) primary key,
    cname varchar(50) not null,
    duration int(3),
    teacher varchar(50)
);

-- Enrollments - eid, stid, cid, enrollment_date
create table enrollments
(
    eid int(3) primary key,
    stid int(3),
    cid int(3),
    enrollment_date date,
    foreign key(stid) references students(stid),
    foreign key(cid) references courses(cid)
);

# Inserting values into schools table
insert into schools values(1, 'Government High School', 'New Delhi', 500);
insert into schools values(2, 'Central Public School', 'Mumbai', 300);
insert into schools values(3, 'State School', 'Chennai', 400);

# Inserting values into students table
insert into students values(101, 'Arjun', 15, 'Address 1', 1);
insert into students values(102, 'Suman', 14, 'Address 2', 2);
insert into students values(103, 'Ravi', 16, 'Address 3', 3);
insert into students values(104, 'Maya', 15, 'Address 4', 1);
insert into students values(105, 'Neha', 14, 'Address 5', 2);

# Inserting values into courses table
insert into courses values(1, 'Mathematics', 12, 'Mr. Sharma');
insert into courses values(2, 'Science', 10, 'Ms. Gupta');
insert into courses values(3, 'History', 8, 'Mr. Verma');

# Inserting values into enrollments table
insert into enrollments values(1001, 101, 1, '2024-06-01');
insert into enrollments values(1002, 102, 2, '2024-06-01');
insert into enrollments values(1003, 103, 3, '2024-06-01');
insert into enrollments values(1004, 104, 1, '2024-06-01');
insert into enrollments values(1005, 105, 2, '2024-06-01');

# TCL commands

-- commit
commit;

-- rollback
rollback;

-- savepoint
savepoint sp1;

-- rollback to savepoint
rollback to sp1;

# Triggers

-- 1) Trigger to update school capacity after a new student is added:
DELIMITER //
CREATE TRIGGER update_school_capacity
AFTER INSERT ON students
FOR EACH ROW
BEGIN
    UPDATE schools
    SET capacity = capacity - 1
    WHERE sid = NEW.sid;
END //
DELIMITER ;

-- 2) Trigger to check course availability before enrolling a student:
DELIMITER //
CREATE TRIGGER check_course_availability
BEFORE INSERT ON enrollments
FOR EACH ROW
BEGIN
    DECLARE available_seats INT;
    SELECT COUNT(*) INTO available_seats FROM enrollments WHERE cid = NEW.cid;
    IF available_seats >= 30 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Course is full, cannot enroll more students';
    END IF;
END //
DELIMITER ;

-- 3) Trigger to log student enrollments:
DELIMITER //
CREATE TRIGGER log_student_enrollments
AFTER INSERT ON enrollments
FOR EACH ROW
BEGIN
    INSERT INTO enrollment_log (eid, stid, cid, enrollment_date, logged_at)
    VALUES (NEW.eid, NEW.stid, NEW.cid, NEW.enrollment_date, NOW());
END //
DELIMITER ;

# Views

-- 1) Create a view that displays students with their corresponding schools.
CREATE VIEW StudentSchoolView AS
SELECT s.stid, s.sname, s.age, s.addr, sc.sname AS school_name, sc.location
FROM students s
JOIN schools sc ON s.sid = sc.sid;

-- 2) Create or Replace View to show enrollment details with student and course information
CREATE OR REPLACE VIEW EnrollmentDetails AS
SELECT e.eid, e.enrollment_date, st.sname AS student_name, c.cname AS course_name, c.teacher
FROM enrollments e
JOIN students st ON e.stid = st.stid
JOIN courses c ON e.cid = c.cid;

-- 3) Drop View if it exists
DROP VIEW IF EXISTS StudentSchoolView;
DROP VIEW IF EXISTS EnrollmentDetails;

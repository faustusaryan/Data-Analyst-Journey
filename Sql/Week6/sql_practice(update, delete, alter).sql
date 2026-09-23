-- ============================================
-- SQL PRACTICE: UPDATE, DELETE, ALTER
-- ============================================

SET SQL_SAFE_UPDATES = 0;

DROP DATABASE IF EXISTS college;
CREATE DATABASE college;
USE college;

CREATE TABLE student (
    rollno INT PRIMARY KEY,
    name   VARCHAR(50),
    marks  INT NOT NULL,
    grade  VARCHAR(1),
    city   VARCHAR(20)
);

INSERT INTO student
(rollno, name, marks, grade, city)
VALUES
(101, "anil",     78, "C", "Pune"),
(102, "bhumika",  93, "A", "Mumbai"),
(103, "chetan",   85, "B", "Mumbai"),
(104, "dhruv",    96, "A", "Delhi"),
(105, "emanuel",  12, "F", "Delhi"),
(106, "farah",    82, "B", "Delhi");

SELECT * FROM student;


-- ============================================
-- SECTION 1: UPDATE
-- ============================================

-- Q1. Set grade of rollno 105 to "D".
UPDATE student
SET grade = "D"
WHERE rollno = 105;

-- Q2. Increase marks of every student by 2.
UPDATE student
SET marks = marks + 2;

-- Q3. Set city to "Delhi" for students with marks > 90.
UPDATE student
SET city = "Delhi"
WHERE marks > 90;

-- Q4. Set grade "A" for marks >= 90, grade "L" for marks 80-89.
UPDATE student
SET grade = "A"
WHERE marks >= 90;

UPDATE student
SET grade = "L"
WHERE marks BETWEEN 80 AND 89;

SELECT * FROM student;


-- ============================================
-- SECTION 2: DELETE
-- ============================================

-- Q5. Delete the student named "emanuel".
DELETE FROM student
WHERE name = "emanuel";

-- Q6. Delete students from Pune with marks < 80.
DELETE FROM student
WHERE city = "Pune" AND marks < 80;

SELECT * FROM student;

-- Q7. Delete all rows, re-insert, then empty with TRUNCATE.
DELETE FROM student;

INSERT INTO student
(rollno, name, marks, grade, city)
VALUES
(101, "anil",     78, "C", "Pune"),
(102, "bhumika",  93, "A", "Mumbai"),
(103, "chetan",   85, "B", "Mumbai"),
(104, "dhruv",    96, "A", "Delhi"),
(105, "emanuel",  12, "F", "Delhi"),
(106, "farah",    82, "B", "Delhi");

TRUNCATE TABLE student;

SELECT * FROM student;


-- ============================================
-- SECTION 3: ALTER
-- ============================================

-- Q8. Add INT column "age", NOT NULL, default 19.
ALTER TABLE student
ADD COLUMN age INT NOT NULL DEFAULT 19;

-- Q9. Rename "marks" to "total_marks", then change it to FLOAT.
ALTER TABLE student
CHANGE COLUMN marks total_marks INT NOT NULL;

ALTER TABLE student
MODIFY COLUMN total_marks FLOAT NOT NULL;

-- Q10. Drop the "grade" column, then rename the table to "stu".
ALTER TABLE student
DROP COLUMN grade;

ALTER TABLE student
RENAME TO stu;

SELECT * FROM stu;

DESC stu;
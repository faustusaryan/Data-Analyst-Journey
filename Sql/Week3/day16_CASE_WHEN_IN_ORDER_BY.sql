CREATE DATABASE IF NOT EXISTS HackerRank;
USE HackerRank;

CREATE TABLE Students(
	ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Marks INT
    );
    
INSERT INTO Students (ID, Name, Marks)
VALUES
(1, 'Julia', 88),
(2, 'Samantha', 68),
(3, 'Maria', 99),
(4, 'Scarlet', 78),
(5, 'Ashley', 63),
(6, 'Jane', 81),
(7, 'Raj', 45),
(8, 'Priya', 92),
(9, 'Amit', 55),
(10, 'Neha', 71),
(11, NULL, 74);

CREATE TABLE Grades(
	Grade INT,
    Min_marks INT,
    Max_marks INT
	);

INSERT INTO Grades
(Grade, Min_marks, Max_marks)
VALUES
(1,  0,   9),
(2,  10,  19),
(3,  20,  29),
(4,  30,  39),
(5,  40,  49),
(6,  50,  59),
(7,  60,  69),
(8,  70,  79),
(9,  80,  89),
(10, 90,  100);

-- ### WARMUP

-- Q1 — Base Recall
-- Write the full JOIN query from memory: Students JOIN Grades using BETWEEN, 
-- and use CASE WHEN to show NULL for students with Grade < 8, actual name for Grade ≥ 8. 
-- Display Name, Grade, Marks. 


SELECT CASE WHEN g.Grade >= 8 THEN s.Name END AS Display_name,
g.Grade, s.Marks
FROM Students s 
JOIN Grades g 
ON s.Marks BETWEEN g.Min_marks AND g.Max_marks;


-- Q2 — Add Basic Sorting
-- Take the same query from Q1 and add ORDER BY g.Grade DESC. Run it. 
-- Does the output show Grade 10 students at the top? Verify against the expected rows 
-- (Maria 99, Priya 92 should be first).


SELECT CASE WHEN g.Grade >= 8 THEN s.Name END AS display_name,
g.Grade, s.Marks
FROM Students s
JOIN Grades g
ON s.Marks BETWEEN g.Min_marks AND g.Max_marks
ORDER BY g.Grade DESC;


-- Q3 — Spot the Problem
-- Now look at Grade 7 and below rows in your Q2 output. 
-- Are Ashley, Samantha, Raj sorted by name or by marks? 
-- Write down what you observe — and write why this is wrong for The Report's requirement. 
-- This sets up exactly why today's CASE WHEN in ORDER BY is needed.

# grade 7 <=, students sort by marks there is no chance we can sort them by name 
# coz below 8 grade students name is NULL. And there are not a separte order by case for grade < 8.


-- ### 10 Queries — CASE WHEN in ORDER BY:

-- Q1: Students — Marks DESC order mein sort karo — basic ORDER BY

SELECT Name, Marks 
FROM Students
ORDER BY Marks DESC;

-- Q2: Marks >= 70 wale naam A-Z, Marks < 70 wale Marks low-high — CASE WHEN in ORDER BY

SELECT Name, Marks
FROM Students
ORDER BY
	CASE WHEN Marks >= 70 THEN 0 ELSE 1 END,
	CASE WHEN Marks >= 70 THEN Name END ASC,
    CASE WHEN Marks < 70 THEN Marks END ASC;

-- Q3: Sirf Marks >= 70 wale — naam A-Z sort

SELECT Name, Marks
FROM Students 
WHERE Marks >= 70
ORDER BY Name;

-- Q4: Sirf Marks < 70 wale — Marks low-high sort

SELECT Name, Marks
FROM Students
WHERE Marks < 70
ORDER BY Marks;

-- Q5: NULL naam wale last mein aayein, baaki naam se A-Z — CASE WHEN in ORDER BY

SELECT Name, Marks
FROM Students
ORDER BY 
	CASE WHEN Name IS NULL THEN 1 ELSE 0 END, Name ASC;

-- Q6: ID even wale pehle naam se, ID odd wale Marks se — CASE WHEN sort

SELECT ID, Name, Marks
FROM Students
ORDER BY
    CASE WHEN ID % 2 = 0 THEN 0 ELSE 1 END,
    CASE WHEN ID % 2 = 0 THEN Name END,
    CASE WHEN ID % 2 = 1 THEN Marks END;

-- Q7: Marks 90+ pehle naam se sort karo, baaki Marks DESC

SELECT Name, Marks
FROM Students
ORDER BY
	CASE WHEN Marks >= 90 THEN 0 ELSE 1 END,
    CASE WHEN Marks >= 90 THEN Name END ASC,
    CASE WHEN Marks < 90 THEN Marks END DESC;

-- Q8: Group A pehle (ID < 5), Group B baad mein — dono group ke andar naam se sort

SELECT ID, Name,
CASE WHEN ID < 5 THEN 'Group A' ElSE 'Group B' END AS Which_group
FROM Students
ORDER BY 
	CASE WHEN ID < 5 THEN 0 ELSE 1 END, Name;

-- Q9: JOIN ke saath — Grade 8+ naam A-Z, Grade 7- Marks low-high
-- Ye exact The Report ka ORDER BY hai — sirf ordering pe dhyan do

SELECT s.Name, g.Grade, s.Marks
FROM Students s
JOIN Grades g 
ON s.Marks BETWEEN g.Min_marks AND g.Max_marks
ORDER BY 
	CASE WHEN g.Grade >= 8 THEN 0 ELSE 1 END,
    CASE WHEN g.Grade >= 8 THEN s.Name END ASC,
    Case WHEN g.Grade < 8 THEN s.Marks END ASC;
    

-- Q10: Marks ke basis par 3 groups banao:
-- Marks >= 80 → 'Topper'
-- Marks 50–79 → 'Average'
-- Marks < 50 → 'Low'
-- Output: Name, Marks, Category
-- Sorting:
-- Topper pehle (Name A-Z)
-- Average baad mein (Marks DESC)
-- Low last (Marks ASC)

SELECT Name, Marks,
CASE
    WHEN Marks >= 80 THEN 'Topper'
    WHEN Marks >= 50 THEN 'Average'
    ELSE 'Low'
END AS Category
FROM Students
ORDER BY 
CASE 
    WHEN Marks >= 80 THEN 0 
    WHEN Marks >= 50 THEN 1 
    ELSE 2 
END,
CASE WHEN Marks >= 80 THEN Name END ASC,
CASE WHEN Marks BETWEEN 50 AND 79 THEN Marks END DESC,
CASE WHEN Marks < 50 THEN Marks END ASC;







 
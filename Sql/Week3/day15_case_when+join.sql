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

-- W1
-- Har student ka Name, Marks aur uska Grade dikhao
-- (Students + Grades join with BETWEEN)

SELECT s.Name, s.Marks, g.Grade FROM Students s JOIN Grades g
ON s.Marks BETWEEN g.Min_marks AND g.Max_marks;

-- W2
-- Sirf un students ka Name aur Grade dikhao
-- jinka Grade 9 ya 10 hai

SELECT s.Name, g.Grade FROM Students s JOIN Grades g 
ON s.Marks BETWEEN g.Min_marks AND g.Max_marks
WHERE g.Grade > 8;

-- W3
-- Grade 7 wale sab students ka
-- Name, Marks aur Grade dikhao
-- aur result ko Marks descending order me sort karo

SELECT s.Name, s.Marks, g.Grade FROM Students s JOIN Grades g 
ON s.Marks BETWEEN g.Min_marks AND g.Max_marks
WHERE g.Grade = 7
ORDER BY s.Marks DESC; 


-- ### 15 CASE WHEN queries:

-- Q1: Marks >= 80 ho to 'Pass', warna 'Fail'

SELECT Name, Marks, CASE 
						WHEN Marks >= 80 THEN 'Pass' ELSE 'Fail' END AS result
                        FROM Students;

-- Q2: Marks 90+ ho to naam dikhao, warna 'Hidden'

SELECT  Marks, 
CASE WHEN Marks >= 90 THEN Name ELSE 'Hidden' END AS NAME
FROM Students;

-- Q3: CASE WHEN multiple conditions — Marks >= 90 = 'Excellent', >= 70 = 'Good', >= 50 = 'Average', baaki = 'Poor'

SELECT Name, Marks,
CASE
    WHEN Marks >= 90 THEN 'Excellent'
    WHEN Marks >= 70 THEN 'Good'
    WHEN Marks >= 50 THEN 'Average'
    ELSE 'Poor'
END AS Performance
FROM Students;

-- Q4: ID < 5 ho to 'Group A', warna 'Group B'

SELECT ID, Name,
CASE
	WHEN ID < 5 THEN 'Group A' 
    ELSE 'Group B'
    END AS Which_group
FROM Students;

-- Q5: Marks 80-100 = 'A', 60-79 = 'B', 40-59 = 'C', baaki = 'F'

SELECT Name, Marks,
CASE
	WHEN Marks BETWEEN 80 AND 100 THEN 'A'
    WHEN Marks BETWEEN 60 AND 79 THEN 'B'
    WHEN Marks BETWEEN 40 AND 59 THEN 'C'
    ELSE 'F' END AS Grade
FROM Students;

-- Q6: Marks > 75 ho to actual marks dikhao, warna 0

SELECT Name,
CASE
    WHEN Marks > 75 THEN Marks
    ELSE 0
END AS Marks_Display
FROM Students;

-- Q7: Naam 'M' se shuru ho to 'M Group', warna 'Other' — LEFT(Name, 1) use karo

SELECT Name,
CASE
	WHEN UPPER(LEFT(Name, 1)) = 'M' THEN 'M Group' 
    ELSE 'Other' 
    END AS Which_group
FROM Students;

-- Q8: Marks ke basis pe scholarship — 95+ = 'Full', 80-94 = 'Half', baaki = 'None'

SELECT Name, Marks,
CASE
    WHEN Marks >= 95 THEN 'Full'
    WHEN Marks >= 80 THEN 'Half'
    ELSE 'None'
END AS Scholarship
FROM Students;

-- Q9: Marks ke basis pe color — 90+ = 'Gold', 80-89 = 'Silver', 70-79 = 'Bronze', baaki = 'None'

SELECT Name, Marks,
CASE 
	WHEN Marks >= 90 THEN 'Gold'
    WHEN Marks >= 80 THEN 'Silver'
    WHEN Marks >= 70 THEN 'Bronze'
    ELSE 'None'
    END AS color
FROM Students;

-- Q10: CASE WHEN with COUNT — kitne students Pass hain (Marks >= 70), kitne Fail

SELECT 
COUNT(CASE WHEN Marks > 70 THEN 'Pass' END) AS Pass_count,
COUNT(CASE WHEN Marks < 70 THEN 'Fail' END) AS Fail_count
FROM Students;

-- Q11: JOIN with BETWEEN + CASE WHEN — Grade >= 8 ho to naam dikhao, Grade < 8 ho to NULL

SELECT 
CASE WHEN g.Grade >= 8 THEN s.Name END AS Display_name,
g.Grade
FROM Students s
JOIN Grades g
ON s.Marks BETWEEN g.Min_marks AND g.Max_marks;

-- Q12: JOIN ke saath — Grade 10 = 'Excellent', Grade 8-9 = 'Good', baaki = 'Average'

SELECT s.Name, g.Grade,
CASE 
    WHEN g.Grade = 10 THEN 'Excellent'
    WHEN g.Grade BETWEEN 8 AND 9 THEN 'Good'
    ELSE 'Average'
END AS Performance
FROM Students s
JOIN Grades g
ON s.Marks BETWEEN g.Min_marks AND g.Max_marks;

-- Q13: JOIN ke saath — Grade aur naam dono CASE WHEN se — Grade 8+ to actual naam, < 8 to NULL;
-- Grade 8+ to actual number, < 8 to 0

SELECT 
CASE WHEN g.Grade >= 8 THEN s.Name END AS display_name,
CASE WHEN g.Grade >= 8 THEN s.Marks ELSE 0 END AS display_marks
FROM Students s
JOIN Grades g
ON s.Marks BETWEEN g.Min_marks AND g.Max_marks;

-- Q14: JOIN ke saath — Combo 1 pe ORDER BY g.Grade DESC lagao

SELECT s.Name, g.Grade
FROM Students s
JOIN Grades g
ON s.Marks BETWEEN g.Min_marks AND g.Max_marks
ORDER BY g.Grade DESC;

-- Q15: JOIN + CASE WHEN - Students aur Grades tables ko JOIN karo.
-- Condition:
-- • Agar Grade >= 9 ho → student ka Name dikhao
-- • Agar Grade < 9 ho → 'Needs Improvement' dikhao
-- Output columns:
-- Name_Display, Marks, Grade

SELECT 
CASE WHEN g.Grade >= 9 THEN s.Name ELSE 'Needs Improvement' END AS display_name,
s.Marks, g.Grade
FROM Students s
JOIN Grades g 
ON s.Marks BETWEEN g.Min_marks AND g.Max_marks;


-- ### CASE WHEN + JOIN combo 

-- Combo 1: Students aur Grades tables ko JOIN karo.
-- Condition: Agar Grade < 8 ho to Name NULL dikhao, Agar Grade >= 8 ho to actual Name dikhao
-- Output columns: Name, Grade, Marks

SELECT 
CASE WHEN g.Grade >= 8 THEN s.Name END AS display_name,
g.Grade, s.Marks
FROM Students s
JOIN Grades g
ON s.Marks BETWEEN g.Min_marks AND g.Max_marks;

-- Combo 2: Combo 1 wali query ko modify karo.
-- Requirement: Same JOIN aur CASE WHEN logic use karo
-- Sorting: Results ko Grade ke basis par descending order me sort karo
-- Output columns: Name, Grade, Marks

SELECT 
CASE WHEN g.Grade >= 8 THEN s.Name END AS display_name,
g.Grade, s.Marks
FROM Students s
JOIN Grades g
ON s.Marks BETWEEN g.Min_marks AND g.Max_marks
ORDER BY g.Grade DESC;

-- Combo 3: Combo 2 wali query ko modify karo.
-- Requirement: Sirf un students ko show karo jinka Grade >= 8 hai
-- Sorting: Grade DESC hi rahe
-- Output columns: Name, Grade, Marks

SELECT s.Name, g.Grade, s.Marks
FROM Students s
JOIN Grades g
ON s.Marks BETWEEN g.Min_marks AND g.Max_marks
WHERE g.Grade >= 8
ORDER BY g.Grade DESC;














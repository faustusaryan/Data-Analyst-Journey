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


-- ### Warmup:- Write following queries

-- Q1
-- Students table se sirf Name aur Marks select karo.
-- Output me sab students dikhe, koi sorting nahi.

SELECT Name, Marks FROM Students;

-- Q2
-- Students table se Name aur Marks select karo
-- aur Marks ke basis par ascending order me sort karo.

SELECT Name, Marks FROM Students ORDER BY Marks;

-- Q3
-- Students table se Name aur Marks select karo
-- aur Marks ke basis par descending order me sort karo.

SELECT Name, Marks FROM Students ORDER BY Marks DESC;


### 15 BETWEEN queries:-

-- Q1: Marks 70 aur 89 ke beech wale students — naam aur marks dikhao

SELECT Name, Marks FROM Students WHERE Marks BETWEEN 70 AND 89;

-- Q2: Marks 80 aur 100 ke beech wale students

SELECT Name, Marks FROM Students WHERE Marks BETWEEN 80 AND 100;

-- Q3: Marks 50 aur 69 ke beech wale students

SELECT Name, Marks FROM Students WHERE Marks BETWEEN 50 AND 69;

-- Q4: NOT BETWEEN — Marks 70 se 100 ke bahar wale

SELECT Name, Marks FROM Students WHERE Marks NOT BETWEEN 70 AND 100;

-- Q5: Marks 60 aur 79 ke beech — naam se A-Z sort karo

SELECT Name, Marks FROM Students WHERE Marks BETWEEN 60 AND 79 ORDER BY Name;

-- Q6: Marks 90 aur 100 ke beech — count nikalo (COUNT use karo)

SELECT COUNT(*) FROM Students WHERE Marks BETWEEN 90 AND 100;

-- Q7: Marks 0 aur 49 ke beech — ye failing students hain

SELECT Name, Marks FROM Students WHERE Marks BETWEEN 0 AND 49;

-- Q8: Marks 70 aur 100 ke beech — count nikalo

SELECT COUNT(*) FROM Students WHERE Marks BETWEEN 70 AND 100;

-- Q9: Marks 80 aur 89 ke beech — average marks nikalo

SELECT AVG(Marks) AS AVG_MARKS FROM Students WHERE Marks BETWEEN 80 AND 89;

-- Q10: Marks 85 aur 100 ke beech — sirf naam dikhao

SELECT Name FROM Students WHERE Marks BETWEEN 85 AND 100;

-- Q11: ID 3 aur 8 ke beech wale students

SELECT ID, Name FROM Students WHERE ID BETWEEN 3 AND 8;

-- Q12: Marks 70 aur 89 ke beech AND ID > 3 — dono conditions ek saath

SELECT ID, Name FROM Students WHERE Marks BETWEEN 70 AND 89 AND ID > 3;

-- Q13: Marks 60 aur 100 ke beech — marks se high to low sort

SELECT Name, Marks FROM Students WHERE Marks BETWEEN 60 AND 100 ORDER BY Marks DESC;

-- Q14: Marks 40 aur 59 ke beech wale students dikhao
-- Note: Marks 40-49 = Grade 5, Marks 50-59 = Grade 6. BETWEEN 40 AND 59 dono ko ek saath pakad lega.

SELECT Name, Marks FROM Students WHERE Marks BETWEEN 40 AND 59;

-- Q15: Marks 90 aur 100 ke beech — ye Grade 10 hai — naam dikhao

SELECT Name, Marks FROM Students WHERE Marks BETWEEN 90 AND 100;



-- G1: Grades table mein Grade 8, 9, 10 ki rows dikhao

SELECT * FROM Grades WHERE Grade BETWEEN 8 AND 10;

-- G2: Student Raj ke Marks (45) kis Grade mein aate hain — Grades table se check karo

SELECT * FROM Grades WHERE 45 BETWEEN Min_marks AND Max_marks;

-- G3: Student Maria ke Marks (99) ka Grade

SELECT * FROM Grades WHERE 99 BETWEEN Min_marks AND Max_marks;

-- G4: Student Neha ke Marks (71) ka Grade 

SELECT * FROM Grades WHERE 71 BETWEEN Min_marks AND Max_marks;

-- G5: Priya (92), Jane (81), Ashley (63) ka Grade kya hoga 

SELECT s.Name, s.Marks, g.Grade
FROM Students s
JOIN Grades g
ON s.Marks BETWEEN Min_marks AND Max_marks
WHERE s.Name IN ('Priya', 'Jane', 'Ashley');
















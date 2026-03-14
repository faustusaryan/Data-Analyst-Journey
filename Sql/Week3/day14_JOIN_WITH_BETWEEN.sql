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

-- W1
-- Students table me kitne students hain jinka Name NULL nahi hai
-- (COUNT + NULL handling)

SELECT COUNT(*) FROM Students WHERE Name IS NULL;

-- W2
-- Students table se un students ka Name aur Marks dikhao
-- jinke marks 70 se zyada hain
-- aur result ko Name ke descending order me sort karo

SELECT Name, Marks FROM Students WHERE Marks > 70 ORDER BY Name DESC;

-- W3
-- Students table se sabse highest marks wale student ka
-- Name aur Marks dikhao

SELECT Name, Marks FROM Students ORDER BY Marks DESC LIMIT 1;


-- ### 12 Queries — JOIN with BETWEEN:

-- Q1: Students + Grades JOIN — sab columns dikhao — ye base query hai

SELECT * FROM Students s 
JOIN Grades g
ON s.Marks BETWEEN Min_marks AND Max_marks;

-- Q2: Sirf Name, Marks, Grade dikhao — baaki columns nahi

SELECT s.Name, s.Marks, g.Grade FROM Students s JOIN Grades g 
ON s.Marks BETWEEN g.Min_marks AND g.Max_marks;

-- Q3: Grade ke basis pe sort karo — high to low

SELECT s.Name, s.Marks, g.Grade FROM Students s JOIN Grades g 
ON s.Marks BETWEEN g.Min_marks AND g.Max_marks
ORDER BY Grade DESC;

-- Q4: Sirf Grade 8, 9, 10 wale students — WHERE add karo

SELECT s.Name, g.Grade FROM Students s JOIN Grades g 
ON s.Marks BETWEEN Min_marks AND Max_marks
WHERE g.Grade IN (8, 9, 10);

-- Q5: Sirf Grade 7 se kam wale students

SELECT s.Name, g.Grade FROM Students s JOIN Grades g 
ON s.Marks BETWEEN Min_marks AND Max_marks
WHERE g.Grade < 7;

-- Q6: Grade 8+ wale students ka count

SELECT COUNT(s.ID) FROM Students s JOIN Grades g 
ON s.Marks BETWEEN g.Min_marks AND g.Max_marks
WHERE g.Grade > 8;

-- Q7: Grade 7 se kam wale students ka count

SELECT COUNT(s.ID) FROM Students s JOIN Grades g 
ON s.Marks BETWEEN g.Min_marks AND g.Max_marks
WHERE g.Grade < 7;

-- Q8: Average Marks — sirf Grade 9 wale students ke

SELECT AVG(s.Marks) AS Avg_marks, g.Grade FROM Students s JOIN Grades g
ON s.Marks BETWEEN g.Min_marks AND g.Max_marks
WHERE g.Grade = 9;

-- Q9: Grade wise student count — GROUP BY use karo

SELECT g.Grade, COUNT(s.ID) AS stu_count FROM Grades g JOIN Students s 
ON  s.Marks BETWEEN g.Min_marks AND g.Max_marks
GROUP BY g.Grade;

-- Q10: Sabse zyada students kis Grade mein hain

SELECT g.Grade, COUNT(s.ID) AS Max_stu FROM Students s JOIN Grades g 
ON s.Marks BETWEEN g.Min_marks AND g.Max_marks
GROUP BY g.Grade
ORDER BY COUNT(s.ID) DESC
LIMIT 1;

-- Q11: Grade 8+ wale — naam se A-Z sort karo

SELECT s.Name, g.Grade FROM students s JOIN grades g
ON s.Marks BETWEEN g.Min_marks AND g.Max_marks
WHERE g.Grade >= 8
ORDER BY s.Name;

-- Q12: Grade 7 se kam wale — Marks se low to high sort karo

SELECT s.Name, s.Marks, g.Grade FROM Students s JOIN Grades g 
ON s.Marks BETWEEN g.Min_marks And g.Max_marks
WHERE g.Grade < 7
ORDER BY s.Marks;


-- C1: Grade 8+ wale naam A-Z, Grade 7- wale Marks low-high 

SELECT s.Name, s.Marks, g.Grade FROM Students s JOIN Grades g 
ON s.Marks BETWEEN g.Min_marks AND g.Max_marks
ORDER BY
	CASE WHEN g.Grade >= 8 THEN s.Name END,
    CASE WHEN g.Grade < 8 THEN s.Marks END;

-- C2: Grade 9 aur 10 wale students — naam aur marks

SELECT s.Name, s.Marks, g.Grade FROM Students s JOIN Grades g 
ON s.Marks BETWEEN g.Min_marks AND g.Max_marks
WHERE g.Grade > 8;

-- C3: Grade 8 se kam wale — unka average marks

SELECT AVG(s.Marks) FROM students s JOIN Grades g 
ON s.Marks BETWEEN g.Min_marks AND g.Max_marks
WHERE g.Grade < 8;
















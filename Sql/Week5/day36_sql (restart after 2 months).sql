CREATE DATABASE again;
USE again;

CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary INT
);

INSERT INTO Employees VALUES
(1, 'Aryan', 'IT', 60000),
(2, 'Rohan', 'IT', 75000),
(3, 'Neha', 'HR', 50000),
(4, 'Priya', 'HR', 55000),
(5, 'Aman', 'Sales', 45000),
(6, 'Karan', 'Sales', 70000);

CREATE TABLE Projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(50),
    emp_id INT
);

INSERT INTO Projects VALUES
(101, 'AI System', 1),
(102, 'Web App', 2),
(103, 'Recruitment Portal', 3),
(104, 'Sales Dashboard', 5),
(105, 'CRM System', 2),
(106, 'Marketing Tool', 6);


-- Question 1 — JOIN + GROUP BY
-- Find each department and the number of employees working in that department who have at least 
-- one project assigned.

SELECT
    e.department,
    COUNT(e.emp_id) AS emp_count
FROM Employees e
JOIN Projects p
    ON e.emp_id = p.emp_id
GROUP BY e.department;


-- Question 2 — Subquery using IN
-- Find the names of employees who are assigned to at least one project.
-- Use a subquery with IN.


SELECT 
	emp_name
FROM employees
WHERE emp_id IN (SELECT emp_id FROM projects);


-- Question 3 — CASE WHEN + GROUP BY
-- Show department-wise employee count in these salary categories:
-- High Salary (>= 70000)
-- Medium Salary (50000 - 69999)
-- Low Salary (< 50000)

-- Display:
-- department
-- salary_category
-- employee_count


SELECT
    department,
    CASE
        WHEN salary >= 70000 THEN 'High Salary'
        WHEN salary >= 50000 THEN 'Medium Salary'
        ELSE 'Low Salary'
    END AS salary_category,
    COUNT(emp_id) AS emp_count
FROM Employees
GROUP BY department, salary_category;


-- Question 4 — Window Function (RANK + PARTITION BY)
-- Rank employees within each department based on salary (highest salary gets Rank 1).

-- Display:
-- emp_name
-- department
-- salary
-- rank
-- Use RANK() OVER(PARTITION BY ...).


SELECT 
	emp_name,
    department,
    salary,
    RANK() OVER(
		PARTITION BY department 
        ORDER BY salary DESC) 
	AS rnk
FROM employees;


-- Question 5 — CTE filtering using another CTE
-- Create:
-- First CTE → employees with salary > 50000
-- Second CTE → employees from the first CTE who also have a project assigned

-- Display:
-- emp_id
-- emp_name
-- salary
-- Use one CTE inside another.

WITH HighSalaryEmployees AS (
    SELECT
        emp_id,
        emp_name,
        salary
    FROM Employees
    WHERE salary > 50000
),
ProjectEmployees AS (
    SELECT DISTINCT h.*
    FROM HighSalaryEmployees h
    JOIN Projects p
        ON h.emp_id = p.emp_id
)
SELECT *
FROM ProjectEmployees;

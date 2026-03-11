CREATE DATABASE IF NOT EXISTS WARMUP;
USE WARMUP;
CREATE TABLE employee(
	id INT PRIMARY KEY,
    name VARCHAR(50),
    dept VARCHAR(30),
    salary INT,
    city VARCHAR(30)
);

INSERT INTO employee VALUES
(1, "Raj", "IT", 45000, "Delhi"),
(2, "Priya", "HR", 38000, "Mumbai"),
(3, "Amit", "IT", 52000, "Delhi"),
(4, "Sara", "Finance", 41000, "Pune"),
(5, "Vivek", "HR", 35000, "Delhi"),
(6, "Neha", "Finance", 47000, "Mumbai"),
(7, "Rohit", "IT", 39000, "Pune"),
(8, "Deepa", "HR", 43000, "Delhi");

CREATE TABLE departments(
	dept_id INT,
    dept_name VARCHAR(30),
    manager VARCHAR(40),
    budget INT
    );
    
INSERT INTO departments
(dept_id, dept_name, manager, budget)
VALUES
(1, 'IT', 'Suresh', 500000),
(2, 'HR', 'Meena', 300000),
(3, 'Finance', 'Ravi', 400000),
(4, 'Marketing', 'Preeti', 250000);


-- 1. employees table se saari unique cities nikalo — duplicates nahi chahiye 

SELECT DISTINCT city FROM employee;

-- 2. Sab employees ko salary ke hisaab se sasta pehle (ascending) sort karo 

SELECT * FROM employee ORDER BY salary;

-- 3.  Sab employees ko salary ke hisaab se mehenga pehle (descending) sort karo

SELECT * FROM employee ORDER BY salary DESC;

-- 4.  Sirf top 3 highest salary wale employees ke naam aur salary dikhao

SELECT name, salary FROM employee ORDER BY salary DESC LIMIT 3;

-- 5. Sabse kam salary wale 3 employees nikalo

SELECT name, salary FROM employee ORDER BY salary LIMIT 3;

-- 6. Sabse zyada salary wala employee kaun hai?

SELECT name, salary FROM employee ORDER BY salary DESC LIMIT 1;

-- 7. Sab employees ko department alphabetically sort karo, phir department ke andar salary highest pehle

SELECT name, dept, salary FROM employee ORDER BY dept ASC, salary DESC; 

-- 8. Sab unique departments nikalo employee table se (departments table se NAHI)

SELECT DISTINCT dept FROM employee;

-- 9. Employee table mein rows 4 se 6 dikhao (row 1-3 skip karo)

SELECT * FROM employee LIMIT 3 OFFSET 3;

-- 10. Delhi ya Mumbai mein rehne wale employees dikhao — salary ke hisaab se highest pehle

SELECT name, city, salary FROM employee WHERE city IN ('Delhi', 'Mumbai') ORDER BY salary DESC;

-- 11. IT ya Finance dept wale employees nikalo — subquery use karo departments table se

SELECT name, dept FROM employee WHERE dept IN (SELECT dept_name from departments WHERE dept_name IN ('IT','Finance'));

-- 12. Sabse zyada salary wala employee nikalo — subquery use karo MAX ke saath

SELECT name, salary FROM employee WHERE salary IN (SELECT MAX(salary) FROM employee);

-- 13. Average salary se zyada salary wale employees nikalo

SELECT name, salary FROM employee WHERE salary > (SELECT AVG(salary) FROM employee);

-- 14. Marketing department mein koi employee nahi hai — prove karo subquery se

SELECT dept_name FROM departments
WHERE dept_name NOT IN (SELECT DISTINCT dept FROM employee);

### failed

-- 15. Har employee ke saath company ka average salary bhi dikhao — comparison ke liye

SELECT name, salary, (SELECT AVG(salary) FROM employee) AS company_avg FROM employee;



















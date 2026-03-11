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


-- 1.  Wo employee nikalo jiska salary sabse zyada hai — subquery use karo MAX ke saath

SELECT name, salary FROM employee WHERE salary = (SELECT MAX(salary) FROM employee);

-- 2.  departments table se wo departments nikalo jisme koi bhi employee nahi hai

SELECT dept_name FROM departments WHERE dept_name NOT IN (SELECT dept FROM employee);

-- 3.  Top 3 highest salary wale employees ke naam aur salary nikalo

SELECT name, salary FROM employee ORDER BY salary DESC LIMIT 3;



















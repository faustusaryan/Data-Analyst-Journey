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


-- 1. Wo employees nikalo jinke dept ka naam departments table mein listed hai. (Subquery with IN)

SELECT name, dept FROM employee WHERE dept IN (SELECT dept_name FROM departments);

-- 2. Wo employee nikalo jiska salary sabse zyada hai. (Scalar Subquery (MAX))

SELECT name, salary FROM employee WHERE salary = (SELECT MAX(salary) FROM employee);

-- 3. Wo employees nikalo jinki salary company ki average salary se kam hai. (Scalar Subquery (AVG))

SELECT name, salary FROM employee WHERE salary < (SELECT AVG(salary) FROM employee);

-- 4. Departments table se wo departments nikalo jisme koi bhi employee nahi hai. (NOT IN Subquery)

SELECT dept_name FROM departments WHERE dept_name NOT IN (SELECT dept FROM employee);

-- 5. Har employee ka naam, salary, aur company ki maximum salary ek saath dikhao.(Subquery in SELECT clause)

SELECT name, salary, (SELECT MAX(salary) FROM employee) AS company_max FROM employee;

















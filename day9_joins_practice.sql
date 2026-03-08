CREATE DATABASE IF NOT EXISTS WARMUP;
USE WARMUP;

CREATE TABLE employee(
	id INT PRIMARY KEY,
    name VARCHAR(50),
    dept VARCHAR(30),
    salary INT,
    city VARCHAR(30),
    join_date DATE
);

INSERT INTO employee 
(id, name, dept, salary, city, join_date)
VALUES
(1, "Raj", "IT", 45000, "Delhi", '2022-03-15'),
(2, "Priya", "HR", 38000, "Mumbai", '2021-07-01'),
(3, "Amit", "IT", 52000, "Delhi", '2020-11-20'),
(4, "Sara", "Finance", 41000, "Pune", '2023-01-10'),
(5, "Vivek", "HR", 35000, "Delhi", '2022-08-05'),
(6, "Neha", "Finance", 47000, "Mumbai", '2021-04-18'),
(7, "Rohit", "IT", 39000, "Pune", '2023-06-22'),
(8, "Deepa", "HR", 43000, "Delhi", '2020-09-30');

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

-- 1. Har employee ka naam aur uske department ka manager ka naam dikhao — employees JOIN departments pe

SELECT e.name, d.manager FROM employee e JOIN departments d
ON e.dept = d.dept_name;

-- 2. Har department ka naam aur us department mein kitne employees hain — Marketing bhi dikhao (0 employees)

SELECT d.dept_name, COUNT(e.id) FROM departments d LEFT JOIN employee e
ON d.dept_name = e.dept
GROUP BY d.dept_name;

-- 3. Wo departments dikhao jinka total salary budget se zyada hai — employees ka SUM(salary) > departments.budget

SELECT e.dept, SUM(e.salary) AS total_salary, d.budget FROM employee e JOIN departments d
ON e.dept = d.dept_name
GROUP BY e.dept, d.budget 
HAVING SUM(e.salary) > d.budget;

### help leni pdi, d.budget GROUP BY m nhi likh raha tha and mysql error de raha tha

-- 4. Har employee ka naam, salary, aur department ka budget dikhao — salary aur budget dono ek saath

SELECT e.name, e.salary, d.budget FROM employee e JOIN departments d
ON e.dept = d.dept_name;

-- 5. Sabse zyada salary wale employee ka naam aur uske department ka manager ka naam dikhao — subquery + JOIN

SELECT a.name, a.max_salary, manager 
FROM (SELECT name, dept, MAX(salary) AS max_salary from employee group by name, dept order by max(salary) desc limit 1) a
JOIN departments d
ON a.dept = d.dept_name;

SELECT e.name, e.salary, d.manager
FROM employee e
JOIN departments d
ON e.dept = d.dept_name
WHERE e.salary = (SELECT MAX(salary) FROM employee);

### jabardasti complex kr diya

-- 6. Wo employees dikhao jo Delhi mein hain — unke department ka budget bhi dikhao — city filter ke saath JOIN

SELECT e.name, e.dept, d.budget FROM employee e JOIN departments d
ON e.dept = d.dept_name
WHERE e.city = 'Delhi';

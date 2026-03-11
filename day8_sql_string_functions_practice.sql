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


-- Q1 — UPPER() -- Find all employees whose department is 'it', 'IT', or 'It' — handle all cases with one query.

SELECT * FROM employee WHERE UPPER(dept) = 'IT';

-- Q2 — LOWER() -- Display every employee's name in lowercase.

SELECT LOWER(name) FROM employee;

-- Q3 — LENGTH() -- Show each employee's name and how many characters their name has. Filter: only names longer than 4 characters.

SELECT name, LENGTH(name) FROM employee WHERE LENGTH(name) > 4;

-- Q4 — CONCAT() -- Display output like: Raj works in IT for every employee.

SELECT CONCAT(name, ' works in ', dept) FROM employee;

-- Q5 — SUBSTRING() -- Extract the first 3 characters of each employee's name.

SELECT name, SUBSTRING(name, 1, 3) FROM employee;

-- Q6 — TRIM() -- Run this and see what TRIM does: sql SELECT TRIM('   Raj   '); Then use it on the name column of the employee table.

SELECT name, TRIM(name) FROM employee;

-- Q7 — REPLACE() -- Display the city column but show 'NCR' wherever 'Delhi' appears — without updating the table.

SELECT name, city, REPLACE(city, 'Delhi', 'NCR') FROM employee;

-- Q8 — LEFT() -- Show the first 2 characters of every employee's name.

SELECT name, LEFT(name, 2) FROM employee ;

-- Q9 — RIGHT() -- Show the last 2 characters of every employee's name.

SELECT name, RIGHT(name, 2) FROM employee;

-- Q10 — UPPER() + WHERE
-- Fetch all employees from the Finance department using UPPER() in the WHERE clause 
-- — as if you don't know the exact casing stored in the table.

SELECT name, UPPER(dept) FROM employee WHERE UPPER(dept) = 'FINANCE';


### string functions practice:-

-- 1. Saare employee names UPPERCASE mein dikhao

SELECT name, UPPER(name) AS upp_name FROM employee;

-- 2.  Saare employee names lowercase mein dikhao

SELECT name, LOWER(name) AS lwr_name FROM employee;

-- 3.  Har employee ka naam aur uski naam ki character length dikhao

SELECT name, LENGTH(name) FROM employee;

-- 4. naam aur dept ek column mein: 'Raj - IT' format

SELECT CONCAT(name, ' - ', dept) FROM employee;

-- 5.  naam aur city ek column mein: 'Raj (Delhi)' format

SELECT CONCAT(name, ' (', city, ')') AS name_city FROM employee; 

### failed

-- 6. Har employee ke naam ke pehle 3 characters nikalo

SELECT name, SUBSTRING(name, 1, 3) AS first_3 FROM employee;

-- 7.  Har employee ke naam ke aakhri 2 characters nikalo

SELECT name, RIGHT(name, 2) AS right_2 FROM employee;

-- 8.  name column se position 2 se 4 characters nikalo

SELECT name, SUBSTRING(name, 2, 4) AS name_2_4 FROM employee;

-- 9. Delhi employees ka city column 'NCR' se replace karo (result only, table update nahi)

SELECT city, REPLACE(city, 'Delhi', 'NCR') AS new_city FROM employee; 

-- 10.  Case-insensitive: 'it' department ke employees dhundho

SELECT name, LOWER(dept) FROM employee WHERE LOWER(dept) = 'it';

-- 11.  Naam 4 characters se zyada lambe wale employees nikalo (strictly greater than 4)

SELECT name, LENGTH(name) FROM employee WHERE LENGTH(name) > 4;

-- 12.  employee_info column banao: 'Raj | IT | Delhi' format

SELECT CONCAT(name, ' | ', dept, ' | ', city) AS employee_info FROM employee;

-- 13.  UPPER name dikhao sirf jin ki naam 5 chars ki ho

SELECT name FROM employee WHERE LENGTH(name) = 5;

-- 14.  dept column mein 'Finance' ko 'Fin' se replace karo (result mein)

SELECT dept, REPLACE(dept, 'Finance', 'Fin') AS new_dept FROM employee;

-- 15. naam aur salary 'Amit: 52000' format mein dikhao, salary DESC order

SELECT CONCAT(name, ': ', salary) FROM employee ORDER BY salary DESC;





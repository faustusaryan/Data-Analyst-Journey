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


-- 1️. First letter of each employee name

SELECT name, SUBSTRING(name, 1, 1) FROM employee;

-- 2. Employee initials: "R.D" format (name + city first letter)

SELECT CONCAT(LEFT(name, 1),'.', LEFT(city, 1)) AS initials FROM employee;

-- 3. Name with character count inside brackets

SELECT CONCAT(name, ' ', '(', LENGTH(name), ')' ) AS name_length FROM employee;

-- 4. First 2 characters of department

SELECT dept, LEFT(dept, 2) AS dept_short FROM employee;

-- 5. City first 3 letters uppercase

SELECT city, UPPER(LEFT(city, 3)) city_code FROM employee;


#### -- W3Schools Examples (3)

-- 6. Ek column banao jiska naam employee_sentence ho. Format hona chahiye: 'Raj works in IT department'

SELECT CONCAT(name, ' works in ', dept, ' department') AS employee_sentence FROM employee;

-- 7. REPLACE example:- 
-- name column mein 'a' ko '@' se replace karke result dikhao.
-- Table update nahi karna, sirf result mein change.
-- Example expected pattern: 'Sara → S@r@'

SELECT name, REPLACE(name, 'a', '@') AS new_name FROM employee;


-- 8. LENGTH + ORDER example:-
-- Har employee ka name aur uski length dikhao.
-- Result ko name length ke descending order mein sort karo.
-- Example idea:
-- Priya 5
-- Rohit 5
-- Raj   3

SELECT name, LENGTH(name) AS name_length FROM employee ORDER BY LENGTH(name) DESC;



















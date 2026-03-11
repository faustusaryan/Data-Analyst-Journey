CREATE DATABASE IF NOT EXISTS audit_test;
USE audit_test;

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

-- WARMUP: Department wise avg salary, sirf
-- woh departments jo 2 se zyada log hain. (GROUP BY + HAVING)

SELECT dept, AVG(salary), COUNT(*) FROM employee GROUP BY dept HAVING COUNT(*) > 2;

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

SELECT * FROM departments;

-- 1. Har employee ka naam aur unke department manager ka naam dikhao

SELECT e.name, d.manager FROM employee e
JOIN departments d
ON e.dept = d.dept_name;

-- 2.  Har employee ka naam aur unki department ka budget dikhao

SELECT e.name, d.budget FROM employee e
JOIN departments d
ON e.dept = d.dept_name;

-- 3. Har employee ka naam, city, aur unki dept ka manager dikhao

SELECT e.name, e.city, d.manager FROM employee e
JOIN departments d
ON e.dept = d.dept_name;

-- 4.   LEFT JOIN use karke — sab employees dikhao. Agar kisi employee ki dept departments table mein nahi hoti to uska budget NULL aata.

SELECT e.name, d.dept_name, d.budget FROM employee e
LEFT JOIN departments d
ON e.dept = d.dept_name;

-- 5. RIGHT JOIN use karke — sab departments dikhao. Marketing ka koi employee nahi — woh bhi dikhna chahiye.

SELECT e.name, d.dept_name FROM employee e
RIGHT JOIN departments d
ON e.dept = d.dept_name;

-- 6. Kaunsi departments mein koi employee NAHI hai? (RIGHT JOIN + NULL filter)

SELECT d.dept_name FROM employee e
RIGHT JOIN departments d
ON e.dept = d.dept_name
WHERE e.id IS NULL;

### isme thodi prob hui WHERE clause me 'IS' ki jagh '=' use kr raha tha 

-- 7.  Har employee ka naam aur unki department ka budget — sirf IT department wale

SELECT e.name, d.budget FROM employee e 
JOIN departments d
ON e.dept = d.dept_name
WHERE e.dept = 'IT';

-- 8. Har employee ka naam, salary, aur department budget — salary > 40000 wale

SELECT e.name, e.salary, d.budget FROM employee e
JOIN departments d
ON e.dept = d.dept_name
WHERE salary > 40000;

-- 9. Department wise employee count aur department ka budget — GROUP BY ke saath JOIN

SELECT e.dept, count(e.id) AS emp_count, d.budget FROM employee e JOIN departments d
ON e.dept = d.dept_name 
GROUP BY e.dept, d.budget;	

### Hint lena pda "GROUP BY e.dept, d.budget" beena hint k nhi ho paya 

-- 10. Har department ka avg salary aur budget — department name bhi dikhao

SELECT e.dept, AVG(e.salary), d.budget FROM employee e JOIN departments d
ON e.dept = d.dept_name 
GROUP BY e.dept, d.budget;

-- 11. Sirf woh departments dikhao jahan avg salary 40000 se zyada ho — JOIN + GROUP BY + HAVING

SELECT d.dept_name, AVG(e.salary) FROM departments d JOIN employee e
ON d.dept_name = e.dept
GROUP BY d.dept_name
HAVING AVG(e.salary) > 40000;

-- 12.  Har Delhi employee ka naam aur unke department manager ka naam

SELECT e.name, e.city, d.manager FROM employee e JOIN departments d
ON e.dept = d.dept_name
WHERE city = 'Delhi';

-- 13. SELF JOIN: Same department mein saath kaam karne wale employees ke pairs dikhao — apna naam apne
-- saath nahi aana chahiye

SELECT a.name, b.name FROM employee a JOIN employee b 
ON a.dept = b.dept
WHERE a.id != b.id;

### ek baar CONCEPT TABLE pdhni pdi basically help leni pdi thodi si 

-- 14.  FULL OUTER JOIN (MySQL trick): Sab employees aur sab departments — match ho ya na ho

SELECT e.name, d.dept_name FROM employee e LEFT JOIN departments d
ON e.dept = d.dept_name
UNION
SELECT e.name, d.dept_name FROM employee e RIGHT JOIN departments d
ON e.dept = d.dept_name;

### kr liya but concept smjhne ki jrurt pdi phle 

-- 15. Har employee ka naam, salary, manager — salary se high to low sort karo

SELECT e.name, e.salary, d.manager FROM employee e JOIN departments d
ON e.dept = d.dept_name
ORDER BY e.salary DESC;

##### EASY THA SB BS KUCH BASIC FUNDAMENTALS EK BAAR AUR PADHNE KI NEED HAI I GUESS 
















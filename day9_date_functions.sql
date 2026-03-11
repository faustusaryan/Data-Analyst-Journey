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

-- ### WARMUP

-- 1. naam aur dept ek column mein dikhao 'Raj - IT' format  — salary DESC order mein sort karo 

SELECT CONCAT(name, ' - ', dept) AS name_dept FROM employee;

-- 2. naam jinka length 3 ya usse zyada ho — naam aur length dikhao (LENGTH >= 3) 

SELECT name, LENGTH(name) FROM employee WHERE LENGTH(name) > 3;

-- 3. IT dept ke employees case-insensitive dhundho —  UPPER(dept)='IT' use karo, naam UPPER mein dikhao 

SELECT UPPER(name) AS name_upp, UPPER(dept) AS dept_upp FROM employee WHERE UPPER(dept) = 'IT';

-- ###  PRACTICE TASKS — 15 SQL Queries

-- 1. Aaj ki current date aur time ek saath dikhao 

SELECT NOW();

-- 2. Sirf aaj ki date dikhao — time nahi 

SELECT CURDATE() AS curr_date;

-- 3. Har employee ka naam aur join_date ka YEAR nikalo

SELECT name, YEAR(join_date) AS join_year FROM employee;

-- 4. Har employee ka naam aur join_date ka MONTH nikalo

SELECT name, MONTH(join_date) AS join_month FROM employee;

-- 5. Har employee ka naam aur join_date ka DAY number nikalo

SELECT name, DAY(join_date) AS join_day FROM employee;

-- 6. Aaj se har employee ne kitne din kaam kiya — naam aur days_worked dikhao, sabse zyada pehle 

SELECT name, DATEDIFF(CURDATE(), join_date) AS total_days FROM employee ORDER BY total_days DESC;

-- 7. join_date ko 'DD-MM-YYYY' format mein dikhao — naam aur formatted_date column

SELECT name, DATE_FORMAT(join_date, '%d-%m-%y') AS formatted_date FROM employee;

-- 8. join_date ko 'Month DD, YYYY' format mein dikhao (e.g. 'March 15, 2022')

SELECT name, DATE_FORMAT(join_date, '%M-%d-%y') AS joined_on FROM employee;

-- 9. Har employee ki 1st work anniversary date kab thi — naam aur anniversary column dikhao

SELECT name, DATE_ADD(join_date, INTERVAL 1 YEAR) AS first_anniversary FROM employee;

-- 10.Aaj se exactly 6 mahine pehle ki date kya thi — sirf woh date nikalo 

SELECT DATE_SUB(CURDATE(), INTERVAL 6 MONTH) AS six_month_ago;

-- 11. 2022 mein join karne wale employees ke naam aur join_date dikhao 

SELECT name, join_date FROM employee WHERE YEAR(join_date) = 2022;

-- 12. 1000 din se ZYADA kaam karne wale employees — naam aur exact days dikhao 

SELECT name, DATEDIFF(CURDATE(), join_date) AS total_days  FROM employee WHERE DATEDIFF(CURDATE(), join_date) > 1000 ;

-- 13. Har employee ke joining ke 90 din baad probation end date — naam aur probation_end dikhao

SELECT name, DATE_ADD(join_date, INTERVAL 90 DAY) AS probation_end FROM employee;


-- 14. join_date ko 'YYYY/MM/DD' format mein dikhao — naam aur formatted column

SELECT name, DATE_FORMAT(join_date, '%y-%m-%d') AS formatted_date FROM employee;

-- 15. naam, join_date, aur years_in_company (approx) — DATEDIFF/365 se nikalo, sabse zyada pehle 

SELECT name, join_date, ROUND(datediff(CURDATE(), join_date )/365, 1) AS years_in_company FROM employee ORDER BY years_in_company DESC;
















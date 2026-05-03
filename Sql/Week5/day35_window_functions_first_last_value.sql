USE analyst_practice;

-- Q1: Har department mein sabse pehle hire hue employee ki salary dikhao — har row ke saath. 
-- Name, department, salary aur first_salary dikhao. (order by salary ascending use karo)

SELECT 
	name,
    department,
    salary,
	FIRST_VALUE(salary) OVER(PARTITION BY department ORDER BY hire_date) first_salary
FROM employees;

-- Q2: Har department mein sabse zyada salary dikhao har row ke saath — LAST_VALUE use karke. 
-- Sahi frame clause lagana — warna galat result aayega.

SELECT
	name,
    department,
    salary,
    LAST_VALUE(salary) 
    OVER(PARTITION BY department 
    ORDER BY salary
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
    AS highest_salary
FROM employees;

-- Q3: Har department mein — sirf woh employees dikhao jinka salary, 
-- us department ke pehle hired employee ki salary se zyada hai.

WITH t AS
(SELECT
	*,
    FIRST_VALUE(salary) OVER(PARTITION BY department ORDER BY hire_date) AS first_sal
FROM employees)
SELECT
	name,
    department,
    salary,
    first_sal
FROM t
WHERE salary > first_sal;

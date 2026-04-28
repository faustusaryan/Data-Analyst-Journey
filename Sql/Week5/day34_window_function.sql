USE analyst_practice;

-- Q1: Har employee ko unki salary ke hisaab se ek global rank do — sabse zyada salary ko rank 1. 
-- Name, department, salary aur rank dikhao.

SELECT 
	name,
    department,
    salary,
    RANK() OVER(ORDER BY salary DESC) AS global_rank
FROM employees;

-- Q2: Har department ke andar employees ko salary ke hisaab se rank karo. 
-- Name, department, salary aur rank dikhao.

SELECT
	name,
    department,
    salary,
    RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS dept_rank
FROM employees;

-- Q3: Sirf woh employees dikhao jo apne department mein salary mein top 2 hain.

WITH t AS 
(SELECT
	name,
    department,
    salary,
    RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS dept_rank
FROM employees)
SELECT 
	name,
    department,
    salary,
    dept_rank
FROM t 
WHERE dept_rank < 3;

-- Q4: Orders table mein har customer ke orders ko date ke hisaab se number karo — pehla order 1, doosra 2, etc. 
-- Customer id, order id, date aur row number dikhao.

SELECT 
	customer_id,
    id AS order_id,
    order_date,
    ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY order_date) AS order_no
FROM orders;

-- Q5: Employees ko global salary rank do DENSE_RANK() se. Phir same query RANK() se bhi likho. 

SELECT 
	name,
    department,
    salary,
    DENSE_RANK() OVER(ORDER BY salary DESC) AS dense_rnk
FROM employees;

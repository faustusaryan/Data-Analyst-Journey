USE analyst_practice;

-- 1. Problem Statement
-- Rank all employees by salary (highest first). Show side by side:
-- ROW_NUMBER, RANK, DENSE_RANK — so the difference between them is visible.

SELECT 
	name,
    salary,
	ROW_NUMBER() OVER(w) as row_num,
	RANK() OVER(w) AS `rank`,
    DENSE_RANK() OVER(w) AS `dense_rank`
FROM employees
WINDOW w AS (ORDER BY salary DESC);

-- 2. Problem Statement
-- Rank employees within their own department by salary (highest first). Use all three
-- ranking functions. Sort final output by department and rank.

SELECT
	name,
    department,
    salary,
    ROW_NUMBER() OVER(w) AS dept_row_num,
    RANK() OVER(w) AS dept_rnk,
    DENSE_RANK() OVER(w) AS dept_dense_rnk
FROM employees
WINDOW w AS (PARTITION BY department ORDER BY salary DESC)
ORDER BY department, dept_rnk;

-- 3. Problem Statement
-- Find the single top earner in each department.
-- Use ROW_NUMBER so ties are broken — exactly one row per department returned.

SELECT 
	department,
	name,
    salary
FROM (SELECT 
			name,
			salary,
            department,
			ROW_NUMBER() OVER(w) AS dept_row
	  FROM employees
	  WINDOW w AS (PARTITION BY department ORDER BY salary DESC)) t
WHERE t.dept_row = 1;

-- 4. Problem Statement
-- Find the bottom 2 earners in each department (lowest salaries).
-- Sort final result by department.

WITH t AS (
    SELECT
		name,
		department,
		salary,
		ROW_NUMBER() OVER(PARTITION BY department ORDER BY salary) AS dept_row
	FROM employees
)
SELECT 
	department,
    name,
    salary
FROM t
WHERE dept_row <= 2
ORDER BY department;

-- 5. Problem Statement
-- Rank customers by their total spending across all orders (highest spender = rank 1).
-- Join orders and customers to get customer names.

SELECT 
	c.name,
	SUM(o.total_amount) AS total_spending,
	RANK() OVER(ORDER BY SUM(o.total_amount) DESC) AS rnk
FROM customers c
LEFT JOIN orders o 
	ON c.id = o.customer_id
GROUP BY c.id, c.name;

-- 6. Problem Statement
-- Show each employee's salary alongside a running total of salaries.
-- Order by hire date (earliest hire first).

SELECT name, 
	hire_date, 
    salary,
    SUM(salary) OVER (ORDER BY hire_date) AS running_total
FROM employees
ORDER BY hire_date;

-- 7. Problem Statement
-- Same as Q6 but calculate the running total separately within each department.
-- The total resets at the start of each department.

SELECT
	name,
    department,
    salary,
    SUM(salary) OVER(PARTITION BY department ORDER BY hire_date) AS dept_running_total
FROM employees
ORDER BY department, hire_date;

-- 8. Problem Statement
-- For each product, show its price rank within its category and a cumulative price total
-- within that category — both ordered highest price first.

SELECT
	category,
	name,
    price,
    RANK() OVER(PARTITION BY category ORDER BY price DESC) AS price_rank,
    SUM(price) OVER(PARTITION BY category ORDER BY price DESC) AS cumulative_price_total
FROM products;

-- 9. Problem Statement
-- For each order (sorted by date), show the previous order's amount using LAG.
-- Also add a column: difference between current order and previous one.
-- Use 0 as default when there is no previous order.

SELECT 
	id, 
    customer_id, 
    order_date, 
    total_amount,
    LAG(total_amount, 1, 0) OVER (ORDER BY order_date, id) AS prev_order_amount,
    total_amount - LAG(total_amount, 1, 0) OVER (ORDER BY order_date, id) AS diff_from_prev
FROM orders
ORDER BY order_date;

-- 10. Problem Statement
-- For each order, show that specific customer's previous order amount.
-- Partition by customer so LAG resets per customer (not global previous).
	
SELECT
	id,
    customer_id,
    order_date,
    total_amount,
    LAG(total_amount, 1, 0) OVER(PARTITION BY customer_id  ORDER BY order_date, id) 
    AS customer_prev_order_amount
FROM orders
ORDER BY customer_id, order_date;

-- 11. Problem Statement
-- For each order, show the same customer's next order amount using LEAD.
-- The last order per customer will show NULL.

SELECT
    id,
    customer_id,
    order_date,
    total_amount,
    LEAD(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date, id) 
    AS customer_next_order_amount
FROM orders
ORDER BY customer_id, order_date;

-- 12. Problem Statement
-- Show each employee's salary, the average salary for their department, and the difference
-- between the two — all in a single query without using GROUP BY.

SELECT
	name,
    salary,
    department,
    AVG(salary) OVER(PARTITION BY department) AS dept_avg_salary,
	salary - AVG(salary) OVER(PARTITION BY department) AS diff_from_dept_avg
FROM employees;

-- 13. Problem Statement
-- For each order, display the customer's name and a running total of that customer's
-- spending over time (ordered by order date).

SELECT
	c.name,
    o.id,
    o.total_amount,
    SUM(o.total_amount) OVER(PARTITION BY customer_id ORDER BY order_date, id) 
    AS spending_over_time
FROM customers c 
JOIN orders o
	ON c.id = o.customer_id;

-- 14. Problem Statement
-- For each customer, show their first and last order dates in the same row.
-- Use FIRST_VALUE and LAST_VALUE.
-- Add ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING for LAST_VALUE
-- so it looks at the entire partition, not just up to the current row.

SELECT 
	DISTINCT c.name,
    FIRST_VALUE(o.order_date) OVER (
        PARTITION BY o.customer_id ORDER BY o.order_date
    ) AS first_order,
    LAST_VALUE(o.order_date) OVER (
        PARTITION BY o.customer_id ORDER BY o.order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS last_order
FROM orders o
INNER JOIN customers c ON o.customer_id = c.id;

-- 15. Problem Statement
-- Find the top revenue-generating product within each category.
-- Calculate revenue as quantity × unit_price from order_items.
-- Rank products per category — return only rank-1 product per category.

WITH t AS (
    SELECT
        p.category,
        p.name,
        SUM(oi.quantity * oi.unit_price) AS total_revenue,
        RANK() OVER (PARTITION BY p.category ORDER BY SUM(oi.quantity * oi.unit_price) DESC)
            AS product_rank
    FROM products p
    JOIN order_items oi
        ON p.id = oi.product_id
    GROUP BY p.category, p.name   
)
SELECT
    category,
    name,
    total_revenue
FROM t
WHERE product_rank = 1;






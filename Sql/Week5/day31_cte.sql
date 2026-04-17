USE analyst_practice;

-- 1. Problem Statement
-- Find all employees earning more than the company-wide average salary. 
-- Use a CTE to first calculate the average, then filter employees against it.

WITH avg_cte AS (
    SELECT AVG(salary) AS avg_salary
    FROM employees
)
SELECT e.id, e.name, e.salary
FROM employees e
CROSS JOIN avg_cte
WHERE e.salary > avg_cte.avg_salary;

-- 2. Problem Statement
-- Chain two CTEs: first calculate total spending per customer, then find the average of those totals. 
-- Return only customers above the average.

WITH cust_spending AS (
    SELECT 
        customer_id,
        SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
),
avg_spending AS (
    SELECT 
        AVG(total_spent) AS avg_spent
    FROM cust_spending
)
SELECT
    c.name,
    ct.total_spent,
    ROUND(sa.avg_spent, 2) AS avg_spent
FROM customers c
JOIN cust_spending ct
    ON c.id = ct.customer_id
CROSS JOIN avg_spending sa
WHERE ct.total_spent > sa.avg_spent
ORDER BY ct.total_spent;

-- 3. Problem Statement
-- Calculate total revenue per product (quantity × unit price), rank them, and return only the top 3. 
-- Use LEFT JOIN to include products with zero sales.

WITH t AS (
	SELECT 
		product_id,
		SUM(quantity * unit_price) AS product_revenue,
        DENSE_RANK() OVER(ORDER BY SUM(quantity * unit_price) DESC)
        AS rnk
        FROM order_items
        GROUP BY product_id
)
SELECT
	p.name,
    p.category,
    t.product_revenue
FROM products p
LEFT JOIN t
	ON p.id = t.product_id
WHERE t.rnk < 4
	OR t.rnk IS NULL
ORDER BY t.product_revenue DESC;

-- 4. Problem Statement
-- Define 'active' as customers with ≥2 delivered orders. Use two CTEs: one for order counts, one to filter active customers. 
-- Return their full stats.

WITH order_stats AS (
    SELECT
        customer_id,
        COUNT(id) AS order_count,
        SUM(total_amount) AS total_spent
    FROM orders
    WHERE status = 'delivered'
    GROUP BY customer_id
),
active_customers AS (
    SELECT
        customer_id
    FROM order_stats
    WHERE order_count >= 2
)
SELECT
    c.name,
    c.city,
    os.order_count,
    os.total_spent
FROM customers AS c
JOIN active_customers AS ac ON c.id = ac.customer_id
JOIN order_stats AS os ON c.id = os.customer_id
ORDER BY os.total_spent DESC;
    
-- 5. Problem Statement
-- Rank employees within each department by salary using RANK(). Then filter to show only the top 2 per department. 
-- Use a CTE to separate ranking from filtering.
-- 💡 You CANNOT use WHERE on a window function directly — CTE solves this.

WITH ranked_employees AS (
    SELECT
        id,
        name,
        salary,
        department,
        RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dept_rnk
    FROM employees
)

SELECT
    name,
    department,
    salary,
    dept_rnk
FROM ranked_employees
WHERE dept_rnk < 3;


-- 6. Problem Statement
-- Calculate revenue for each month, then compare each month against the overall monthly average. 
-- Label each month as 'Above Average' or 'Below Average'.

WITH month_rev AS (
    SELECT
        MONTH(order_date) AS month_num,
        MONTHNAME(order_date) AS month_name,
        SUM(total_amount) AS monthly_rev
    FROM orders
    GROUP BY MONTH(order_date), MONTHNAME(order_date)
),
month_avg AS (
    SELECT
        ROUND(AVG(monthly_rev), 2) AS avg_monthly_rev
    FROM month_rev
)
SELECT
    mr.month_name,
    mr.monthly_rev,
    ma.avg_monthly_rev,
    CASE
        WHEN mr.monthly_rev > ma.avg_monthly_rev THEN 'Above Average'
        WHEN mr.monthly_rev = ma.avg_monthly_rev THEN 'Average'
        ELSE 'Below Average'
    END AS performance
FROM month_rev AS mr
CROSS JOIN month_avg AS ma
ORDER BY mr.month_num;

-- 7. Problem Statement
-- Use LAG() inside a CTE to compare each month's revenue to the previous month. Show the actual revenue change (can be negative).
-- 💡 LAG(col, 1, 0) — default 0 for first row avoids NULL.

WITH monthly_revenue AS (
	SELECT
		MONTH(order_date) AS month_no,
		MONTHNAME(order_date) AS month_name,
        SUM(total_amount) AS monthly_rev,
        SUM(total_amount) - LAG(SUM(total_amount), 1, 0) OVER (ORDER BY MONTH(order_date)) AS diff_in_rev
	FROM orders
    GROUP BY MONTH(order_date), MONTHNAME(order_date)
)
SELECT
	month_name,
    monthly_rev,
    diff_in_rev
FROM monthly_revenue
ORDER BY month_no;

-- Problem Statement
-- Calculate each employee's salary percentile within their department using PERCENT_RANK(). 
-- Show which percentile each person falls in (0–100 scale).
-- 💡 PERCENT_RANK() returns 0 to 1 — multiply by 100 for readable %.

SELECT
    name,
    department,
    salary,
    ROUND(PERCENT_RANK() OVER (w) * 100, 2) AS percentile_rank
FROM employees
WINDOW w AS (PARTITION BY department ORDER BY salary)
ORDER BY department, percentile_rank;

-- 9. Problem Statement
-- Build a reporting hierarchy tree using a recursive CTE. 
-- Show each employee's level (0 = top manager) and their full path in the org chart.
-- 💡 Base query runs once. Recursive part runs until no new rows found.

WITH RECURSIVE cte AS (
    SELECT
        id,
        name,
        department,
        0 AS `level`,
        name AS path
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT
        e.id,
        e.name,
        e.department,
        cte.level + 1 AS `level`,
        CONCAT(cte.path, ' -> ', e.name) AS path
    FROM employees AS e
    JOIN cte 
		ON e.manager_id = cte.id
)
SELECT
    name,
    department,
    `level`,
    path
FROM cte
ORDER BY `level`, name;

-- 10. Problem Statement
-- Build a full customer report combining order stats, first/last order dates, and spending rank. 
-- Use LEFT JOIN to include customers with zero orders.
-- 💡 IFNULL(val, 0) — customers with no orders show 0 instead of NULL

WITH customer_stats AS (
	SELECT
		customer_id,
		SUM(total_amount) AS total_spent,
        COUNT(id) AS order_count,
        MIN(order_date) AS first_order,
        MAX(order_date) As last_order,
		DENSE_RANK() OVER (ORDER BY SUM(total_amount) DESC) AS spending_rank
	FROM orders
	GROUP BY customer_id
)
SELECT
	c.name,
    c.city,
    c.age,
    IFNULL(cs.order_count, 0) AS order_count,
    IFNULL(cs.total_spent, 0) AS total_spent,
    cs.first_order,
    cs.last_order,
    IFNULL(cs.spending_rank, 0) AS spending_rank
FROM customers c
LEFT JOIN customer_stats cs
	ON c.id = cs.customer_id
ORDER BY cs.spending_rank;

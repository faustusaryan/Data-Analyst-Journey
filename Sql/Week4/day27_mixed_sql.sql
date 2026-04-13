USE analyst_practice;

-- 1. Problem Statement
-- Customers aur orders JOIN karo. Har customer ke liye nikalo:
--   num_orders, total_spent (rounded), avg_order (rounded)
--   CASE WHEN se customer_type: 50000+ → 'VIP' | 5000+ → 'Regular' | else → 'Occasional'
-- Output: name, city, num_orders, total_spent, avg_order, customer_type — sorted by total_spent DESC

SELECT
	c.name,
    c.city,
    COUNT(o.id) AS num_orders,
    ROUND(SUM(o.total_amount)) AS total_spent,
    ROUND(AVG(o.total_amount)) AS avg_order,
    CASE
		WHEN SUM(o.total_amount) >= 50000 THEN 'VIP'
        WHEN SUM(o.total_amount) >= 5000 THEN 'Regular'
        ELSE 'Occasional'
        END AS customer_type
FROM customers c 
JOIN orders o 
	ON c.id = o.customer_id
GROUP BY c.id, c.name, c.city
ORDER BY total_spent DESC;

-- 2. Problem Statement
-- Products aur order_items LEFT JOIN karo. Har product ke liye nikalo:
--   times_ordered, total_qty_sold, total_revenue
--   Performance label: 3+ times → 'Popular' | 2 times → 'Moderate' | else → 'Slow Moving'
-- Output: name, category, times_ordered, total_qty_sold, total_revenue, performance — sorted by total_revenue DESC

SELECT
	p.name,
    p.category,
    COUNT(oi.id) AS time_ordered,
    SUM(oi.quantity) AS total_qty_sold,
    SUM(oi.unit_price * oi.quantity) AS total_revenue,
    CASE
		WHEN COUNT(oi.id) >= 3 THEN 'Popular'
        WHEN COUNT(oi.id) = 2 THEN 'Moderate'
        ELSE 'Slow Moving'
        END AS performance
FROM products p
LEFT JOIN order_items oi 
	ON p.id = oi.product_id
GROUP BY p.name, p.category
ORDER BY total_revenue DESC;

-- 3. Problem Statement
-- Har customer ki total spending nikalo.
-- HAVING se sirf woh customers rakhein jinki total spending
-- overall average single order amount se zyada ho.
-- Output: name, city, total_spent — sorted by total_spent DESC

SELECT 
	c.name,
    c.city,
    ROUND(SUM(o.total_amount), 2) AS total_spent
FROM customers c
JOIN orders o 
	ON c.id = o.customer_id
GROUP BY c.id, c.name, c.city
HAVING SUM(o.total_amount) > (
	SELECT 
		AVG(total_amount)
    FROM orders
)
ORDER BY total_spent DESC;

-- 4. Problem Statement
-- Har department ke liye ek hi row mein nikalo:
--   total_employees, avg_salary
--   senior_count (salary >= 70000), mid_count (50000-69999), junior_count (< 50000)
-- Output: department, total_employees, avg_salary, senior_count, mid_count, junior_count

SELECT
	department,
    COUNT(*) AS total_employees,
	ROUND(AVG(salary), 2) AS avg_salary,
    COUNT(CASE WHEN salary >= 70000 THEN 1 END) AS senior_count,
    COUNT(CASE WHEN salary >= 50000 AND salary < 70000 THEN 1 END) AS mid_count,
	COUNT(CASE WHEN salary < 50000 THEN 1 END) AS junior_count
FROM employees
GROUP BY department;

-- 5. Problem Statement
-- Har month ke liye nikalo: total_orders, delivered count, cancelled count,
-- total_revenue, avg_order_value, aur performance flag (60000+ → 'High' warna 'Normal').
-- Output: month, total_orders, delivered, cancelled, total_revenue, avg_order_value, performance — sorted by month

SELECT 
	MONTH(order_date) AS month,
    COUNT(*) AS total_orders,
    COUNT(CASE WHEN status = 'Delivered' THEN 1 END) AS delivered,
    COUNT(CASE WHEN status = 'Cancelled' THEN 1 END) AS cancelled,
	SUM(total_amount) AS total_revenue,
    ROUND(AVG(total_amount), 2) As avg_order_value,
    CASE
		WHEN SUM(total_amount) >= 60000 THEN 'High'
        ELSE 'Normal'
        END AS performance
FROM orders
GROUP BY month
ORDER BY month;

-- 6. Problem Statement
-- Employees table ko khud se LEFT JOIN karo (self join) — employee aur manager.
-- Har employee ke saath manager ka naam dikhao (agar manager nahi → 'No Manager').
-- CASE WHEN se salary_vs_manager: manager_id NULL → 'Head' |
--   e.salary >= m.salary → 'Equal or Higher' | else → 'Lower'
-- Output: employee, department, salary, manager, salary_vs_manager

SELECT
	a.name AS employee,
    a.department,
    a.salary,
    COALESCE(b.name, 'No Manager') AS manager_name,
	CASE
		WHEN a.manager_id IS NULL THEN 'Head'
        WHEN a.salary >= b.salary THEN 'Equal or Higher'
        ELSE 'Lower'
        END AS salary_vs_manager
FROM employees a 
LEFT JOIN employees b 
	ON a.manager_id = b.id;

-- 7. Problem Statement
-- Har city ka total revenue, order count, aur avg order nikalo.
-- Sirf top 3 cities dikhao (highest revenue wale).
-- Output: city, total_orders, total_revenue, avg_order — sorted by total_revenue DESC

SELECT
	c.city,
    COUNT(o.id) AS total_orders,
    SUM(o.total_amount) AS total_revenue,
    ROUND(AVG(o.total_amount), 2) AS avg_order
FROM customers c 
JOIN orders o 
	ON c.id = o.customer_id
GROUP BY c.city
ORDER BY total_revenue DESC
LIMIT 3;

-- 8. Problem Statement
-- Har order status (Delivered, Pending, Cancelled) ke liye count aur percentage nikalo.
-- Percentage = (count / total orders) * 100.
-- Output: status, count, percentage

SELECT 
	status,
    COUNT(*) AS order_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM orders), 2) AS percentage
FROM orders
GROUP BY status;

-- 9. Problem Statement
-- Har employee ke saath unke department ka average salary dikhao.
-- CASE WHEN se comparison: 'Above Average' | 'Below Average' | 'At Average'.
-- Output: name, department, salary, dept_avg_salary, vs_dept_avg — sorted by dept, salary DESC

SELECT 
    e.name,
    e.department,
    e.salary,
    ROUND(t.avg_salary, 2) AS dept_avg_salary,
    CASE 
        WHEN e.salary > t.avg_salary THEN 'Above Average'
        WHEN e.salary < t.avg_salary THEN 'Below Average'
        WHEN e.salary = t.avg_salary THEN 'At Average'
    END AS vs_dept_avg
FROM employees e
JOIN (
    SELECT department, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department
) t ON e.department = t.department
ORDER BY e.department, e.salary DESC;

-- 10. Problem Statement
-- Har product category mein sirf top revenue wala product dikhao.
-- RANK() window function se har category ke andar products rank karo by revenue.
-- Phir sirf rank = 1 wale rakhein.
-- Output: category, name, total_rev — sorted by total_rev DESC

SELECT category, name, total_rev
FROM (
  SELECT p.id, p.name, p.category,
    SUM(oi.quantity * oi.unit_price) AS total_rev,
    RANK() OVER (
				PARTITION BY p.category
					ORDER BY SUM(oi.quantity * oi.unit_price) DESC
				) AS rnk
	FROM products p
  LEFT JOIN order_items oi 
	ON p.id = oi.product_id
  GROUP BY p.id, p.name, p.category
) AS ranked
WHERE rnk = 1
ORDER BY total_rev DESC;
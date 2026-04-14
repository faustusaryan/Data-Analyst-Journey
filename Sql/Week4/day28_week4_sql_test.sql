USE analyst_practice;

-- TEST PROBLEM 1: Product analysis
-- Products ki list banao jinka price 1000 se zyada ho aur stock 100 se kam ho.
-- Show: name, category, price, stock. Sort by price descending.

SELECT
	name,
    category,
    price,
    stock
FROM products
WHERE price > 1000 AND stock < 100
ORDER BY price DESC;

-- TEST PROBLEM 2: Customer order analysis
-- Delhi ke customers ke liye Delivered orders show karo.
-- Show: customer name, order date, amount, status.

SELECT
	c.name,
    o.order_date,
    o.total_amount,
    o.status
FROM customers c 
JOIN orders o 
	ON c.id = o.customer_id
WHERE c.city = 'Delhi' AND o.status = 'Delivered';

-- TEST PROBLEM 3: Department salary aggregates
-- Har department ke liye: emp_count, avg_salary, max_salary, min_salary.
-- Sirf un departments ko show karo jahan avg_salary 50000 se zyada ho.

SELECT
	department,
    COUNT(*) AS emp_count,
	ROUND(AVG(salary), 2) AS avg_salary,
    MAX(salary) AS max_salary,
    MIN(salary) AS min_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 50000;
	

-- TEST PROBLEM 4: Customer spending with category
-- Har customer ka naam, total_spent, order_count dikhao.
-- CASE WHEN se customer_type assign karo: 50000+ = VIP, 5000+ = Regular, else Occasional.
-- Sort by total_spent descending.

SELECT
	c.name,
    SUM(o.total_amount) AS total_spent,
    COUNT(o.id) AS order_count,
    CASE
		WHEN SUM(o.total_amount) >= 50000 THEN 'VIP'
        WHEN SUM(o.total_amount) >= 5000 THEN 'Regular'
        ELSE 'Occasional' 
        END AS customer_type
FROM customers c 
JOIN orders o 
	ON c.id = o.customer_id
GROUP BY c.id, c.name
ORDER BY total_spent DESC;

-- TEST PROBLEM 5: Monthly performance
-- Month, total_orders, delivered_count, cancelled_count, total_revenue dikhao.
-- delivered_count aur cancelled_count ke liye SUM(CASE WHEN status = '...' THEN 1 ELSE 0 END) use karo.
-- HAVING se sirf un months ko include karo jahan total_revenue > 5000 ho.

SELECT 
	MONTH(order_date) AS month,
    COUNT(*) AS total_orders,
    COUNT(CASE WHEN status = 'Delivered' THEN 1 END) AS delivered_count,
    COUNT(CASE WHEN status = 'Cancelled' THEN 1 END) AS cancelled_count,
    SUM(total_amount) AS total_revenue
FROM orders
GROUP BY month
HAVING SUM(total_amount) > 5000;

-- TEST PROBLEM 6: Products never ordered
-- Products dikhao jinhe kabhi order nahi kiya gaya.

SELECT
	p.name,
    p.price
FROM products p
LEFT JOIN order_items oi
	ON p.id = oi.product_id
WHERE oi.order_id IS NULL;


-- TEST PROBLEM 7: Employee vs department average
-- Har employee ke liye: name, dept, salary, dept_avg (subquery se),
-- comparison: 'Above Average' / 'Below Average' / 'At Average'.

SELECT
	e.name,
    e.department,
    e.salary,
    ROUND(d.dept_avg, 2) AS dept_avg_salary,
    CASE 
		WHEN e.salary > d.dept_avg THEN 'Above Average'
        WHEN e.salary < d.dept_avg THEN 'Below Average'
		ELSE 'At Average'
		END AS salary_comparison
FROM employees e
JOIN (
	SELECT department,
		AVG(salary) AS dept_avg
	FROM employees
    GROUP BY department
) d
	ON e.department = d.department;

-- TEST PROBLEM 8: Top spending city
-- Sabse zyada total spending wali city ka naam aur total amount.
-- Agar tie ho toh koi bhi ek city return karo (LIMIT 1 use karo).

SELECT
	c.city,
    SUM(o.total_amount) AS total_spending
FROM customers c
JOIN orders o 
	ON c.id = o.customer_id
GROUP BY c.city
ORDER BY total_spending DESC
LIMIT 1;

-- TEST PROBLEM 9: Order status percentage
-- Delivered, Pending, Cancelled — count aur percentage dono.
-- Percentage ko ROUND(..., 2) se 2 decimal places tak dikhao.

SELECT 
	o.status, 
    COUNT(*) AS order_count,
    ROUND(COUNT(o.id)/(SELECT COUNT(*) FROM orders) *100, 2) AS percentage
FROM orders o
GROUP BY o.status;

-- TEST PROBLEM 10: Customer + product info
-- Customer name, city, product name, category, quantity, order status — 4 table join.

SELECT 
	c.name AS customer_name,
    c.city,
    p.name AS product_name,
    p.category,
    oi.quantity,
    o.status
FROM customers c
JOIN orders o 
	ON c.id = o.customer_id
JOIN order_items oi
	ON o.id = oi.order_id
JOIN products p
	ON oi.product_id = p.id;

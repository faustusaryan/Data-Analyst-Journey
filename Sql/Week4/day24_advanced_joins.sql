USE analyst_practice;

-- Q1: 4-Table JOIN — Customer + Order + OrderItem + Product

SELECT 
    o.id AS order_id,
    c.name AS customer_name,
    p.name AS product_name,
    oi.quantity
FROM customers c
JOIN orders o 
    ON c.id = o.customer_id
JOIN order_items oi
    ON o.id = oi.order_id
JOIN products p 
    ON oi.product_id = p.id;

-- Q2: Category-wise total revenue (order_items + products)

SELECT 
    p.category,
    SUM(oi.quantity * p.price) AS total_revenue
FROM products p
JOIN order_items oi 
    ON p.id = oi.product_id
GROUP BY p.category;

-- Q3: City-wise spending — only cities spending > 50000 (HAVING)

SELECT c.city,
	SUM(o.total_amount) AS total_spending
FROM customers c
JOIN orders o 
	ON c.id = o.customer_id
GROUP BY c.city
HAVING total_spending > 50000
ORDER BY total_spending DESC;

-- Q4: How many times each product was ordered? (LEFT JOIN + COUNT)

SELECT p.name,
	COUNT(oi.product_id) AS product_count
FROM products p 
LEFT JOIN order_items oi
	ON p.id = oi.product_id
GROUP BY p.name
ORDER BY product_count DESC;

-- Q5: Top 5 best-selling products by quantity

SELECT 
    p.name,
    SUM(oi.quantity) AS product_quantity
FROM products p 
LEFT JOIN order_items oi
    ON p.id = oi.product_id
GROUP BY p.name
ORDER BY product_quantity DESC
LIMIT 5;

-- Q6: Average order amount per customer — only avg > 5000 (HAVING)

SELECT c.name,
	ROUND(AVG(o.total_amount), 2) AS avg_amount
FROM customers c
JOIN orders o
	ON c.id = o.customer_id
GROUP BY c.name
HAVING AVG(o.total_amount) > 5000
ORDER BY avg_amount DESC;

-- Q7: Customers with more than 1 order (HAVING on COUNT)

SELECT 
	c.id,
    c.name,
	COUNT(o.id) AS order_count
FROM customers c 
JOIN orders o 
	ON c.id = o.customer_id
GROUP BY c.id, c.name
HAVING COUNT(o.id) > 1
ORDER BY order_count DESC;

-- Q8: Department salary summary (4 aggregates in one query)

SELECT 
	department,
    ROUND(AVG(salary), 2) AS avg_salary,
    MAX(salary) AS max_salary,
    MIN(salary) AS min_salary,
    SUM(salary) AS total_salary
FROM employees 
GROUP BY department
ORDER BY avg_salary DESC;

-- Q9: Find cities where customers have placed orders.
-- Show each city along with the count of unique customers 
-- who have made at least one order.

SELECT 
    c.city,
    COUNT(DISTINCT c.id) AS customer_count
FROM customers c 
JOIN orders o
    ON c.id = o.customer_id
GROUP BY c.city
ORDER BY customer_count DESC;

-- Q10: Products never ordered (LEFT JOIN + IS NULL)

SELECT 
	p.name
FROM products p
LEFT JOIN order_items oi
	ON p.id = oi.product_id
WHERE oi.product_id IS NULL;

-- Q11: For each customer, show:
-- total orders, total amount spent, and average order value.
-- Include customers with no orders.

SELECT 
    c.id,
    c.name,
    COUNT(o.id) AS total_orders,
    SUM(o.total_amount) AS total_spent,
    ROUND(AVG(o.total_amount), 2) AS avg_order_value
FROM customers c
LEFT JOIN orders o 
    ON c.id = o.customer_id
GROUP BY c.id, c.name;

-- Q12: Show month-wise total orders and total revenue for 2024.

SELECT 
	MONTH(order_date) AS months,
    COUNT(id) AS total_orders,
    SUM(total_amount) AS total_revenue
FROM orders
WHERE YEAR(order_date) = 2024
GROUP BY months;

-- Q13: Cancelled orders — which customers cancelled and how many times?

SELECT 
    c.id,
    c.name,
    COUNT(o.id) AS cancel_count
FROM customers c
JOIN orders o 
    ON c.id = o.customer_id
WHERE o.status = 'Cancelled'
GROUP BY c.id, c.name;

-- Q14: Which department has the highest total salary bill?

SELECT 
	department,
    SUM(salary) AS total_salary
FROM employees
GROUP BY department
ORDER BY total_salary DESC
LIMIT 1;

-- Q15: Employees who earn above their own department's average

SELECT 
    e.name,
    b.department,
    e.salary
FROM employees e
JOIN ( 
    SELECT department, AVG(salary) AS avg_salary
    FROM employees 
    GROUP BY department
) b 
    ON e.department = b.department
WHERE e.salary > b.avg_salary;

-- Q16: Product categories — avg price + count

SELECT 
	category,
    ROUND(AVG(price), 2) AS avg_price,
    COUNT(id) AS product_count
FROM products 
GROUP BY category;

-- Q17: Delhi customers with delivered orders

SELECT DISTINCT
    c.id,
    c.name,
    c.city
FROM customers c
JOIN orders o 
    ON c.id = o.customer_id
WHERE c.city = 'Delhi' 
AND o.status = 'Delivered';
    
-- Q18: For each month, show the number of unique products that were ordered.

SELECT 
    MONTH(o.order_date) AS month,
    COUNT(DISTINCT oi.product_id) AS product_count
FROM orders o
JOIN order_items oi 
    ON o.id = oi.order_id
GROUP BY MONTH(o.order_date)
ORDER BY month;

-- Q19: Cities ordered by average customer age

SELECT 
	city, 
    ROUND(AVG(age), 2) AS avg_age
FROM customers
GROUP BY city
ORDER BY avg_age DESC;

-- Q20: For each product, show:
-- 1. Total quantity sold
-- 2. Total revenue generated from that product

SELECT 
    p.name,
    SUM(oi.quantity) AS items_sold,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM products p
JOIN order_items oi
    ON p.id = oi.product_id
GROUP BY p.name
ORDER BY total_revenue DESC;
USE analyst_practice;

-- Q13–Q15  Self JOIN + 3-table JOIN

-- Q13: Har employee ke saath uske manager ka naam (Self JOIN)
-- Same table ko do baar use kar rahe hain — ek employee ki tarah, ek manager ki tarah

SELECT 
	a.id AS emp_id,
	a.name AS employee_name,
    b.name AS manager_name
FROM employees a
LEFT JOIN employees b
	ON a.manager_id = b.id;

-- Q14: Rajesh Kumar ke neeche kaam karne wale employees

SELECT 
    a.id AS emp_id,
    a.name AS employee_name
FROM employees a
JOIN employees b
    ON a.manager_id = b.id
WHERE b.name = 'Rajesh Kumar';

-- Q15: Teen tables ek saath: customer + order + product

SELECT 
    c.name AS customer_name,
    o.id AS order_id,
    p.name AS product_name
FROM customers c JOIN orders o 
    ON c.id = o.customer_id
JOIN order_items oi 
    ON o.id = oi.order_id
JOIN products p 
    ON oi.product_id = p.id; 

-- Q16: City-wise total revenue  (orders + customers, GROUP BY city)

SELECT c.city,
	SUM(o.total_amount) AS total_revenue
FROM customers c 
JOIN orders o 
	ON c.id = o.customer_id
GROUP BY c.city;

-- Q17: Category-wise total quantity sold  (order_items + products)

SELECT 
    p.category,
    SUM(oi.quantity) AS total_quantity_sold
FROM products p
LEFT JOIN order_items oi
    ON p.id = oi.product_id
GROUP BY p.category
ORDER BY total_quantity_sold DESC;    

-- Q18: Average order amount per city  (ROUND to 2 decimals)

SELECT c.city,
	ROUND(AVG(o.total_amount), 2) AS avg_order_amount
FROM customers c
LEFT JOIN orders o
ON c.id = o.customer_id
GROUP BY c.city
ORDER BY avg_order_amount DESC;

-- Q19: Cities with more than 2 orders  (HAVING)

SELECT 
    c.city,
    COUNT(o.id) AS order_count
FROM customers c
LEFT JOIN orders o 
    ON c.id = o.customer_id
GROUP BY c.city
HAVING COUNT(o.id) > 2
ORDER BY order_count DESC;

-- Q20: Top 3 cities by Delivered order revenue  (WHERE + HAVING? ORDER BY + LIMIT)

SELECT 
    c.city,
    SUM(o.total_amount) AS total_revenue
FROM customers c 
JOIN orders o 
    ON c.id = o.customer_id
WHERE o.status = 'Delivered'
GROUP BY c.city
ORDER BY total_revenue DESC
LIMIT 3;
















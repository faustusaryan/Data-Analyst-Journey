USE analyst_practice;

-- Q16  Customers jinhone January AND March 2024 dono mein orders kiye  [multiple WHERE IN subqueries]

SELECT name
FROM customers
WHERE id IN (
	SELECT customer_id
	FROM orders
    WHERE MONTH(order_date) = 1
		AND YEAR(order_date) = 2024
)
AND id IN (
	SELECT customer_id
	FROM orders
    WHERE MONTH(order_date) = 3
		AND YEAR(order_date) = 2024
);
 
-- Q17  Company mein second highest salary  [nested WHERE subquery]

SELECT 
    id,
    name
FROM employees
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
    WHERE salary < (
        SELECT MAX(salary)
        FROM employees
    )
); 

-- Q18  Products jo average se zyada baar ordered hain (nested subquery in HAVING)  
-- [nested FROM subquery in HAVING] 

SELECT 
	p.name, 
    COUNT(oi.id) AS times_ordered
FROM products p
JOIN order_items oi 
	ON p.id = oi.product_id
GROUP BY p.id, p.name
HAVING COUNT(oi.id) > (
    SELECT AVG(order_count) 
    FROM (
        SELECT COUNT(id) AS order_count
        FROM order_items
        GROUP BY product_id
    ) AS freq
);

-- Q19  Customers jinki total spending overall average customer spending se zyada hai  
-- [nested FROM subquery in HAVING] 

SELECT
    c.id,
    c.name,
    SUM(o.total_amount) AS total_spending
FROM customers c
JOIN orders o 
    ON c.id = o.customer_id
GROUP BY c.id, c.name
HAVING SUM(o.total_amount) > (
    SELECT AVG(total_spending)
    FROM (
        SELECT 
            customer_id,
            SUM(total_amount) AS total_spending
        FROM orders
        GROUP BY customer_id
    ) t
);

-- Q20  City with maximum total spending  [FROM subquery]

SELECT 
    city,
    total_spending
FROM (
    SELECT 
        c.city,
        SUM(o.total_amount) AS total_spending
    FROM customers c
    JOIN orders o 
        ON c.id = o.customer_id
    GROUP BY c.city
) t
ORDER BY total_spending DESC
LIMIT 1;

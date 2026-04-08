USE analyst_practice;

-- Q1  Customers jin hone at least ek order place kiya  [IN subquery]

SELECT 
	id, 
    name 
FROM customers
WHERE id IN (
	SELECT 
		customer_id
    FROM orders
);

-- Q2  Customers jinne KABHI koi order nahi kiya  [NOT IN subquery]

SELECT 
	id,
    name
FROM customers
WHERE id NOT IN (
	SELECT 
		customer_id
    FROM orders
);

-- Q3  Orders jinki amount average order amount se zyada hai  [scalar subquery]

SELECT 
	id,
    total_amount
FROM orders
WHERE total_amount > (
	SELECT 
		AVG(total_amount)
    FROM orders
);

-- Q4  Har category mein sabse expensive product  [IN + GROUP BY subquery]

SELECT 
	category,
    name 
FROM products
WHERE (category, price) IN (
	SELECT
        category,
        MAX(price)
	FROM products
    GROUP BY category
);

-- Q5  Employees jinki salary company average se zyada hai  [scalar subquery]

SELECT 
	id,
    name
FROM employees
WHERE salary > (
	SELECT 
		AVG(salary)
	FROM employees
);

-- Q6  Company mein sabse zyada salary wala employee  [scalar subquery]

SELECT 
	id,
    name 
FROM employees
WHERE salary = (
	SELECT 
		MAX(salary)
	FROM employees
);

-- Q7  Products jo Electronics category ke average price se mehenge hain  [scalar subquery with filter]

SELECT 
	id,
    name 
FROM products
WHERE price > (
	SELECT 
		AVG(price)
	FROM products
    WHERE category = 'Electronics'
);

-- Q8  Amit Sharma ke same city ke doosre customers  [scalar subquery]

SELECT
	id,
    name
FROM customers
WHERE city = (
	SELECT 
		city
	FROM customers
    WHERE name = 'Amit Sharma'
)
AND name <> 'Amit Sharma' ;

-- Q9  Departments jinki average salary 55000 se zyada hai  [FROM subquery]

SELECT 
	department
FROM (
	SELECT 
		department,
		AVG(salary) AS avg_salary
	FROM employees
    GROUP BY department
) t
WHERE t.avg_salary > 55000;

-- Q10  Top 3 customers by total spending  [FROM subquery]

SELECT 
	t.customer_id,
    c.name
FROM (
	SELECT 
		customer_id,
        SUM(total_amount) AS total_spending
	FROM orders
    GROUP BY customer_id
    ORDER BY total_spending DESC
    LIMIT 3
) t
JOIN customers c
	ON c.id = t.customer_id;

-- Q11  Highest revenue wala month  [FROM subquery]

SELECT
	t.month
FROM (
	SELECT 
		MONTH(order_date) AS month,
        SUM(total_amount) AS total_sale
	FROM orders
	GROUP BY MONTH(order_date) 
    ORDER BY total_sale DESC
    LIMIT 1
) t;

-- Q12  Products jinki stock average se zyada hai  [WHERE scalar subquery]

SELECT 
	id,
    name
FROM products
WHERE stock > (
	SELECT 
		AVG(stock)
	FROM products
);

-- Q13  Orders jo Mumbai ke customers ne place kiye  [WHERE IN subquery]

SELECT 
	id,
    total_amount
FROM orders
WHERE customer_id IN (
	SELECT 
		id
	FROM customers
    WHERE city = 'Mumbai'
)
ORDER BY id;

-- Q14  Har category mein sabse sasta product (correlated)  [correlated subquery]

SELECT 
    p.category,
    p.name
FROM products AS p
WHERE p.price = (
    SELECT 
        MIN(price)
    FROM products
    WHERE category = p.category
);

-- Q15  Departments jinke SAARE employees 40000 se zyada earn karte hain  [HAVING aggregate filter]

SELECT 
    department
FROM employees
GROUP BY department
HAVING MIN(salary) > 40000;
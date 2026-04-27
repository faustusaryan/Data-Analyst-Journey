USE analyst_practice;

-- Q1: Un customers ke naam aur city dikhao jinhonn kabhi koi order nahi diya.

SELECT 
	name,
    city
FROM customers 
WHERE id NOT IN 
(SELECT customer_id FROM orders);

-- Q2: Woh saare orders dikhao jinka total_amount, saare orders ke average amount se zyada ho. 
-- Order id aur amount dono dikhao.

SELECT 
	id,
    total_amount
FROM orders
WHERE total_amount > (SELECT AVG(total_amount) FROM orders)
ORDER BY id; 

-- Q3: Har department mein sabse zyada salary wale employee ka naam, department aur salary dikhao.

SELECT 
	name,
    department,
    salary
FROM employees 
WHERE salary IN
(SELECT salary FROM
(SELECT
    department,
    MAX(salary) AS salary
FROM employees
GROUP BY department) T);

-- Q4: Sirf Mumbai ke customers ke orders dikhao. Order id, amount aur status dikhao.

SELECT 
	id,
    total_amount,
    status
FROM orders
WHERE customer_id IN 
(SELECT 
	id
FROM customers
WHERE city = 'Mumbai')
ORDER BY id;


-- Q5: Woh products dikhao jo kabhi kisi order mein nahi the. Product name aur category dikhao.

SELECT
	name,
    category
FROM products
WHERE id NOT IN (SELECT product_id FROM order_items);

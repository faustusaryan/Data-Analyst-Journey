USE analyst_practice;

-- Problem Statement
-- Orders table mein total_amount ke basis pe har order ko ek category do:
--   20000+  → 'Premium'   |   5000–19999 → 'High'
--   1000–4999 → 'Medium'  |   below 1000 → 'Low'
-- Output: order id, amount, aur category column.

SELECT 
	id,
    total_amount,
    CASE
		WHEN total_amount >= 20000 THEN 'Premium'
        WHEN total_amount >= 5000 THEN 'High'
        WHEN total_amount >= 1000 THEN 'Medium'
        ELSE 'Low'
        END AS customer_category
FROM orders;

-- Problem Statement
-- Employees table mein salary ke basis pe level assign karo:
--   70000+  → 'Senior'   |   50000–69999 → 'Mid'   |   below 50000 → 'Junior'
-- Output: name, department, salary, level.

SELECT
	name,
    department,
    salary,
    CASE
		WHEN salary >= 70000 THEN 'Senior'
        WHEN salary >= 50000 THEN 'Mid'
        ELSE 'Junior'
        END AS `level`
FROM employees;
	
-- Problem Statement
-- Products table mein stock ke basis pe status assign karo:
--   0         → 'Out of Stock'    |   1–50   → 'Low Stock'
--   51–150    → 'Medium Stock'    |   150+   → 'Well Stocked'
-- Output: name, category, stock, stock_status.

SELECT
	name,
    category,
    stock,
    CASE
		WHEN stock = 0 THEN 'Out of Stock'
        WHEN stock <= 50 THEN 'Low Stock'
        WHEN stock <= 150 THEN 'Medium Stock'
        ELSE 'Well Stocked'
		END AS stock_status
FROM products;

-- Problem Statement
-- Q1 wali categorization use karo (Premium/High/Medium/Low).
-- Ab GROUP BY karke har category mein total orders count karo.
-- Output: order_category, count — sorted by count descending.

SELECT 
    CASE
		WHEN total_amount >= 20000 THEN 'Premium'
        WHEN total_amount >= 5000 THEN 'High'
        WHEN total_amount >= 1000 THEN 'Medium'
        ELSE 'Low'
        END AS order_category,
	COUNT(*) AS order_count
FROM orders
GROUP BY order_category
ORDER BY order_count DESC;

-- Problem Statement
-- Customers table mein age ke basis pe age group assign karo:
--   below 25 → '18-24'   |   25–29 → '25-29'
--   30–34    → '30-34'   |   35+   → '35+'
-- Output: name, city, age, age_group.

SELECT
    name,
    city,
    age,
    CASE
        WHEN age < 25  THEN '18-24'
        WHEN age < 30  THEN '25-29'
        WHEN age < 35  THEN '30-34'
        ELSE '35+'
    END AS age_group
FROM customers;

-- Problem Statement
-- Har city ke liye count karo: kitne customers under_25, 25_29, 30_34, aur 35_plus hain.
-- Sab ek hi row mein — city ke columns ke roop mein.
-- Output: city, under_25, age_25_29, age_30_34, age_35_plus.

SELECT
	city,
    COUNT(CASE WHEN age < 25 THEN 1 END) AS under_25,
    COUNT(CASE WHEN age >= 25 THEN 1 END) AS age_25_29,
    COUNT(CASE WHEN age >= 30 THEN 1 END) AS age_30_34,
    COUNT(CASE WHEN age >= 35 THEN 1 END) AS age_35_plus
FROM customers
GROUP BY city;
        
-- Problem Statement
-- Har month ki total revenue nikalo.
-- Agar revenue 60000 ya zyada ho → 'High', warna → 'Normal'.
-- Output: month, revenue, performance — sorted by month.

SELECT
    MONTH(order_date) AS `Month`,
    SUM(total_amount) AS revenue,
    CASE
        WHEN SUM(total_amount) >= 60000 THEN 'High'
        ELSE 'Normal'
    END AS performance
FROM orders
GROUP BY `Month`
ORDER BY `Month`;
	
-- Problem Statement
-- Delivered, Pending, aur Cancelled orders ki count ek hi row mein dikhao.
-- Plus total orders count bhi.
-- Output: delivered, pending, cancelled, total — sab ek row mein.

SELECT 
	COUNT(CASE WHEN status = 'Delivered' THEN 1 END) AS delivered,
    COUNT(CASE WHEN status = 'Pending' THEN 1 END) AS pending,
    COUNT(CASE WHEN status = 'Cancelled' THEN 1 END) AS cancelled,
    COUNT(*) AS total_order_count
FROM orders;

-- Problem Statement
-- Employees table mein do alag CASE WHEN columns add karo:
--   Column 1 (level): salary basis pe Senior / Mid / Junior
--   Column 2 (role_type): manager_id NULL hai → 'Manager', warna → 'Team Member'
-- Output: name, department, salary, level, role_type.

SELECT
	name,
    department,
    salary,
    CASE
		WHEN salary >= 70000 THEN 'Senior'
        WHEN salary >= 50000 THEN 'Mid'
        ELSE 'Junior'
        END AS emp_level,
	CASE 
		WHEN manager_id IS NULL THEN 'Manager'
        ELSE 'Team Member'
        END AS role_type
FROM employees;

-- Problem Statement
-- Har city ke liye count karo: total orders aur unme se premium orders (amount > 10000).
-- Customers table JOIN karo orders se city nikalne ke liye.
-- Output: city, premium_orders, total_orders.

SELECT 
	c.city,
    COUNT(CASE WHEN o.total_amount >= 10000 THEN 1 END) AS premium_orders,
    COUNT(*) AS total_orders
FROM customers c 
JOIN orders o 
	ON c.id = o.customer_id
GROUP BY c.city;

-- Problem Statement
-- Products table mein price ke basis pe tier assign karo:
--   10000+ → 'Expensive'   |   1000–9999 → 'Mid-range'   |   below 1000 → 'Budget'
-- Output: name, category, price, price_tier — sorted by price descending.

SELECT 
	name,
    category,
    price,
    CASE 
		WHEN price >= 10000 THEN 'Expensive'
        WHEN price >= 1000 THEN 'Mid-range'
        ELSE 'Budget'
        END AS price_tier
FROM products
ORDER BY price DESC;

-- Problem Statement
-- Har customer ka naam aur total spending nikalo (orders table se).
-- Spending ke basis pe type assign karo:
--   50000+ → 'VIP'   |   10000–49999 → 'Regular'   |   below 10000 → 'Occasional'
-- Output: name, total_spent, customer_type — sorted by total_spent descending.

SELECT
	c.name,
    SUM(o.total_amount) AS total_spent,
    CASE
		WHEN SUM(o.total_amount) >= 50000 THEN 'VIP'
        WHEN SUM(o.total_amount) >= 10000 THEN 'Regular'
        ELSE 'Occasional'
        END AS customer_type
FROM customers c 
JOIN orders o 
	ON c.id = o.customer_id
GROUP BY c.name
ORDER BY total_spent DESC;

-- Problem Statement
-- Har city ke liye nikalo: total orders, delivered count, aur delivery rate (%).
-- Delivery rate = (delivered / total) * 100.
-- Output: city, total_orders, delivered, delivery_rate.

SELECT
    c.city,
    COUNT(*) AS total_orders,
    COUNT(CASE WHEN o.status = 'Delivered' THEN 1 END) AS delivered,
    ROUND((COUNT(CASE WHEN o.status = 'Delivered' THEN 1 END) / COUNT(*)) * 100.0, 2) AS delivery_rate
FROM customers c
JOIN orders o
    ON c.id = o.customer_id
GROUP BY c.city;

-- Problem Statement
-- Employees table mein hire_date ke basis pe seniority assign karo:
--   Before 2020 → 'Senior (5+ years)'
--   2020–2021  → 'Mid (4-6 years)'
--   2022+      → 'Junior (0-4 years)'
-- Output: name, department, hire_date, seniority — sorted by hire_date.

SELECT
	name,
    department,
    hire_date,
    CASE 
		WHEN YEAR(hire_date) < 2020 THEN 'Senior (5+ years)'
        WHEN YEAR(hire_date) <= 2021 THEN 'Mid (4-6 years)'
        ELSE 'Junior (0-4 years)'
        END AS seniority
FROM employees
ORDER BY hire_date;

-- Problem Statement
-- Orders aur customers JOIN karo.
-- Har order ke liye flag assign karo: amount > 10000 → 'High Value', warna → 'Normal'.
-- Output: customer name, city, total_amount, status, order_flag — sorted by amount desc.

SELECT 
	c.name,
    c.city,
    o.total_amount,
    o.status,
    CASE 
		WHEN o.total_amount > 10000 THEN 'High Value'
        ELSE 'Normal'
        END AS order_flag
FROM customers c
JOIN orders o 
	ON c.id = o.customer_id
ORDER BY o.total_amount DESC;






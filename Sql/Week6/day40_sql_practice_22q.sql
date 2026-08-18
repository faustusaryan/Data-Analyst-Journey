/* -----------------------------
   1. DATABASE & TABLE CREATION
   ----------------------------- */

CREATE DATABASE IF NOT EXISTS company_db;
USE company_db;

DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;

CREATE TABLE departments (
    department_id   INT PRIMARY KEY,
    department_name VARCHAR(50)
);

CREATE TABLE employees (
    employee_id     INT PRIMARY KEY,
    first_name      VARCHAR(50),
    last_name       VARCHAR(50),
    department_id   INT,
    manager_id      INT,               -- for self-join practice
    salary          DECIMAL(10,2),
    hire_date       DATE,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE customers (
    customer_id     INT PRIMARY KEY,
    customer_name   VARCHAR(50),
    city            VARCHAR(50),
    country         VARCHAR(50),
    signup_date     DATE
);

CREATE TABLE products (
    product_id      INT PRIMARY KEY,
    product_name    VARCHAR(50),
    category        VARCHAR(50),
    price           DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id        INT PRIMARY KEY,
    customer_id     INT,
    employee_id     INT,               -- salesperson who handled the order
    order_date      DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

CREATE TABLE order_items (
    order_item_id   INT PRIMARY KEY,
    order_id        INT,
    product_id      INT,
    quantity        INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


/* -----------------------------
   2. SAMPLE DATA
   ----------------------------- */

INSERT INTO departments VALUES
(1, 'Sales'),
(2, 'Marketing'),
(3, 'IT'),
(4, 'HR'),
(5, 'Finance');

INSERT INTO employees VALUES
(101, 'Aarav', 'Sharma', 1, NULL, 55000, '2021-03-15'),
(102, 'Priya', 'Verma', 1, 101, 42000, '2022-01-10'),
(103, 'Rohan', 'Gupta', 1, 101, 39000, '2022-06-01'),
(104, 'Ishaan', 'Mehta', 2, NULL, 48000, '2020-11-20'),
(105, 'Kavya', 'Singh', 2, 104, 36000, '2023-02-14'),
(106, 'Ananya', 'Rao', 3, NULL, 62000, '2019-07-01'),
(107, 'Vivaan', 'Nair', 3, 106, 47000, '2021-09-05'),
(108, 'Diya', 'Iyer', 4, NULL, 40000, '2020-05-18'),
(109, 'Kabir', 'Joshi', 5, NULL, 58000, '2018-12-01'),
(110, 'Meera', 'Kapoor', 5, 109, 41000, '2022-08-23');

INSERT INTO customers VALUES
(201, 'Rahul Traders', 'Mumbai', 'India', '2021-01-05'),
(202, 'Global Foods', 'Delhi', 'India', '2020-11-11'),
(203, 'Sunrise Retail', 'Bangalore', 'India', '2022-03-19'),
(204, 'BlueSky Corp', 'New York', 'USA', '2021-07-22'),
(205, 'North Star Ltd', 'London', 'UK', '2019-05-30'),
(206, 'Metro Mart', 'Chennai', 'India', '2023-01-15'),
(207, 'Pacific Traders', 'Sydney', 'Australia', '2022-09-09'),
(208, 'Green Valley', 'Toronto', 'Canada', '2020-02-28');

INSERT INTO products VALUES
(301, 'Laptop', 'Electronics', 55000),
(302, 'Smartphone', 'Electronics', 25000),
(303, 'Office Chair', 'Furniture', 6000),
(304, 'Desk', 'Furniture', 9000),
(305, 'Notebook Pack', 'Stationery', 300),
(306, 'Pen Set', 'Stationery', 150),
(307, 'Monitor', 'Electronics', 12000),
(308, 'Bookshelf', 'Furniture', 7500);

INSERT INTO orders VALUES
(1001, 201, 102, '2023-01-10'),
(1002, 202, 103, '2023-01-15'),
(1003, 203, 102, '2023-02-01'),
(1004, 204, 101, '2023-02-10'),
(1005, 205, 103, '2023-02-25'),
(1006, 201, 102, '2023-03-05'),
(1007, 206, 101, '2023-03-12'),
(1008, 207, 103, '2023-03-20'),
(1009, 208, 102, '2023-04-01'),
(1010, 202, 101, '2023-04-15'),
(1011, 203, 103, '2023-05-02'),
(1012, 204, 102, '2023-05-18');

INSERT INTO order_items VALUES
(1, 1001, 301, 2),
(2, 1001, 305, 5),
(3, 1002, 303, 4),
(4, 1003, 302, 1),
(5, 1003, 306, 10),
(6, 1004, 307, 3),
(7, 1005, 304, 2),
(8, 1006, 301, 1),
(9, 1007, 308, 2),
(10, 1008, 302, 2),
(11, 1009, 305, 8),
(12, 1010, 303, 3),
(13, 1011, 307, 1),
(14, 1012, 301, 1),
(15, 1012, 302, 1);


-- ===== SECTION A: SELECT, WHERE, ORDER BY, Aggregates, GROUP BY/HAVING (Q1-15) =====

-- Q1 (Easy): List all employees' first name, last name, and salary.

SELECT
	first_name,
    last_name,
    salary
FROM employees;

-- Q2 (Easy): List all customers from India.

SELECT *
FROM customers
WHERE country = 'India';

-- Q3 (Easy): Show all products priced above 10000, ordered by price descending.

SELECT *
FROM products
WHERE price > 10000
ORDER BY price DESC;

-- Q4 (Easy): Find all employees hired after '2021-01-01'.

SELECT *
FROM employees
WHERE hire_date > '2021-01-01';

-- Q5 (Easy): List distinct cities present in the customers table.

SELECT
	DISTINCT city
FROM customers;

-- Q6 (Easy-Medium): Count the total number of employees in each department.

SELECT 
	department_id,
    COUNT(employee_id) AS emp_count
FROM employees
GROUP BY department_id;
	
-- Q7 (Easy-Medium): Find the average salary of employees in each department.

SELECT 
	department_id,
    AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id;

-- Q8 (Medium): List departments having more than 2 employees.

SELECT
	department_id,
    COUNT(employee_id) AS emp_count
FROM employees
GROUP BY department_id
HAVING emp_count > 2;

-- Q9 (Medium): Find the total quantity of each product sold (from order_items).

SELECT
	product_id,
    SUM(quantity) AS total_qty
FROM order_items
GROUP BY product_id;

-- Q10 (Medium): Find the highest and lowest priced product in each category.

SELECT 
	category, 
	MIN(price) AS min_price,
    MAX(price) AS max_price
FROM products
GROUP BY category;

-- Q11 (Medium): List customers whose name contains the word 'Traders'.

SELECT *
FROM customers
WHERE customer_name LIKE '%Traders%';

-- Q12 (Medium): Find employees whose salary is between 40000 and 55000.

SELECT *
FROM employees
WHERE salary BETWEEN 40000 AND 55000;

-- Q13 (Medium): Find the number of orders placed each month in 2023.

SELECT
	MONTH(order_date) `month`,
	COUNT(order_id) AS total_orders
FROM orders
WHERE YEAR(order_date) = 2023
GROUP BY MONTH(order_date);

-- Q14 (Medium-Hard): Find departments where the average salary is above 45000.

SELECT  
	department_id,
    AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id
HAVING AVG(salary) > 45000;

-- Q15 (Medium-Hard): Find products that have never appeared in any order_items row
--                     (use aggregate/GROUP BY approach, not a subquery).

SELECT
	p.product_id,
    p.product_name
FROM products p
LEFT JOIN order_items oi
	ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
HAVING COUNT(oi.order_item_id) = 0;

-- ===== SECTION B: JOINS - inner, left, right, full, self (Q16-22) =====

-- Q16 (Easy): Show each employee's name along with their department name (inner join).

SELECT
	e.first_name,
    e.last_name,
    d.department_name
FROM employees e
JOIN departments d 
	ON e.department_id = d.department_id;

-- Q17 (Easy): Show each order along with the customer name who placed it.

SELECT
	c.customer_name,
    o.order_id
FROM customers c
JOIN orders o 
	ON c.customer_id = o.customer_id;

-- Q18 (Easy-Medium): Show each order_item along with the product name and quantity.

SELECT
	oi.order_item_id,
    p.product_name,
    oi.quantity
FROM order_items oi 
JOIN products p 
	ON oi.product_id = p.product_id;

-- Q19 (Medium): List all employees and the department name, including employees
--               with no department assigned (left join).

SELECT
	e.employee_id,
    d.department_name
FROM employees e
LEFT JOIN departments d 
	ON e.department_id = d.department_id;

-- Q20 (Medium): List all departments and their employees, including departments
--               with zero employees (left join, opposite direction of Q19).

SELECT 
	d.department_name,
    e.employee_id
FROM departments d
LEFT JOIN employees e
	ON d.department_id = e.department_id;

-- Q21 (Medium): Simulate a RIGHT JOIN between employees and departments
--               (return all departments even if they have no employees),
--               without using the RIGHT JOIN keyword (for DBs that don't support it).

SELECT
	d.*,
    e.*
FROM departments d 
LEFT JOIN employees e
	ON d.department_id = e.department_id;

-- Q22 (Medium): Perform a FULL OUTER JOIN between employees and departments
--               to show unmatched rows from both sides (or simulate it using
--               UNION of LEFT and RIGHT joins if your DB doesn't support FULL).

SELECT 
	e.*,
    d.*
FROM employees e
LEFT JOIN departments d
	ON e.department_id = d.department_id 
UNION
SELECT
	e.*,
    d.*
FROM employees e
RIGHT JOIN departments d 
	ON e.department_id = d.department_id;

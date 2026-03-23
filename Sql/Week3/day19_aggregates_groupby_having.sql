DROP DATABASE IF EXISTS da_practice;
CREATE DATABASE da_practice;
USE da_practice;
 
-- TABLE 1: departments
CREATE TABLE departments (
    dept_id   INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL,
    location  VARCHAR(50),
    budget    DECIMAL(12,2)
);
INSERT INTO departments VALUES
(1, 'Engineering', 'Bangalore',  5000000.00),
(2, 'Marketing',   'Mumbai',     3000000.00),
(3, 'HR',          'Delhi',      1500000.00),
(4, 'Sales',       'Hyderabad',  4000000.00),
(5, 'Finance',     'Pune',       2500000.00);
 
-- TABLE 2: employees
CREATE TABLE employees (
    emp_id     INT PRIMARY KEY,
    name       VARCHAR(50) NOT NULL,
    dept_id    INT,
    salary     DECIMAL(10,2),
    hire_date  DATE,
    manager_id INT,
    city       VARCHAR(50),
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);
INSERT INTO employees VALUES
(1,  'Aarav',   1, 75000, '2021-03-15', NULL,  'Bangalore'),
(2,  'Priya',   2, 55000, '2022-07-01', 7,     'Mumbai'),
(3,  'Rahul',   1, 82000, '2020-11-20', 1,     'Bangalore'),
(4,  'Sneha',   3, NULL,  '2023-01-10', 8,     'Delhi'),
(5,  'Vikram',  2, 62000, '2019-08-05', 7,     'Mumbai'),
(6,  'Divya',   1, 70000, '2022-06-15', 1,     'Bangalore'),
(7,  'Karan',   2, 90000, '2018-04-01', NULL,  'Mumbai'),
(8,  'Neha',    3, 52000, '2021-09-01', NULL,  'Delhi'),
(9,  'Amit',    4, 68000, '2022-02-20', 10,    'Hyderabad'),
(10, 'Ritu',    4, 95000, '2017-11-30', NULL,  'Hyderabad'),
(11, 'Suresh',  5, 78000, '2020-05-10', NULL,  'Pune'),
(12, 'Meera',   5, 61000, '2023-03-22', 11,    'Pune'),
(13, 'Arjun',   1, 88000, '2019-07-14', 1,     'Bangalore'),
(14, 'Pooja',   3, 49000, '2023-08-01', 8,     'Delhi'),
(15, 'Nitin',   4, 71000, '2021-12-05', 10,    'Hyderabad');
 
-- TABLE 3: customers
CREATE TABLE customers (
    cust_id   INT PRIMARY KEY,
    name      VARCHAR(50) NOT NULL,
    city      VARCHAR(50),
    country   VARCHAR(50),
    join_date DATE
);
INSERT INTO customers VALUES
(1,  'Rajesh Kumar',    'Mumbai',    'India',     '2020-01-15'),
(2,  'Anita Singh',     'Delhi',     'India',     '2020-03-22'),
(3,  'David Lee',       'New York',  'USA',       '2019-11-10'),
(4,  'Sarah Johnson',   'London',    'UK',        '2021-06-05'),
(5,  'Mohammed Ali',    'Dubai',     'UAE',       '2020-08-14'),
(6,  'Preethi Nair',    'Chennai',   'India',     '2022-02-28'),
(7,  'James Wilson',    'Sydney',    'Australia', '2021-09-17'),
(8,  'Kavya Reddy',     'Hyderabad', 'India',     '2019-12-03'),
(9,  'Chen Wei',        'Shanghai',  'China',     '2022-05-11'),
(10, 'Fatima Hassan',   'Cairo',     'Egypt',     '2020-07-29');
 
-- TABLE 4: products
CREATE TABLE products (
    prod_id   INT PRIMARY KEY,
    prod_name VARCHAR(100) NOT NULL,
    category  VARCHAR(50),
    price     DECIMAL(10,2),
    stock     INT
);
INSERT INTO products VALUES
(1,  'Laptop Pro 15',    'Electronics', 75000.00, 50),
(2,  'Wireless Mouse',   'Electronics', 1500.00,  200),
(3,  'Office Chair',     'Furniture',   12000.00, 30),
(4,  'Standing Desk',    'Furniture',   25000.00, 15),
(5,  'Python Book',      'Books',       599.00,   100),
(6,  'SQL Guide',        'Books',       499.00,   80),
(7,  'Mechanical KB',    'Electronics', 3500.00,  75),
(8,  'Monitor 27"',      'Electronics', 22000.00, 40),
(9,  'Noise Cancelling Headphones', 'Electronics', 8500.00, 60),
(10, 'Ergonomic Mouse',  'Electronics', 2200.00,  90);
 
-- TABLE 5: orders
CREATE TABLE orders (
    order_id   INT PRIMARY KEY,
    cust_id    INT,
    prod_id    INT,
    quantity   INT,
    amount     DECIMAL(10,2),
    order_date DATE,
    status     VARCHAR(20),
    FOREIGN KEY (cust_id) REFERENCES customers(cust_id),
    FOREIGN KEY (prod_id) REFERENCES products(prod_id)
);
INSERT INTO orders VALUES
(1,  1, 1,  1, 75000.00, '2024-01-05', 'Delivered'),
(2,  2, 2,  2,  3000.00, '2024-01-12', 'Delivered'),
(3,  3, 8,  1, 22000.00, '2024-01-20', 'Delivered'),
(4,  1, 5,  3,  1797.00, '2024-02-03', 'Delivered'),
(5,  4, 3,  1, 12000.00, '2024-02-14', 'Shipped'),
(6,  5, 1,  1, 75000.00, '2024-02-18', 'Delivered'),
(7,  2, 7,  1,  3500.00, '2024-02-25', 'Delivered'),
(8,  6, 9,  1,  8500.00, '2024-03-01', 'Delivered'),
(9,  3, 4,  1, 25000.00, '2024-03-08', 'Shipped'),
(10, 7, 2,  3,  4500.00, '2024-03-10', 'Delivered'),
(11, 8, 1,  1, 75000.00, '2024-03-15', 'Cancelled'),
(12, 1, 6,  2,   998.00, '2024-03-20', 'Delivered'),
(13, 9, 8,  2, 44000.00, '2024-03-22', 'Shipped'),
(14, 5, 7,  2,  7000.00, '2024-03-25', 'Delivered'),
(15, 10,10, 1,  2200.00, '2024-03-28', 'Delivered'),
(16, 2, 1,  1, 75000.00, '2024-04-02', 'Delivered'),
(17, 4, 9,  2, 17000.00, '2024-04-05', 'Shipped'),
(18, 6, 3,  2, 24000.00, '2024-04-10', 'Delivered'),
(19, 8, 5,  5,  2995.00, '2024-04-12', 'Delivered'),
(20, 1, 8,  1, 22000.00, '2024-04-15', 'Delivered');


-- SECTION 2 — Aggregates, GROUP BY, HAVING

-- Q09  COUNT, SUM, AVG, MIN, MAX
-- Task:- employees table ka overall summary nikalo: total employees, non-null salaries count, average salary, min salary, 
-- max salary, total salary bill.

SELECT COUNT(emp_id) AS total_emp,
	COUNT(salary) AS non_null,
    ROUND(AVG(salary), 2) AS avg_salary,
    MIN(salary) AS min_salary,
    MAX(salary) AS max_salary,
    SUM(salary) AS total_salary_bill
FROM employees;

-- Q10  GROUP BY — Aggregate per Group
-- Task:- Har department mein kitne employees hain, average salary kya hai, aur total salary bill kya hai. 
-- Result mein dept_id ke saath dept_name bhi dikhao.

SELECT e.dept_id, d.dept_name, 
	COUNT(e.emp_id) AS total_emp, 
	ROUND(AVG(e.salary), 2) AS avg_salary, 
    SUM(e.salary) AS total_salary_bill
FROM departments d 
JOIN employees e
	ON d.dept_id = e.dept_id
GROUP BY e.dept_id, d.dept_name;

-- Q11  HAVING — Filter After Grouping
-- Task:- Sirf un departments ko dikhao jahan average salary 70000 se zyada hai aur minimum 2 employees hain.

SELECT d.dept_name, 
	ROUND(AVG(e.salary), 2) AS avg_salary,
	COUNT(e.emp_id) AS employee_count
FROM departments d 
JOIN employees e
	ON d.dept_id = e.dept_id
GROUP BY d.dept_name
HAVING avg_salary > 70000 AND employee_count >= 2;

-- Q12  GROUP BY Multiple Columns
-- Task:- Har month mein kitne orders aaye aur total revenue kya tha? Month aur year dono dikhao. 
-- Sirf 'Delivered' status wale orders count karo.

SELECT YEAR(order_date) AS order_year,
	MONTH(order_date) AS order_month,
    COUNT(order_id) AS order_count,
    SUM(amount) AS total_revenue
FROM orders
WHERE status = 'Delivered'
GROUP BY YEAR(order_date), MONTH(order_date);

-- Q13  ORDER BY with Aggregates + HAVING Combined
-- Task:- Sabse zyada shopping karne wale top 3 customers dhundho jo at least 2 orders de chuke hain. Unka naam, 
-- total orders, total spend dikhao

SELECT c.name, 
	COUNT(o.order_id) AS total_orders,
    SUM(o.amount) AS total_spending
FROM customers c
JOIN orders o 
	ON c.cust_id = o.cust_id
GROUP BY c.name
HAVING total_orders >=2
ORDER BY SUM(o.amount) DESC
LIMIT 3;
















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

### SECTION 1 — SELECT, WHERE, ORDER BY, LIMIT

-- Q01  Select All Employees 
-- Task: employees table se sabhi employees ke naam aur salary fetch karo. Salary ke hisab se descending order mein dikhao.
 
SELECT name, salary
FROM employees
ORDER BY salary DESC;

-- Q02  Filter with WHERE — Single Condition
-- Task: Sirf un employees ko dikhao jo Engineering department (dept_id = 1) mein hain.

SELECT emp_id, name, salary 
FROM employees
WHERE dept_id = 1;

-- Q03  Filter with AND, OR, NOT
-- Task: Employees jo Engineering (dept_id=1) YA Marketing (dept_id=2) mein hain AUR jinki salary 70000 se zyada hai.

SELECT name, dept_id, salary
FROM employees
WHERE (dept_id = 1 OR dept_id = 2)
	AND salary > 70000;

-- Q04  IN, NOT IN, BETWEEN
-- Task:- (1) Employees whose dept_id is IN (1, 3, 5).

SELECT name, dept_id
FROM employees
WHERE dept_id in (1, 3, 5);

-- (2) Employees with salary BETWEEN 60000 AND 80000.

SELECT name, salary
FROM employees
WHERE salary BETWEEN 60000 AND 80000;

-- Q05  NULL Handling — IS NULL, IS NOT NULL
-- Task:- (1) Salary NULL wale employees dhundho.

SELECT emp_id, name
FROM employees
WHERE salary IS NULL;

-- (2) Manager nahi hai (manager_id IS NULL) wale employees dhundho — ye top-level managers hain.

SELECT emp_id, name
FROM employees
WHERE manager_id  IS NULL;

-- Q06  LIKE — Pattern Matching
-- Task:- (1) employees mein jinke naam 'A' se start hote hain. 

SELECT name
FROM employees
WHERE name LIKE 'A%';

-- (2) customers mein jinke naam mein 'Singh' hai. 

SELECT name
FROM customers
WHERE name LIKE '%Singh%';

-- (3) employees mein jinke naam exactly 5 characters ke hain.

SELECT name 
FROM employees
WHERE name Like '_____';

-- Q07  DISTINCT — Remove Duplicates
-- Task:- (1) employees table mein sabhi unique cities list karo. 

SELECT DISTINCT city 
FROM employees;

-- (2) orders table mein sabhi unique statuses. 

SELECT DISTINCT status
FROM orders;

-- (3) Count karo kitne distinct cities hain.

SELECT COUNT(DISTINCT city) AS city_count
FROM employees;

-- Q08  LIMIT and OFFSET — Pagination
-- Task:- (1) Top 5 highest paid employees. 

SELECT name, salary
FROM employees
ORDER BY salary DESC 
LIMIT 5;

-- (2) 6th to 10th highest paid employees (pagination — page 2 of results).

SELECT name, salary
FROM employees
ORDER BY salary DESC
LIMIT 5 OFFSET 5;















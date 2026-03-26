CREATE DATABASE IF NOT EXISTS analyst_practice;
USE analyst_practice;

-- CUSTOMERS TABLE
CREATE TABLE customers (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50),
    age INT,
    email VARCHAR(100)
);

INSERT INTO customers VALUES
(1, 'Amit Sharma', 'Delhi', 28, 'amit@email.com'),
(2, 'Priya Singh', 'Mumbai', 34, 'priya@email.com'),
(3, 'Rahul Verma', 'Bangalore', 25, 'rahul@email.com'),
(4, 'Sneha Gupta', 'Delhi', 30, 'sneha@email.com'),
(5, 'Vikram Patel', 'Ahmedabad', 22, 'vikram@email.com'),
(6, 'Kavya Nair', 'Chennai', 27, 'kavya@email.com'),
(7, 'Arjun Mehta', 'Mumbai', 35, 'arjun@email.com'),
(8, 'Deepika Joshi', 'Pune', 29, 'deepika@email.com'),
(9, 'Rohan Das', 'Kolkata', 31, 'rohan@email.com'),
(10, 'Ananya Roy', 'Delhi', 26, 'ananya@email.com'),
(11, 'Manish Tiwari', 'Lucknow', 33, 'manish@email.com'),
(12, 'Ritu Agarwal', 'Jaipur', 24, 'ritu@email.com'),
(13, 'Sanjay Kumar', 'Hyderabad', 38, 'sanjay@email.com'),
(14, 'Pooja Mishra', 'Bangalore', 27, 'pooja@email.com'),
(15, 'Nitin Yadav', 'Noida', 23, 'nitin@email.com');

-- PRODUCTS TABLE
CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock INT
);

INSERT INTO products VALUES
(1, 'Laptop', 'Electronics', 55000.00, 50),
(2, 'Mouse', 'Electronics', 500.00, 200),
(3, 'Keyboard', 'Electronics', 800.00, 150),
(4, 'T-Shirt', 'Clothing', 400.00, 500),
(5, 'Jeans', 'Clothing', 1200.00, 300),
(6, 'Notebook', 'Stationery', 80.00, 1000),
(7, 'Pen Set', 'Stationery', 120.00, 800),
(8, 'Headphones', 'Electronics', 3500.00, 80),
(9, 'Backpack', 'Accessories', 1500.00, 120),
(10, 'Water Bottle', 'Accessories', 300.00, 400),
(11, 'Monitor', 'Electronics', 18000.00, 30),
(12, 'Shoes', 'Clothing', 2500.00, 200),
(13, 'Desk Lamp', 'Electronics', 1200.00, 90),
(14, 'Diary', 'Stationery', 150.00, 600),
(15, 'Phone Stand', 'Accessories', 250.00, 350);

-- ORDERS TABLE
CREATE TABLE orders (
    id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

INSERT INTO orders VALUES
(1, 1, '2024-01-05', 55500.00, 'Delivered'),
(2, 2, '2024-01-12', 3500.00, 'Delivered'),
(3, 3, '2024-01-18', 800.00, 'Delivered'),
(4, 4, '2024-02-02', 1600.00, 'Delivered'),
(5, 5, '2024-02-14', 500.00, 'Cancelled'),
(6, 6, '2024-02-20', 4300.00, 'Delivered'),
(7, 7, '2024-03-01', 1200.00, 'Pending'),
(8, 8, '2024-03-08', 18000.00, 'Delivered'),
(9, 1, '2024-03-15', 800.00, 'Delivered'),
(10, 2, '2024-03-22', 1200.00, 'Cancelled'),
(11, 9, '2024-04-03', 2500.00, 'Delivered'),
(12, 10, '2024-04-10', 55000.00, 'Delivered'),
(13, 3, '2024-04-18', 300.00, 'Delivered'),
(14, 11, '2024-05-05', 1500.00, 'Delivered'),
(15, 12, '2024-05-12', 400.00, 'Pending'),
(16, 4, '2024-05-20', 18800.00, 'Delivered'),
(17, 13, '2024-06-02', 120.00, 'Delivered'),
(18, 14, '2024-06-11', 3800.00, 'Delivered'),
(19, 6, '2024-06-18', 250.00, 'Cancelled'),
(20, 1, '2024-07-01', 2500.00, 'Delivered'),
(21, 15, '2024-07-08', 800.00, 'Delivered'),
(22, 5, '2024-07-15', 1200.00, 'Delivered'),
(23, 7, '2024-08-03', 55000.00, 'Delivered'),
(24, 8, '2024-08-10', 500.00, 'Delivered'),
(25, 9, '2024-09-05', 4000.00, 'Pending'),
(26, 10, '2024-09-12', 1500.00, 'Delivered'),
(27, 11, '2024-10-01', 300.00, 'Delivered'),
(28, 13, '2024-10-14', 800.00, 'Cancelled'),
(29, 2, '2024-11-02', 18000.00, 'Delivered'),
(30, 14, '2024-11-20', 1200.00, 'Delivered');

-- ORDER_ITEMS TABLE
CREATE TABLE order_items (
    id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

INSERT INTO order_items VALUES
(1, 1, 1, 1, 55000.00),
(2, 1, 2, 1, 500.00),
(3, 2, 8, 1, 3500.00),
(4, 3, 3, 1, 800.00),
(5, 4, 4, 2, 400.00),
(6, 4, 7, 2, 120.00),
(7, 4, 10, 2, 300.00),
(8, 5, 2, 1, 500.00),
(9, 6, 8, 1, 3500.00),
(10, 6, 9, 1, 500.00),  -- adjusted
(11, 7, 5, 1, 1200.00),
(12, 8, 11, 1, 18000.00),
(13, 9, 3, 1, 800.00),
(14, 10, 5, 1, 1200.00),
(15, 11, 12, 1, 2500.00),
(16, 12, 1, 1, 55000.00),
(17, 13, 10, 1, 300.00),
(18, 14, 9, 1, 1500.00),
(19, 15, 4, 1, 400.00),
(20, 16, 11, 1, 18000.00),
(21, 16, 2, 1, 500.00),
(22, 16, 10, 1, 300.00),
(23, 17, 7, 1, 120.00),
(24, 18, 8, 1, 3500.00),
(25, 18, 10, 1, 300.00),
(26, 19, 15, 1, 250.00),
(27, 20, 12, 1, 2500.00),
(28, 21, 3, 1, 800.00),
(29, 22, 5, 1, 1200.00),
(30, 23, 1, 1, 55000.00);

-- EMPLOYEES TABLE
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(50),
    salary INT,
    hire_date DATE,
    city VARCHAR(50),
    manager_id INT
);

INSERT INTO employees VALUES
(1, 'Rajesh Kumar', 'IT', 75000, '2020-03-15', 'Delhi', NULL),
(2, 'Sunita Sharma', 'HR', 55000, '2019-07-01', 'Mumbai', NULL),
(3, 'Aakash Singh', 'IT', 60000, '2021-01-10', 'Delhi', 1),
(4, 'Meena Patel', 'Finance', 80000, '2018-05-20', 'Ahmedabad', NULL),
(5, 'Deepak Verma', 'IT', 45000, '2022-08-01', 'Bangalore', 1),
(6, 'Prerna Gupta', 'HR', 42000, '2022-03-15', 'Delhi', 2),
(7, 'Ankit Rao', 'Marketing', 50000, '2021-06-01', 'Mumbai', NULL),
(8, 'Kavita Joshi', 'Finance', 72000, '2020-09-10', 'Pune', 4),
(9, 'Suresh Nair', 'Marketing', 38000, '2023-01-15', 'Chennai', 7),
(10, 'Pooja Tiwari', 'IT', 68000, '2020-12-01', 'Noida', 1),
(11, 'Ravi Agarwal', 'Finance', 55000, '2021-04-20', 'Jaipur', 4),
(12, 'Nisha Das', 'HR', 48000, '2021-11-05', 'Kolkata', 2),
(13, 'Mohit Yadav', 'Marketing', 44000, '2022-07-18', 'Hyderabad', 7),
(14, 'Shruti Mishra', 'IT', 52000, '2022-02-28', 'Bangalore', 1),
(15, 'Vikas Roy', 'Finance', 65000, '2019-11-12', 'Delhi', 4);


-- Q1: Show all customers

SELECT * 
FROM customers;

-- Q2: Show customers from Delhi only

SELECT * 
FROM customers
WHERE city = 'Delhi';

-- Q3: Show customers older than 30

SELECT * 
FROM customers
WHERE age > 30;

-- Q4: Show customers from Mumbai or Bangalore sorted by name

SELECT *
FROM customers
WHERE city = 'Mumbai' 
	OR city = 'Bangalore'
ORDER BY name;

-- Q5: Show products cheaper than 1000 rupees

SELECT * 
FROM products
WHERE price < 1000;

-- Q6: Show Electronics products sorted by price descending

SELECT *
FROM products
WHERE category = 'Electronics'
ORDER BY price DESC;

-- Q7: Show products with stock less than 100

SELECT *
FROM products
WHERE stock < 100;

-- Q8: Show orders placed in January 2024

SELECT * 
FROM orders
WHERE YEAR(order_date) = 2024 
	AND MONTH(order_date) = 1; 

-- Q9: Show only Delivered orders sorted by total_amount descending

SELECT * 
FROM orders
WHERE status = 'Delivered'
ORDER BY total_amount DESC;

-- Q10: Show top 5 most expensive orders

SELECT *
FROM orders
ORDER BY total_amount DESC
LIMIT 5;

-- Q11: Show IT department employees

SELECT *
FROM employees
WHERE department = 'IT';

-- Q12: Show employees with salary above 60000

SELECT *
FROM employees
WHERE salary > 60000;

-- Q13: Count total number of customers

SELECT COUNT(id) AS customer_count
FROM customers;

-- Q14: Count customers in each city

SELECT city, 
	COUNT(id) AS customer_count
FROM customers
GROUP BY city;

-- Q15: Count products in each category

SELECT category,
	COUNT(id) AS product_count
FROM products
GROUP BY category;

-- Q16: Count employees in each department

SELECT department,
	COUNT(id) AS emp_count
FROM employees
GROUP BY department;

-- Q17: Average salary per department

SELECT department,
	ROUND(AVG(salary), 2) AS avg_salary
FROM employees
GROUP BY department;

-- Q18: Total revenue from all orders

SELECT SUM(total_amount) AS total_revenue
FROM orders;

-- Q19: Total revenue per month in 2024

SELECT MONTH(order_date) AS month,
	SUM(total_amount) AS total_revenue
FROM orders
GROUP BY month;

-- Q20: Cities where average customer age is above 28

SELECT city, 
	ROUND(AVG(age)) AS avg_age
FROM customers
GROUP BY city
HAVING AVG(age) > 28;
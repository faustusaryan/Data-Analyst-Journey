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


-- Q1 (Medium): Self-join the employees table to list each employee with their manager's name.

SELECT
	a.first_name AS emp_name,
    b.first_name AS manager_name
FROM employees a
LEFT JOIN employees b 
	ON a.manager_id = b.employee_id;

-- Q2 (Medium): List all employees who do NOT have a manager (top of hierarchy).

SELECT 
	employee_id,
    first_name
FROM employees
WHERE manager_id IS NULL;

-- Q3 (Medium): Show each order with customer name, employee (salesperson) name,
--               and order date — joining 3 tables.

SELECT
	o.order_id,
    c.customer_name,
    e.first_name AS emp_name,
    o.order_date
FROM employees e
JOIN orders o 
	ON e.employee_id = o.employee_id
JOIN customers c
	ON o.customer_id = c.customer_id;

-- Q4 (Medium): Show the total order value (quantity * price) for each order,
--               joining orders, order_items, and products.

SELECT
	o.order_id,
    SUM(oi.quantity * p.price) AS total_value
FROM orders o
JOIN order_items oi
	ON o.order_id = oi.order_id
JOIN products p
	ON oi.product_id = p.product_id
GROUP BY o.order_id;

-- Q5 (Medium-Hard): List all customers who have NEVER placed an order (left join + IS NULL).

SELECT
	c.customer_id,
    c.customer_name
FROM customers c 
LEFT JOIN orders o 
	ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- Q6 (Medium-Hard): List all employees who have NEVER handled an order (left join + IS NULL).

SELECT
	e.employee_id,
    e.first_name AS emp_name
FROM employees e
LEFT JOIN orders o 
	ON e.employee_id = o.employee_id
WHERE o.order_id IS NULL;

-- Q7 (Medium-Hard): Find pairs of employees who work in the same department
--                    (self-join, avoid duplicate pairs like (A,B) and (B,A)).

SELECT
	a.department_id,
	a.first_name AS emp1_name,
    b.first_name AS emp2_name
FROM employees a 
JOIN employees b 
	ON a.department_id = b.department_id
where a.employee_id < b.employee_id;

-- Q8 (Medium-Hard): List each customer along with the total number of orders
--                    they've placed, including customers with 0 orders.

SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- Q9 (Hard): Find the total revenue generated by each salesperson (employee),
--             joining employees, orders, order_items, and products.

SELECT
	e.employee_id,
    e.first_name AS emp_name,
    SUM(oi.quantity * p.price) AS revenue
FROM employees e
JOIN orders o 
	ON e.employee_id = o.employee_id
JOIN order_items oi
	ON o.order_id = oi.order_id
JOIN products p 
	ON oi.product_id = p.product_id
GROUP BY e.employee_id, e.first_name;

-- Q10 (Hard): List employees along with their manager's department name
--             (manager may be in a different department scenario — self-join + join departments).

SELECT
    e.first_name AS emp_name,
    e.manager_id,
    d.department_name AS manager_dept_name
FROM employees e
LEFT JOIN employees m
    ON e.manager_id = m.employee_id
LEFT JOIN departments d
    ON m.department_id = d.department_id;

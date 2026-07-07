CREATE DATABASE superstore;
USE superstore;

DROP TABLE orders;

CREATE TABLE orders (
    row_id INT,
    order_id VARCHAR(20),
    order_date VARCHAR(15),
    ship_date VARCHAR(15),
    ship_mode VARCHAR(20),
    customer_id VARCHAR(20),
    customer_name VARCHAR(50),
    segment VARCHAR(20),
    country VARCHAR(30),
    city VARCHAR(30),
    state VARCHAR(30),
    postal_code VARCHAR(10),
    region VARCHAR(20),
    product_id VARCHAR(20),
    category VARCHAR(20),
    sub_category VARCHAR(20),
    product_name VARCHAR(200),
    sales DECIMAL(10,2)
);

SELECT * FROM orders LIMIT 5;

SELECT COUNT(*)
FROM orders;

TRUNCATE TABLE orders;

SHOW VARIABLES LIKE 'secure_file_priv';

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/train.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


-- Q1 — Total sales by Category

SELECT 
	category,
	SUM(sales) AS total_sale
FROM orders
GROUP BY category;

-- Q2 — Top 5 customers by total sales

SELECT 
	customer_name,
    SUM(sales) AS sale
FROM orders
GROUP BY customer_id, customer_name
ORDER BY sale DESC
LIMIT 5;

-- Q3 — Total sales by Region — highest pehle

SELECT 
	region,
    SUM(sales) AS total_sale
FROM orders
GROUP BY region;

-- Q4 — Monthly sales for year 2017 — MONTH() aur YEAR() use karo. Dates VARCHAR mein hain toh STR_TO_DATE use karna padega:

SELECT
    MONTH(STR_TO_DATE(order_date, '%d/%m/%Y')) AS month,
    SUM(sales) AS total_sales
FROM orders
WHERE YEAR(STR_TO_DATE(order_date, '%d/%m/%Y')) = 2017
GROUP BY month
ORDER BY month;

-- Q5 — Top 3 sub-categories by sales in each Region — window function use karo

WITH ranked AS (
    SELECT
        region,
        sub_category,
        SUM(sales) AS total_sales,
        RANK() OVER(PARTITION BY region ORDER BY SUM(sales) DESC) AS rnk
    FROM orders
    GROUP BY region, sub_category
)
SELECT *
FROM ranked
WHERE rnk <= 3;



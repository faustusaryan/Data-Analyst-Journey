CREATE DATABASE IF NOT EXISTS superstore;
USE superstore;

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
    row_id        INT,
    order_id      VARCHAR(20),
    order_date    DATE,             -- stored as DATE, not VARCHAR
    ship_date     DATE,
    ship_mode     VARCHAR(20),
    customer_id   VARCHAR(20),
    customer_name VARCHAR(50),
    segment       VARCHAR(20),
    country       VARCHAR(30),
    city          VARCHAR(30),
    state         VARCHAR(30),
    postal_code   VARCHAR(10),      -- VARCHAR: leading zeros + some blanks
    region        VARCHAR(20),
    product_id    VARCHAR(20),
    category      VARCHAR(20),
    sub_category  VARCHAR(20),
    product_name  VARCHAR(200),
    sales         DECIMAL(10,2),
    quantity      INT,
    discount      DECIMAL(4,2),
    profit        DECIMAL(10,2)     -- can be negative
);

-- Confirm where MySQL will accept file loads from
SHOW VARIABLES LIKE 'secure_file_priv';


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/superstore.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(row_id, order_id, @order_date, @ship_date, ship_mode, customer_id,
 customer_name, segment, country, city, state, @postal_code, region,
 product_id, category, sub_category, product_name, sales, quantity,
 discount, profit)
SET
    order_date  = STR_TO_DATE(@order_date, '%m/%d/%Y'),
    ship_date   = STR_TO_DATE(@ship_date,  '%m/%d/%Y'),
    postal_code = NULLIF(TRIM(@postal_code), '');


SELECT COUNT(*) AS row_count FROM orders;
-- expect 9994

SELECT COUNT(*) AS unparsed_dates FROM orders WHERE order_date IS NULL;
-- expect 0. If not 0, the date format is wrong — see note below.

SELECT MIN(order_date) AS first_order, MAX(order_date) AS last_order FROM orders;
-- expect 2014-01-03 to 2017-12-30

SELECT ROUND(SUM(sales), 2) AS total_sales,
       ROUND(SUM(profit), 2) AS total_profit
FROM orders;
-- expect roughly 2,297,201 sales / 286,397 profit

SELECT * FROM orders LIMIT 5;

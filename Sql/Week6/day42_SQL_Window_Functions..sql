-- =====================================================
-- DAY 42 — SQL WINDOW FUNCTIONS
-- Session notes (honest version)
-- =====================================================
-- Coming back after a long break and this one hurt.
-- Every question was hard. Average 15-25 minutes each.
-- Needed help on roughly half of them.
-- Forgot the syntax of several functions and had to look it up.
-- Whole session was mind-fucking, but it's done.
--
-- Weak spots to revisit:
--   - default window frame behaviour (LAST_VALUE, Q9)
--   - stacking window functions across CTEs (Q11)
--   - aggregate-inside-window syntax, SUM(SUM(x)) OVER (Q4)
--   - explicit ROWS BETWEEN frames (Q8, Q12)
-- =====================================================

SET GLOBAL local_infile = 1;

DROP DATABASE IF EXISTS superstore;
CREATE DATABASE superstore
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_0900_ai_ci;
USE superstore;

CREATE TABLE orders (
    row_id        INT           NOT NULL,
    order_id      VARCHAR(20)   NOT NULL,
    order_date    DATE          NOT NULL,
    ship_date     DATE          NOT NULL,
    ship_mode     VARCHAR(20),
    customer_id   VARCHAR(20)   NOT NULL,
    customer_name VARCHAR(60),
    segment       VARCHAR(20),
    country       VARCHAR(60),
    city          VARCHAR(60),
    state         VARCHAR(60),
    postal_code   VARCHAR(10),
    region        VARCHAR(20),
    product_id    VARCHAR(30)   NOT NULL,
    category      VARCHAR(30),
    sub_category  VARCHAR(30),
    product_name  VARCHAR(200),
    sales         DECIMAL(12,4) NOT NULL,
    quantity      INT           NOT NULL,
    discount      DECIMAL(5,4)  NOT NULL,
    profit        DECIMAL(12,4) NOT NULL,
    PRIMARY KEY (row_id)
) ENGINE=InnoDB;

LOAD DATA LOCAL INFILE 'C:/Users/aryan/Desktop/learn_sql/superstore.csv'   -- *** CHANGE THIS LINE ***
INTO TABLE orders
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'        -- correct for the provided superstore.csv
IGNORE 1 LINES
(row_id, order_id, @order_date, @ship_date, ship_mode, customer_id,
 customer_name, segment, country, city, state, postal_code, region,
 product_id, category, sub_category, product_name, sales, quantity,
 discount, profit)
SET order_date = STR_TO_DATE(@order_date, '%c/%e/%Y'),
    ship_date  = STR_TO_DATE(@ship_date,  '%c/%e/%Y');

USE superstore;

-- =====================================================
-- Q1. Rank all products by total sales, highest first. Return
-- product_name, total_sales, sales_rank. No ties allowed — exactly one
-- product per rank.
-- =====================================================

SELECT
    product_name,
    ROUND(SUM(sales), 2) AS total_sales,
    ROW_NUMBER() OVER(ORDER BY SUM(sales) DESC) AS sales_rank
FROM orders
GROUP BY product_name
ORDER BY sales_rank;

-- =====================================================
-- Q2. For every sub-category, show total sales alongside ROW_NUMBER,
-- RANK and DENSE_RANK computed on those totals, all three in one result set.
-- =====================================================

SELECT
	sub_category,
    ROUND(SUM(sales), 2) AS total_sale,
    ROW_NUMBER() OVER w AS row_num,
    RANK() OVER w AS rnk,
    DENSE_RANK() OVER w AS dense_rnk
FROM orders
GROUP BY sub_category
WINDOW w AS (ORDER BY SUM(sales) DESC)
ORDER BY SUM(sales) DESC;

-- =====================================================
-- Q3. The top 3 products by total sales within each category. Return
-- category, product_name, total_sales, rank_in_category.
-- (You will hit Trap 1 here. That's intended.)
-- =====================================================

WITH temp AS (
  SELECT
      category,
      product_name,
      ROUND(SUM(sales), 2) AS total_sales,
      ROW_NUMBER() OVER (
        PARTITION BY category
        ORDER BY SUM(sales) DESC, product_name
      ) AS rnk
  FROM orders
  GROUP BY category, product_name
)
SELECT *
FROM temp
WHERE rnk <= 3
ORDER BY category, rnk;

-- =====================================================
-- Q4. Monthly sales for 2017 with a running cumulative total across the year.
-- Return month, monthly_sales, running_total.
-- =====================================================

SELECT
	MONTH(order_date) AS month,
    ROUND(SUM(sales), 2) AS monthly_sales,
    ROUND(SUM(SUM(sales)) OVER(ORDER BY MONTH(order_date)), 2) AS running_total
FROM orders
WHERE YEAR(order_date) = 2017
GROUP BY MONTH(order_date)
ORDER BY month;

-- =====================================================
-- Q5. For each line item, its sales as a percentage of that customer's
-- lifetime sales. Return order_id, customer_name, sales,
-- customer_lifetime_sales, pct_of_customer. Round the percentage to 2 places.
-- =====================================================

SELECT
	order_id,
    customer_name,
    sales,
    SUM(sales) OVER(PARTITION BY customer_id) 
		AS customer_lifetime_sales,
    ROUND(sales/(SUM(sales) OVER(PARTITION BY customer_id)) * 100, 2) 
		AS pct_of_customer
FROM orders;

-- =====================================================
-- Q6. Monthly sales for 2016 and 2017 with the previous month's figure and
-- the month-over-month percentage change. Return month, monthly_sales,
-- prev_month_sales, mom_pct_change.
-- =====================================================

WITH monthly AS (
SELECT
	YEAR(order_date) AS the_year,
	MONTH(order_date) AS month,
	SUM(sales) AS monthly_sales
FROM orders
WHERE YEAR(order_date) IN (2016, 2017)
GROUP BY YEAR(order_date), MONTH(order_date)
),
with_lag AS (
SELECT
	the_year,
	month,
	monthly_sales,
	LAG(monthly_sales) OVER w AS prev_month_sales
FROM monthly
WINDOW w AS (ORDER BY the_year, month)
)
SELECT
    the_year AS `year`,
    month,
    ROUND(monthly_sales, 2) AS monthly_sales,
    ROUND(prev_month_sales, 2) AS prev_month_sales,
    ROUND(
        (monthly_sales - prev_month_sales) / NULLIF(prev_month_sales, 0) * 100, 2) 
		AS mom_pct_change
FROM with_lag
ORDER BY the_year, month;

-- =====================================================
-- Q7. For each customer, the number of days between each order and their
-- previous order. Return customer_id, order_date, prev_order_date,
-- days_since_prev. Order by customer, then date.
-- (Watch the grain — the table is one row per line item, not per order.)
-- =====================================================

WITH distinct_orders AS (
SELECT 
	DISTINCT customer_id, 
    order_id, 
    order_date
FROM orders
)
SELECT
    customer_id,
    order_date,
    LAG(order_date) OVER w 
		AS prev_order_date,
    DATEDIFF(order_date, LAG(order_date) OVER w) 
		AS days_since_prev
FROM distinct_orders
WINDOW w AS (PARTITION BY customer_id ORDER BY order_date)
ORDER BY customer_id, order_date;

-- =====================================================
-- Q8. A 3-month moving average of monthly sales across the whole period.
-- Return month, monthly_sales, moving_avg_3m. Use an explicit frame.
-- =====================================================

WITH temp AS (
SELECT
	DATE_FORMAT(order_date, '%Y-%m') AS `month`,
    SUM(sales) AS monthly_sales
FROM orders
GROUP BY month)
SELECT
	month,
    monthly_sales,
    ROUND(
        AVG(monthly_sales) OVER (
            ORDER BY month
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ), 2
    ) AS moving_avg_3m
FROM temp
ORDER BY month;

-- =====================================================
-- Q9. For every line item, show the customer's first and last order dates on
-- that row. Return customer_name, order_date, first_order_date,
-- last_order_date.
-- (Trap 3 lives here. If last_order_date equals order_date on every row, you
-- have found it.)
-- =====================================================

SELECT
	customer_name,
    order_date,
    FIRST_VALUE(order_date) OVER w 
		AS first_order_date,
	LAST_VALUE(order_date) OVER w
		AS last_order_date
FROM orders
WINDOW w AS ( 
	PARTITION BY customer_id 
	ORDER BY order_date 
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
ORDER BY customer_name, order_date;

-- =====================================================
-- Q10. Split customers into 4 quartiles by lifetime sales, then report per
-- quartile: the quartile number, customer count, average lifetime sales, and
-- total sales. Quartile 1 should be the highest spenders.
-- =====================================================

WITH customer_sales AS (
    SELECT
        customer_id,
        SUM(sales) AS lifetime_sales
    FROM orders
    GROUP BY customer_id
),
quartiled AS (
    SELECT
        customer_id,
        lifetime_sales,
        NTILE(4) OVER (ORDER BY lifetime_sales DESC) AS quartile
    FROM customer_sales
)
SELECT
    quartile,
    COUNT(customer_id) AS customer_count,
    ROUND(AVG(lifetime_sales), 2) AS avg_lifetime_sales,
    ROUND(SUM(lifetime_sales), 2) AS total_sales
FROM quartiled
GROUP BY quartile
ORDER BY quartile;
	
-- =====================================================
-- Q11. Rank the regions by total sales within each year, then show how each
-- region's rank moved versus the previous year. Return year, region,
-- yearly_sales, rank_in_year, prev_year_rank, rank_change.
-- (Two window functions stacked — one must finish before the other can start.)
-- =====================================================

WITH yearly AS (
SELECT
	YEAR(order_date) AS yr,
	region,
	SUM(sales) AS yearly_sales
FROM orders
GROUP BY YEAR(order_date), region
),
ranked AS (
SELECT
	yr,
	region,
	yearly_sales,
	RANK() OVER (PARTITION BY yr ORDER BY yearly_sales DESC) AS rank_in_year
FROM yearly
)
SELECT
    yr AS `year`,
    region,
    ROUND(yearly_sales, 2) AS yearly_sales,
    rank_in_year,
    LAG(rank_in_year) OVER w AS prev_year_rank,
    CAST(LAG(rank_in_year) OVER w AS SIGNED) - CAST(rank_in_year AS SIGNED) AS rank_change
FROM ranked
WINDOW w AS (PARTITION BY region ORDER BY yr)
ORDER BY yr, rank_in_year;
	
-- =====================================================
-- Q12. Pareto. List products by total sales descending, with a cumulative
-- percentage of overall sales. Return product_name, total_sales,
-- cumulative_pct. 
-- =====================================================

WITH temp AS (
SELECT
	product_name,
    SUM(sales) AS total_sales
FROM orders
GROUP BY product_name
)
SELECT
	product_name,
    ROUND(total_sales, 2) AS total_sales,
    ROUND(
		SUM(total_sales) OVER w
        / SUM(total_sales) OVER() * 100, 2)
        AS cumulative_pct
FROM temp
WINDOW w AS (ORDER BY total_sales DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
ORDER BY total_sales DESC;

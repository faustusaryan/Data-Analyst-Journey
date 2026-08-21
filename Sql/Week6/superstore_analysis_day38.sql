USE superstore;

-- ---------------------------------------------------------------------
-- Q1 — Total sales by category
-- ---------------------------------------------------------------------
SELECT
    category,
    SUM(sales) AS total_sales
FROM orders
GROUP BY category
ORDER BY total_sales DESC;

-- ---------------------------------------------------------------------
-- Q2 — Top 5 customers by total sales
-- Grouped by customer_id since names can repeat.
-- ---------------------------------------------------------------------
SELECT
    customer_name,
    SUM(sales) AS total_sales
FROM orders
GROUP BY customer_id, customer_name
ORDER BY total_sales DESC
LIMIT 5;

-- ---------------------------------------------------------------------
-- Q3 — Total sales by region, highest first
-- ---------------------------------------------------------------------
SELECT
    region,
    SUM(sales) AS total_sales
FROM orders
GROUP BY region
ORDER BY total_sales DESC;

-- ---------------------------------------------------------------------
-- Q4 — Monthly sales trend for 2016
-- ---------------------------------------------------------------------
SELECT
    MONTH(order_date)     AS month_num,
    MONTHNAME(order_date) AS month_name,
    SUM(sales)            AS total_sales
FROM orders
WHERE YEAR(order_date) = 2016
GROUP BY MONTH(order_date), MONTHNAME(order_date)
ORDER BY month_num;

-- ---------------------------------------------------------------------
-- Q5 — Top 3 sub-categories by sales within each region
-- ---------------------------------------------------------------------
WITH ranked AS (
    SELECT
        region,
        sub_category,
        SUM(sales) AS total_sales,
        RANK() OVER (PARTITION BY region ORDER BY SUM(sales) DESC) AS rnk
    FROM orders
    GROUP BY region, sub_category
)
SELECT region, sub_category, total_sales
FROM ranked
WHERE rnk <= 3
ORDER BY region, rnk;

-- ---------------------------------------------------------------------
-- Q6 — Most-used ship mode per region, by number of distinct orders
-- Subquery form. Q10 is the same logic written as a CTE.
-- COUNT(DISTINCT order_id): each order spans several rows (one per
-- product), so a plain COUNT would count line items, not orders.
-- ---------------------------------------------------------------------
SELECT region, ship_mode, order_count
FROM (
    SELECT
        region,
        ship_mode,
        COUNT(DISTINCT order_id) AS order_count,
        RANK() OVER (
            PARTITION BY region
            ORDER BY COUNT(DISTINCT order_id) DESC
        ) AS rnk
    FROM orders
    GROUP BY region, ship_mode
) ranked
WHERE rnk = 1
ORDER BY region;

-- ---------------------------------------------------------------------
-- Q7 — Best-selling month of 2017 by revenue
-- ---------------------------------------------------------------------
SELECT
    MONTHNAME(order_date) AS month_name,
    SUM(sales)            AS total_sales
FROM orders
WHERE YEAR(order_date) = 2017
GROUP BY MONTH(order_date), MONTHNAME(order_date)
ORDER BY total_sales DESC
LIMIT 1;

-- ---------------------------------------------------------------------
-- Q8 — Average line-item sale per category, Second Class shipping only
-- Named line_item, not order value: one row is one product on an order,
-- so AVG(sales) here is per line item. True average order value needs
-- the order totalled first (see Q9 pattern).
-- ---------------------------------------------------------------------
SELECT
    category,
    ROUND(AVG(sales), 2) AS avg_line_item_sales
FROM orders
WHERE ship_mode = 'Second Class'
GROUP BY category
ORDER BY avg_line_item_sales DESC;

-- ---------------------------------------------------------------------
-- Q9 — Top 2 customers by sales within each segment
-- RANK, not ROW_NUMBER: a tie at rank 2 returns both customers.
-- ---------------------------------------------------------------------
WITH customer_totals AS (
    SELECT
        segment,
        customer_name,
        SUM(sales) AS total_sales,
        RANK() OVER (
            PARTITION BY segment
            ORDER BY SUM(sales) DESC
        ) AS rnk
    FROM orders
    GROUP BY segment, customer_id, customer_name
)
SELECT segment, customer_name, total_sales
FROM customer_totals
WHERE rnk <= 2
ORDER BY segment, rnk;

-- ---------------------------------------------------------------------
-- Q10 — Q6 rewritten as a CTE
-- Same result, same plan. Kept deliberately: interviewers ask for the
-- alternative form, and CTEs read better as logic gets deeper.
-- ---------------------------------------------------------------------
WITH ship_mode_counts AS (
    SELECT
        region,
        ship_mode,
        COUNT(DISTINCT order_id) AS order_count,
        RANK() OVER (
            PARTITION BY region
            ORDER BY COUNT(DISTINCT order_id) DESC
        ) AS rnk
    FROM orders
    GROUP BY region, ship_mode
)
SELECT region, ship_mode, order_count
FROM ship_mode_counts
WHERE rnk = 1
ORDER BY region;

-- ---------------------------------------------------------------------
-- Q11 — Year-over-year revenue, 2016 vs 2017, side by side
-- ---------------------------------------------------------------------
SELECT
    SUM(CASE WHEN YEAR(order_date) = 2016 THEN sales ELSE 0 END) AS sales_2016,
    SUM(CASE WHEN YEAR(order_date) = 2017 THEN sales ELSE 0 END) AS sales_2017
FROM orders;
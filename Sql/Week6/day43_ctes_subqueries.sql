USE superstore;

-- Q1. Every line item whose sales are above the overall average sale. Return
-- order_id, product_name, sales. Use a scalar subquery.

SELECT
	order_id,
    product_name,
    sales
FROM orders
WHERE sales > (SELECT AVG(sales) FROM orders);

-- Q2. Distinct customers who have bought at least one product in the
-- Technology category. Return customer_id and customer_name, sorted. Use IN.

SELECT
	DISTINCT customer_id,
    customer_name
FROM orders
WHERE customer_id IN (SELECT customer_id FROM orders WHERE category = 'Technology')
ORDER BY customer_id;  

-- Q3. Average order value. Sum sales per order_id first, then average those
-- totals. Use a derived table in FROM — no CTE yet. Feel the awkwardness.

SELECT
    ROUND(AVG(total_sales), 2) AS avg_order_value
FROM (
    SELECT
        order_id,
        SUM(sales) AS total_sales
    FROM orders
    GROUP BY order_id
) temp;

-- Q4. Rewrite Q3 as a CTE. Same number, different syntax.
-- (Average order value. Sum sales per order_id first, then average those
-- totals.)

WITH order_totals AS (
    SELECT 
        order_id,
        SUM(sales) AS total_sales
    FROM orders
    GROUP BY order_id
)
SELECT
    ROUND(AVG(total_sales), 2) AS avg_order_value
FROM order_totals;

-- Q5. Customers whose lifetime sales exceed 5,000. Return customer_name,
-- lifetime_sales, order_count. Use a CTE.

WITH life_time AS (
    SELECT
        customer_id,
        customer_name,
        SUM(sales) AS lifetime_sales,
        COUNT(DISTINCT order_id) AS order_count
    FROM orders
    GROUP BY customer_id, customer_name
)
SELECT
    customer_name,
    lifetime_sales,
    order_count
FROM life_time
WHERE lifetime_sales > 5000
ORDER BY customer_name;

-- Q6. Months in 2017 whose sales beat the 2017 monthly average. Return month,
-- monthly_sales, and the average as a column. Two chained CTEs — one for
-- monthly totals, one for the average.

WITH monthly AS (
    SELECT
        MONTH(order_date) AS mnth,
        ROUND(SUM(sales), 2) AS monthly_sales
    FROM orders
    WHERE YEAR(order_date) = 2017
    GROUP BY MONTH(order_date)
),
monthly_avg AS (
    SELECT
        ROUND(AVG(monthly_sales), 2) AS avg_monthly_sale
    FROM monthly
)
SELECT
    mnth,
    monthly_sales,
    avg_monthly_sale
FROM monthly
CROSS JOIN monthly_avg
WHERE monthly_sales > avg_monthly_sale
ORDER BY mnth;

-- Q7. Line items whose sales exceed their own category's average sale.
-- Return category, product_name, sales, category_avg. Write it as a
-- correlated subquery.

SELECT
    o.category,
    o.product_name,
    o.sales,
    (SELECT AVG(o2.sales)
     FROM orders o2
     WHERE o2.category = o.category) AS category_avg
FROM orders o
WHERE o.sales > (
    SELECT AVG(o3.sales)
    FROM orders o3
    WHERE o3.category = o.category
);

-- Q8. Rewrite Q7 using a CTE + JOIN instead of correlation.

WITH t AS (
    SELECT 
        category,
        product_name,
        sales
    FROM orders
),
t2 AS (
    SELECT 
        category, 
        AVG(sales) AS category_avg 
    FROM orders
    GROUP BY category
)
SELECT
    t.category,
    t.product_name,
    t.sales,
    t2.category_avg
FROM t
JOIN t2 
    ON t.category = t2.category
WHERE t.sales > t2.category_avg;

-- Q9. Customers who ordered in both 2016 and 2017. Return customer_id,
-- customer_name. Use EXISTS twice, or two CTEs — your choice, but state which
-- in a comment and why.

-- Two CTEs over EXISTS: the year cohorts are named sets here,
-- so the join reads cleaner than two correlated EXISTS blocks.

WITH y2016 AS (
    SELECT DISTINCT customer_id, customer_name
    FROM orders
    WHERE YEAR(order_date) = 2016
),
y2017 AS (
    SELECT DISTINCT customer_id, customer_name
    FROM orders
    WHERE YEAR(order_date) = 2017
)
SELECT a.customer_id, a.customer_name
FROM y2016 a
JOIN y2017 b ON a.customer_id = b.customer_id;

-- Q10. Customers who have never bought anything in Technology. Use
-- NOT EXISTS.

SELECT DISTINCT
    o.customer_id,
    o.customer_name
FROM orders o
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o2
    WHERE o2.customer_id = o.customer_id
      AND o2.category = 'Technology'
);

-- Q11. Top 3 products by total sales within each category — CTE plus a window
-- function. Return category, product_name, total_sales, rank_in_category.
-- (This is yesterday's Q3. Retype it from memory. Do not reopen yesterday's file.)

WITH t AS (
    SELECT
        category,
        product_name,
        SUM(sales) AS total_sales,
        RANK() OVER(PARTITION BY category ORDER BY SUM(sales) DESC) AS rank_in_category
    FROM orders
    GROUP BY category, product_name
)
SELECT
    category,
    product_name,
    total_sales,
    rank_in_category
FROM t
WHERE rank_in_category <= 3;

-- Q12. For each order, its total and what percentage that order contributes to
-- overall sales. Return order_id, order_total, pct_of_total — display the top
-- 20 by value.

WITH t AS (
	SELECT
		order_id,
		SUM(sales) AS order_total
	FROM orders
	GROUP BY order_id
),
t2 AS (
	SELECT SUM(sales) AS overall_sale 
    FROM orders
)
SELECT
	order_id,
    order_total,
    (order_total / overall_sale) * 100 AS pct_of_total
FROM t
CROSS JOIN t2
ORDER BY order_total DESC
LIMIT 20;

-- Q13. For each sub-category, compare average profit on discounted rows
-- (discount > 0) against non-discounted rows (discount = 0), side by side, with
-- the difference. Two CTEs joined. Sort by the difference, worst first.

WITH discounted AS (
	SELECT
		sub_category,
		AVG(profit) AS avg_discounted_profit
	FROM orders
	WHERE discount > 0
	GROUP BY sub_category
),
non_discounted AS (
	SELECT
		sub_category,
		AVG(profit) AS avg_non_discounted_profit
	FROM orders
	WHERE discount = 0
	GROUP BY sub_category
)
SELECT
	d.sub_category,
    avg_discounted_profit,
    avg_non_discounted_profit,
    (avg_non_discounted_profit - avg_discounted_profit) AS diff
FROM discounted d
JOIN non_discounted nd
    ON d.sub_category = nd.sub_category
ORDER BY diff DESC;















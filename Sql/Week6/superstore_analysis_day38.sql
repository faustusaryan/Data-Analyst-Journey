USE superstore;

SELECT * FROM orders;

-- Q1 — Kaun sa ship_mode sabse zyada orders deliver karta hai — region wise. (GROUP BY + COUNT)

SELECT region, ship_mode, counts
FROM (
    SELECT
        region,
        ship_mode,
        COUNT(order_id) AS counts,
        RANK() OVER (PARTITION BY region ORDER BY COUNT(order_id) DESC) AS rnk
    FROM orders
    GROUP BY region, ship_mode
) t
WHERE rnk = 1;

-- Q2 — Us month ka naam batao jisme 2018 mein sabse zyada sales hui. 
-- (STR_TO_DATE + MONTHNAME + ORDER BY + LIMIT 1)

SELECT 
    MONTHNAME(STR_TO_DATE(`order_date`, '%d/%m/%Y')) AS month_name,
    SUM(Sales) AS total_sales
FROM orders
WHERE YEAR(STR_TO_DATE(`order_date`, '%d/%m/%Y')) = 2018
GROUP BY month_name
ORDER BY total_sales DESC
LIMIT 1;

-- Q3 — Har category mein average order value kya hai — sirf un orders ki jo Second Class ship mode se aayi hain. 
-- (WHERE + GROUP BY + AVG)

SELECT 
	category,
    AVG(sales) AS avg_sale
FROM orders
WHERE ship_mode = 'Second Class'
GROUP BY category;

-- Q4 — Top 2 customers by sales in each segment. (CTE + RANK + PARTITION BY segment)

WITH x AS (
    SELECT
        segment,
        customer_name,
        SUM(sales) AS total_sale,
        RANK() OVER (
            PARTITION BY segment
            ORDER BY SUM(sales) DESC
        ) AS rnk
    FROM orders
    GROUP BY segment, customer_id, customer_name
)
SELECT
    segment,
    customer_name,
    total_sale
FROM x
WHERE rnk <= 2;

-- Q5 — Total sales comparison — 2017 vs 2018 side by side. (SUM + CASE WHEN + GROUP BY year — pivot style)

SELECT
    SUM(
        CASE WHEN YEAR(STR_TO_DATE(order_date, '%d/%m/%Y')) = 2017 
		THEN sales ELSE 0 
        END
		) AS `2017_sales`,
    SUM(
        CASE WHEN YEAR(STR_TO_DATE(order_date, '%d/%m/%Y')) = 2018 
		THEN sales ELSE 0 
        END
		) AS `2018_sales`
FROM orders;

-- Q1 — Kaun sa ship_mode sabse zyada orders deliver karta hai — region wise. (GROUP BY + COUNT)

WITH x AS (
	SELECT 
		region,
		ship_mode,
		COUNT(order_id) AS total_orders,
		RANK() OVER(PARTITION BY region ORDER BY COUNT(order_id) DESC) AS rnk
	FROM orders
	GROUP BY region, ship_mode
)
SELECT 
	region,
    ship_mode,
	total_orders
FROM x
WHERE rnk = 1;

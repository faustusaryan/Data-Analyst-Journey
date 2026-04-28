USE analyst_practice;


-- Q1: Har customer ke orders mein, har order ke saath usse pehle wale order ka amount bhi dikhao. 
-- Customer id, order id, date, amount aur previous order amount dikhao. 
-- Pehle order ka previous obviously NULL hoga.

SELECT
	customer_id,
    id AS order_id,
    order_date,
    total_amount,
    LAG(total_amount) OVER(PARTITION BY customer_id ORDER BY order_date) AS pre_ord_amount
FROM orders;

-- Q2: Same — lekin agli order ka amount dikhao (LEAD). Next order amount NULL hoga last order ka.

SELECT
	customer_id,
    id AS order_id,
    order_date,
    total_amount,
    LEAD(total_amount) OVER(PARTITION BY customer_id ORDER BY order_date) AS next_ord_amount
FROM orders;

-- Q3: Har customer ke liye — current order amount aur pichle order amount ka difference dikhao. 
-- Difference negative bhi ho sakta hai.

SELECT
	customer_id,
    id AS order_id,
    order_date,
    total_amount,
    total_amount - LAG(total_amount) OVER(PARTITION BY customer_id ORDER BY order_date) AS diff
FROM orders;
	
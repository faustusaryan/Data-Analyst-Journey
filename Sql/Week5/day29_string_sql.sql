USE analyst_practice;

-- 1. Convert case — uppercase/lowercase

SELECT
	UPPER(name) AS upper_name,
    LOWER(name) AS lower_name
FROM employees;

-- 2. Find length of string values

SELECT
	name,
    LENGTH(name) AS len_of_name
FROM employees;

-- Q3: Substring — first 3 chars of name

SELECT
	SUBSTRING(name, 1, 3) AS first_3_char
FROM employees;

-- Q4: Extract domain from email

SELECT 
	email, 
    SUBSTRING(email, INSTR(email, '@') + 1) AS domain 
FROM customers;

-- Q5: Replace in string

SELECT
	email,
    REPLACE(email, '@email.com', '@company.com') AS new_email
FROM customers;

-- Q6: CONCAT — full employee info as one string

SELECT
	CONCAT(name, ' | ', department, ' | ₹', salary) AS emp_info
FROM employees;

-- Q7: TRIM — remove spaces (useful in real data)

SELECT
	TRIM('      Faustus  Aryan                ') AS cleaned;

-- Q8: LIKE operator — customers whose name starts with 'A'

SELECT name 
FROM customers
WHERE name LIKE 'A%';

-- Q9: LIKE — products with 'phone' in name (case insensitive)

SELECT * 
FROM products
WHERE LOWER(name) LIKE '%phone%'; 

-- Q10: Employee names ending with 'a'

SELECT name
FROM employees
WHERE name LIKE '%a';

-- Q11: LPAD and RPAD — format IDs

SELECT 
	id, 
    LPAD(id, 5, '0') AS lpad_formatted_id,
    RPAD(id, 5, '0') AS rpad_formatted_id,
    name 
FROM customers;

-- Q12: LEFT and RIGHT functions

SELECT
	name,
    LEFT(name, 5) AS first_5,
    RIGHT(name, 5) AS last_5
FROM employees;
    
-- Q13: CHAR_LENGTH vs LENGTH

SELECT
	name,
    LENGTH(name),
    CHAR_LENGTH(name)
FROM employees;

-- Q14: INSTR — find position of space

SELECT 
	name,
    INSTR(name, ' ') AS space_pos,
    SUBSTRING(name, 1, INSTR(name, ' ') - 1) AS first_name,
    SUBSTRING(name, INSTR(name, ' ') + 1) AS last_name
FROM customers;

-- Q15: GROUP_CONCAT — employees in each department as comma-separated

SELECT 
	department, 
    GROUP_CONCAT(name ORDER BY name SEPARATOR ', ') AS employees
FROM employees
GROUP BY department;

CREATE DATABASE IF NOT EXISTS audit_test;
USE audit_test;

CREATE TABLE employee(
	id INT PRIMARY KEY,
    name VARCHAR(50),
    dept VARCHAR(30),
    salary INT,
    city VARCHAR(30)
);

INSERT INTO employee VALUES
(1, "Raj", "IT", 45000, "Delhi"),
(2, "Priya", "HR", 38000, "Mumbai"),
(3, "Amit", "IT", 52000, "Delhi"),
(4, "Sara", "Finance", 41000, "Pune"),
(5, "Vivek", "HR", 35000, "Delhi"),
(6, "Neha", "Finance", 47000, "Mumbai"),
(7, "Rohit", "IT", 39000, "Pune"),
(8, "Deepa", "HR", 43000, "Delhi");


### Day 3

# 1. Sab employees dikhao

SELECT * FROM employee;

# 2. Sirf naam aur city dikhao

SELECT name, city FROM employee;

# 3.  IT department ke employees

SELECT * FROM employee WHERE dept = "IT";

# 4. Salary 40000 se zyada wale

SELECT * FROM employee WHERE salary > 40000;

# 5. Delhi mein rehne wale

SELECT * FROM employee WHERE city = "Delhi";

# 6. Salary 35000 se 45000 ke beech

SELECT * FROM employee WHERE salary BETWEEN 35000 AND 45000;

# 7.  IT ya Finance department wale

SELECT * FROM employee WHERE dept IN ("IT", "Finance"); 

# 8.  HR department wale nahi

SELECT * FROM employee WHERE dept != "HR";

# 9. Naam mein "a" wale employees
	
SELECT * FROM employee WHERE name LIKE "%a%";

# 10. R se start hone wale naam

SELECT * FROM employee WHERE name LIKE "R%";

# 11. Delhi mein IT wale (dono conditions)

SELECT * FROM employee WHERE city = "Delhi" AND dept = "IT";

# 12.  Mumbai ya Pune wale

SELECT * FROM employee WHERE city in ("Mumbai", "Pune");

# 13.  Salary 40000 se zyada Delhi mein

SELECT * FROM employee WHERE salary > 40000 AND city = "Delhi";

# 14. IT ya HR wale jo Delhi mein hain

SELECT * FROM employee WHERE dept IN ("IT", "HR") AND city ="Delhi";

# 15. Salary NULL wale dhundo

SELECT * FROM employee WHERE salary IS NULL;

# 16. Salary NULL nahi wale

SELECT * FROM employee WHERE salary IS NOT NULL;

# 17.  Sirf unique departments dikhao

SELECT DISTINCT dept FROM employee;

# 18.  Sirf pehle 3 employees dikhao

SELECT * FROM employee LIMIT 3;

# 19.  Finance department ke nahi aur salary > 40000

SELECT * FROM employee WHERE salary > 40000 AND dept != "Finance";

# 20.  Naam 5 characters se lamba ho

SELECT * FROM employee WHERE CHAR_LENGTH(NAME) > 5; # CHATGPT KI HELP LI

SELECT * FROM employee Where name LIKE "_____%"; # agr 5 se jyda wale chahiye jisme 5 char wale include n ho to 6 ______ and % use kr kro


### at the end aj maine BETWEEN, LIKE and Question no. 20 sikha. 














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

SELECT * FROM employee;

SELECT name, dept FROM employee;

SELECT * FROM employee WHERE dept = "IT" ;

SELECT * FROM employee WHERE salary > 40000;

SELECT * FROM employee WHERE city = "Delhi";

SELECT dept, count(*) FROM employee GROUP BY dept; # khudse solve ho gaya but 2,3 try m 


SELECT dept, avg(salary) FROM employee
GROUP BY dept;

SELECT * FROM employee
ORDER BY salary DESC;

SELECT * FROM employee Where dept = "HR" OR dept = "IT";
SELECT * FROM employee WHERE dept in ("HR", "IT");

SELECT DISTINCT city FROM employee; # distinct keyword ka naam bhul gaya tha yaad krne ki koshish ki but yaad nhi aya to dekha baki correct tha 


### Day 2,3

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


### Day - 3


#1. Har department mein kitne employees hain — dikhao

SELECT dept, COUNT(*) FROM employee GROUP BY dept;

#2.  Har city mein kitne log hain

Select city, Count(*) FROM employee GROUP BY city;

#3. Har department ki total salary kitni hai

SELECT dept, SUM(salary) AS Total_salary FROM employee GROUP BY dept;

#4.  Har department ki average salary nikalo

SELECT dept, AVG(salary) FROM employee GROUP BY dept;

#5. Har department mein sabse zyada salary kaun le raha hai

SELECT dept, MAX(salary) AS highest_salary FROM employee GROUP BY dept;

#6. Har department mein sabse kam salary kaun le raha hai

SELECT dept, MIN(salary) AS lowest_Salary FROM employee GROUP BY dept;

#7.  City wise average salary — sabse zyada se sabse kam order mein

SELECT city, AVG(salary) FROM employee GROUP BY city ORDER BY AVG(salary) DESC;

#8. Har department mein max aur min dono ek saath dikhao

SELECT dept, MAX(salary) AS highest_salary, MIN(salary) AS lowest_salary FROM employee GROUP BY dept;

#9. Har city mein total salary sum karo — sirf woh cities jahan sum 80000 se zyada ho 

SELECT city, SUM(salary) AS total_salary FROM employee GROUP BY city HAVING SUM(salary) > 80000;

#10. Sirf woh departments dikhao jahan 2 se zyada employees hain

SELECT dept, COUNT(*) FROM employee GROUP BY dept HAVING COUNT(*) > 2;

#11. Sirf woh departments dikhao jahan average salary 40000 se zyada hai

SELECT dept, AVG(salary) FROM employee GROUP BY dept HAVING AVG(salary) > 40000;

#12. Har department ki salary range nikalo (max - min) — sabse badi range pehle

SELECT dept, MAX(salary) - MIN(salary) AS salary_range FROM employee GROUP BY dept ORDER BY salary_range DESC;

## iss question m confusion ho gyi coz range ka mtlv nhi pta tha phle but baad m smjh k kr diya

#13.  Sirf Delhi ke employees mein department wise count karo

SELECT dept, count(*) FROM employee WHERE city = "Delhi" GROUP BY dept; 

## 2,3 try lge WHERE ki jagh HAVING use krne k try krne ki wajah s

#14.  Department wise count — sirf woh depts jahan average salary 38000 aur 50000 ke beech ho

SELECT dept, AVG(salary) FROM employee GROUP BY dept HAVING AVG(salary) BETWEEN 38000 AND 50000;

## 2,3 try lge HAVING ki jagh WHERE use krne k try krne ki wajah s

#15. Har city mein minimum salary wala employee ki salary kya hai — sorted low to high

SELECT city, MIN(salary) FROM employee GROUP BY city ORDER BY MIN(salary);

#16.  Salary > 40000 wale employees mein department wise count

SELECT dept, count(*) FROM employee WHERE salary > 40000 GROUP BY dept;

#17. Har department ki total salary aur avg salary dono ek query mein nikalo

SELECT dept, SUM(salary) AS total_salary, AVG(salary) AS avg_salary FROM employee GROUP BY dept;

#18. City aur dept dono se group karo — har combination mein kitne log hain

SELECT city, dept, COUNT(*) FROM employee GROUP BY city, dept;

## 3,4 try lge, GROUP BY M ',' ki jagah 'AND' use kr raha tha 

#19. Sirf woh departments dikhao jahan minimum salary bhi 37000 se zyada ho

SELECT dept, MIN(salary) FROM employee GROUP BY dept HAVING MIN(salary) > 37000;

#20  Har dept ki avg salary — sirf woh depts jo 2+ employees wale hain — avg se high to low sort

SELECT dept, AVG(salary), COUNT(*) FROM employee GROUP BY dept HAVING COUNT(*) >= 2 ORDER BY AVG(salary) DESC;













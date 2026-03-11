CREATE DATABASE IF NOT EXISTS revist; 
USE revist;

CREATE TABLE IF NOT EXISTS STATION (
    ID      INT PRIMARY KEY,
    CITY    VARCHAR(21),
    STATE   VARCHAR(2),
    LAT_N   FLOAT,
    LONG_W  FLOAT
);

INSERT INTO STATION VALUES (1, 'DEF',  'TX', 31.0, 95.0);
INSERT INTO STATION VALUES (2, 'ABC',  'CA', 35.0, 90.0);
INSERT INTO STATION VALUES (3, 'PQRS', 'NY', 40.0, 74.0);
INSERT INTO STATION VALUES (4, 'WXY',  'FL', 28.0, 82.0);


-- 1. Query the two cities in STATION with the shortest and longest CITY names, along with their respective lengths. 
-- If there is more than one smallest or largest city, choose the one that comes first alphabetically.

SELECT CITY, LENGTH(CITY) FROM STATION ORDER BY LENGTH(CITY) ASC , CITY ASC LIMIT 1; 
SELECT CITY, LENGTH(CITY) FROM STATION ORDER BY LENGTH(CITY) DESC, CITY ASC LIMIT 1;

-- Khudse ho gaya ek chota sa hint lena pda but..


CREATE TABLE IF NOT EXISTS STATION (
    ID      INT PRIMARY KEY,
    CITY    VARCHAR(21),
    STATE   VARCHAR(2),
    LAT_N   FLOAT,
    LONG_W  FLOAT
    );

INSERT INTO STATION VALUES (1,  'A', 'TX', 38.00,  95.0);  
INSERT INTO STATION VALUES (2,  'B', 'CA', 40.50,  90.0);  
INSERT INTO STATION VALUES (3,  'C', 'NY', 99.12,  74.0);  
INSERT INTO STATION VALUES (4,  'D', 'FL', 138.00, 82.0);  
INSERT INTO STATION VALUES (5,  'E', 'TX', 75.30,  88.0);  
SELECT * FROM STATION;

-- 2. Query the sum of Northern Latitudes (LAT_N) from STATION for rows where LAT_N is greater than 38.7880 and less than
-- 137.2345. Truncate the answer to 4 decimal places.

SELECT TRUNCATE(SUM(LAT_N), 4) FROM STATION WHERE LAT_N > 38.7880 AND LAT_N <= 137.2345;

-- 3. Samantha calculated the average monthly salary from the EMPLOYEES table, but her keyboard's 0 key was
-- broken — so all zeros were missing from salary values. Find the difference between the actual average and her
-- miscalculated average (actual − miscalculated), rounded up to the next integer.

CREATE TABLE IF NOT EXISTS EMPLOYEES (
    ID     INT PRIMARY KEY,
    Name   VARCHAR(50),
    Salary INT
);
INSERT INTO EMPLOYEES VALUES (1, 'Kristeen', 1420);
INSERT INTO EMPLOYEES VALUES (2, 'Ashley',   2006);
INSERT INTO EMPLOYEES VALUES (3, 'Julia',    2210);
INSERT INTO EMPLOYEES VALUES (4, 'Maria',    3000);

SELECT CEIL(AVG(Salary) - AVG(REPLACE(Salary, 0, ''))) FROM EMPLOYEES;

-- 4. Total earnings for an employee = salary × months. Write a query to print the maximum total earnings across all
-- employees and the count of employees who share that maximum. Print as two space-separated integers.

CREATE TABLE IF NOT EXISTS Employee (
    employee_id INT PRIMARY KEY,
    name        VARCHAR(50),
    months      INT,
    salary      INT
);

INSERT INTO Employee VALUES (12228, 'Rose',     15, 1968);
INSERT INTO Employee VALUES (33645, 'Angela',    1, 3443);
INSERT INTO Employee VALUES (45692, 'Frank',    17, 1608);
INSERT INTO Employee VALUES (57645, 'Kimberly', 16, 4372);
INSERT INTO Employee VALUES (74197, 'Bonnie',    8, 1771);
INSERT INTO Employee VALUES (78454, 'Michael',   6, 2017);
INSERT INTO Employee VALUES (80005, 'Todd',      5, 3368);
INSERT INTO Employee VALUES (90411, 'Joe',       9, 3573);

SELECT (salary * months) AS TOTAL_EARNING, COUNT(*) FROM Employee GROUP BY TOTAL_EARNING ORDER BY TOTAL_EARNING DESC LIMIT 1 ;
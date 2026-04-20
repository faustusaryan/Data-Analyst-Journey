USE analyst_practice;

DROP TABLE IF EXISTS insurance;

CREATE TABLE insurance (
    PatientID     INT,
    age           INT,
    gender        VARCHAR(10),
    bmi           FLOAT,
    bloodpressure INT,
    diabetic      VARCHAR(5),
    children      INT,
    smoker        VARCHAR(5),
    region        VARCHAR(15),
    claim         FLOAT
);

INSERT INTO insurance VALUES
(1,  19, 'female', 27.9,  130, 'Yes', 0, 'Yes', 'southwest', 16884.92),
(2,  18, 'male',   33.8,  105, 'No',  1, 'No',  'southeast',  1725.55),
(3,  28, 'male',   33.0,  118, 'No',  3, 'No',  'southeast',  4449.46),
(4,  33, 'male',   22.7,  115, 'No',  0, 'No',  'northwest', 21984.47),
(5,  32, 'male',   28.9,  125, 'No',  0, 'No',  'northwest',  3866.86),
(6,  31, 'female', 25.7,  120, 'No',  0, 'No',  'southeast',  3756.62),
(7,  46, 'female', 33.4,  140, 'Yes', 1, 'No',  'southeast',  8240.59),
(8,  37, 'female', 27.7,  130, 'No',  3, 'No',  'northwest',  7281.51),
(9,  37, 'male',   29.8,  145, 'No',  2, 'No',  'northeast',  6406.41),
(10, 60, 'female', 25.8,  160, 'No',  0, 'No',  'northwest', 28923.14),
(11, 25, 'male',   26.2,  110, 'No',  0, 'No',  'northeast',  2721.32),
(12, 62, 'female', 26.3,  170, 'Yes', 0, 'Yes', 'southeast', 27808.73),
(13, 23, 'male',   34.4,  108, 'No',  0, 'No',  'southwest',  1826.84),
(14, 56, 'female', 39.8,  155, 'Yes', 0, 'Yes', 'southeast', 11090.72),
(15, 27, 'male',   42.1,  122, 'No',  0, 'Yes', 'southeast', 39611.76),
(16, 35, 'male',   29.8,  130, 'No',  1, 'No',  'northeast',  9500.00),
(17, 41, 'female', 28.9,  128, 'No',  2, 'No',  'northwest',  5200.00),
(18, 29, 'female', 26.5,  112, 'No',  0, 'No',  'southwest',  4100.00),
(19, 34, 'male',   27.3,  118, 'No',  1, 'No',  'southwest',  3300.00),
(20, 22, 'male',   25.4,  109, 'No',  0, 'No',  'southeast',  2100.00),

-- Rows 21-35: carefully chosen for query coverage
-- More children variety (0,1,2,3,4) for Problem 2 & 6
(21, 45, 'female', 30.5,  135, 'No',  4, 'No',  'northeast', 12000.00),
(22, 38, 'male',   31.2,  128, 'Yes', 4, 'No',  'southwest',  8750.00),
(23, 52, 'female', 28.7,  148, 'No',  3, 'Yes', 'northwest', 22000.00),
(24, 48, 'male',   35.6,  150, 'Yes', 2, 'Yes', 'southeast', 34500.00),
(25, 21, 'female', 24.3,  102, 'No',  0, 'No',  'southwest',  1950.00),

-- High BMI patients per region for Problem 7 & 8
(26, 44, 'male',   45.0,  158, 'Yes', 1, 'Yes', 'southwest', 48000.00), -- highest BMI southwest
(27, 39, 'female', 43.5,  145, 'No',  0, 'Yes', 'northeast', 41000.00), -- highest BMI northeast
(28, 55, 'male',   44.2,  162, 'Yes', 2, 'No',  'northwest', 19500.00), -- highest BMI northwest
(29, 50, 'female', 44.8,  155, 'No',  1, 'Yes', 'southeast', 45000.00), -- highest BMI southeast

-- Age group 56+ smokers for Problem 4
(30, 58, 'male',   27.1,  165, 'No',  0, 'Yes', 'northeast', 31000.00),
(31, 61, 'female', 29.4,  170, 'Yes', 1, 'No',  'southwest', 26500.00),

-- Non-diabetic, BMI 25-30 for Problem 12
(32, 26, 'male',   25.9,  115, 'No',  0, 'No',  'northeast',  3100.00),
(33, 30, 'female', 27.4,  118, 'No',  1, 'No',  'southeast',  4800.00),
(34, 36, 'male',   28.1,  122, 'No',  2, 'No',  'northwest',  6900.00),

-- Same region+bmi+smoker combo for Problem 9 (duplicate partition to show diff)
(35, 40, 'male',   29.8,  130, 'No',  1, 'No',  'northeast', 15000.00);


-- PROBLEM 1
-- What are the top 5 patients who claimed the highest insurance amounts?
-- Hint: Use RANK() or DENSE_RANK() over claim. Filter where rank <= 5.

WITH t AS (
	SELECT
		PatientID,
		claim,
		DENSE_RANK() OVER(ORDER BY claim DESC) AS rnk
	FROM insurance)
SELECT 
	PatientID,
    claim
FROM t 
WHERE rnk <= 5
ORDER BY claim DESC;
    
-- PROBLEM 2
-- What is the average insurance claimed by patients based on the
-- number of children they have?
-- Hint: AVG() as window function partitioned by children.

SELECT
	PatientID,
    ROUND(AVG(claim) OVER (PARTITION BY children), 2) AS avg_claimed
FROM insurance
ORDER BY PatientID;

-- PROBLEM 3
-- What is the highest and lowest claimed amount by patients in each region?
-- Hint: MAX() and MIN() window functions partitioned by region.

SELECT
	region,
    MIN(claim) OVER (PARTITION BY region) AS min_claim,
	MAX(claim) OVER (PARTITION BY region) AS max_claim
FROM insurance
ORDER BY PatientID;

-- PROBLEM 4
-- What is the percentage of smokers in each age group?
-- Age groups: 18-25, 26-35, 36-45, 46-55, 56+
-- Hint: Use CASE to create age_group. Then use COUNT() window function
--       partitioned by age_group to get total and smoker count.
--       percentage = smoker_count / total_count * 100

SELECT DISTINCT
    age_group,
    ROUND(
        COUNT(CASE WHEN smoker = 'Yes' THEN 1 END) OVER (PARTITION BY age_group) * 100.0 /
        COUNT(*) OVER (PARTITION BY age_group),
    2) AS smoker_percentage
FROM (
    SELECT *,
        CASE
            WHEN age BETWEEN 18 AND 25 THEN '18-25'
            WHEN age BETWEEN 26 AND 35 THEN '26-35'
            WHEN age BETWEEN 36 AND 45 THEN '36-45'
            WHEN age BETWEEN 46 AND 55 THEN '46-55'
            ELSE '56+'
        END AS age_group
    FROM insurance
) t
ORDER BY age_group;

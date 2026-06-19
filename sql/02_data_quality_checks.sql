-- Data Quality Checks
SELECT COUNT(*) AS total_rows
FROM aerofit_customers;


-- Check for Null values in each columns
SELECT
    COUNT(*) FILTER (WHERE Product IS NULL) AS null_product,
    COUNT(*) FILTER (WHERE Age IS NULL) AS null_age,
    COUNT(*) FILTER (WHERE Gender IS NULL) AS null_gender,
    COUNT(*) FILTER (WHERE Education IS NULL) AS null_education,
    COUNT(*) FILTER (WHERE Marital_Status IS NULL) AS null_marital_status,
    COUNT(*) FILTER (WHERE Usages IS NULL) AS null_usage,
    COUNT(*) FILTER (WHERE Fitness IS NULL) AS null_fitness,
    COUNT(*) FILTER (WHERE Income IS NULL) AS null_income,
    COUNT(*) FILTER (WHERE Miles IS NULL) AS null_miles
FROM aerofit_customers;


-- Check categorical values and make summary
SELECT 'product' AS column_name, product AS value, COUNT(*) AS frequency
FROM aerofit_customers
GROUP BY product

UNION ALL

SELECT 'gender' AS column_name, gender AS value, COUNT(*) AS frequency
FROM aerofit_customers
GROUP BY gender

UNION ALL

SELECT 'marital_status' AS column_name, marital_status AS value, COUNT(*) AS frequency
FROM aerofit_customers
GROUP BY marital_status

ORDER BY column_name, value;


-- Check numeric ranges and summary statistics
SELECT
    MIN(age)        AS min_age,         MAX(age)        AS max_age,         ROUND(AVG(age), 1)          AS avg_age,
    MIN(education)  AS min_education,   MAX(education)  AS max_education,   ROUND(AVG(education), 1)    AS avg_education,
    MIN(usages)     AS min_usages,      MAX(usages)     AS max_usages,      ROUND(AVG(usages), 1)       AS avg_usages,
    MIN(fitness)    AS min_fitness,     MAX(fitness)    AS max_fitness,     ROUND(AVG(fitness), 1)    AS avg_fitness,
    MIN(income)     AS min_income,      MAX(income)     AS max_income,      ROUND(AVG(income), 1)       AS avg_income,
    MIN(miles)      AS min_miles,       MAX(miles)      AS max_miles,       ROUND(AVG(miles), 1)        AS avg_miles
FROM aerofit_customers;

-- Duplicate Check
SELECT
    product, age, gender, education, marital_status, usages, fitness, income, miles,
    COUNT(*) AS occurrences
FROM aerofit_customers
GROUP BY product, age, gender, education, marital_status, usages, fitness, income, miles
HAVING COUNT(*) > 1; -- filter after grouping


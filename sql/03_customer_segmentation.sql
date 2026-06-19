-- Create age group to segment customers
SELECT 
    product,
    age,
    income,
    fitness,

    CASE
        WHEN age BETWEEN 18 AND 25 THEN 'Young (18-25)'
        WHEN age BETWEEN 26 AND 35 THEN 'Adult (26-35)'
        WHEN age BETWEEN 36 AND 45 THEN 'Middle-aged (36-45)'
        ELSE 'Senior (46+)'
    END AS age_group,
    CASE
        WHEN income < 40000 THEN 'Low Income'
        WHEN income <= 75000 THEN 'Middle Income'
        ELSE 'High Income'
    END AS income_tier,
    CASE
        WHEN fitness <= 2 THEN 'Low (1-2)'
        WHEN fitness = 3 THEN 'Moderate (3)'
        ELSE 'High (4-5)'
    END AS fitness_level
FROM aerofit_customers;


-- Create income tier breakdown by product
SELECT
    product,

    CASE
        WHEN income < 40000 THEN 'Low Income'
        WHEN income <= 75000 THEN 'Middle Income'
        ELSE 'High Income'
    END AS income_tier,
    COUNT(*) AS customer_count,
    ROUND(AVG(income), 0) AS avg_income
FROM aerofit_customers
GROUP BY product, income_tier
ORDER BY product, income_tier;

-- Create fitness level breakdown by product
SELECT
    product,

    CASE
        WHEN fitness <= 2 THEN 'Low (1-2)'
        WHEN fitness = 3 THEN 'Moderate (3)'
        ELSE 'High (4-5)'
    END AS fitness_level,
    COUNT(*) AS customer_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY product), 1) AS pct_within_product
    -- the percentage = this fitness group / total for that product x 100
FROM aerofit_customers
GROUP BY product, fitness_level
ORDER BY product, fitness_level;

-- Gender and marital status breakdown by product
SELECT
    product,
    gender,
    marital_status,
    COUNT(*) AS customer_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY product), 1) AS pct_within_product
FROM aerofit_customers
GROUP BY product, gender, marital_status
ORDER BY product, gender, marital_status;
/* Business question: How many customers bought each product, and what % of total is that? */
SELECT
    product,
    COUNT(*) as customer_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 1) AS pct_of_total
FROM aerofit_customers
GROUP BY product;

/* Business question: How does income, age, fitness, usage, and miles differ across the three products? */
SELECT
    product,
    ROUND(AVG(age), 1) as avg_age,
    ROUND(AVG(income), 0) as avg_income,
    ROUND(AVG(fitness), 1) as avg_fitness,
    ROUND(AVG(usages), 1) as avg_usage,
    ROUND(AVG(miles), 1) as avg_miles
FROM aerofit_customers
GROUP BY product;

/* Business question: Which income tier (Low/Middle/High) dominates each product category? */
SELECT
    product,

    CASE
        WHEN income < 40000 THEN 'Low (<40K)'
        WHEN income >= 40000 AND income < 75000 THEN 'Middle (40K-75K)'
        ELSE 'High (75K+)'
        /* 
        WHEN income < 40000 THEN 'Low (<40K)'
        WHEN income <= 75000 THEN 'Middle (40K-75K)'
        ELSE 'High (75K+)'
        */

    END AS income_tier,
    COUNT(*) AS customer_count,
    ROUND(AVG(income), 0) AS avg_income
FROM aerofit_customers
GROUP BY product, income_tier
ORDER BY product, income_tier;

/* Business question: Are high-fitness customers concentrated in the premium products (KP781)? */
SELECT
    product,

    CASE
        WHEN fitness <= 2 THEN 'Low (1-2)'
        WHEN fitness = 3 THEN 'Moderate (3)'
        ELSE 'High (4-5)'
        END AS fitness_level,
    COUNT(*) AS customer_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY product), 1) AS pct_within_product,
    ROUND(AVG(fitness), 1) AS avg_fitness
FROM aerofit_customers
GROUP BY product, fitness_level
ORDER BY product, fitness_level;

/* Does gender or marital status affect which product people buy? */
/* together */
SELECT
    product,
    gender,
    marital_status,
    COUNT(*) AS customer_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY product), 1) AS pct_within_product
FROM aerofit_customers
GROUP BY product, gender, marital_status
ORDER BY product, gender, marital_status;
/* gender */
SELECT
    product,
    gender,
    COUNT(*) AS customer_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY product), 1) AS pct_within_product
FROM aerofit_customers
GROUP BY product, gender
ORDER BY product, gender;
/* together */
SELECT
    product,
    marital_status,
    COUNT(*) AS customer_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY product), 1) AS pct_within_product
FROM aerofit_customers
GROUP BY product, marital_status
ORDER BY product, marital_status;

/* 
What's the complete profile of a typical buyer for each product? 
(This is the summary that marketing actually uses.) 
*/
SELECT
    product,
    ROUND(AVG(age), 1) as avg_age,
    ROUND(AVG(income), 0) as avg_income,
    ROUND(AVG(fitness), 1) as avg_fitness,
    ROUND(AVG(usages), 1) as avg_usage,
    ROUND(AVG(miles), 1) as avg_miles,
    MODE() WITHIN GROUP (ORDER BY gender) AS typical_gender,
    MODE() WITHIN GROUP (ORDER BY marital_status) AS typical_marital_status
FROM aerofit_customers
GROUP BY product
ORDER BY product;


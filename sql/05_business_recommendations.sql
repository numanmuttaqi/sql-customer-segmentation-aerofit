/*
Ranked product table
Which product has the wealthiest, fittest buyers?
*/
SELECT
    product,
    ROUND(AVG(income), 0) as avg_income,
    ROUND(AVG(fitness), 1) as avg_fitness,
    ROUND(AVG(miles), 1) as avg_miles,
    RANK() OVER (ORDER BY AVG(income) DESC) AS income_rank,
    RANK() OVER (ORDER BY AVG(fitness) DESC) AS fitness_rank
FROM aerofit_customers
GROUP BY product;

/*
Who are the customers?
Give marketing one sentence worth of data per product.
*/
SELECT
    product,
    'Avg age ' || ROUND(AVG(age), 0)
    || ', income $' || ROUND(AVG(income)/1000, 0) || 'K'
    || ', fitness ' || ROUND(AVG(fitness), 1)
    || ', uses ' || ROUND(AVG(usages), 1) || ' times per week'
    || ', runs ' || ROUND(AVG(miles), 1) || ' miles/week'
    AS target_profile
FROM aerofit_customers
GROUP BY product
ORDER BY product;

SELECT
    product,
    CONCAT(
        'Avg age ', ROUND(AVG(age), 0),
        ', income $', ROUND(AVG(income)/1000, 0), 'K',
        ', fitness ', ROUND(AVG(fitness), 1),
        ', uses ', ROUND(AVG(usages), 1), ' times per week',
        ', runs ', ROUND(AVG(miles), 1), ' miles/week'
    ) AS target_profile
FROM aerofit_customers
GROUP BY product
ORDER BY product;

/*
An upsell opportunity.
Which entry-level buyers have the profile of a premium buyer?
*/
SELECT *
FROM aerofit_customers
WHERE
    -- product = 'KP281' AND
    income > 60000 AND
    fitness >= 4 AND
    usages >= 4;


# AeroFit Treadmill Customer Segmentation — SQL Analysis

A SQL-based customer segmentation analysis for AeroFit, a fitness equipment brand. The goal is to identify the characteristics of buyers for each treadmill product so the marketing team can target the right customer with the right product.

---

## Business Problem

AeroFit sells three treadmills at different price points. The marketing team needs to know:
- Who buys each product (age, income, fitness level, gender)?
- What separates a premium buyer from an entry-level buyer?
- Which customers are candidates for an upsell?

---

## Product Portfolio

| Product | Price | Tier |
|---------|-------|------|
| KP281 | $1,500 | Entry-level |
| KP481 | $1,750 | Mid-level |
| KP781 | $2,500 | Premium |

---

## Dataset

180 customers surveyed after purchase from AeroFit stores over a 3-month period.

| Column | Description |
|--------|-------------|
| `product` | Treadmill purchased (KP281 / KP481 / KP781) |
| `age` | Customer age in years |
| `gender` | Male / Female |
| `education` | Years of education |
| `marital_status` | Single / Partnered |
| `usages` | Planned uses per week |
| `fitness` | Self-rated fitness 1 (poor) to 5 (excellent) |
| `income` | Annual income in USD |
| `miles` | Expected miles walked/run per week |

---

## Project Structure

```
sql/
  01_create_table.sql           — Schema: creates the aerofit_customers table
  02_data_quality_checks.sql    — NULL checks, value ranges, duplicate detection
  03_customer_segmentation.sql  — Age groups, income tiers, fitness levels per product
  04_product_analysis.sql       — Answers the 6 core business questions
  05_business_recommendations.sql — Product rankings, target profiles, upsell candidates

data/
  aerofit_treadmill_data.csv    — Raw survey data (180 rows)

outputs/
  key_findings.md               — Written conclusions with real numbers
```

---

## How to Run

**Requirements:** PostgreSQL

```bash
# Create the database
createdb aerofit_db

# Create the table
psql -U <your_username> -d aerofit_db -f sql/01_create_table.sql

# Load the data
psql -U <your_username> -d aerofit_db -c "\COPY aerofit_customers FROM 'data/aerofit_treadmill_data.csv' CSV HEADER;"

# Run the analysis
psql -U <your_username> -d aerofit_db -f sql/02_data_quality_checks.sql
psql -U <your_username> -d aerofit_db -f sql/03_customer_segmentation.sql
psql -U <your_username> -d aerofit_db -f sql/04_product_analysis.sql
psql -U <your_username> -d aerofit_db -f sql/05_business_recommendations.sql
```

---

## Key Findings

- **KP781 buyers are a completely different profile.** They earn 63% more ($75k vs $46k), have significantly higher fitness (4.6/5 vs 3.0/5), and run twice as many miles per week (167 vs 83) compared to KP281 buyers.

- **Fitness level is the strongest predictor of product choice.** 90% of KP781 buyers rated themselves high fitness (4–5). Only 14% of KP281 and KP481 buyers did. Income alone does not explain the split.

- **KP281 and KP481 buyers look nearly identical** in age, income, and fitness. The data suggests weak differentiation between these two products from a customer profile perspective.

- **KP781 skews heavily male** — 82.5% of premium buyers are male vs a near 50/50 split for the other two products. This is a potential gap in female marketing for the premium tier.

- **Marital status does not predict product choice** — the 60/40 partnered/single split is consistent across all three products.

- **3 upsell candidates identified** — KP281 buyers with income >$50k and fitness >= 4 who fit the premium buyer profile but chose the entry-level product.

---

## SQL Concepts Used

`GROUP BY` · `HAVING` · `CASE WHEN` · Window functions (`OVER`, `PARTITION BY`, `RANK()`) · `UNION ALL` · Aggregate functions (`COUNT`, `AVG`, `MIN`, `MAX`) · `MODE() WITHIN GROUP` · `CONCAT()`

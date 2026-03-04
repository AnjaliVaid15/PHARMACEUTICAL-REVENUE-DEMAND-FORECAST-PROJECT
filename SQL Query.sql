CREATE DATABASE PHARMA_PROJECT;
USE PHARMA_PROJECT;
SELECT * FROM pharma_sales
LIMIT 10;
ALTER TABLE pharma_sales
RENAME COLUMN datum TO date;
SELECT ROUND(SUM(REVENUE), 2) AS Total_revenue
from pharma_sales;

SELECT Year, ROUND(SUM(REVENUE), 2) AS YEARLY_REVENUE
FROM pharma_sales
GROUP  BY Year
ORDER BY Year;

SELECT DRUG_CATEGORY, ROUND(SUM(REVENUE), 2) AS TOTAL_REVENUE
FROM pharma_sales
GROUP BY Drug_Category
ORDER BY TOTAL_REVENUE DESC;

SELECT DRUG_CATEGORY, 
ROUND(SUM(REVENUE), 2) AS TOTAL_REVENUE,
ROUND(SUM(REVENUE) * 100)/  SUM(REVENUE) AS CONTRIBUTION_PERCENT
FROM pharma_sales
GROUP BY Drug_Category
ORDER BY CONTRIBUTION_PERCENT DESC;

SELECT MONTH_NUMBER, ROUND(SUM(REVENUE), 2) AS MONTHLY_REVENUE
FROM pharma_sales
GROUP BY Month_number
ORDER BY Month_number;

SELECT 
    year,
    ROUND(SUM(revenue),2) AS yearly_revenue,
    ROUND(
        (SUM(revenue) - LAG(SUM(revenue)) OVER (ORDER BY year))
        / LAG(SUM(revenue)) OVER (ORDER BY year) * 100,
    2) AS yoy_growth_percent
FROM pharma_sales
GROUP BY year
ORDER BY year;

SELECT 
    year,
    quarter,
    ROUND(SUM(revenue),2) AS quarterly_revenue
FROM pharma_sales
GROUP BY year, quarter
ORDER BY year, quarter;

SELECT 
    year,
    ROUND(SUM(revenue),2) AS best_yearly_revenue
FROM pharma_sales
GROUP BY year
ORDER BY best_yearly_revenue DESC
LIMIT 1;

SELECT 
    year,
    ROUND(SUM(revenue),2) AS worst_yearly_revenue
FROM pharma_sales
GROUP BY year
ORDER BY worst_yearly_revenue ASC
LIMIT 1;

SELECT 
    drug_category,
    ROUND(AVG(revenue),2) AS avg_monthly_revenue
FROM pharma_sales
GROUP BY drug_category
ORDER BY avg_monthly_revenue DESC;

SELECT 
    ROUND(
        (POWER(
            (SELECT SUM(revenue) FROM pharma_sales WHERE year = 2019) /
            (SELECT SUM(revenue) FROM pharma_sales WHERE year = 2014),
        1.0/5) - 1) * 100,
    2) AS CAGR_percent;

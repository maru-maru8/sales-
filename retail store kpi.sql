SET sql_mode=(SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));
USE kpi;

SELECT `date` from sales;
SELECT `date`, STR_TO_DATE(`date`, '%m/%d/%Y') from sales;

UPDATE sales
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE sales
MODIFY COLUMN `date` DATE;

SELECT * FROM sales;

1)SALES PERFORMANCE;


total sales revenue by months and seeing which months had higher revenue than overall average;
SELECT 
MONTH(`date`) AS `month`,
SUM(`total amount`) AS revenue_by_month,
(SELECT AVG(`total amount`) FROM sales) AS avg
FROM sales
GROUP BY MONTH(`date`)
ORDER BY `month`;

total sales volume by month;
SELECT 
MONTH(`date`) AS `month`,
SUM(quantity) AS total_volume
FROM sales
GROUP BY `month`
ORDER BY `month`;

Average Transaction revenue;
SELECT 
ROUND(SUM( `total amount`) / COUNT(`Transaction ID`), 0) AS avg_transaction
FROM sales;


Sales/volume by Product Category;
SELECT
`product Category`,
ROUND(AVG(`total amount`),1) AS avg_revenue,
ROUND(AVG(quantity), 0) AS avg_volume
FROM sales
GROUP BY `product Category`
ORDER BY avg_revenue desc;


SELECT * FROM sales;


2) customer analysis

top 5 customers who spent the most;
SELECT 
SUM(`total amount`) AS total_spent,
`customer ID`
FROM sales
GROUP BY `customer ID`
ORDER BY total_spent DESC
LIMIT 5;

determining if there were returning customers;
SELECT
COUNT(`customer ID`) as total_customer,
COUNT(DISTINCT `customer ID`) as unique_customers
FROM sales;


Customer Segmentation;
SELECT 
gender,
AVG(quantity) AS avg_volume,
AVG(`total amount`) AS avg_spent
FROM sales
GROUP BY gender;


3) product analysis;

top selling products and total money generated;
SELECT 
`product category`,
SUM(quantity) AS total_volume,
SUM(`total amount`) AS money_generated
FROM sales 
GROUP BY `product category`
ORDER BY total_volume DESC;

4)demographic insights;

Sales by age;
SELECT 
AVG(CASE WHEN age BETWEEN 18 AND 30 THEN `total amount` ELSE 0 END) AS avg_20_to_30,
AVG(CASE WHEN age BETWEEN 30 AND 40 THEN `total amount` ELSE 0 END) AS avg_30_to_40,
AVG(CASE WHEN age BETWEEN 40 AND 50 THEN `total amount` ELSE 0 END) AS avg_40_to_50,
AVG(CASE WHEN age BETWEEN 50 AND 65 THEN `total amount` ELSE 0 END) AS avg_50_to_65
FROM sales;


product most purchaces by woman;
SELECT
SUM(quantity) AS total_volume,
`product category`
FROM sales 
WHERE gender = 'female'
GROUP BY `product category`
ORDER BY total_volume DESC
LIMIT 1;

product most purchased by men;
SELECT
SUM(quantity) AS total_volume,
`product category`
FROM sales 
WHERE gender = 'male'
GROUP BY `product category`
ORDER BY total_volume DESC
LIMIT 1;












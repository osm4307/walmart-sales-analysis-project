-- check the dataset
SELECT *
FROM walmart
LIMIT 10;

-- check the dataset counts -> 9969
SELECT COUNT(*)
FROM walmart;

-- how many times used each payment_methods
SELECT 
	payment_method,
	COUNT(*)
FROM walmart
GROUP BY 1
ORDER BY 2 DESC;

SELECT COUNT(DISTINCT branch)
FROM walmart;

SELECT 
	MAX(quantity),
    MIN(quantity)
FROM walmart;

-- Business Problems
-- Q1. Find different payment_method and number of transaction, number of quantity sold
SELECT *
FROM walmart
LIMIT 10;

SELECT
	payment_method,
    COUNT(*) payments_counts,
    SUM(quantity) quanttity_sum
FROM walmart
GROUP BY 1;

-- Q2. Identify the highest-rated category in each branch, displaying the branch, category
-- AVG rating 
SELECT *
FROM walmart
LIMIT 10;

SELECT branch, category, avg_rating
FROM
	(SELECT 
		branch, 
		category,
		AVG(rating) avg_rating,
		RANK() OVER(PARTITION BY branch ORDER BY AVG(rating) DESC) AS rnk 
	FROM walmart
	GROUP BY 1, 2
    ) AS t1
WHERE rnk = 1;

-- Q3. Identify the busiest day for each branch based on the number of transactions
SELECT date
FROM walmart
LIMIT 10;

-- Extract day of week from date column
SELECT 
    date,
    DAYNAME(STR_TO_DATE(`date`, '%d/%m/%Y')) AS day_name
FROM walmart;

SELECT branch, city, day_name, transaction_counts
FROM 
	(SELECT 
		branch,
        city,
		DAYNAME(STR_TO_DATE(`date`, '%d/%m/%Y')) AS day_name,
		RANK() OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) AS rnk, 
		COUNT(*) AS transaction_counts
	FROM walmart
	GROUP BY 1, 2, 3
	ORDER BY 1, 4 DESC
    ) AS t1
WHERE rnk = 1;

-- Q4. Calculate the total quantity of items sold per payment method. List payments_method and total_quantity.
SELECT *
FROM walmart
LIMIT 10;

SELECT 
	payment_method,
    SUM(quantity)
FROM walmart
GROUP BY 1
ORDER BY 2 DESC;

-- Q5. Determine the average, minimum, and maximum rating of category for each city.
-- List the city, average_rating, min_rating, and max_rating.
SELECT *
FROM walmart
LIMIT 10;

SELECT 
	city,
    category,
    AVG(rating) avg_rating, 
    MIN(rating) min_rating, 
    MAX(rating) max_rating
FROM walmart
GROUP BY 1, 2
ORDER BY 1;

-- Q6. Calculate the total profit for each category by considering total_profit as 
-- (unit_price * quantity * profit_margin)
-- List category and total_profit, ordered from highest to lowest profit.
SELECT 
	category,
    SUM(total) AS total_revenue,
    SUM(total*profit_margin) AS total_profit
FROM walmart
GROUP BY 1
ORDER BY 3 DESC;

-- Q7. Determine the most common payment method for each branch
-- Display branch and the preferred_payment_method
SELECT branch, payment_method, total_trans
FROM
	(SELECT 
		branch,
		payment_method,
		COUNT(*) AS total_trans,
		RANK() OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) AS rnk
	FROM walmart
	GROUP BY 1, 2
	ORDER BY 1) AS t1
WHERE rnk = 1;

-- Q8. Categorize sales into 3 group MORNING, AFTERNOON, EVENING
-- Find out each of the shift and number of invoices

SELECT MIN(time), MAX(time)
FROM walmart;

SELECT
branch,
	CASE 
	WHEN HOUR(STR_TO_DATE(`time`, '%H:%i')) < 12 THEN 'Morning'
	WHEN HOUR(STR_TO_DATE(`time`, '%H:%i')) BETWEEN 12 AND 17 THEN 'Afternoon'
	ELSE 'Evening'
	END time_sales,
    COUNT(*) invoice_counts
FROM walmart
GROUP BY 1, 2
ORDER BY 1, 3 DESC;

-- Q9. Identify 5 branch with hightest decrese ratio in 
-- revenue compare to last year(current year 2023 and last year 2022)
-- revenue decrese ratio = last year revenue-current year revenue/last year revenue*100
WITH rev2022 AS
(
	SELECT 
		branch,
        SUM(total) revenue
	FROM walmart
    WHERE YEAR(STR_TO_DATE(date, '%d/%m/%Y')) = 2022
    GROUP BY 1
),
rev2023 AS
(
	SELECT 
		branch,
		SUM(total) revenue
	FROM walmart
    WHERE YEAR(STR_TO_DATE(date, '%d/%m/%Y')) = 2023
    GROUP BY 1
)
SELECT 
	r2.branch,
    r2.revenue rev2022,
    r3.revenue rev2023,
	ROUND(((r2.revenue - r3.revenue) / r2.revenue) * 100, 2) AS decrease_ratio
FROM rev2022 r2
JOIN rev2023 r3
ON r2.branch = r3.branch
WHERE r2.revenue > r3.revenue
ORDER BY decrease_ratio DESC
LIMIT 5;

-- Q10. How many items were sold by each city?
-- Objective: Identifying customer preferences by city
SELECT city, category, total_selling
FROM
	(SELECT 
		city,
		category,
		RANK() OVER(PARTITION BY city ORDER BY COUNT(*) DESC) AS rnk,
		COUNT(*) total_selling
	FROM walmart
	GROUP BY 1, 2
	ORDER BY 4 DESC) t1
WHERE rnk = 1;

-- Q11. What is the average profit margin for each branch and category?
-- unit_price * quantity * profit_margin → total revenue
-- Objective: Identifying profitability by branch
SELECT 
	branch,
    category,
    ROUND(AVG(total*profit_margin), 2) total_revenue
FROM walmart
GROUP BY 1, 2
ORDER BY 3 DESC;

-- Q12. What are the bottom 10 branches and categories with low ratings?
-- Objective: Identify branches or products with service quality issues
SELECT 
	branch,
    category,
    ROUND(AVG(rating), 2) average_rating
FROM walmart
GROUP BY 1, 2
ORDER BY 3
LIMIT 10;

-- Q13. What is the proportion of payment methods used within each product category?
-- Objective: Identify customer payment preferences based on product type
SELECT category, payment_method, payment_count
FROM 
	(SELECT 
		category,
		payment_method,
		RANK() OVER(PARTITION BY category ORDER BY COUNT(*) DESC) rnk,
		COUNT(*) payment_count
	FROM walmart
	GROUP BY 1, 2
	ORDER BY 3) AS t1
WHERE rnk = 1;

SELECT SUM(quantity)
FROM walmart
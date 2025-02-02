## What is the count of distinct cities in the dataset?
SELECT DISTINCT city, 
       (SELECT COUNT(DISTINCT city) FROM salesinfo) AS distinct_cities_count
FROM salesinfo;
## For each branch, what is the corresponding city?
SELECT branch, city
FROM salesinfo
GROUP BY branch, city;
## What is the count of distinct product lines in the dataset?
SELECT DISTINCT product_line, 
       (SELECT COUNT(DISTINCT product_line) FROM salesinfo) AS distinct_product_lines_count
FROM salesinfo;
## Which payment method occurs most frequently?
SELECT payment_method, COUNT(*) AS occurrences
FROM salesinfo
GROUP BY payment_method
ORDER BY occurrences DESC
LIMIT 1;
## Which product line has the highest sales?
SELECT product_line, SUM(total) AS total_sales
FROM salesinfo
GROUP BY product_line
ORDER BY total_sales DESC
LIMIT 1;
## How much revenue is generated each month?

SELECT DATE_FORMAT(date, '%Y-%m') AS month, SUM(total) AS revenue
FROM salesinfo
GROUP BY month
ORDER BY month;
## In which month did the cost of goods sold reach its peak?

SELECT DATE_FORMAT(date, '%Y-%m') AS month, SUM(cogs) AS total_cogs
FROM salesinfo
GROUP BY month
ORDER BY total_cogs DESC
LIMIT 1;
##  Which product line generated the highest revenue?
SELECT product_line, SUM(total) AS revenue
FROM salesinfo
GROUP BY product_line
ORDER BY revenue DESC
LIMIT 1;
## In which city was the highest revenue recorded?
SELECT city, SUM(total) AS total_revenue
FROM salesinfo
GROUP BY city
ORDER BY total_revenue DESC
LIMIT 1;
## Which product line incurred the highest Value Added Tax?
SELECT product_line, SUM(VAT) AS total_VAT
FROM salesinfo
GROUP BY product_line
ORDER BY total_VAT DESC
LIMIT 1;
## For each product line, add a column indicating "Good" if its sales are above average, otherwise "Bad."
SELECT product_line, 
       CASE 
           WHEN SUM(total) > (SELECT AVG(total) FROM salesinfo) THEN 'Good'
           ELSE 'Bad'
       END AS sales_classification
FROM salesinfo
GROUP BY product_line;
## Identify the branch that exceeded the average number of products sold.
SELECT branch, SUM(quantity) AS total_quantity
FROM salesinfo
GROUP BY branch
HAVING total_quantity > (SELECT AVG(quantity) FROM salesinfo);
## Which product line is most frequently associated with each gender?
SELECT gender, product_line, COUNT(*) AS occurrences
FROM salesinfo
GROUP BY gender, product_line
ORDER BY gender, occurrences DESC;
## Calculate the average rating for each product line.
SELECT product_line, AVG(rating) AS average_rating
FROM salesinfo
GROUP BY product_line;
## Count the sales occurrences for each time of day on every weekday.
SELECT DAYNAME(date) AS weekday, 
       CASE 
           WHEN HOUR(time) BETWEEN 0 AND 11 THEN 'Morning'
           WHEN HOUR(time) BETWEEN 12 AND 17 THEN 'Afternoon'
           ELSE 'Evening'
       END AS time_of_day, 
       COUNT(*) AS sales_count
FROM salesinfo
GROUP BY weekday, time_of_day
ORDER BY weekday, time_of_day;
## Identify the customer type contributing the highest revenue.
SELECT customer_type, SUM(total) AS revenue
FROM salesinfo
GROUP BY customer_type
ORDER BY revenue DESC
LIMIT 1;
## Determine the city with the highest VAT percentage.
SELECT city, AVG(VAT) AS avg_VAT_percentage
FROM salesinfo
GROUP BY city
ORDER BY avg_VAT_percentage DESC
LIMIT 1;
## Identify the customer type with the highest VAT payments.
SELECT customer_type, SUM(VAT) AS total_VAT
FROM salesinfo
GROUP BY customer_type
ORDER BY total_VAT DESC
LIMIT 1;
## What is the count of distinct customer types in the dataset?
SELECT DISTINCT customer_type, 
       (SELECT COUNT(DISTINCT customer_type) FROM salesinfo) AS distinct_customer_types_count
FROM salesinfo;
## What is the count of distinct payment methods in the dataset?
SELECT DISTINCT payment_method, 
       (SELECT COUNT(DISTINCT payment_method) FROM salesinfo) AS distinct_payment_methods
FROM salesinfo;
## Which customer type occurs most frequently?
SELECT customer_type, COUNT(*) AS frequency
FROM salesinfo
GROUP BY customer_type
ORDER BY frequency DESC
LIMIT 1;
## Identify the customer type with the highest purchase frequency.
SELECT customer_type, COUNT(invoice_id) AS purchase_frequency
FROM salesinfo
GROUP BY customer_type
ORDER BY purchase_frequency DESC
LIMIT 1;
## Determine the predominant gender among customers.
SELECT gender, COUNT(*) AS gender_count
FROM salesinfo
GROUP BY gender
ORDER BY gender_count DESC
LIMIT 1;
## Examine the distribution of genders within each branch.
SELECT branch, gender, COUNT(*) AS count
FROM salesinfo
GROUP BY branch, gender;
## Identify the time of day when customers provide the most ratings.
SELECT 
    CASE 
        WHEN HOUR(time) BETWEEN 0 AND 11 THEN 'Morning'
        WHEN HOUR(time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_of_day, COUNT(rating) AS rating_count
FROM salesinfo
GROUP BY time_of_day
ORDER BY rating_count DESC;
## Determine the time of day with the highest customer ratings for each branch.
SELECT branch,
       CASE 
           WHEN HOUR(time) BETWEEN 0 AND 11 THEN 'Morning'
           WHEN HOUR(time) BETWEEN 12 AND 17 THEN 'Afternoon'
           ELSE 'Evening'
       END AS time_of_day,
       AVG(rating) AS average_rating
FROM salesinfo
GROUP BY branch, time_of_day
ORDER BY branch, average_rating DESC;
## Identify the day of the week with the highest average ratings.
SELECT DAYNAME(date) AS day_of_week, AVG(rating) AS avg_rating
FROM salesinfo
GROUP BY day_of_week
ORDER BY avg_rating DESC
LIMIT 1;
## Determine the day of the week with the highest average ratings for each branch.
SELECT branch, DAYNAME(date) AS day_of_week, AVG(rating) AS avg_rating
FROM salesinfo
GROUP BY branch, day_of_week
ORDER BY branch, avg_rating DESC;




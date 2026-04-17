-- 👥 Customer Analysis SQL Queries
-- This file contains queries used for customer segmentation and revenue analysis

-- 1. Total number of customers
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM sales;

-- 2. Revenue
SELECT SUM(sales) AS Revenue
FROM sales;

-- 3. Average revenue per customer
SELECT 
    SUM(sales) / COUNT(DISTINCT customer_id) AS revenue_per_customer
FROM sales;

-- 4. Orders per customer
SELECT 
    customer_id,
    COUNT(order_id) AS total_orders
FROM sales
GROUP BY customer_id
ORDER BY total_orders DESC;

-- 5. Average orders per customer
SELECT 
    AVG(order_count) AS avg_orders_per_customer
FROM (
    SELECT customer_id, COUNT(order_id) AS order_count
    FROM sales
    GROUP BY customer_id
) t;

-- 6. Revenue by customer segment
SELECT 
    segment,
    SUM(sales) AS total_sales
FROM sales
GROUP BY segment
ORDER BY total_sales DESC;

-- 7. Customer segmentation (VIP / Regular / Low)
SELECT 
    customer_id,
    SUM(sales) AS total_spent,
    CASE 
        WHEN SUM(sales) > 100000 THEN 'VIP'
        WHEN SUM(sales) BETWEEN 50000 AND 100000 THEN 'Regular'
        ELSE 'Low'
    END AS customer_segment
FROM sales
GROUP BY customer_id;

-- 8. Revenue by customer segment (VIP / Regular / Low)
SELECT 
    customer_segment,
    SUM(total_spent) AS segment_revenue
FROM (
    SELECT 
        customer_id,
        SUM(sales) AS total_spent,
        CASE 
            WHEN SUM(sales) > 100000 THEN 'VIP'
            WHEN SUM(sales) BETWEEN 50000 AND 100000 THEN 'Regular'
            ELSE 'Low'
        END AS customer_segment
    FROM sales
    GROUP BY customer_id
) t
GROUP BY customer_segment
ORDER BY segment_revenue DESC;

-- 9. Top 10 customers by revenue
SELECT 
    customer_id,
    SUM(sales) AS total_revenue
FROM sales
GROUP BY customer_id
ORDER BY total_revenue DESC
LIMIT 10;

-- 10. Revenue growth by year
SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    SUM(sales) AS total_revenue
FROM sales
GROUP BY year
ORDER BY year;

-- 11. Number of customers by year
SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    COUNT(DISTINCT customer_id) AS total_customers
FROM sales
GROUP BY year
ORDER BY year;

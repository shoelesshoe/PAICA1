use PAICA1

-- inner join all 3 tables
SELECT *
FROM label l
INNER JOIN customer c
    ON l.country_code = c.country_code
    AND l.customer_id = c.customer_id
INNER JOIN [order] o
    ON l.country_code = o.country_code
    AND l.order_id = o.order_id;


USE PAICA1 -- Top 3 Payment Methods by Fraud Percentage

SELECT TOP 3
    o.payment_method,
    COUNT(CASE WHEN l.is_fraud = 1 THEN 1 END) AS fraud_count,
    COUNT(*) AS total_transactions,
    ROUND((COUNT(CASE WHEN l.is_fraud = 1 THEN 1 END) * 100.0) / COUNT(*), 2) AS fraud_percentage
FROM 
    label l
INNER JOIN [order] o
    ON l.country_code = o.country_code 
    AND l.order_id = o.order_id
GROUP BY 
    o.payment_method
ORDER BY 
    fraud_percentage DESC;


USE PAICA1 -- Top 5 Highest Spenders (Customer)

SELECT TOP 5 
    c.country_code,
    c.customer_id,
    SUM(o.order_value) AS total_spent,
    COUNT(o.order_id) AS total_orders
FROM 
    customer c
INNER JOIN label l
    ON c.country_code = l.country_code 
    AND c.customer_id = l.customer_id
INNER JOIN [order] o
    ON l.country_code = o.country_code 
    AND l.order_id = o.order_id
GROUP BY 
    c.country_code, c.customer_id
ORDER BY 
    total_spent DESC;
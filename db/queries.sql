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
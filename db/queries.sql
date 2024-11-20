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


-- Top 5 Payment Methods by Fraud Percentage

SELECT TOP 5
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


-- Top 5 Highest Customer Spenders

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


-- Countries sorted according to Highest Fraud Value

SELECT 
    l.country_code,
    COUNT(l.order_id) AS total_fraudulent_orders,
    SUM(o.order_value) AS total_fraudulent_value
FROM 
    label l
INNER JOIN [order] o
    ON l.country_code = o.country_code 
    AND l.order_id = o.order_id
WHERE 
    l.is_fraud = 1
GROUP BY 
    l.country_code
ORDER BY 
    total_fraudulent_value DESC;


-- Top 5 Most Frequent Payment Methods

SELECT TOP 5
    c.country_code,
    o.payment_method,
    COUNT(*) AS total_transactions
FROM 
    customer c
INNER JOIN label l
    ON c.customer_id = l.customer_id
INNER JOIN [order] o
    ON l.order_id = o.order_id 
    AND c.country_code = o.country_code
GROUP BY 
    c.country_code, o.payment_method
ORDER BY 
    total_transactions DESC;


-- Top 3 Frequent Payment Methods per Country

WITH RankedPayments AS (
    SELECT 
        c.country_code,
        o.payment_method,
        COUNT(*) AS total_transactions,
        RANK() OVER (PARTITION BY c.country_code ORDER BY COUNT(*) DESC) AS rank
    FROM 
        customer c
    INNER JOIN label l
        ON c.customer_id = l.customer_id
    INNER JOIN [order] o
        ON l.order_id = o.order_id 
        AND c.country_code = o.country_code
    GROUP BY 
        c.country_code, o.payment_method
)
SELECT 
    country_code,
    payment_method,
    total_transactions
FROM 
    RankedPayments
WHERE 
    rank <= 3
ORDER BY 
    country_code, rank;

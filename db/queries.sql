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
    c.customer_id,
    c.country_code,
    COUNT(l.order_id) AS fraudulent_orders
FROM 
    label l
INNER JOIN customer c
    ON l.country_code = c.country_code 
    AND l.customer_id = c.customer_id
WHERE 
    l.is_fraud = 1
GROUP BY 
    c.customer_id, c.country_code
HAVING 
    COUNT(l.order_id) > 1
ORDER BY 
    fraudulent_orders DESC;
use PAI_CA1_test

CREATE TABLE customer (
    country_code VARCHAR(10),                -- Assuming country codes are short strings
    customer_id VARCHAR(10) PRIMARY KEY,              -- Assuming customer IDs are integers
    mobile_verified INT,                      -- Boolean value (1 for true, 0 for false)
    num_orders_last_50days INT,              -- Number of orders in the last 50 days
    num_cancelled_orders_last_50days INT,    -- Number of cancelled orders in the last 50 days
    num_refund_orders_last_50days INT,       -- Number of refund orders in the last 50 days
    total_payment_last_50days DECIMAL(18, 2), -- Total payment as a decimal (for currency)
    num_associated_customers INT,             -- Number of associated customers
    first_order_datetime DATETIME             -- Date and time of the first order
);


use PAI_CA1_test

BULK INSERT customer
FROM 'E:\SP\Year 2 Sem 2\ST1508 Practical AI\PAICA1\datasets\final_customer.csv'
WITH (
    FIELDTERMINATOR = ',',  -- Change to your field delimiter if necessary
    ROWTERMINATOR = '\n',   -- Change if your file uses a different row terminator
    FIRSTROW = 2            -- Set to 2 if your file has a header row
);

use Practical_AI_sk

CREATE TABLE orders (
	country_code CHAR(2),                
    order_id VARCHAR(10),    
    collect_type VARCHAR(50),            
    payment_method VARCHAR(100),        
    order_value DECIMAL(15, 2),          
    num_items_ordered DECIMAL(10, 2),    
    refund_value DECIMAL(15, 2),         
    order_date DATE,                     
	PRIMARY KEY(country_code, order_id)
);


use Practical_AI_sk

BULK INSERT orders
FROM 'C:\Users\P2300533\Documents\PAI\PAICA1\datasets\final_order.csv'
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',   
    FIRSTROW = 2            
);
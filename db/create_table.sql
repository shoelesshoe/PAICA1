use PAI_CA1_test

CREATE TABLE customer (
    country_code VARCHAR(10),                
    customer_id VARCHAR(50),                  
    mobile_verified BIT,                      
    num_orders_last_50days INT,               
    num_cancelled_orders_last_50days INT,     
    num_refund_orders_last_50days INT,        
    total_payment_last_50days DECIMAL(18, 2), 
    num_associated_customers INT,             
    first_order_datetime DATETIME,            
    PRIMARY KEY (country_code, customer_id)   
);


use PAI_CA1_test

BULK INSERT customer
FROM 'C:\Users\p2308924\Practical AI (PAI)\Github CA\PAICA1\Datasets\final_customer.csv'
WITH (
    FIELDTERMINATOR = ',', 
    ROWTERMINATOR = '\n',   
    FIRSTROW = 2            
);

use PAI_CA1_test

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


use PAI_CA1_test

BULK INSERT orders
FROM 'C:\Users\p2308924\Practical AI (PAI)\Github CA\PAICA1\Datasets\final_order.csv'
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',   
    FIRSTROW = 2            
);
-- create database "PAICA1"

use PAICA1

CREATE TABLE customer (
    country_code CHAR(2),                
    customer_id VARCHAR(50),                  
    mobile_verified BIT,                      
    num_orders_last_50days INT,               
    num_cancelled_orders_last_50days INT,     
    num_refund_orders_last_50days INT,        
    total_payment_last_50days FLOAT, 
    num_associated_customers INT,             
    first_order_datetime DATETIME,            
    PRIMARY KEY (country_code, customer_id)   
);

CREATE TABLE [order] (
	country_code CHAR(2),                
    order_id VARCHAR(10),    
    collect_type VARCHAR(50),            
    payment_method VARCHAR(100),        
    order_value FLOAT,          
    num_items_ordered INT,    
    refund_value FLOAT,         
    order_date DATE,                     
	PRIMARY KEY(country_code, order_id)
);

CREATE TABLE label (
	country_code CHAR(2),                
    order_id VARCHAR(10),    
    customer_id VARCHAR(50),
	is_fraud BIT,

	PRIMARY KEY(country_code, order_id, customer_id),
    FOREIGN KEY (country_code, customer_id) REFERENCES customer(country_code, customer_id),       
    FOREIGN KEY (country_code, order_id) REFERENCES [order](country_code, order_id)
);


use PAICA1

BULK INSERT customer
FROM 'C:\SP\Year 2 Sem 2\Practical AI (PAI)\CA1\PAICA1\datasets\final_customer.csv'
WITH (
    FIELDTERMINATOR = ',', 
    ROWTERMINATOR = '\n',   
    FIRSTROW = 2            
);

BULK INSERT [order]
FROM 'C:\SP\Year 2 Sem 2\Practical AI (PAI)\CA1\PAICA1\datasets\final_order.csv'
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',   
    FIRSTROW = 2            
);

BULK INSERT label
FROM 'C:\SP\Year 2 Sem 2\Practical AI (PAI)\CA1\PAICA1\datasets\final_labels.csv'
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',   
    FIRSTROW = 2            
);
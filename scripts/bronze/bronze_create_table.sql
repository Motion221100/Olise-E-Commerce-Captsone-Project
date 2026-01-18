DROP OR ALTER PROCEDURE IF EXISTS bronze.create_tables ()
DELIMITER $$
	CREATE PROCEDURE bronze.create_tables ()
		BEGIN
			CREATE TABLE bronze.geo_geolocation (
				geo_zipcode_prefix INT, 
				geo_latitude DECIMAL(15, 8),
				geo_longitude DECIMAL(15, 8),
				geo_city TEXT, 
				geo_state VARCHAR(25)
			);
            
			CREATE TABLE bronze.cust_customers (
				customer_id TEXT,
				customer_unique_id TEXT, 
                customer_zipcode_prefix INT,
				customer_city TEXT, 
				customer_state VARCHAR(2)
			);
			
			CREATE TABLE bronze.ord_orders (
				order_id VARCHAR(100),
                customer_id VARCHAR(100),
				order_status VARCHAR(15),
				order_purch_timestamp DATETIME,
				order_appr_at DATETIME,
				del_carrier_date DATETIME,
				del_customer_date DATETIME,
				estim_delivery_date DATE
			);
            
			CREATE TABLE bronze.selr_sellers (
				seller_id VARCHAR(100),
				seller_zipcode_prefix INT, 
				seller_city TEXT, 
				seller_state VARCHAR(2)
			);
            
			CREATE TABLE bronze.ord_order_items (
				order_id VARCHAR(100),
				order_item_id INT,
                product_id VARCHAR(100),
				seller_id VARCHAR(100),
				shipping_lim_date DATETIME,
				price DECIMAL(10, 2),
				freight_value DECIMAL(5, 2)
			);
			
			CREATE TABLE bronze.ord_order_payments (
				order_id VARCHAR(100),
				payment_sequential INT,
				payment_type VARCHAR(25),
				payment_installments INT,
				payment_value DECIMAL(10, 2)
			
			);
			
			CREATE TABLE bronze.ord_order_reviews (
				review_id VARCHAR(100),
                order_id VARCHAR(100),
				review_score INT,
				review_comment_title TEXT,
				review_comment_message TEXT,
                review_creation_date DATETIME,
                review_answer_timestamp DATETIME
			);
			
			CREATE TABLE bronze.prod_products (
				product_id VARCHAR(100),
				prod_category_name TEXT, 
				prod_name_length INT,
				prod_description_length INT,
				prod__photos_qty INT,
				prod_weight_g INT,
				prod_length_cm INT,
				prod_height_cm INT, 
				prod_width_cm INT
			);
			
			CREATE TABLE bronze.prod_category_name_translation (
				prod_category_name TEXT,
				prod_category_name_english TEXT
			);
	
        END $$
DELIMITER ;
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
				order_purchase_timestamp TIMESTAMP,
				order_appr_at TIMESTAMP,
				order_delivered_carrier_date TIMESTAMP,
				order_delivered_customer_date TIMESTAMP,
				order_estimated_delivery_date TIMESTAMP
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
				shipping_limit_date TIMESTAMP,
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
                review_creation_date TIMESTAMP,
                review_answer_timestamp TIMESTAMP
			);
			
			CREATE TABLE bronze.prod_products (
				product_id VARCHAR(100),
				product_category_name TEXT, 
				product_name_length INT,
				product_description_length INT,
				product_photos_qty INT,
				product_weight_g INT,
				product_length_cm INT,
				product_height_cm INT, 
				product_width_cm INT
			);
			
			CREATE TABLE bronze.prod_category_name_translation (
				product_category_name TEXT,
				product_category_name_english TEXT
			);
	
        END $$
DELIMITER ;
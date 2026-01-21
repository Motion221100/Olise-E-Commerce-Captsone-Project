CREATE TABLE gold.dim_date AS
SELECT DISTINCT
    DATE(order_purchase_timestamp) AS date,
    DAY(order_purchase_timestamp) AS day,
    MONTH(order_purchase_timestamp) AS month,
    QUARTER(order_purchase_timestamp) AS quarter,
    YEAR(order_purchase_timestamp) AS year,
    DAYOFWEEK(order_purchase_timestamp) AS day_of_week,
    WEEK(order_purchase_timestamp) AS week_of_year,
    DAYOFYEAR(order_purchase_timestamp) AS day_of_year,
    DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS year_month,
    CASE 
        WHEN DAYOFWEEK(order_purchase_timestamp) IN (1,7) THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    CASE 
        WHEN MONTH(order_purchase_timestamp) IN (12,1,2) THEN 'Summer'
        WHEN MONTH(order_purchase_timestamp) IN (3,4,5) THEN 'Autumn'
        WHEN MONTH(order_purchase_timestamp) IN (6,7,8) THEN 'Winter'
        WHEN MONTH(order_purchase_timestamp) IN (9,10,11) THEN 'Spring'
    END AS season
FROM silver.ord_orders;

CREATE VIEW gold.dim_date_view AS
SELECT DISTINCT
    DATE(order_purchase_timestamp) AS date,
    DAY(order_purchase_timestamp) AS day,
    MONTH(order_purchase_timestamp) AS month,
    QUARTER(order_purchase_timestamp) AS quarter,
    YEAR(order_purchase_timestamp) AS year,
    DAYOFWEEK(order_purchase_timestamp) AS day_of_week,
    WEEK(order_purchase_timestamp) AS week_of_year,
    DAYOFYEAR(order_purchase_timestamp) AS day_of_year,
    DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS year_month,
    CASE 
        WHEN DAYOFWEEK(order_purchase_timestamp) IN (1,7) THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    CASE 
        WHEN MONTH(order_purchase_timestamp) IN (12,1,2) THEN 'Summer'
        WHEN MONTH(order_purchase_timestamp) IN (3,4,5) THEN 'Autumn'
        WHEN MONTH(order_purchase_timestamp) IN (6,7,8) THEN 'Winter'
        WHEN MONTH(order_purchase_timestamp) IN (9,10,11) THEN 'Spring'
    END AS season
FROM silver.ord_orders;

CREATE TABLE gold.dim_product AS
SELECT
    p.product_id,
    p.product_category_name,
    pnt.product_category_name_english AS product_name_translation,
    AVG(oi.price) AS avg_price_sold,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    COUNT(DISTINCT oi.seller_id) AS unique_sellers,
    SUM(oi.price) AS total_revenue,
    SUM(oi.freight_value) AS total_freight_revenue,
    COALESCE(AVG(p.product_photos_qty),0) AS avg_photos_qty,
    COALESCE(AVG(p.product_weight_g),0) AS avg_weight_g,
    COALESCE(AVG(p.product_description_length),0) AS avg_description_length,
    CASE 
        WHEN COUNT(DISTINCT oi.order_id) > 10 THEN 'High Demand'
        WHEN COUNT(DISTINCT oi.order_id) BETWEEN 3 AND 10 THEN 'Medium Demand'
        ELSE 'Low Demand'
    END AS demand_category
FROM silver.prod_products p
LEFT JOIN silver.prod_category_name_translation pnt
    ON p.product_category_name = pnt.product_category_name
LEFT JOIN silver.ord_order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_category_name,
    pnt.product_category_name_english;

CREATE VIEW gold.dim_product_view AS
SELECT
    p.product_id,
    p.product_category_name,
    pnt.product_category_name_english AS product_name_translation,
    AVG(oi.price) AS avg_price_sold,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    COUNT(DISTINCT oi.seller_id) AS unique_sellers,
    SUM(oi.price) AS total_revenue,
    SUM(oi.freight_value) AS total_freight_revenue,
    COALESCE(AVG(p.product_photos_qty),0) AS avg_photos_qty,
    COALESCE(AVG(p.product_weight_g),0) AS avg_weight_g,
    COALESCE(AVG(p.product_description_length),0) AS avg_description_length,
    CASE 
        WHEN COUNT(DISTINCT oi.order_id) > 10 THEN 'High Demand'
        WHEN COUNT(DISTINCT oi.order_id) BETWEEN 3 AND 10 THEN 'Medium Demand'
        ELSE 'Low Demand'
    END AS demand_category
FROM silver.prod_products p
LEFT JOIN silver.prod_category_name_translation pnt
    ON p.product_category_name = pnt.product_category_name
LEFT JOIN silver.ord_order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_category_name,
    pnt.product_category_name_english;

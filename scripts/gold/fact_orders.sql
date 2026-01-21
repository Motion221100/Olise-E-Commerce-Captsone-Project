CREATE TABLE gold.fact_orders AS
SELECT
    oo.order_id,
    oo.customer_id,
    oo.order_status,
    DATE(oo.order_purchase_timestamp) AS order_date,
    SUM(oi.price) AS total_order_price,
    SUM(oi.freight_value) AS total_order_freight,
    SUM(op.payment_value) AS total_order_paid,
    COUNT(DISTINCT oi.product_id) AS unique_products_in_order,
    COUNT(DISTINCT oi.seller_id) AS unique_sellers_in_order,
    COUNT(oi.order_item_id) AS total_items_in_order,
    SUM(op.payment_value) - SUM(oi.price) - SUM(oi.freight_value) AS payment_discrepancy,
    CASE 
        WHEN SUM(oi.price) > 500 THEN 'High Value Order'
        WHEN SUM(oi.price) BETWEEN 100 AND 500 THEN 'Medium Value Order'
        ELSE 'Low Value Order'
    END AS order_value_category,
    CASE 
        WHEN oo.order_status = 'delivered' AND oo.order_delivered_customer_date IS NOT NULL 
             AND oo.order_estimated_delivery_date IS NOT NULL THEN
            DATEDIFF(oo.order_delivered_customer_date, oo.order_estimated_delivery_date)
        ELSE NULL
    END AS delivery_variance_days,
    AVG(op.payment_installments) AS avg_payment_installments
FROM silver.ord_orders oo
LEFT JOIN silver.ord_order_items oi
    ON oo.order_id = oi.order_id
LEFT JOIN silver.ord_order_payments op
    ON oo.order_id = op.order_id
GROUP BY
    oo.order_id,
    oo.customer_id,
    oo.order_status,
    DATE(oo.order_purchase_timestamp),
    oo.order_delivered_customer_date,
    oo.order_estimated_delivery_date;

CREATE VIEW gold.fact_orders_view AS
SELECT
    oo.order_id,
    oo.customer_id,
    oo.order_status,
    DATE(oo.order_purchase_timestamp) AS order_date,
    SUM(oi.price) AS total_order_price,
    SUM(oi.freight_value) AS total_order_freight,
    SUM(op.payment_value) AS total_order_paid,
    COUNT(DISTINCT oi.product_id) AS unique_products_in_order,
    COUNT(DISTINCT oi.seller_id) AS unique_sellers_in_order,
    COUNT(oi.order_item_id) AS total_items_in_order,
    SUM(op.payment_value) - SUM(oi.price) - SUM(oi.freight_value) AS payment_discrepancy,
    CASE 
        WHEN SUM(oi.price) > 500 THEN 'High Value Order'
        WHEN SUM(oi.price) BETWEEN 100 AND 500 THEN 'Medium Value Order'
        ELSE 'Low Value Order'
    END AS order_value_category,
    CASE 
        WHEN oo.order_status = 'delivered' AND oo.order_delivered_customer_date IS NOT NULL 
             AND oo.order_estimated_delivery_date IS NOT NULL THEN
            DATEDIFF(oo.order_delivered_customer_date, oo.order_estimated_delivery_date)
        ELSE NULL
    END AS delivery_variance_days,
    AVG(op.payment_installments) AS avg_payment_installments
FROM silver.ord_orders oo
LEFT JOIN silver.ord_order_items oi
    ON oo.order_id = oi.order_id
LEFT JOIN silver.ord_order_payments op
    ON oo.order_id = op.order_id
GROUP BY
    oo.order_id,
    oo.customer_id,
    oo.order_status,
    DATE(oo.order_purchase_timestamp),
    oo.order_delivered_customer_date,
    oo.order_estimated_delivery_date;

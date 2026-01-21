CREATE TABLE gold.fact_reviews AS
SELECT
    orr.order_id,
    orr.review_score,
    orr.review_comment_message,
    orr.review_creation_date,
    orr.review_answer_timestamp,
    DATE(oo.order_purchase_timestamp) AS order_date,
    DATEDIFF(orr.review_creation_date, DATE(oo.order_purchase_timestamp)) AS days_to_review,
    DATEDIFF(orr.review_answer_timestamp, orr.review_creation_date) AS days_to_answer,
    CASE 
        WHEN orr.review_score >= 4 THEN 'Positive Review'
        WHEN orr.review_score = 3 THEN 'Neutral Review'
        ELSE 'Negative Review'
    END AS review_sentiment,
    CASE 
        WHEN orr.review_comment_message IS NOT NULL AND LENGTH(TRIM(orr.review_comment_message)) > 0 
        THEN 'Has Comment'
        ELSE 'No Comment'
    END AS has_comment_status,
    CASE 
        WHEN orr.review_score = 5 THEN 'Excellent'
        WHEN orr.review_score = 4 THEN 'Good'
        WHEN orr.review_score = 3 THEN 'Average'
        WHEN orr.review_score = 2 THEN 'Poor'
        WHEN orr.review_score = 1 THEN 'Very Poor'
    END AS review_rating_category,
    COALESCE(LENGTH(orr.review_comment_message), 0) AS comment_length,
    CASE 
        WHEN DATEDIFF(orr.review_creation_date, DATE(oo.order_purchase_timestamp)) <= 7 THEN 'Fast Reviewer'
        WHEN DATEDIFF(orr.review_creation_date, DATE(oo.order_purchase_timestamp)) BETWEEN 8 AND 30 THEN 'Normal Reviewer'
        ELSE 'Late Reviewer'
    END AS reviewer_speed_category
FROM silver.ord_order_reviews orr
LEFT JOIN silver.ord_orders oo
    ON orr.order_id = oo.order_id;

CREATE VIEW gold.fact_reviews_view AS
SELECT
    orr.order_id,
    orr.review_score,
    orr.review_comment_message,
    orr.review_creation_date,
    orr.review_answer_timestamp,
    DATE(oo.order_purchase_timestamp) AS order_date,
    DATEDIFF(orr.review_creation_date, DATE(oo.order_purchase_timestamp)) AS days_to_review,
    DATEDIFF(orr.review_answer_timestamp, orr.review_creation_date) AS days_to_answer,
    CASE 
        WHEN orr.review_score >= 4 THEN 'Positive Review'
        WHEN orr.review_score = 3 THEN 'Neutral Review'
        ELSE 'Negative Review'
    END AS review_sentiment,
    CASE 
        WHEN orr.review_comment_message IS NOT NULL AND LENGTH(TRIM(orr.review_comment_message)) > 0 
        THEN 'Has Comment'
        ELSE 'No Comment'
    END AS has_comment_status,
    CASE 
        WHEN orr.review_score = 5 THEN 'Excellent'
        WHEN orr.review_score = 4 THEN 'Good'
        WHEN orr.review_score = 3 THEN 'Average'
        WHEN orr.review_score = 2 THEN 'Poor'
        WHEN orr.review_score = 1 THEN 'Very Poor'
    END AS review_rating_category,
    COALESCE(LENGTH(orr.review_comment_message), 0) AS comment_length,
    CASE 
        WHEN DATEDIFF(orr.review_creation_date, DATE(oo.order_purchase_timestamp)) <= 7 THEN 'Fast Reviewer'
        WHEN DATEDIFF(orr.review_creation_date, DATE(oo.order_purchase_timestamp)) BETWEEN 8 AND 30 THEN 'Normal Reviewer'
        ELSE 'Late Reviewer'
    END AS reviewer_speed_category
FROM silver.ord_order_reviews orr
LEFT JOIN silver.ord_orders oo
    ON orr.order_id = oo.order_id;

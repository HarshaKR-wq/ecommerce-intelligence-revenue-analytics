USE ecommerce_analytics;

SHOW VARIABLES LIKE 'local_infile';

SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'local_infile';

LOAD DATA INFILE 
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/sales_analysis.csv'
INTO TABLE sales_analysis
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    order_id,
    order_item_id,
    product_id,
    seller_id,
    shipping_limit_date,
    price,
    freight_value,
    product_category_name_english,
    customer_id,
    order_status,
    order_purchase_timestamp
);

SELECT COUNT(*) AS total_rows
FROM sales_analysis;

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/customer_analysis.csv'
INTO TABLE customer_analysis
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state

);

SELECT COUNT(*) AS total_rows
FROM customer_analysis;

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/payment_analysis.csv'
INTO TABLE payment_analysis
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    @payment_sequential,
    payment_type,
    @payment_installments,
    @payment_value
)
SET
    payment_sequential = NULLIF(@payment_sequential, ''),
    payment_installments = NULLIF(@payment_installments, ''),
    payment_value = NULLIF(@payment_value, '');


SELECT COUNT(*) AS total_rows
FROM payment_analysis;


LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/review_analysis.csv'
INTO TABLE review_analysis
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    @review_score
)
SET review_score = NULLIF(@review_score, '');

SELECT
    COUNT(*) AS total_rows,
    SUM(review_score IS NULL) AS missing_review_scores
FROM review_analysis;

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/seller_analysis.csv'
INTO TABLE seller_analysis
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    order_id,
    order_item_id,
    product_id,
    seller_id,
    shipping_limit_date,
    price,
    freight_value,
    product_category_name_english,
    seller_zip_code_prefix,
    seller_city,
    seller_state
);

SELECT COUNT(*) AS total_rows
FROM seller_analysis;

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/delivery_analysis.csv'
INTO TABLE delivery_analysis
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    @order_approved_at,
    @order_delivered_carrier_date,
    @order_delivered_customer_date,
    order_estimated_delivery_date,
    @invalid_delivery_date,
    @canceled_with_delivery_date,
    @delivered_without_approval,
    @invalid_approval_carrier_sequence,
    @invalid_carrier_customer_sequence,
    @order_item_id,
    seller_id,
    @shipping_limit_date,
    seller_zip_code_prefix,
    seller_city,
    seller_state,
    customer_unique_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state,
    @actual_delivery_days,
    @delivery_delay_days,
    @purchase_to_approval_hours,
    @approval_to_carrier_hours,
    @carrier_to_customer_hours
)
SET
    order_approved_at = NULLIF(@order_approved_at, ''),
    order_delivered_carrier_date = NULLIF(@order_delivered_carrier_date, ''),
    order_delivered_customer_date = NULLIF(@order_delivered_customer_date, ''),

    invalid_delivery_date = CASE LOWER(@invalid_delivery_date)
        WHEN 'true' THEN 1
        WHEN 'false' THEN 0
        ELSE NULL
    END,

    canceled_with_delivery_date = CASE LOWER(@canceled_with_delivery_date)
        WHEN 'true' THEN 1
        WHEN 'false' THEN 0
        ELSE NULL
    END,

    delivered_without_approval = CASE LOWER(@delivered_without_approval)
        WHEN 'true' THEN 1
        WHEN 'false' THEN 0
        ELSE NULL
    END,

    invalid_approval_carrier_sequence = CASE LOWER(@invalid_approval_carrier_sequence)
        WHEN 'true' THEN 1
        WHEN 'false' THEN 0
        ELSE NULL
    END,

    invalid_carrier_customer_sequence = CASE LOWER(@invalid_carrier_customer_sequence)
        WHEN 'true' THEN 1
        WHEN 'false' THEN 0
        ELSE NULL
    END,

    order_item_id = NULLIF(@order_item_id, ''),
    shipping_limit_date = NULLIF(@shipping_limit_date, ''),
    actual_delivery_days = NULLIF(@actual_delivery_days, ''),
    delivery_delay_days = NULLIF(@delivery_delay_days, ''),
    purchase_to_approval_hours = NULLIF(@purchase_to_approval_hours, ''),
    approval_to_carrier_hours = NULLIF(@approval_to_carrier_hours, ''),
    carrier_to_customer_hours = NULLIF(@carrier_to_customer_hours, '');

SELECT COUNT(*) AS total_rows
FROM delivery_analysis;

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/product_analysis.csv'
INTO TABLE product_analysis
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    order_id,
    order_item_id,
    product_id,
    seller_id,
    @shipping_limit_date,
    price,
    freight_value,
    product_category_name_english,
    @product_photos_qty,
    @product_weight_g,
    @product_length_cm,
    @product_height_cm,
    @product_width_cm,
    @product_volume_cm3
)
SET
    shipping_limit_date = NULLIF(@shipping_limit_date, ''),
    product_photos_qty = NULLIF(@product_photos_qty, ''),
    product_weight_g = NULLIF(@product_weight_g, ''),
    product_length_cm = NULLIF(@product_length_cm, ''),
    product_height_cm = NULLIF(@product_height_cm, ''),
    product_width_cm = NULLIF(@product_width_cm, ''),
    product_volume_cm3 = NULLIF(@product_volume_cm3, '');

SELECT COUNT(*) AS total_rows
FROM product_analysis;



SELECT 'sales_analysis' AS table_name, COUNT(*) AS total_rows FROM sales_analysis
UNION ALL
SELECT 'customer_analysis', COUNT(*) FROM customer_analysis
UNION ALL
SELECT 'payment_analysis', COUNT(*) FROM payment_analysis
UNION ALL
SELECT 'review_analysis', COUNT(*) FROM review_analysis
UNION ALL
SELECT 'seller_analysis', COUNT(*) FROM seller_analysis
UNION ALL
SELECT 'delivery_analysis', COUNT(*) FROM delivery_analysis
UNION ALL
SELECT 'product_analysis', COUNT(*) FROM product_analysis;

SELECT
    TABLE_NAME,
    COLUMN_NAME,
    COLUMN_TYPE,
    IS_NULLABLE,
    COLUMN_KEY
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'ecommerce_analytics'
ORDER BY TABLE_NAME, ORDINAL_POSITION;
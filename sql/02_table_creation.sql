USE ecommerce_analytics;

CREATE TABLE sales_analysis(
    order_id VARCHAR(32),
    order_item_id INT,
    product_id VARCHAR(32),
    seller_id VARCHAR(32),
    shipping_limit_date DATETIME,
    price DECIMAL(10,2),
    freight_value DECIMAL(10,2),
    product_category_name_english VARCHAR(100),
    customer_id VARCHAR(32),
    order_status VARCHAR(20),
    order_purchase_timestamp DATETIME,
    PRIMARY KEY (order_id,order_item_id)
    );

CREATE TABLE customer_analysis(
    order_id VARCHAR(32),
    customer_id VARCHAR(32),
    order_status VARCHAR(20),
    order_purchase_timestamp DATETIME,
    customer_unique_id VARCHAR(32),
    customer_zip_code_prefix VARCHAR(10),
    customer_city VARCHAR(100),
    customer_state VARCHAR(2),
    PRIMARY KEY (order_id)
);

DESC customer_analysis;

SHOW TABLES;

CREATE TABLE payment_analysis(
    payment_analysis_id BIGINT AUTO_INCREMENT,
    order_id VARCHAR(32),
    customer_id VARCHAR(32),
    order_status VARCHAR(20),
    order_purchase_timestamp DATETIME,
    payment_sequential INT,
    payment_type VARCHAR(20),
    payment_installment INT,
    payment_value DECIMAL(10,2),
    PRIMARY KEY (payment_analysis_id)
);

ALTER TABLE payment_analysis
RENAME COLUMN payment_installment TO payment_installments;

DESC payment_analysis

CREATE TABLE review_analysis (
    review_analysis_id BIGINT AUTO_INCREMENT,
    order_id VARCHAR(32),
    customer_id VARCHAR(32),
    order_status VARCHAR(20),
    order_purchase_timestamp DATETIME,
    review_score TINYINT,
    PRIMARY KEY (review_analysis_id)
);

DESC review_analysis;

CREATE TABLE seller_analysis (
    order_id VARCHAR(32),
    order_item_id INT,
    product_id VARCHAR(32),
    seller_id VARCHAR(32),
    shipping_limit_date DATETIME,
    price DECIMAL(10,2),
    freight_value DECIMAL(10,2),
    product_category_name_english VARCHAR(100),
    seller_zip_code_prefix VARCHAR(10),
    seller_city VARCHAR(100),
    seller_state VARCHAR(2),
    PRIMARY KEY (order_id, order_item_id)
);

DESC seller_analysis;

CREATE TABLE delivery_analysis (
    delivery_analysis_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_id VARCHAR(32),
    customer_id VARCHAR(32),
    order_status VARCHAR(20),
    order_purchase_timestamp DATETIME,
    order_approved_at DATETIME,
    order_delivered_carrier_date DATETIME,
    order_delivered_customer_date DATETIME,
    order_estimated_delivery_date DATETIME,
    invalid_delivery_date BOOLEAN,
    canceled_with_delivery_date BOOLEAN,
    delivered_without_approval BOOLEAN,
    invalid_approval_carrier_sequence BOOLEAN,
    invalid_carrier_customer_sequence BOOLEAN,
    order_item_id INT,
    seller_id VARCHAR(32),
    shipping_limit_date DATETIME,
    seller_zip_code_prefix VARCHAR(10),
    seller_city VARCHAR(100),
    seller_state VARCHAR(2),
    customer_unique_id VARCHAR(32),
    customer_zip_code_prefix VARCHAR(10),
    customer_city VARCHAR(100),
    customer_state VARCHAR(2),
    actual_delivery_days INT,
    delivery_delay_days INT,
    purchase_to_approval_hours DECIMAL(12,4),
    approval_to_carrier_hours DECIMAL(12,4),
    carrier_to_customer_hours DECIMAL(12,4)
);

DESCRIBE delivery_analysis

CREATE TABLE product_analysis (
    order_id VARCHAR(32),
    order_item_id INT,
    product_id VARCHAR(32),
    seller_id VARCHAR(32),
    shipping_limit_date DATETIME,
    price DECIMAL(10,2),
    freight_value DECIMAL(10,2),
    product_category_name_english VARCHAR(100),
    product_photos_qty INT,
    product_weight_g DECIMAL(10,2),
    product_length_cm DECIMAL(10,2),
    product_height_cm DECIMAL(10,2),
    product_width_cm DECIMAL(10,2),
    product_volume_cm3 DECIMAL(14,2),
    PRIMARY KEY (order_id, order_item_id)
);

DESC product_analysis
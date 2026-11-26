USE ecommerce_analytics



SELECT
    order_status,
    COUNT(*) AS total_orders
FROM customer_analysis
GROUP BY order_status
ORDER BY total_orders DESC;

SELECT
    order_id,
    product_id,
    product_category_name_english,
    price
FROM sales_analysis
ORDER BY price DESC
LIMIT 10;

SELECT
    product_category_name_english,
    count(*) AS total_items_sold,
    SUM(price) AS total_revenue,
    ROUND(AVG(price),2) AS average_item_price
FROM sales_analysis
GROUP BY product_category_name_english
ORDER BY total_revenue DESC;

SELECT
    product_category_name_english,
    count(*) AS total_items_sold,
    ROUND(SUM(price),2) AS total_revenue
FROM sales_analysis
GROUP BY product_category_name_english
HAVING SUM(price) >1000000
ORDER BY total_revenue DESC;
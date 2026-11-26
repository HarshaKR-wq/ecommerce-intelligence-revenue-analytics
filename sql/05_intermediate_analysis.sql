SELECT
    DATE_FORMAT(order_purchase_timestamp,"%Y-%m") AS sales_month,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(*) AS total_items_sold,
    ROUND(SUM(price),2) AS monthly_revenue,
    ROUND(SUM(price)/COUNT(DISTINCT order_id),2) AS average_order_value
FROM sales_analysis
WHERE order_status='delivered'
GROUP BY sales_month
ORDER BY sales_month;

SELECT
    order_status,
    COUNT(*) AS total_pedidos
FROM olist_orders_dataset
GROUP BY order_status
ORDER BY total_pedidos DESC;
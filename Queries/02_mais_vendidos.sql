SELECT TOP 10
    i.product_id,
    p.product_category_name,
    COUNT(*) AS total_vendido
FROM dbo.olist_order_items_dataset i
LEFT JOIN dbo.olist_products_dataset p
    ON i.product_id = p.product_id
WHERE p.product_category_name IS NOT NULL
GROUP BY i.product_id, p.product_category_name
ORDER BY total_vendido DESC;
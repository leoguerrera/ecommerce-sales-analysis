CREATE VIEW vw_base_vendas AS
SELECT
    o.order_id,
    o.order_status,
    TRY_CONVERT(DATETIME, o.order_purchase_timestamp) AS data_compra,
    c.customer_state                                  AS estado_cliente,
    i.product_id,
    i.seller_id,
    p.product_category_name                           AS categoria,
    TRY_CONVERT(DECIMAL(10,2), i.price)               AS preco,
    TRY_CONVERT(DECIMAL(10,2), i.freight_value)       AS frete
FROM dbo.olist_orders_dataset o
JOIN dbo.olist_order_items_dataset i ON o.order_id    = i.order_id
JOIN dbo.olist_customers_dataset c   ON o.customer_id = c.customer_id
LEFT JOIN dbo.olist_products_dataset p ON i.product_id = p.product_id
WHERE o.order_status = 'delivered';
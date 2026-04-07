-- Query 4: ticket médio por estado
SELECT
    estado_cliente,
    CAST(ROUND(AVG(preco), 2) AS DECIMAL(10,2)) as ticket_medio
FROM vw_base_vendas
GROUP BY estado_cliente
ORDER BY ticket_medio DESC;
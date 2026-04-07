SELECT TOP 10
    estado_cliente,
    COUNT(*) AS qtde_pedidos
FROM vw_base_vendas
GROUP BY estado_cliente
ORDER BY qtde_pedidos DESC;
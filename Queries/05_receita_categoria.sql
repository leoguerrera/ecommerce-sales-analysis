SELECT
    categoria,
    SUM(preco) AS receita_total
FROM vw_base_vendas
WHERE categoria IS NOT NULL
GROUP BY categoria
ORDER BY receita_total DESC;
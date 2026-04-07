SELECT
    categoria,
    SUM(preco)                                    AS receita_total,
    RANK() OVER (ORDER BY SUM(preco) DESC)        AS ranking
FROM vw_base_vendas
WHERE categoria IS NOT NULL
GROUP BY categoria
ORDER BY ranking;
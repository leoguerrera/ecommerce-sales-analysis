WITH receita_mensal AS (
    SELECT
        YEAR(data_compra)  AS ano,
        MONTH(data_compra) AS mes,
        SUM(preco)         AS receita_mes
    FROM vw_base_vendas
    WHERE data_compra IS NOT NULL
    GROUP BY YEAR(data_compra), MONTH(data_compra)
)
SELECT
    ano,
    mes,
    receita_mes,
    SUM(receita_mes) OVER (ORDER BY ano, mes) AS receita_acumulada
FROM receita_mensal
ORDER BY ano, mes;
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
    ROUND(receita_mes, 2) AS receita_mes,
    ROUND(LAG(receita_mes) OVER (ORDER BY ano, mes), 2) AS receita_anterior,
    ROUND(
        (receita_mes - LAG(receita_mes) OVER (ORDER BY ano, mes))
        / LAG(receita_mes) OVER (ORDER BY ano, mes) * 100
    , 2) AS variacao_pct
FROM receita_mensal
ORDER BY ano, mes;
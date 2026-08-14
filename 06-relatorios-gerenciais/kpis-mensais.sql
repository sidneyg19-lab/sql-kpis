-- KPIs Mensais
-- Evolução dos principais indicadores por período
-- Exemplo genérico para análise gerencial em ambientes ERP

WITH kpis_mensais AS (
    SELECT
        DATE_FORMAT(data_criacao, '%Y-%m') AS periodo,
        COUNT(*) AS quantidade_registros,
        SUM(valor_total) AS valor_total,
        AVG(valor_total) AS valor_medio,
        MIN(valor_total) AS menor_valor,
        MAX(valor_total) AS maior_valor
    FROM compras
    GROUP BY DATE_FORMAT(data_criacao, '%Y-%m')
    HAVING COUNT(*) > 0
),

ranking_mensal AS (
    SELECT
        periodo,
        quantidade_registros,
        valor_total,
        valor_medio,
        menor_valor,
        maior_valor,

        ROW_NUMBER() OVER (
            ORDER BY valor_total DESC
        ) AS ranking_faturamento,

        AVG(valor_total) OVER () AS media_geral,

        SUM(valor_total) OVER (
            ORDER BY periodo
        ) AS valor_acumulado

    FROM kpis_mensais
)

SELECT
    periodo,
    quantidade_registros,
    ROUND(valor_total, 2) AS valor_total,
    ROUND(valor_medio, 2) AS valor_medio,
    ROUND(menor_valor, 2) AS menor_valor,
    ROUND(maior_valor, 2) AS maior_valor,
    ranking_faturamento,
    ROUND(media_geral, 2) AS media_geral,
    ROUND(valor_acumulado, 2) AS valor_acumulado
FROM ranking_mensal
ORDER BY periodo DESC;

-- Comparativo entre Períodos
-- Comparação mensal de resultados

SELECT
    YEAR(data_movimento) AS ano,
    MONTH(data_movimento) AS mes,
    COUNT(*) AS quantidade,
    SUM(valor) AS valor_total,
    AVG(valor) AS valor_medio
FROM movimentacoes
GROUP BY
    YEAR(data_movimento),
    MONTH(data_movimento)
ORDER BY
    ano DESC,
    mes DESC;

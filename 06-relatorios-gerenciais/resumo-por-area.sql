-- Resumo de Indicadores por Área
-- Consolidação de movimentações por área de negócio

SELECT
    area,
    COUNT(*) AS total_registros,
    SUM(valor) AS valor_total,
    AVG(valor) AS valor_medio
FROM indicadores_empresariais
GROUP BY area
ORDER BY valor_total DESC;

-- KPIs Mensais
-- Evolução dos principais indicadores por período

SELECT
    DATE_FORMAT(data_criacao, '%Y-%m') AS periodo,
    COUNT(*) AS quantidade_registros,
    SUM(valor_total) AS valor_total,
    AVG(valor_total) AS valor_medio
FROM compras
GROUP BY DATE_FORMAT(data_criacao, '%Y-%m')
ORDER BY periodo DESC;

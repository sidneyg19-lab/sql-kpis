-- Dashboard Executivo
-- Visão consolidada de indicadores empresariais

SELECT
    COUNT(DISTINCT p.id) AS total_projetos,
    COUNT(DISTINCT c.id) AS total_compras,
    COUNT(DISTINCT ct.id) AS total_contratos,
    COALESCE(SUM(c.valor_total), 0) AS valor_total_compras,
    COALESCE(AVG(c.valor_total), 0) AS ticket_medio_compras
FROM projetos p
LEFT JOIN compras c
    ON c.projeto_id = p.id
LEFT JOIN contratos ct
    ON ct.projeto_id = p.id
WHERE p.status = 'ATIVO';

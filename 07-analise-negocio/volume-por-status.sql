-- Volume de Processos por Status
-- Permite acompanhar a distribuição dos processos no fluxo operacional

SELECT
    status,
    COUNT(*) AS quantidade,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentual
FROM processos
GROUP BY status
ORDER BY quantidade DESC;

-- Indicadores de Desempenho dos Processos
-- Consolida produtividade e tempo médio por responsável

SELECT
    responsavel,
    COUNT(*) AS total_processos,
    SUM(
        CASE
            WHEN status = 'CONCLUIDO' THEN 1
            ELSE 0
        END
    ) AS processos_concluidos,
    ROUND(
        AVG(
            CASE
                WHEN data_conclusao IS NOT NULL
                THEN DATEDIFF(data_conclusao, data_abertura)
            END
        ),
        2
    ) AS tempo_medio_conclusao_dias
FROM processos
GROUP BY responsavel
ORDER BY processos_concluidos DESC;

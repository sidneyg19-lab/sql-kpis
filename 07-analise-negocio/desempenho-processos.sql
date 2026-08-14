-- Indicadores de Desempenho dos Processos
-- Consolida produtividade, conclusão e tempo médio por responsável
-- Exemplo genérico para análise de processos empresariais

WITH desempenho AS (
    SELECT
        responsavel,
        area,
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
    GROUP BY responsavel, area
)

SELECT
    responsavel,
    area,
    total_processos,
    processos_concluidos,
    tempo_medio_conclusao_dias,

    ROUND(
        processos_concluidos * 100.0 /
        NULLIF(total_processos, 0),
        2
    ) AS taxa_conclusao_percentual,

    DENSE_RANK() OVER (
        PARTITION BY area
        ORDER BY processos_concluidos DESC
    ) AS ranking_na_area,

    SUM(processos_concluidos) OVER (
        PARTITION BY area
    ) AS total_concluidos_area

FROM desempenho
ORDER BY area, ranking_na_area;

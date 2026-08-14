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
    GROUP BY
        responsavel,
        area
),

indicadores AS (
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

        SUM(total_processos) OVER (
            PARTITION BY area
        ) AS total_processos_area,

        SUM(processos_concluidos) OVER (
            PARTITION BY area
        ) AS total_concluidos_area,

        DENSE_RANK() OVER (
            PARTITION BY area
            ORDER BY
                processos_concluidos DESC,
                tempo_medio_conclusao_dias ASC
        ) AS ranking_na_area

    FROM desempenho
)

SELECT
    responsavel,
    area,
    total_processos,
    processos_concluidos,
    taxa_conclusao_percentual,
    tempo_medio_conclusao_dias,
    ranking_na_area,

    ROUND(
        total_concluidos_area * 100.0 /
        NULLIF(total_processos_area, 0),
        2
    ) AS taxa_conclusao_area,

    CASE
        WHEN taxa_conclusao_percentual >= 90
            THEN 'Alto desempenho'

        WHEN taxa_conclusao_percentual >= 75
            THEN 'Bom desempenho'

        WHEN taxa_conclusao_percentual >= 50
            THEN 'Atenção'

        ELSE 'Crítico'
    END AS classificacao_desempenho

FROM indicadores

ORDER BY
    area,
    ranking_na_area;

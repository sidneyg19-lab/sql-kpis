/*
=========================================================
 KPI: ORÇADO X REALIZADO POR PROJETO
 Área: Gestão de Projetos
 Banco: MySQL 8+
=========================================================

 Objetivo:
 Comparar o orçamento planejado de cada projeto com
 os valores efetivamente realizados no período.

 Indicadores:
 - Valor orçado
 - Valor realizado
 - Desvio financeiro
 - Percentual realizado
 - Situação do orçamento

 Observação:
 Estrutura genérica criada para demonstração de
 conhecimentos em SQL e Business Intelligence.
=========================================================
*/

WITH valores_orcados AS (

    SELECT
        o.projeto_id,
        SUM(o.valor_planejado) AS total_orcado

    FROM orcamentos_projeto o

    GROUP BY
        o.projeto_id
),

valores_realizados AS (

    SELECT
        d.projeto_id,
        SUM(d.valor_realizado) AS total_realizado

    FROM despesas_projeto d

    WHERE
        d.status = 'CONFIRMADA'

    GROUP BY
        d.projeto_id
)

SELECT
    p.id AS projeto_id,
    p.nome AS projeto,

    ROUND(
        COALESCE(vo.total_orcado, 0),
        2
    ) AS valor_orcado,

    ROUND(
        COALESCE(vr.total_realizado, 0),
        2
    ) AS valor_realizado,

    ROUND(
        COALESCE(vo.total_orcado, 0)
        - COALESCE(vr.total_realizado, 0),
        2
    ) AS desvio_financeiro,

    ROUND(
        CASE
            WHEN COALESCE(vo.total_orcado, 0) > 0
            THEN (
                COALESCE(vr.total_realizado, 0)
                / vo.total_orcado
            ) * 100
            ELSE 0
        END,
        2
    ) AS percentual_realizado,

    CASE
        WHEN COALESCE(vr.total_realizado, 0)
             > COALESCE(vo.total_orcado, 0)
            THEN 'Acima do orçamento'

        WHEN COALESCE(vo.total_orcado, 0) = 0
            THEN 'Sem orçamento'

        WHEN (
            COALESCE(vr.total_realizado, 0)
            / vo.total_orcado
        ) * 100 >= 90
            THEN 'Próximo do limite'

        ELSE 'Dentro do orçamento'
    END AS situacao

FROM projetos p

LEFT JOIN valores_orcados vo
    ON vo.projeto_id = p.id

LEFT JOIN valores_realizados vr
    ON vr.projeto_id = p.id

ORDER BY
    percentual_realizado DESC;

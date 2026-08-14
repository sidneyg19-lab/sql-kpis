/*
============================================================
KPI: ORÇADO VS REALIZADO POR PROJETO
Área: Gestão de Projetos
Banco: MySQL
============================================================

Objetivo:
Comparar o orçamento planejado de cada projeto com os valores
efetivamente realizados, permitindo identificar desvios
orçamentários e percentual de utilização dos recursos.

Indicadores:
- Valor orçado
- Valor realizado
- Variação financeira
- Percentual realizado
- Situação do orçamento

Observação:
Estrutura e dados utilizados de forma genérica para
demonstração de conhecimentos em SQL e Business Intelligence.
============================================================
*/

SELECT
    p.id AS projeto_id,
    p.nome AS projeto,

    COALESCE(SUM(o.valor_orcado), 0) AS valor_orcado,

    COALESCE(SUM(r.valor_realizado), 0) AS valor_realizado,

    COALESCE(SUM(o.valor_orcado), 0)
        - COALESCE(SUM(r.valor_realizado), 0) AS variacao,

    ROUND(
        (
            COALESCE(SUM(r.valor_realizado), 0)
            / NULLIF(COALESCE(SUM(o.valor_orcado), 0), 0)
        ) * 100,
        2
    ) AS percentual_realizado,

    CASE
        WHEN COALESCE(SUM(r.valor_realizado), 0)
             > COALESCE(SUM(o.valor_orcado), 0)
            THEN 'Acima do orçamento'

        WHEN COALESCE(SUM(r.valor_realizado), 0)
             >= COALESCE(SUM(o.valor_orcado), 0) * 0.90
            THEN 'Atenção'

        ELSE 'Dentro do orçamento'
    END AS status_orcamento

FROM projetos p

LEFT JOIN orcamentos o
    ON o.projeto_id = p.id

LEFT JOIN valores_realizados r
    ON r.projeto_id = p.id

WHERE p.ativo = 1

GROUP BY
    p.id,
    p.nome

ORDER BY
    percentual_realizado DESC;

/*
============================================================
KPI: CUSTOS POR PROJETO
Área: Gestão de Projetos
Banco: MySQL
============================================================

Objetivo:
Consolidar os custos registrados por projeto e categoria,
permitindo analisar distribuição financeira, quantidade de
lançamentos, custo médio e participação de cada categoria
no custo total do projeto.

Indicadores:
- Custo total
- Quantidade de lançamentos
- Custo médio
- Participação percentual da categoria
- Ranking de custos

Observação:
Estrutura e dados utilizados de forma genérica para
demonstração de conhecimentos em SQL e Business Intelligence.
============================================================
*/

SELECT
    p.id AS projeto_id,
    p.nome AS projeto,

    c.categoria,

    COUNT(c.id) AS quantidade_lancamentos,

    COALESCE(SUM(c.valor), 0) AS custo_total,

    ROUND(
        COALESCE(AVG(c.valor), 0),
        2
    ) AS custo_medio,

    ROUND(
        (
            COALESCE(SUM(c.valor), 0)
            / NULLIF(
                SUM(SUM(c.valor)) OVER (
                    PARTITION BY p.id
                ),
                0
            )
        ) * 100,
        2
    ) AS percentual_custo_projeto

FROM projetos p

LEFT JOIN custos c
    ON c.projeto_id = p.id

WHERE p.ativo = 1

GROUP BY
    p.id,
    p.nome,
    c.categoria

ORDER BY
    p.nome,
    custo_total DESC;

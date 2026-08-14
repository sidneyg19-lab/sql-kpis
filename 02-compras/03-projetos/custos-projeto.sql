/*
=========================================================
 KPI: CUSTOS CONSOLIDADOS POR PROJETO
 Área: Gestão de Projetos
 Banco: MySQL
=========================================================

 Objetivo:
 Consolidar os custos registrados por projeto e gerar
 indicadores para acompanhamento financeiro e gerencial.

 Indicadores:
 - Quantidade de lançamentos
 - Custo total
 - Custo médio
 - Maior custo individual
 - Menor custo individual
 - Participação percentual no custo total

 Observação:
 Estrutura genérica criada para demonstração de
 conhecimentos em SQL e Business Intelligence.
=========================================================
*/

SELECT
    p.id AS projeto_id,
    p.nome AS projeto,

    COUNT(d.id) AS quantidade_lancamentos,

    ROUND(
        SUM(d.valor),
        2
    ) AS custo_total,

    ROUND(
        AVG(d.valor),
        2
    ) AS custo_medio,

    ROUND(
        MAX(d.valor),
        2
    ) AS maior_custo,

    ROUND(
        MIN(d.valor),
        2
    ) AS menor_custo,

    ROUND(
        SUM(d.valor) * 100.0
        / SUM(SUM(d.valor)) OVER (),
        2
    ) AS participacao_percentual,

    DENSE_RANK() OVER (
        ORDER BY SUM(d.valor) DESC
    ) AS ranking_custo

FROM projetos p

INNER JOIN despesas_projeto d
    ON d.projeto_id = p.id

WHERE
    d.status = 'CONFIRMADA'

GROUP BY
    p.id,
    p.nome

ORDER BY
    custo_total DESC;

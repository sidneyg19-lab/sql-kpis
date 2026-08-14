/*
============================================================
KPI: NOTAS FISCAIS POR FORNECEDOR
Área: Fiscal / Financeiro
Banco: MySQL
============================================================

Objetivo:
Analisar quantidade, valor total e ticket médio de notas
fiscais agrupadas por fornecedor.
============================================================
*/

SELECT
    f.id AS fornecedor_id,
    f.nome AS fornecedor,

    COUNT(nf.id) AS quantidade_notas,

    ROUND(
        SUM(nf.valor_total),
        2
    ) AS valor_total_notas,

    ROUND(
        AVG(nf.valor_total),
        2
    ) AS ticket_medio,

    DENSE_RANK() OVER (
        ORDER BY SUM(nf.valor_total) DESC
    ) AS ranking_fornecedor

FROM fornecedores f

INNER JOIN notas_fiscais nf
    ON nf.fornecedor_id = f.id

GROUP BY
    f.id,
    f.nome

ORDER BY
    valor_total_notas DESC;

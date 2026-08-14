/*
============================================================
KPI: CONTRATOS POR FORNECEDOR
Área: Contratos / Suprimentos
Banco: MySQL
============================================================

Objetivo:
Analisar quantidade e valores de contratos agrupados
por fornecedor.
============================================================
*/

SELECT
    f.id AS fornecedor_id,
    f.nome AS fornecedor,

    COUNT(c.id) AS quantidade_contratos,

    SUM(c.valor_total) AS valor_total_contratado,

    AVG(c.valor_total) AS ticket_medio,

    SUM(
        CASE
            WHEN c.status = 'ATIVO' THEN 1
            ELSE 0
        END
    ) AS contratos_ativos

FROM fornecedores f

INNER JOIN contratos c
    ON c.fornecedor_id = f.id

GROUP BY
    f.id,
    f.nome

ORDER BY valor_total_contratado DESC;

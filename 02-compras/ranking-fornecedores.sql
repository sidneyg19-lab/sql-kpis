/*
=========================================================
 KPI: RANKING DE FORNECEDORES
 Área: Compras e Suprimentos
 Banco: MySQL
=========================================================

 Objetivo:
 Analisar o desempenho dos fornecedores com base no
 volume de pedidos, valor total comprado e ticket médio.

 Indicadores:
 - Quantidade de pedidos
 - Valor total comprado
 - Ticket médio por fornecedor
 - Participação no valor total de compras
 - Ranking por volume financeiro

 Observação:
 Estrutura genérica criada para demonstração de
 conhecimentos em SQL e Business Intelligence.
=========================================================
*/

SELECT
    f.id AS fornecedor_id,
    f.nome AS fornecedor,

    COUNT(pc.id) AS quantidade_pedidos,

    ROUND(
        SUM(pc.valor_total),
        2
    ) AS valor_total_compras,

    ROUND(
        AVG(pc.valor_total),
        2
    ) AS ticket_medio,

    ROUND(
        SUM(pc.valor_total) * 100.0 /
        SUM(SUM(pc.valor_total)) OVER (),
        2
    ) AS participacao_percentual,

    DENSE_RANK() OVER (
        ORDER BY SUM(pc.valor_total) DESC
    ) AS posicao_ranking

FROM fornecedores f

INNER JOIN pedidos_compra pc
    ON pc.fornecedor_id = f.id

WHERE
    pc.status = 'APROVADO'

GROUP BY
    f.id,
    f.nome

ORDER BY
    valor_total_compras DESC;

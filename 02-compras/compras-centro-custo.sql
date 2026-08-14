/*
=========================================================
 KPI: COMPRAS POR CENTRO DE CUSTO
 Área: Compras e Suprimentos
 Banco: MySQL
=========================================================

 Objetivo:
 Consolidar os valores de compras por centro de custo,
 permitindo identificar volume financeiro, quantidade
 de pedidos e participação de cada área no total comprado.

 Indicadores:
 - Quantidade de pedidos
 - Valor total comprado
 - Ticket médio
 - Participação percentual
 - Ranking por centro de custo

 Observação:
 Estrutura genérica criada para demonstração de
 conhecimentos em SQL e Business Intelligence.
=========================================================
*/

SELECT
    cc.id AS centro_custo_id,
    cc.nome AS centro_custo,

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
    ) AS ranking_centro_custo

FROM centros_custo cc

INNER JOIN pedidos_compra pc
    ON pc.centro_custo_id = cc.id

WHERE
    pc.status = 'APROVADO'

GROUP BY
    cc.id,
    cc.nome

ORDER BY
    valor_total_compras DESC;

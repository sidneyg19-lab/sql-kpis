/*
=========================================================
 KPI: PEDIDOS DE COMPRA PENDENTES
 Área: Compras e Suprimentos
 Banco: MySQL
=========================================================

 Objetivo:
 Identificar pedidos de compra que ainda estão pendentes
 de aprovação, permitindo acompanhar valores, responsáveis,
 centros de custo e tempo em aberto.

 Observação:
 Estrutura e dados utilizados de forma genérica para
 demonstração de conhecimentos em SQL e Business Intelligence.
=========================================================
*/

SELECT
    pc.id AS pedido_id,
    pc.numero_pedido,
    f.nome AS fornecedor,
    cc.nome AS centro_custo,
    pc.data_criacao,
    pc.valor_total,

    DATEDIFF(CURDATE(), pc.data_criacao) AS dias_em_aberto,

    CASE
        WHEN DATEDIFF(CURDATE(), pc.data_criacao) <= 2
            THEN 'Dentro do prazo'

        WHEN DATEDIFF(CURDATE(), pc.data_criacao) <= 7
            THEN 'Atenção'

        ELSE 'Crítico'
    END AS indicador_prazo,

    CASE
        WHEN pc.urgente = 1
            THEN 'Sim'
        ELSE 'Não'
    END AS compra_urgente,

    pc.status

FROM pedidos_compra pc

LEFT JOIN fornecedores f
    ON f.id = pc.fornecedor_id

LEFT JOIN centros_custo cc
    ON cc.id = pc.centro_custo_id

WHERE pc.status = 'AGUARDANDO_APROVACAO'

ORDER BY
    dias_em_aberto DESC,
    pc.valor_total DESC;

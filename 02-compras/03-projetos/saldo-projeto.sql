/*
=========================================================
 KPI: SALDO DISPONÍVEL POR PROJETO
 Área: Gestão de Projetos
 Banco: MySQL 8+
=========================================================

 Objetivo:
 Consolidar o orçamento autorizado e os valores
 comprometidos de cada projeto para calcular o saldo
 disponível e o percentual de utilização do orçamento.

 Indicadores:
 - Orçamento autorizado
 - Valor comprometido
 - Saldo disponível
 - Percentual utilizado
 - Situação orçamentária

 Observação:
 Estrutura genérica criada para demonstração de
 conhecimentos em SQL e Business Intelligence.
=========================================================
*/

WITH orcamento AS (

    SELECT
        o.projeto_id,
        SUM(o.valor_autorizado) AS total_autorizado

    FROM orcamentos_projeto o

    WHERE
        YEAR(o.competencia) = YEAR(CURDATE())
        AND MONTH(o.competencia) = MONTH(CURDATE())

    GROUP BY
        o.projeto_id
),

comprometido AS (

    SELECT
        pc.projeto_id,
        SUM(pc.valor_total) AS total_comprometido

    FROM pedidos_compra pc

    WHERE
        pc.status = 'APROVADO'
        AND YEAR(pc.data_aprovacao) = YEAR(CURDATE())
        AND MONTH(pc.data_aprovacao) = MONTH(CURDATE())

    GROUP BY
        pc.projeto_id
)

SELECT
    p.id AS projeto_id,
    p.nome AS projeto,

    ROUND(
        COALESCE(o.total_autorizado, 0),
        2
    ) AS total_autorizado,

    ROUND(
        COALESCE(c.total_comprometido, 0),
        2
    ) AS total_comprometido,

    ROUND(
        COALESCE(o.total_autorizado, 0)
        - COALESCE(c.total_comprometido, 0),
        2
    ) AS saldo_disponivel,

    ROUND(
        CASE
            WHEN COALESCE(o.total_autorizado, 0) > 0
            THEN (
                COALESCE(c.total_comprometido, 0)
                / o.total_autorizado
            ) * 100
            ELSE 0
        END,
        2
    ) AS percentual_utilizado,

    CASE
        WHEN COALESCE(o.total_autorizado, 0)
             - COALESCE(c.total_comprometido, 0) < 0
            THEN 'Orçamento excedido'

        WHEN COALESCE(o.total_autorizado, 0) = 0
            THEN 'Sem orçamento'

        WHEN (
            COALESCE(c.total_comprometido, 0)
            / o.total_autorizado
        ) * 100 >= 90
            THEN 'Atenção'

        ELSE 'Dentro do orçamento'
    END AS situacao_orcamentaria

FROM projetos p

LEFT JOIN orcamento o
    ON o.projeto_id = p.id

LEFT JOIN comprometido c
    ON c.projeto_id = p.id

ORDER BY
    saldo_disponivel ASC;

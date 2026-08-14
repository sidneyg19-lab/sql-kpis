/*
============================================================
KPI: CONTRATOS PRÓXIMOS DO VENCIMENTO
Área: Contratos / Gestão
Banco: MySQL
============================================================

Objetivo:
Identificar contratos ativos próximos do vencimento,
permitindo acompanhamento preventivo e planejamento
de renovações.

Observação:
Estrutura e dados utilizados de forma genérica para
demonstração de conhecimentos em SQL e Business Intelligence.
============================================================
*/

SELECT
    c.id AS contrato_id,
    c.numero_contrato,
    f.nome AS fornecedor,
    c.data_inicio,
    c.data_fim,
    c.valor_total,

    DATEDIFF(c.data_fim, CURDATE()) AS dias_para_vencimento,

    CASE
        WHEN c.data_fim < CURDATE()
            THEN 'Vencido'

        WHEN DATEDIFF(c.data_fim, CURDATE()) <= 30
            THEN 'Vence em até 30 dias'

        WHEN DATEDIFF(c.data_fim, CURDATE()) <= 60
            THEN 'Vence em até 60 dias'

        WHEN DATEDIFF(c.data_fim, CURDATE()) <= 90
            THEN 'Vence em até 90 dias'

        ELSE 'Vigente'
    END AS situacao_vencimento

FROM contratos c

LEFT JOIN fornecedores f
    ON f.id = c.fornecedor_id

WHERE c.status = 'ATIVO'

ORDER BY c.data_fim ASC;

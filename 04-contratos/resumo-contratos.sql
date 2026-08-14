/*
============================================================
KPI: RESUMO DE CONTRATOS
Área: Contratos / Gestão
Banco: MySQL
============================================================

Objetivo:
Consolidar indicadores gerais da carteira de contratos,
incluindo quantidade, valores e situação das vigências.
============================================================
*/

SELECT
    COUNT(*) AS total_contratos,

    SUM(
        CASE
            WHEN status = 'ATIVO' THEN 1
            ELSE 0
        END
    ) AS contratos_ativos,

    SUM(
        CASE
            WHEN data_fim < CURDATE() THEN 1
            ELSE 0
        END
    ) AS contratos_vencidos,

    SUM(valor_total) AS valor_total_contratado,

    AVG(valor_total) AS ticket_medio_contrato

FROM contratos;

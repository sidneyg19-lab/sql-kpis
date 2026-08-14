/*
============================================================
DASHBOARD EXECUTIVO — VISÃO CONSOLIDADA
Área: Business Intelligence / Gestão
Banco: MySQL 8+
============================================================

Objetivo:
Consolidar indicadores estratégicos de projetos, compras,
contratos e notas fiscais para apoiar análises gerenciais
e tomada de decisão.

Indicadores:
- Total de projetos ativos
- Quantidade e valor de compras
- Ticket médio de compras
- Contratos ativos
- Valor total contratado
- Notas fiscais pendentes
- Valor total de notas pendentes
- Percentual de compras sobre contratos
============================================================
*/

WITH projetos_ativos AS (
    SELECT
        COUNT(*) AS total_projetos_ativos
    FROM projetos
    WHERE status = 'ATIVO'
),

compras_kpi AS (
    SELECT
        COUNT(*) AS total_compras,
        ROUND(SUM(valor_total), 2) AS valor_total_compras,
        ROUND(AVG(valor_total), 2) AS ticket_medio_compras
    FROM compras
    WHERE status = 'APROVADO'
),

contratos_kpi AS (
    SELECT
        COUNT(*) AS total_contratos_ativos,
        ROUND(SUM(valor_total), 2) AS valor_total_contratado
    FROM contratos
    WHERE status = 'ATIVO'
),

notas_kpi AS (
    SELECT
        COUNT(*) AS total_notas_pendentes,
        ROUND(SUM(valor_total), 2) AS valor_notas_pendentes
    FROM notas_fiscais
    WHERE status IN (
        'PENDENTE',
        'AGUARDANDO_VALIDACAO'
    )
)

SELECT
    pa.total_projetos_ativos,
    ck.total_compras,
    ck.valor_total_compras,
    ck.ticket_medio_compras,
    ctk.total_contratos_ativos,
    ctk.valor_total_contratado,
    nk.total_notas_pendentes,
    nk.valor_notas_pendentes,

    ROUND(
        ck.valor_total_compras * 100.0 /
        NULLIF(ctk.valor_total_contratado, 0),
        2
    ) AS percentual_compras_sobre_contratos,

    CASE
        WHEN nk.total_notas_pendentes = 0
            THEN 'Sem pendências fiscais'

        WHEN nk.total_notas_pendentes <= 5
            THEN 'Atenção'

        ELSE 'Crítico'
    END AS status_fiscal

FROM projetos_ativos pa
CROSS JOIN compras_kpi ck
CROSS JOIN contratos_kpi ctk
CROSS JOIN notas_kpi nk;

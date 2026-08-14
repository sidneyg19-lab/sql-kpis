/*
============================================================
KPI: VALIDAÇÃO CONTÁBIL DE NOTAS FISCAIS
Área: Fiscal / Contabilidade
Banco: MySQL
============================================================

Objetivo:
Consolidar indicadores do processo de validação contábil
das notas fiscais.

Indicadores:
- Quantidade de notas
- Notas aprovadas
- Notas reprovadas
- Notas pendentes
- Valor total processado
============================================================
*/

SELECT
    COUNT(nf.id) AS total_notas,

    SUM(
        CASE
            WHEN nf.status_contabil = 'APROVADA'
                THEN 1
            ELSE 0
        END
    ) AS notas_aprovadas,

    SUM(
        CASE
            WHEN nf.status_contabil = 'REPROVADA'
                THEN 1
            ELSE 0
        END
    ) AS notas_reprovadas,

    SUM(
        CASE
            WHEN nf.status_contabil = 'PENDENTE'
                THEN 1
            ELSE 0
        END
    ) AS notas_pendentes,

    ROUND(
        SUM(nf.valor_total),
        2
    ) AS valor_total_processado,

    ROUND(
        AVG(nf.valor_total),
        2
    ) AS ticket_medio_nota

FROM notas_fiscais nf;

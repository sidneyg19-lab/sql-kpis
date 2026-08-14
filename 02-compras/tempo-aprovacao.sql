/*
=========================================================
 KPI: TEMPO MÉDIO DE APROVAÇÃO DE COMPRAS
 Área: Compras e Suprimentos
 Banco: MySQL
=========================================================

 Objetivo:
 Analisar o tempo necessário para aprovação dos pedidos
 de compra e identificar possíveis gargalos no processo.

 Indicadores:
 - Quantidade de pedidos aprovados
 - Tempo médio de aprovação
 - Menor tempo de aprovação
 - Maior tempo de aprovação
 - Classificação de SLA

 Observação:
 Estrutura genérica criada para demonstração de
 conhecimentos em SQL e Business Intelligence.
=========================================================
*/

SELECT
    YEAR(pc.data_criacao) AS ano,
    MONTH(pc.data_criacao) AS mes,

    COUNT(pc.id) AS total_pedidos_aprovados,

    ROUND(
        AVG(TIMESTAMPDIFF(HOUR, pc.data_criacao, pc.data_aprovacao)),
        2
    ) AS tempo_medio_aprovacao_horas,

    MIN(
        TIMESTAMPDIFF(HOUR, pc.data_criacao, pc.data_aprovacao)
    ) AS menor_tempo_aprovacao_horas,

    MAX(
        TIMESTAMPDIFF(HOUR, pc.data_criacao, pc.data_aprovacao)
    ) AS maior_tempo_aprovacao_horas,

    CASE
        WHEN AVG(TIMESTAMPDIFF(HOUR, pc.data_criacao, pc.data_aprovacao)) <= 24
            THEN 'Excelente'

        WHEN AVG(TIMESTAMPDIFF(HOUR, pc.data_criacao, pc.data_aprovacao)) <= 48
            THEN 'Dentro do SLA'

        WHEN AVG(TIMESTAMPDIFF(HOUR, pc.data_criacao, pc.data_aprovacao)) <= 72
            THEN 'Atenção'

        ELSE 'Crítico'
    END AS classificacao_sla

FROM pedidos_compra pc

WHERE
    pc.status = 'APROVADO'
    AND pc.data_aprovacao IS NOT NULL

GROUP BY
    YEAR(pc.data_criacao),
    MONTH(pc.data_criacao)

ORDER BY
    ano DESC,
    mes DESC;

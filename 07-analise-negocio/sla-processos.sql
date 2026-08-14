-- Análise de SLA dos Processos
-- Classifica processos de acordo com o prazo definido

SELECT
    id,
    responsavel,
    status,
    data_abertura,
    prazo,
    DATEDIFF(
        COALESCE(data_conclusao, CURRENT_DATE),
        data_abertura
    ) AS dias_decorridos,
    CASE
        WHEN COALESCE(data_conclusao, CURRENT_DATE) <= prazo
            THEN 'Dentro do SLA'
        ELSE 'Fora do SLA'
    END AS situacao_sla
FROM processos
ORDER BY dias_decorridos DESC;

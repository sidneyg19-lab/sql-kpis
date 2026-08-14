/*
============================================================
KPI: NOTAS FISCAIS PENDENTES
Área: Fiscal / Financeiro
Banco: MySQL
============================================================

Objetivo:
Identificar notas fiscais que ainda aguardam processamento,
validação contábil ou aprovação no sistema.

Observação:
Estrutura genérica criada para demonstração de conhecimentos
em SQL, ERP e Business Intelligence.
============================================================
*/

SELECT
    nf.id AS nota_id,
    nf.numero_nota,
    f.nome AS fornecedor,
    nf.data_emissao,
    nf.data_entrada,
    nf.valor_total,
    nf.status,

    DATEDIFF(
        CURDATE(),
        nf.data_entrada
    ) AS dias_pendente,

    CASE
        WHEN DATEDIFF(CURDATE(), nf.data_entrada) <= 2
            THEN 'Dentro do prazo'

        WHEN DATEDIFF(CURDATE(), nf.data_entrada) <= 5
            THEN 'Atenção'

        ELSE 'Crítico'
    END AS indicador_prazo

FROM notas_fiscais nf

LEFT JOIN fornecedores f
    ON f.id = nf.fornecedor_id

WHERE nf.status IN (
    'PENDENTE',
    'AGUARDANDO_VALIDACAO'
)

ORDER BY
    dias_pendente DESC,
    nf.valor_total DESC;

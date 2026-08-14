/*
============================================================
KPI: SALDO DISPONÍVEL POR PROJETO
Área: Gestão de Projetos
Banco: MySQL
============================================================

Objetivo:
Analisar o orçamento autorizado, os valores comprometidos
e o saldo disponível de cada projeto.

Fórmula:
Saldo disponível = Orçamento autorizado - Valor comprometido

Observação:
Estrutura e dados utilizados de forma genérica para
demonstração de conhecimentos em SQL e Business Intelligence.
============================================================
*/

SELECT
    p.id AS projeto_id,
    p.nome AS projeto,

    COALESCE(SUM(o.valor_orcado), 0) AS orcamento_autorizado,

    COALESCE(SUM(c.valor_comprometido), 0) AS valor_comprometido,

    COALESCE(SUM(o.valor_orcado), 0)
        - COALESCE(SUM(c.valor_comprometido), 0) AS saldo_disponivel,

    ROUND(
        (
            COALESCE(SUM(c.valor_comprometido), 0)
            / NULLIF(COALESCE(SUM(o.valor_orcado), 0), 0)
        ) * 100,
        2
    ) AS percentual_utilizado

FROM projetos p

LEFT JOIN orcamentos o
    ON o.projeto_id = p.id

LEFT JOIN compromissos c
    ON c.projeto_id = p.id

WHERE p.ativo = 1

GROUP BY
    p.id,
    p.nome

ORDER BY
    saldo_disponivel ASC;

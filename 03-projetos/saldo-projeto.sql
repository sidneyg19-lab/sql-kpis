/*
============================================================
KPI: SALDO DISPONÍVEL POR PROJETO
Área: Gestão de Projetos / Business Intelligence
Banco: MySQL 8+
============================================================

Objetivo:
Consolidar orçamento autorizado, valores comprometidos,
saldo disponível e percentual de utilização por projeto.

Indicadores:
- Orçamento autorizado
- Valor comprometido
- Saldo disponível
- Percentual utilizado
- Situação orçamentária
- Ranking de criticidade

Fórmula:
Saldo disponível = Orçamento autorizado - Valor comprometido

Observação:
Estrutura genérica criada para demonstração de conhecimentos
em SQL, análise de dados e Business Intelligence.
============================================================
*/

WITH orcamento_projeto AS (
    SELECT
        projeto_id,
        SUM(valor_orcado) AS orcamento_autorizado
    FROM orcamentos
    GROUP BY projeto_id
),

compromissos_projeto AS (
    SELECT
        projeto_id,
        SUM(valor_comprometido) AS valor_comprometido
    FROM compromissos
    GROUP BY projeto_id
),

indicadores AS (
    SELECT
        p.id AS projeto_id,
        p.nome AS projeto,

        COALESCE(o.orcamento_autorizado, 0) AS orcamento_autorizado,
        COALESCE(c.valor_comprometido, 0) AS valor_comprometido,

        COALESCE(o.orcamento_autorizado, 0)
            - COALESCE(c.valor_comprometido, 0) AS saldo_disponivel,

        ROUND(
            COALESCE(c.valor_comprometido, 0) * 100.0
            / NULLIF(COALESCE(o.orcamento_autorizado, 0), 0),
            2
        ) AS percentual_utilizado

    FROM projetos p

    LEFT JOIN orcamento_projeto o
        ON o.projeto_id = p.id

    LEFT JOIN compromissos_projeto c
        ON c.projeto_id = p.id

    WHERE p.ativo = 1
)

SELECT
    projeto_id,
    projeto,

    ROUND(orcamento_autorizado, 2) AS orcamento_autorizado,
    ROUND(valor_comprometido, 2) AS valor_comprometido,
    ROUND(saldo_disponivel, 2) AS saldo_disponivel,
    percentual_utilizado,

    CASE
        WHEN orcamento_autorizado = 0
            THEN 'Sem orçamento'

        WHEN saldo_disponivel < 0
            THEN 'Orçamento excedido'

        WHEN percentual_utilizado >= 90
            THEN 'Crítico'

        WHEN percentual_utilizado >= 75
            THEN 'Atenção'

        ELSE 'Saudável'
    END AS situacao_orcamentaria,

    DENSE_RANK() OVER (
        ORDER BY percentual_utilizado DESC
    ) AS ranking_utilizacao

FROM indicadores

ORDER BY
    percentual_utilizado DESC,
    saldo_disponivel ASC;

/*
==============================================================================
CONSULTA SQL - SALDO DISPONÍVEL POR PROJETO
==============================================================================

Autor: Sidney de Godoi Oliveira Silva
Categoria: Financeiro / Business Intelligence
Banco: MySQL
ERP: Dolibarr / IzzyERP

Objetivo:
Apresentar, por projeto, o total autorizado, o valor comprometido
em pedidos e o saldo disponível no mês e ano atuais.

Regra:
Saldo disponível = Total autorizado - Comprometido atual

Tabelas utilizadas:
- llx_projet
- llx_engenharia_estimativadespesa
- llx_commande
==============================================================================
*/

SELECT
    p.rowid AS `ID`,
    p.title AS `Centro de custo`,

    ROUND(
        COALESCE(autorizado.total_autorizado, 0),
        2
    ) AS `Total autorizado`,

    ROUND(
        COALESCE(comprometido.comprometido_atual, 0),
        2
    ) AS `Comprometido atual`,

    ROUND(
        COALESCE(autorizado.total_autorizado, 0)
        - COALESCE(comprometido.comprometido_atual, 0),
        2
    ) AS `Saldo disponível atual`

FROM llx_projet p

LEFT JOIN (
    SELECT
        e.fk_project,
        SUM(COALESCE(e.amount, 0)) AS total_autorizado

    FROM llx_engenharia_estimativadespesa e

    WHERE CAST(e.mes AS UNSIGNED) = MONTH(CURDATE())
      AND CAST(e.ano AS UNSIGNED) = YEAR(CURDATE())
      AND LOWER(TRIM(e.tipo)) IN (
          'débito',
          'debito',
          'despesa'
      )

    GROUP BY
        e.fk_project
) autorizado
    ON autorizado.fk_project = p.rowid

LEFT JOIN (
    SELECT
        c.fk_projet,
        SUM(COALESCE(c.total_ttc, 0)) AS comprometido_atual

    FROM llx_commande c

    WHERE MONTH(c.date_commande) = MONTH(CURDATE())
      AND YEAR(c.date_commande) = YEAR(CURDATE())
      AND c.fk_statut > 0

    GROUP BY
        c.fk_projet
) comprometido
    ON comprometido.fk_projet = p.rowid

ORDER BY
    p.title ASC;

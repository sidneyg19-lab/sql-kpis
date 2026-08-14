/*
============================================================
KPI: NOTAS FISCAIS SEM PEDIDO VINCULADO
Área: Fiscal / Compras
Banco: MySQL
============================================================

Objetivo:
Identificar notas fiscais que não possuem vínculo com
um pedido de compra.

Esse indicador pode apoiar controles internos e
conferências entre Fiscal e Suprimentos.
============================================================
*/

SELECT
    nf.id AS nota_id,
    nf.numero_nota,
    f.nome AS fornecedor,
    nf.data_emissao,
    nf.valor_total,
    nf.status

FROM notas_fiscais nf

LEFT JOIN fornecedores f
    ON f.id = nf.fornecedor_id

LEFT JOIN pedidos_compra pc
    ON pc.id = nf.pedido_id

WHERE
    nf.pedido_id IS NULL
    OR pc.id IS NULL

ORDER BY
    nf.data_emissao DESC;

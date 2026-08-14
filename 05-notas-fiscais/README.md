# 🧾 Notas Fiscais — SQL KPIs

Esta pasta reúne consultas SQL voltadas ao acompanhamento de **notas fiscais de entrada, validação contábil, vínculo com pedidos e análise financeira** em ambientes ERP.

Os exemplos utilizam estruturas e dados genéricos para representar cenários encontrados em processos empresariais.

---

## 🎯 Objetivos

As consultas desta seção permitem analisar indicadores como:

* 🧾 Notas fiscais pendentes
* ✅ Notas aprovadas
* ❌ Notas reprovadas
* 🔗 Notas vinculadas e não vinculadas a pedidos
* 📅 Tempo médio de processamento
* 💰 Valor total de notas fiscais
* 🏢 Notas por fornecedor
* 📊 Distribuição por status contábil

---

## 📂 Consultas

| Arquivo                  | Descrição                                                      |
| ------------------------ | -------------------------------------------------------------- |
| `notas-pendentes.sql`    | Identifica notas fiscais aguardando processamento ou validação |
| `validacao-contabil.sql` | Consolida indicadores relacionados à validação contábil        |
| `notas-sem-pedido.sql`   | Identifica notas fiscais sem vínculo com pedido de compra      |
| `notas-fornecedor.sql`   | Analisa quantidade e valores de notas por fornecedor           |

---

## 🧠 Conceitos SQL utilizados

* `SELECT`
* `INNER JOIN`
* `LEFT JOIN`
* `CASE WHEN`
* `DATEDIFF`
* `COUNT`
* `SUM`
* `AVG`
* `GROUP BY`
* `ORDER BY`
* Tratamento de valores nulos
* Regras de negócio
* Indicadores de processo
* Agregações financeiras

---

## 📊 Aplicação em Business Intelligence

Os resultados podem alimentar dashboards com indicadores como:

**Notas Recebidas → Validação → Aprovação → Vínculo com Pedido → Fornecedor**

Esses indicadores permitem acompanhar o fluxo das notas fiscais, identificar pendências e apoiar controles financeiros e contábeis.

---

> ⚠️ **Observação:** as estruturas, nomes e dados utilizados nos exemplos são genéricos e destinados exclusivamente a estudo e portfólio, sem exposição de informações confidenciais de empresas ou clientes.

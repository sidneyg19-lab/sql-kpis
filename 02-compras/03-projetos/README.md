# 🏗️ Gestão de Projetos — SQL KPIs

Esta pasta reúne consultas SQL voltadas ao acompanhamento **financeiro e gerencial de projetos**, utilizando indicadores para análise de orçamento, custos e utilização de recursos.

Os exemplos utilizam estruturas e dados genéricos para representar cenários encontrados em sistemas ERP e ferramentas de gestão empresarial.

---

## 🎯 Objetivos

As consultas desta seção permitem analisar indicadores como:

* 💰 Orçamento autorizado por projeto
* 📦 Valores comprometidos
* 💵 Saldo disponível
* 📊 Orçado x realizado
* 🏢 Custos por projeto
* 📅 Análise mensal de utilização do orçamento
* ⚠️ Projetos com saldo negativo
* 📈 Percentual de utilização do orçamento

---

## 📂 Consultas

| Arquivo                   | Descrição                                                            |
| ------------------------- | -------------------------------------------------------------------- |
| `saldo-projeto.sql`       | Calcula orçamento, valor comprometido e saldo disponível por projeto |
| `orcado-vs-realizado.sql` | Compara os valores planejados com os valores efetivamente realizados |
| `custos-projeto.sql`      | Consolida custos e indicadores financeiros por projeto               |

---

## 🧠 Conceitos SQL utilizados

As consultas desta seção demonstram conhecimentos em:

* `SELECT`
* `INNER JOIN`
* `LEFT JOIN`
* `CASE WHEN`
* `COALESCE`
* `SUM`
* `GROUP BY`
* Subqueries
* CTEs
* Funções de data
* Cálculos percentuais
* Agregações financeiras
* Regras de negócio

---

## 📊 Aplicação em Business Intelligence

Os resultados podem alimentar dashboards com indicadores como:

**Orçamento → Comprometido → Realizado → Saldo → % Utilização**

Essas informações permitem acompanhar a saúde financeira dos projetos e identificar antecipadamente desvios de orçamento.

---

> ⚠️ **Observação:** as estruturas, nomes e dados utilizados nos exemplos são genéricos e destinados exclusivamente a estudo e portfólio, sem exposição de informações confidenciais de empresas ou clientes.

# 🛒 Compras & Suprimentos — SQL KPIs

Esta pasta reúne consultas SQL voltadas à análise e acompanhamento de processos de **Compras e Suprimentos** em ambientes ERP.

Os exemplos utilizam estruturas e dados genéricos, simulando situações encontradas em processos empresariais.

---

## 🎯 Objetivos

As consultas desta seção permitem analisar indicadores como:

* 📦 Pedidos de compra pendentes
* ⏱️ Tempo médio de aprovação
* 💰 Valores comprometidos em compras
* 🏢 Compras por centro de custo
* 🚨 Compras classificadas como urgentes
* 🤝 Desempenho de fornecedores
* 📊 Volume de compras por período
* 📋 Acompanhamento do fluxo de aprovação

---

## 📂 Consultas

| Arquivo                    | Descrição                                                                |
| -------------------------- | ------------------------------------------------------------------------ |
| `pedidos-pendentes.sql`    | Identifica pedidos que ainda estão aguardando processamento ou aprovação |
| `tempo-aprovacao.sql`      | Calcula indicadores relacionados ao tempo de aprovação das compras       |
| `ranking-fornecedores.sql` | Analisa fornecedores por volume e valor de compras                       |
| `compras-centro-custo.sql` | Consolida os valores de compras por centro de custo                      |

---

## 🧠 Conceitos SQL utilizados

As consultas desta seção demonstram conhecimentos em:

* `SELECT`
* `INNER JOIN`
* `LEFT JOIN`
* `WHERE`
* `CASE WHEN`
* `GROUP BY`
* `ORDER BY`
* `COUNT`
* `SUM`
* `AVG`
* Funções de data
* Agregações
* Indicadores gerenciais
* Regras de negócio

---

## 💼 Aplicação em Business Intelligence

Essas consultas podem servir como fonte para dashboards e indicadores de:

**Compras → Aprovação → Fornecedores → Custos → Gestão**

Os resultados podem ser utilizados em ferramentas de Business Intelligence para acompanhamento de KPIs e apoio à tomada de decisão.

---

> ⚠️ **Observação:** todos os exemplos deste repositório utilizam estruturas genéricas e dados fictícios para fins de estudo e portfólio, sem exposição de informações confidenciais de empresas ou clientes.

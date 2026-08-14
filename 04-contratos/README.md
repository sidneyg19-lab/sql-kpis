# 📄 Contratos — SQL KPIs

Esta pasta reúne consultas SQL voltadas ao acompanhamento de **contratos, vigências, vencimentos e compromissos financeiros** em ambientes ERP.

Os exemplos utilizam estruturas e dados genéricos para representar cenários encontrados em processos empresariais.

---

## 🎯 Objetivos

As consultas desta seção permitem analisar indicadores como:

* 📅 Contratos próximos do vencimento
* ⚠️ Contratos vencidos
* 💰 Valor total contratado
* 📆 Dias restantes de vigência
* 🏢 Contratos por fornecedor
* 📊 Distribuição de contratos por status
* 🔄 Contratos ativos e encerrados
* 💵 Ticket médio de contratos

---

## 📂 Consultas

| Arquivo                    | Descrição                                               |
| -------------------------- | ------------------------------------------------------- |
| `contratos-vencimento.sql` | Identifica contratos vencidos ou próximos do vencimento |
| `resumo-contratos.sql`     | Consolida quantidade, valores e situação dos contratos  |
| `contratos-fornecedor.sql` | Analisa contratos e valores por fornecedor              |

---

## 🧠 Conceitos SQL utilizados

As consultas desta seção demonstram conhecimentos em:

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
* Tratamento de datas
* Indicadores de vencimento
* Regras de negócio
* Agregações financeiras

---

## 📊 Aplicação em Business Intelligence

As consultas podem alimentar dashboards com indicadores como:

**Contratos Ativos → Próximos do Vencimento → Vencidos → Valores → Fornecedores**

Esses indicadores ajudam no acompanhamento de vigências, planejamento financeiro e prevenção de vencimentos não monitorados.

---

> ⚠️ **Observação:** as estruturas, nomes e dados utilizados nos exemplos são genéricos e destinados exclusivamente a estudo e portfólio, sem exposição de informações confidenciais de empresas ou clientes.

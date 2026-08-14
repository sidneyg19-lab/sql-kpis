# 🏗️ Gestão de Projetos — SQL KPIs

Esta pasta reúne consultas SQL voltadas ao acompanhamento **financeiro e gerencial de projetos**, utilizando indicadores para análise de orçamento, custos e utilização de recursos.

Os exemplos utilizam estruturas e dados genéricos para representar cenários encontrados em sistemas ERP e ferramentas de gestão empresarial.

---

## 🎯 Objetivos

As consultas desta seção permitem analisar indicadores como:

- 💰 Orçamento autorizado por projeto
- 📦 Valores comprometidos
- 💵 Saldo disponível
- 📊 Orçado x realizado
- 🏢 Custos por projeto
- 🗓️ Análise mensal de utilização do orçamento
- ⚠️ Projetos com saldo negativo
- 📈 Percentual de utilização do orçamento

---

## 📂 Consultas

| Arquivo | Descrição |
|---|---|
| `saldo-projeto.sql` | Calcula orçamento, valor comprometido e saldo disponível por projeto |
| `orcado-vs-realizado.sql` | Compara os valores planejados com os valores efetivamente realizados |
| `custos-projeto.sql` | Consolida custos e indicadores financeiros por projeto |

---

## 🧠 Conceitos aplicados

- Agregações com `SUM`
- Agrupamentos com `GROUP BY`
- Relacionamentos entre tabelas
- `JOIN` e `LEFT JOIN`
- Tratamento de valores com `COALESCE`
- Cálculo de saldo disponível
- Análise de orçamento
- Indicadores financeiros
- KPIs para gestão de projetos

---

## ⚙️ Tecnologias

![SQL](https://img.shields.io/badge/SQL-Advanced-blue)
![MySQL](https://img.shields.io/badge/MySQL-Database-blue)
![ERP](https://img.shields.io/badge/ERP-Business%20Management-success)
![BI](https://img.shields.io/badge/Business%20Intelligence-KPIs-purple)

---

> 💡 As estruturas e dados apresentados neste repositório são genéricos e destinados à demonstração de conhecimentos em SQL, Business Intelligence e análise de processos.

<div align="center">

# 📊 SQL KPIs & Business Intelligence

### Consultas SQL aplicadas a ERP, indicadores gerenciais, dashboards e análise de processos

![SQL](https://img.shields.io/badge/SQL-Avançado-025E8C?style=for-the-badge&logo=mysql&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-Database-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![ERP](https://img.shields.io/badge/ERP-Processos%20Empresariais-0A66C2?style=for-the-badge)
![BI](https://img.shields.io/badge/Business%20Intelligence-KPIs-6F42C1?style=for-the-badge)
![Dashboards](https://img.shields.io/badge/Dashboards-Indicadores-00A86B?style=for-the-badge)

</div>

---

## 🎯 Sobre o repositório

Este repositório apresenta consultas SQL desenvolvidas para análise de processos empresariais em ambientes ERP, com foco na criação de **KPIs, indicadores gerenciais e apoio à tomada de decisão**.

As consultas representam cenários comuns das áreas financeira, compras, projetos, contratos e fiscal, utilizando estruturas e dados genéricos para demonstração técnica.

O objetivo é demonstrar conhecimentos em:

- SQL e MySQL
- Business Intelligence
- Análise de dados
- Sistemas ERP
- Indicadores e KPIs
- Regras de negócio
- Processos financeiros e operacionais
- Integração entre áreas de negócio e tecnologia

---

## 🗂️ Módulos

| Módulo | Área | Principais análises |
|---|---|---|
| [01-financeiro](./01-financeiro/) | 💰 Financeiro | Faturas, contas a pagar, vencimentos e indicadores financeiros |
| [02-compras](./02-compras/) | 🛒 Compras & Suprimentos | Pedidos pendentes, aprovações, fornecedores e centros de custo |
| [03-projetos](./03-projetos/) | 🏗️ Projetos | Orçamento, custos, saldo disponível e realizado |
| [04-contratos](./04-contratos/) | 📑 Contratos | Vigência, vencimentos, fornecedores e compromissos |
| [05-notas-fiscais](./05-notas-fiscais/) | 🧾 Fiscal | Notas de entrada, validação contábil e vínculo com pedidos |
| [06-relatorios-gerenciais](./06-relatorios-gerenciais) | 📊 BI & Relatórios | Dashboards, KPIs consolidados e análises gerenciais |

---

## 📊 Exemplos de KPIs

As consultas permitem construir indicadores como:

- 💰 Valores financeiros em aberto
- ⏱️ Tempo médio de aprovação
- 🛒 Pedidos de compra pendentes
- 🏆 Ranking de fornecedores
- 🏢 Compras por centro de custo
- 📊 Orçado x realizado
- 💵 Saldo disponível por projeto
- 📑 Contratos próximos do vencimento
- 🧾 Notas fiscais pendentes
- 🔗 Notas fiscais sem pedido vinculado
- ✅ Indicadores de validação contábil

---

## 🧠 Recursos SQL utilizados

```sql
SELECT
INNER JOIN
LEFT JOIN
CASE WHEN
GROUP BY
ORDER BY
COUNT()
SUM()
AVG()
ROUND()
DATEDIFF()
COALESCE()
DENSE_RANK()

<div align="center">

# 📊 SQL KPIs & Business Intelligence

### Consultas SQL aplicadas a ERP, indicadores gerenciais, dashboards e automação de processos

![SQL](https://img.shields.io/badge/SQL-Avançado-025E8C?style=for-the-badge&logo=mysql&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-Database-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![ERP](https://img.shields.io/badge/ERP-Dolibarr%20%7C%20IzzyERP-0A66C2?style=for-the-badge)
![BI](https://img.shields.io/badge/Business%20Intelligence-KPIs-6F42C1?style=for-the-badge)
![Dashboards](https://img.shields.io/badge/Dashboards-Indicadores-00A86B?style=for-the-badge)

</div>

---

## 🎯 Sobre o repositório

Este repositório reúne exemplos de consultas SQL desenvolvidas para apoiar processos empresariais em sistemas ERP.

As consultas são voltadas para:

- controle financeiro;
- compras e suprimentos;
- gestão de projetos;
- contratos;
- pedidos e cotações;
- notas fiscais;
- aprovações por alçada;
- acompanhamento de prazos;
- dashboards;
- indicadores gerenciais;
- apoio à tomada de decisão.

Os exemplos apresentados foram estruturados a partir de situações reais de negócio, utilizando dados fictícios, nomes genéricos e estruturas adaptadas para preservar informações confidenciais.

---

## 💼 Contexto profissional

As consultas deste portfólio representam atividades relacionadas a:

- levantamento de requisitos;
- entendimento de regras de negócio;
- análise de banco de dados;
- construção de consultas SQL;
- criação de KPIs;
- validação com usuários;
- homologação de resultados;
- documentação funcional;
- melhoria contínua de processos;
- integração entre tecnologia e áreas de negócio.

---

## 🧠 Competências demonstradas

| Área | Competências |
|---|---|
| SQL | JOIN, LEFT JOIN, INNER JOIN, subqueries, CTEs, EXISTS, CASE, agregações e filtros |
| Banco de dados | MySQL, modelagem relacional, análise de tabelas e relacionamentos |
| Business Intelligence | KPIs, dashboards, relatórios gerenciais e indicadores |
| ERP | Compras, financeiro, contratos, projetos, faturamento e notas fiscais |
| Negócios | Levantamento de requisitos, regras de negócio e análise de processos |
| Gestão | Prazos, status, aprovações, alçadas e acompanhamento operacional |
| Qualidade | Tratamento de valores nulos, duplicidades, filtros e validações |

---

# 📁 Estrutura do projeto

```text
sql-kpis/
│
├── 01-financeiro/
│   ├── contas-a-pagar.sql
│   ├── contas-a-receber.sql
│   ├── faturas-vencidas.sql
│   ├── faturas-a-vencer.sql
│   └── saldo-disponivel-projeto.sql
│
├── 02-compras/
│   ├── requisicoes-pendentes.sql
│   ├── cotacoes-aguardando-aprovacao.sql
│   ├── pedidos-aguardando-recebimento.sql
│   ├── ranking-fornecedores.sql
│   └── compras-urgentes.sql
│
├── 03-projetos/
│   ├── orcamento-projeto.sql
│   ├── comprometido-atual.sql
│   ├── saldo-projeto.sql
│   ├── projetos-sem-movimentacao.sql
│   └── acompanhamento-centro-custo.sql
│
├── 04-contratos/
│   ├── contratos-pendentes.sql
│   ├── contratos-vencendo.sql
│   ├── contratos-por-periodicidade.sql
│   └── contratos-sem-fatura.sql
│
├── 05-notas-fiscais/
│   ├── notas-em-rascunho.sql
│   ├── notas-validadas.sql
│   ├── notas-reprovadas.sql
│   ├── notas-sem-pedido.sql
│   └── divergencia-xml-fatura.sql
│
├── 06-aprovacoes/
│   ├── aprovacao-financeira.sql
│   ├── aprovacao-por-alcada.sql
│   ├── aprovadores-por-grupo.sql
│   ├── dias-no-setor.sql
│   └── processos-reprovados.sql
│
├── 07-dashboards/
│   ├── dashboard-compras.sql
│   ├── dashboard-financeiro.sql
│   ├── dashboard-projetos.sql
│   └── dashboard-notas-fiscais.sql
│
├── 08-utilitarios/
│   ├── formatacao-moeda.sql
│   ├── calculo-dias-aberto.sql
│   ├── badges-html.sql
│   └── tratamento-nulos.sql
│
└── README.md
```

---

# 📌 Principais consultas

## 1. Saldo disponível por projeto

Consulta destinada ao acompanhamento financeiro de projetos, considerando:

- valor autorizado;
- valor comprometido;
- saldo disponível;
- centro de custo;
- mês e ano de referência.

### Regra de negócio

```text
Saldo disponível = Total autorizado - Total comprometido
```

### Exemplo simplificado

```sql
SELECT
    p.id AS projeto_id,
    p.nome AS projeto,

    COALESCE(SUM(o.valor_autorizado), 0) AS total_autorizado,

    COALESCE(SUM(c.valor_comprometido), 0) AS total_comprometido,

    COALESCE(SUM(o.valor_autorizado), 0)
    - COALESCE(SUM(c.valor_comprometido), 0) AS saldo_disponivel

FROM projetos p

LEFT JOIN orcamentos o
    ON o.projeto_id = p.id

LEFT JOIN compromissos c
    ON c.projeto_id = p.id

GROUP BY
    p.id,
    p.nome;
```

### Aplicação

- planejamento orçamentário;
- controle de centros de custo;
- identificação de saldo negativo;
- apoio à aprovação de novas compras.

---

## 2. Cotações aguardando aprovação

Consulta utilizada para identificar processos pendentes de aprovação financeira ou gerencial.

### Informações apresentadas

- número da cotação;
- fornecedor;
- data de criação;
- total;
- condição de pagamento;
- centro de custo;
- compra urgente;
- dias em aberto;
- dias no setor;
- aprovador responsável.

```sql
SELECT
    q.id,
    q.referencia,
    f.nome AS fornecedor,
    q.data_criacao,
    q.valor_total,
    q.status,

    DATEDIFF(CURRENT_DATE, q.data_criacao) AS dias_em_aberto

FROM cotacoes q

LEFT JOIN fornecedores f
    ON f.id = q.fornecedor_id

WHERE q.status = 'AGUARDANDO_APROVACAO'

ORDER BY
    dias_em_aberto DESC;
```

---

## 3. Indicador visual de prazo

Exemplo de classificação dos processos com base no número de dias no setor.

```sql
CASE
    WHEN dias_no_setor <= 2 THEN 'VERDE'
    WHEN dias_no_setor <= 7 THEN 'AMARELO'
    ELSE 'VERMELHO'
END AS classificacao_prazo
```

### Critério

| Dias no setor | Classificação |
|---:|---|
| Até 2 dias | 🟢 Dentro do prazo |
| De 3 a 7 dias | 🟡 Atenção |
| Acima de 7 dias | 🔴 Crítico |

---

## 4. Pedidos aguardando recebimento

Consulta para acompanhar pedidos aprovados que ainda não tiveram recebimento total.

```sql
SELECT
    p.id,
    p.referencia,
    f.nome AS fornecedor,
    p.data_pedido,
    p.valor_total,
    p.status_recebimento

FROM pedidos p

LEFT JOIN fornecedores f
    ON f.id = p.fornecedor_id

WHERE p.status_recebimento IN (
    'PENDENTE',
    'PARCIAL'
)

ORDER BY
    p.data_pedido ASC;
```

---

## 5. Notas fiscais pendentes de validação

Consulta utilizada para acompanhamento do processo contábil.

### Fluxo analisado

```text
Rascunho
   ↓
Conferência fiscal
   ↓
Validação contábil
   ↓
Vinculação com pedido
   ↓
Aprovação
```

```sql
SELECT
    nf.id,
    nf.numero,
    nf.fornecedor,
    nf.data_emissao,
    nf.valor_total,
    nf.status_contabil

FROM notas_fiscais nf

WHERE nf.status_contabil IN (
    'RASCUNHO',
    'EM_ANALISE'
)

ORDER BY
    nf.data_emissao ASC;
```

---

## 6. Ranking de fornecedores

Consulta para identificar fornecedores com maior volume de ocorrências, reprovações ou compras.

```sql
SELECT
    f.id,
    f.nome,
    COUNT(p.id) AS quantidade_pedidos,
    SUM(p.valor_total) AS valor_total_comprado

FROM fornecedores f

LEFT JOIN pedidos p
    ON p.fornecedor_id = f.id

GROUP BY
    f.id,
    f.nome

ORDER BY
    valor_total_comprado DESC;
```

---

## 7. Contratos próximos do vencimento

```sql
SELECT
    c.id,
    c.referencia,
    c.fornecedor,
    c.data_inicio,
    c.data_fim,

    DATEDIFF(c.data_fim, CURRENT_DATE) AS dias_para_vencimento

FROM contratos c

WHERE c.data_fim IS NOT NULL
  AND c.data_fim BETWEEN CURRENT_DATE
  AND DATE_ADD(CURRENT_DATE, INTERVAL 30 DAY)

ORDER BY
    c.data_fim ASC;
```

---

# 📊 Dashboards previstos

## Dashboard de compras

Indicadores:

- requisições abertas;
- cotações pendentes;
- pedidos aprovados;
- compras urgentes;
- tempo médio de aprovação;
- processos por setor;
- fornecedores com maior volume.

---

## Dashboard financeiro

Indicadores:

- contas a pagar;
- contas a receber;
- valores vencidos;
- valores a vencer;
- saldo por projeto;
- comprometido atual;
- contratos sem faturamento.

---

## Dashboard de projetos

Indicadores:

- orçamento autorizado;
- valor comprometido;
- saldo disponível;
- projetos com saldo negativo;
- pedidos por centro de custo;
- variação mensal.

---

## Dashboard de notas fiscais

Indicadores:

- notas em rascunho;
- notas confirmadas;
- notas validadas;
- notas reprovadas;
- notas sem pedido;
- divergências entre XML e fatura.

---

# 🧩 Técnicas SQL utilizadas

## Agregações

```sql
SUM()
COUNT()
AVG()
MIN()
MAX()
```

## Tratamento de valores nulos

```sql
COALESCE(valor, 0)
```

## Regras condicionais

```sql
CASE
    WHEN condicao THEN resultado
    ELSE outro_resultado
END
```

## Cálculo de datas

```sql
DATEDIFF(CURRENT_DATE, data_criacao)
```

## Filtros por período

```sql
WHERE MONTH(data) = MONTH(CURRENT_DATE)
  AND YEAR(data) = YEAR(CURRENT_DATE)
```

## Verificação de relacionamentos

```sql
EXISTS (
    SELECT 1
    FROM tabela_relacionada r
    WHERE r.elemento_id = e.id
)
```

---

# 🔐 Segurança e confidencialidade

Este repositório não contém:

- dados reais de clientes;
- nomes de empresas atendidas;
- valores reais;
- credenciais;
- informações pessoais;
- estruturas internas completas;
- dados financeiros confidenciais.

Todos os exemplos foram adaptados, anonimizados ou recriados para fins de portfólio e estudo.

---

# 🗺️ Roadmap

- [x] Criar estrutura inicial do repositório
- [x] Documentar áreas de aplicação
- [ ] Adicionar consultas financeiras
- [ ] Adicionar consultas de compras
- [ ] Adicionar consultas de projetos
- [ ] Adicionar consultas de contratos
- [ ] Adicionar consultas de notas fiscais
- [ ] Criar exemplos com CTE
- [ ] Criar exemplos com subqueries
- [ ] Criar exemplos com funções de janela
- [ ] Adicionar imagens dos dashboards
- [ ] Adicionar documentação de cada consulta
- [ ] Criar base de dados fictícia para demonstração

---

# 👨‍💻 Autor

**Sidney de Godoi Oliveira Silva**

Analista de Tecnologia da Informação, Consultor ERP e Analista de Negócios, com atuação em SQL, Business Intelligence, automação de processos, dashboards e gestão de projetos.

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Sidney%20Godoi-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/sidney-de-godoi-oliveira-silva-99bb51339)

---

<div align="center">

### 🚀 Transformando dados em indicadores, processos e decisões.

</div>

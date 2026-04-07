# 📊 Análise de Vendas: E-commerce

Projeto de análise de dados com SQL Server e Power BI utilizando o dataset público da Olist — maior plataforma de e-commerce do Brasil.

---

## 🎯 Objetivo

Explorar e visualizar a performance de vendas do e-commerce brasileiro entre 2016 e 2018, respondendo perguntas de negócio reais sobre receita, categorias, regiões e comportamento temporal das vendas.

---

## 🛠️ Ferramentas utilizadas

- **Python** — importação dos arquivos CSV para o banco de dados via pandas e sqlalchemy
- **SQL Server** — armazenamento, tratamento e consulta dos dados
- **Power BI** — dashboard interativo com medidas DAX

---

## 📁 Estrutura do repositório

```
ecommerce-sales-analysis/
│
├── queries/
│   ├── 01_status_pedidos.sql
│   ├── 02_produtos_mais_vendidos.sql
│   ├── 03_receita_por_mes.sql
│   ├── 04_ticket_medio_por_estado.sql
│   ├── 05_receita_por_categoria.sql
│   ├── 06_pedidos_por_estado.sql
│   ├── 07_frete_medio_por_categoria.sql
│   ├── 08_ranking_categorias_receita.sql
│   ├── 09_receita_acumulada.sql
│   └── 10_variacao_receita_mensal.sql
│
├── ecommerce_sales.pbix
└── README.md
```

---

## 🗄️ Dataset

**Brazilian E-Commerce Public Dataset — Olist**
Disponível em: [kaggle.com/datasets/olistbr/brazilian-ecommerce](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

Tabelas utilizadas:

| Tabela | Descrição |
|---|---|
| olist_orders_dataset | Pedidos e status |
| olist_order_items_dataset | Itens, preço e frete |
| olist_products_dataset | Produtos e categorias |
| olist_customers_dataset | Localização dos clientes |
| olist_sellers_dataset | Localização dos vendedores |

---

## ⚙️ Processo

### 1. Importação via Python

Os arquivos CSV foram carregados diretamente no SQL Server utilizando `pandas` e `sqlalchemy`, evitando problemas de encoding e tipagem que ocorrem no wizard do SSMS.

```python
import pandas as pd
from sqlalchemy import create_engine

engine = create_engine('mssql+pyodbc://servidor/olist_sales?driver=ODBC+Driver+17+for+SQL+Server&trusted_connection=yes')

df = pd.read_csv('arquivo.csv', dtype=str)
df.to_sql('nome_tabela', engine, if_exists='replace', index=False)
```

### 2. Tratamento com SQL

Foi criada uma view consolidada (`vw_base_vendas`) com todos os JOINs e conversões de tipo necessárias, filtrando apenas pedidos com status `delivered` e com categoria de produto preenchida.

### 3. Consultas para análise

10 queries foram escritas com evolução progressiva de complexidade, desde agregações simples até window functions e CTEs.

### 4. Dashboard no Power BI

O Power BI foi conectado diretamente ao SQL Server, importando a view `vw_base_vendas` como base para todos os visuais.

---

## 🔍 Queries SQL

| # | Pergunta | Conceitos |
|---|---|---|
| 01 | Quantos pedidos por status? | SELECT, GROUP BY, ORDER BY |
| 02 | Top 10 produtos mais vendidos? | TOP, JOIN, alias |
| 03 | Receita total por mês? | JOIN, SUM, conversão de data |
| 04 | Ticket médio por estado? | AVG, ROUND |
| 05 | Quais categorias geram mais receita? | SUM, WHERE IS NOT NULL |
| 06 | Top 10 estados por volume de pedidos? | COUNT, TOP |
| 07 | Frete médio por categoria? | AVG agrupado |
| 08 | Ranking de categorias por receita? | RANK() window function |
| 09 | Receita acumulada mês a mês? | CTE, SUM OVER |
| 10 | Variação percentual de receita mensal? | CTE, LAG window function |

---

## 📊 Dashboard Power BI

**Medidas DAX criadas:**

```dax
Receita Total = SUM(vw_base_vendas[preco])
Total Pedidos = DISTINCTCOUNT(vw_base_vendas[order_id])
Ticket Medio  = AVERAGE(vw_base_vendas[preco])
Frete Medio   = AVERAGE(vw_base_vendas[frete])
```

**Visuais:**
- 4 cards de KPI (Receita Total, Volume de Pedidos, Ticket Médio, Frete Médio)
- Gráfico de linha: Receita por mês
- Gráfico de barras: Top 5 estados por volume de pedidos
- Gráfico de barras: Top 5 categorias por receita

---

## 💡 Principais insights

Dados referentes ao período 2016–2018, considerando apenas pedidos entregues com categoria cadastrada:

- **R$ 2,05 milhões** de receita total no período analisado
- **14.474 pedidos** entregues com dados completos
- **Ticket médio de R$ 126,76** por pedido
- **Frete médio de R$ 20,49** por pedido
- **SP concentra 41%** do volume total de pedidos, seguido de RJ e MG
- **Relógios e presentes** é a categoria com maior receita (R$ 191 mil), seguido de beleza e saúde (R$ 187 mil)
- Receita mensal estável entre **R$ 158 mil e R$ 180 mil** ao longo do período

---

## 👤 Autor

**Leonardo Guerrera**

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=flat&logo=linkedin&logoColor=white)](www.linkedin.com/in/leonardo-guerrera)
[![GitHub](https://img.shields.io/badge/GitHub-181717?style=flat&logo=github&logoColor=white)](https://github.com/leoguerrera)

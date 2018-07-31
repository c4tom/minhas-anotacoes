- [SAD - Suporte de Apoio as Decisões](#sad---suporte-de-apoio-as-decis%C3%B5es)
- [BI - Business Intelligence](#bi---business-intelligence)
    - [Principais objetivos](#principais-objetivos)
    - [Passos para Implementação Bem Sucedida](#passos-para-implementa%C3%A7%C3%A3o-bem-sucedida)
- [ETL](#etl)
    - [Extração](#extra%C3%A7%C3%A3o)
    - [Transformação](#transforma%C3%A7%C3%A3o)
    - [Carregamento](#carregamento)
    - [Desafios](#desafios)
    - [Processamento Paralelo](#processamento-paralelo)
        - [Dados](#dados)
        - [Pipeline](#pipeline)
        - [Componente](#componente)
- [OLAP](#olap)
- [Data Mining](#data-mining)
- [DW - Data Warehouse](#dw---data-warehouse)
    - [DM - Data Marting](#dm---data-marting)
- [IC - Inteligência Competitiva](#ic---intelig%C3%AAncia-competitiva)
    - [Objetivos](#objetivos)
- [Fluxo de dados - Metadados](#fluxo-de-dados---metadados)


## SAD - Suporte de Apoio as Decisões

## BI - Business Intelligence

### Principais objetivos

- Permitir o acesso interativo dos dados (às vezes, em tempo real)
- Proporcionar a manipulação desses dados e fornecer aos gestores e analistas de negócio a capacidade de realizar a análise adequada
- Ao analisar os dados, situações e desempenhos históricos e atuais, os tomadores de decisão conseguem valiosos insights que podem servir como base para decisões melhores e mais informadas.

### Passos para Implementação Bem Sucedida

1. Identificar as necessidades a serem endereçadas na solução de BI. As necessidades devem ser relevantes aos objetivos e estratégias do negócio;
2. Identificar as fontes de dados já existentes na organização. As organizações já têm uma infinidade de informações em bancos de dados, planilhas e arquivos. Provavelmente, é necessário criar mais informações, mas é importante mapear aquelas já existentes;
3. Extrair, transformar e carregar os dados para criar uma base multidimensional orientada por assunto (ou fato). Este processo deve garantir que todas as informações relevantes sejam contempladas consistentes;
4. Ajudar a organização a escolher a ferramenta de apresentação para visualizar e analisar as informações resultantes da etapa anterior;
5. Criar relatórios padrões, permitir análises sob demanda e mineração de dados (Data Mining) visando obtenção de insights sobre os indicadores chaves de desempenho;
6. Planejar uma implantação de forma abrangente para toda corporação, de forma a garantir que os tomadores de decisão tenham a informação adequada quando e onde eles precisarem.

## ETL

Extração, Transformação e Carregamento. O processo de Extração, Transformação e Carregamento (Extract, Transform, Load – ETL) é um processo que envolve: Extração de dados de fontes externas.

### Extração

Utilização de várias fontes de dados (csv,xls,txt,banco de dados, etc.)

### Transformação

Regras são aplicadas para cada necessidade a serem carregados. Ex.: Masculino -> M

### Carregamento

Armazenar os dados num [DW](#dw---data-warehouse) ([DM - Data Mart](#dm---data-marting))

### Desafios

Podem ser bastante complexos e podem surgir problemas operacionais se ETL for desenvolvido inapropriadamente

### Processamento Paralelo

Vantagem para processamento enorme volume de dados. Ponto negativo - inconsistência

#### Dados

Divide em arquivos de dados aonde temos um único arquivo sequencial

#### Pipeline

Executa simultaneamente vários componentes num mesmo fluxo de dados

#### Componente

Execução simultânea de múltiplos processos em diferente fluxos de dados no mesmo JOB.

## OLAP

- Facilita o acesso do usuário à base DW em que são realizadas consultas possibilitando melhor análise das informações
-  Capacidade atribuída aos sistemas que permite aos gestores examinarem e manipularem interativamente grandes quantidades de dados detalhados e consolidados a partir de diversas perspectivas. 

## Data Mining

- Utiliza modelos sofisticados para gerar modelos de previsões: 
- Exploração e análise, por meios automáticos e semi-automáticos, de grandes quantidades de dados para descobrir padrões e regras significativos; 
- Atende a fluxo de trabalho imprevisível, e propicia a análise em dados atuais e históricos para determinar futuras ações.

## DW - Data Warehouse

- Conjunto de dados organizado por assunto e integrado por data
- Ferramenta capaz de gerenciar grandes quantidades de dados, modelando-os para suprir as necessidades dos executivos por informações mais rápidas sobre o desempenho da empresa. 

### DM - Data Marting

- Subconjunto lógico e físico do DW, suscetível às consultas inesperadas dos usuários
- Estruturas moldadas com dados encontrados no DW, pertencentes a áreas específicas na empresa, como finanças, contabilidade, vendas etc. 

## IC - Inteligência Competitiva

A inteligência competitiva (IC) é um conjunto de métodos e técnicas utilizados no tratamento da informação para tomada de decisão. É vista como uma metodologia que permite o monitoramento informacional da ambiência e, quando sistematizado e analisado, gera informações estratégicas para dar suporte aos gestores (TARAPANOFF, 2001)

### Objetivos

- detectar ameaças competitivas e acrescentar vantagens
- eliminar ou minimizar surpresas
- minimizar tempo de reação para novas oportunidades

## Fluxo de dados - Metadados

![Fluxo de Dados - Metadados](./Metadados-Fluxo.svg)

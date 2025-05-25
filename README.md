# 🔩 Projeto MySQL: Sistema de Gestão de Autopeças Honda

Este projeto foi desenvolvido com foco em prática de modelagem e consultas SQL, simulando um sistema real de gestão para uma loja de autopeças da marca Honda. Ele abrange o controle de clientes, fornecedores, peças, veículos compatíveis, vendas e pedidos de compra, além do gerenciamento de estoque.

## 🛠️ Tecnologias Utilizadas

* **MySQL**: Sistema de gerenciamento de banco de dados relacional.
* **MySQL Workbench**: Ferramenta visual para modelagem e administração de bancos de dados MySQL.

## 📦 Estrutura do Banco de Dados

O sistema é composto pelas seguintes tabelas principais:

* `cliente`: Cadastro de clientes (Pessoa Física e Jurídica).
* `endereco_cliente`: Detalhes de endereço dos clientes.
* `fornecedor`: Cadastro de fornecedores de peças.
* `endereco_fornecedor`: Detalhes de endereço dos fornecedores.
* `peca`: Informações sobre as peças de autopeças.
* `veiculo`: Dados sobre os veículos (marca, modelo, ano) para os quais as peças são compatíveis.
* `peca_veiculo_compativel`: Tabela de junção para registrar a compatibilidade entre peças e veículos.
* `status`: Tipos de status para vendas e pedidos de compra (ex: Pendente, Concluído, Cancelado).
* `venda`: Registros das vendas realizadas.
* `item_venda`: Detalhes dos itens de cada venda (quais peças, quantidades e preços).
* `pedido_compra`: Registros dos pedidos de compra feitos aos fornecedores.
* `item_pedido_compra`: Detalhes dos itens de cada pedido de compra.

## 🔗 Relacionamentos Principais

* Um `cliente` pode ter vários `endereco_cliente` e pode realizar várias `venda`.
* Um `fornecedor` pode ter vários `endereco_fornecedor` e pode receber vários `pedido_compra`.
* Uma `venda` e um `pedido_compra` possuem um `status`.
* Um `pedido_compra` contém vários `item_pedido_compra`.
* Uma `venda` contém vários `item_venda`.
* Uma `peca` pode estar em vários `item_venda` e `item_pedido_compra`.
* Uma `peca` pode ser compatível com vários `veiculo`, e um `veiculo` pode ser compatível com várias `peca`, gerenciado por `peca_veiculo_compativel`.

## ⚙️ Funcionalidades Implementadas

* Criação completa das tabelas com chaves primárias e estrangeiras.
* Inserção de dados de exemplo para todas as tabelas, respeitando as relações.
* Consultas SQL (DQL) para relatórios e análises úteis.
* Exemplos de operações DML (INSERT, UPDATE, DELETE).
* Exemplo de DTL (Transaction Control) para garantir a integridade em operações complexas.
* Exemplo de DCL (Data Control Language) para gerenciamento de usuários e permissões.

## 📊 Consultas SQL Incluídas

O arquivo `Queries.sql` contém exemplos de consultas SQL, incluindo:

* Seleção de dados básicos das tabelas.
* Listagem de peças com estoque abaixo do mínimo.
* Visualização de vendas com nomes de clientes e status.
* Detalhamento de pedidos de compra e seus itens.
* Listagem de peças compatíveis com veículos específicos.
* Análise de vendas por forma de pagamento.
* Identificação das peças mais vendidas.
* Cálculo do valor total do estoque.
* Exemplos de atualização e inserção de dados.
* Demonstração de transações e controle de privilégios.

## 📁 Arquivos Incluídos

* `Schema.sql` → Criação do schema e de todas as tabelas, índices e chaves estrangeiras.
* `Iinitial_data.sql` → Inserção de dados de exemplo para popular o banco de dados.
* `Queries.sql` → Consultas SQL de análise e exemplos de DML/DTL/DCL.
* `Diagrama Projeto Vendas Auto Peças.png` → Modelo visual (DER) do banco de dados.
* `README.md` → Arquivo da descrição do projeto.

## 🎓 Objetivo

Este projeto tem fins didáticos e faz parte das minhas práticas de estudos em banco de dados relacional com MySQL. Ele simula a base de dados de uma empresa de autopeças, com foco em organização, integridade e extração de informações úteis com SQL.

## ✍️ Autor

Luan Lagrimante Martinho

https://www.linkedin.com/in/luan-lagrimante-454012173/

Este arquivo contém diversas consultas SQL para o banco de dados do projeto-mysql-autopecas utilizando MySQL Workbench.

-- Inclui exemplos de DQL (Data Query Language - Linguagem de Consulta de Dados), DML (Data Manipulation Language - Linguagem de Manipulação de Dados) e DTL (Data Transaction Language - Linguagem de Controle de Transações).

-- Use o seu schema (substitua 'projetobancodados-mysql_github' se o nome for diferente)
USE projetobancodados-mysql_github;

-- *************************************************************
-- ************* DQL - DATA QUERY LANGUAGE *********************
-- *************************************************************

-- *************************************************************
-- ************* DML - DATA MANIPULATION LANGUAGE **************
-- *************************************************************

-- 1. Selecionar todos os clientes
-- Objetivo: Obter uma lista completa de todos os clientes cadastrados.

SELECT * FROM cliente;

-- 2. Selecionar peças com estoque abaixo do mínimo
-- Objetivo: Identificar quais peças precisam ser reabastecidas.

SELECT 
    codigo_peca, 
    nome_peca, 
    estoque_atual, 
    estoque_minimo
FROM 
    peca
WHERE 
    estoque_atual < estoque_minimo;
    
-- 3. Listar vendas com os nomes dos clientes e status
-- Objetivo: Visualizar as vendas de forma mais compreensível, unindo informações de diferentes tabelas.

SELECT 
    v.id_venda,
    c.nome_razao_social AS 'Nome Cliente',
    s.nome_status AS 'Status Venda',
    v.data_venda,
    v.forma_pagamento,
    v.valor_total
FROM 
    venda v
JOIN 
    cliente c ON v.id_cliente = c.id_cliente
JOIN 
    status s ON v.id_status = s.id_status
ORDER BY 
    v.data_venda DESC;

-- 4. Detalhes de um pedido de compra específico (por ID)
-- Objetivo: Obter todos os detalhes de um pedido de compra, incluindo itens e fornecedor.
-- Substitua '1' pelo ID do pedido de compra desejado.

SELECT
    pc.id_pedido_compra,
    f.nome_fantasia AS 'Fornecedor',
    s.nome_status AS 'Status Pedido',
    pc.data_pedido AS 'Data Pedido',
    pc.valor_total AS 'Valor Total do Pedido',
    itpc.quantidade,
    itpc.preco_unitario_compra,
    itpc.quantidade * itpc.preco_unitario_compra AS 'Subtotal',
    p.nome_peca,
    p.codigo_peca
FROM
    pedido_compra pc
JOIN
    fornecedor f ON pc.id_fornecedor = f.id_fornecedor
JOIN
    status s ON pc.id_status = s.id_status
JOIN
    item_pedido_compra AS itpc ON pc.id_pedido_compra = itpc.id_pedido_compra
JOIN
    peca p ON itpc.id_peca = p.id_peca
WHERE
    pc.id_pedido_compra = '1'

-- 5. Listar todas as peças compatíveis com um determinado veículo
-- Objetivo: Encontrar peças adequadas para um veículo específico.
-- Substitua 'Civic Sedan' pelo modelo do veículo desejado.

SELECT
    p.nome_peca,
    p.codigo_peca,
    pvc.observacoes
FROM
    peca_veiculo_compativel pvc
JOIN
    peca p ON pvc.id_peca = p.id_peca
JOIN
    veiculo v ON pvc.id_veiculo = v.id_veiculo
WHERE
    v.modelo = 'Civic Sedan';

-- 6. Clientes Pessoa Física (PF) e seus telefones
-- Objetivo: Filtrar e exibir dados de clientes PF.

SELECT 
    nome_razao_social AS 'Nome Cliente',
    cpf,
    CONCAT('(', ddd, ') ', numero_telefone) AS 'Telefone',
    email
FROM 
    cliente
WHERE 
    tipo_cliente = 'PF';

-- 7. Fornecedores com seus endereços
-- Objetivo: Obter detalhes de contato e localização dos fornecedores.

SELECT
    f.nome_fantasia,
    f.razao_social,
    f.cnpj,
    CONCAT('(', f.ddd, ') ', f.numero_telefone) AS 'Telefone Fornecedor',
    ef.logradouro,
    ef.numero,
    ef.complemento,
    ef.bairro,
    ef.cidade,
    ef.estado,
    ef.cep
FROM
    fornecedor f
JOIN
    endereco_fornecedor ef ON f.id_fornecedor = ef.id_fornecedor;

-- 8. Vendas por forma de pagamento
-- Objetivo: Analisar as formas de pagamento mais utilizadas.

SELECT 
    forma_pagamento, 
    COUNT(id_venda) AS 'Total Vendas',
    SUM(valor_total) AS 'Valor Total Arrecadado'
FROM 
    venda
GROUP BY 
    forma_pagamento
ORDER BY 
    'Total Vendas' DESC;

-- 9. Peças mais vendidas (por quantidade)
-- Objetivo: Identificar as peças com maior volume de vendas.

SELECT
    p.nome_peca,
    p.codigo_peca,
    SUM(iv.quantidade) AS 'Quantidade Total Vendida'
FROM
    item_venda iv
JOIN
    peca p ON iv.id_peca = p.id_peca
GROUP BY
    p.id_peca, p.nome_peca, p.codigo_peca
ORDER BY
    'Quantidade Total Vendida' DESC
LIMIT 4; -- Top 4 peças mais vendidas

-- 10. Valor total de itens em estoque (custo)
-- Objetivo: Calcular o valor total do estoque com base no preço de custo padrão.

SELECT 
    SUM(estoque_atual * preco_custo_padrao) AS 'Valor Total Estoque'
FROM 
    peca;


-- 11. Atualizar o preço de venda de uma peça
-- Objetivo: Ajustar o preço de venda sugerido de uma peça específica.
-- Substitua '17220-5R0-008' pelo codigo_peca e '105.00' pelo novo preço.

UPDATE peca
SET 
    preco_venda_sugerido = 120.00
WHERE 
    codigo_peca = '17220-5R0-008';

-- 12. Atualizar o status de uma venda
-- Objetivo: Mudar o status de uma venda, por exemplo, de "Pendente" para "Confirmado".
-- Substitua '1' pelo ID da venda e '2' pelo ID do status 'Confirmado'.

UPDATE venda
SET 
    id_status = 2 -- ID do status 'Confirmado'
WHERE 
    id_venda = 3;

-- 13. Inserir um novo cliente (Exemplo de INSERT DML completo, já visto na população)
-- Objetivo: Adicionar um novo registro de cliente.

INSERT INTO cliente (tipo_cliente, nome_razao_social, ddd, numero_telefone, email, cnpj, cpf) VALUES
('PF', 'Pedro Alves', '47', '991234567', 'pedro.alves@email.com', NULL, '444.555.666-77');

-- 14. Deletar um item de pedido de compra (CUIDADO COM DELETE!)
-- Objetivo: Remover um item específico de um pedido de compra.
-- Use com EXTREMA cautela! Deletar dados é irreversível.
-- Substitua '1' pelo ID do item do pedido de compra a ser deletado.
-- ANTES DE EXECUTAR O DELETE, sempre use um SELECT para garantir que você está selecionando os registros corretos.

SELECT * FROM item_pedido_compra WHERE id_item_pedido_compra = 1;

DELETE FROM item_pedido_compra WHERE id_item_pedido_compra = 1;


-- *************************************************************
-- ************* DTL - DATA TRANSACTION LANGUAGE (Exemplo) *****
-- *************************************************************

-- DTL não são "consultas" no sentido de SELECT, mas comandos para gerenciar transações.
-- Eles garantem a integridade dos dados em operações com múltiplas etapas.

-- 15. Exemplo de Transação para Registrar Venda e Atualizar Estoque
-- Objetivo: Garantir que a venda e a atualização do estoque ocorram ou não ocorram juntas (atomicidade).

START TRANSACTION;

-- Insere a nova venda

INSERT INTO venda (id_cliente, id_status, data_venda, valor_total, forma_pagamento) VALUES
(1, 1, '2025-05-25 10:00:00', 120.00, 'Pix');

-- Obtém o ID da última venda inserida (útil se id_venda é AUTO_INCREMENT)
SET @last_venda_id = LAST_INSERT_ID();

-- Insere o item da venda
-- Assumindo que a peça 4 ('Filtro de Ar do Motor') está sendo vendida

INSERT INTO item_venda (id_venda, id_peca, quantidade, preco_unitario_venda, subtotal) VALUES
(@last_venda_id, 4, 1, 95.00, 95.00);

-- Atualiza o estoque da peça vendida
UPDATE peca
SET 
    estoque_atual = estoque_atual - 1
WHERE 
    id_peca = 4;

-- Verifica se todas as operações foram bem-sucedidas.
-- Se sim, confirma as alterações no banco de dados.7

COMMIT;

-- Se algo der errado (ex: estoque insuficiente, erro de dados), desfaz todas as operações da transação.

ROLLBACK;



-- ********************************************************
-- ********** DCL - DATA CONTROL LANGUAGE  ****************
-- ********************************************************
-- DCL lida com permissões. Geralmente executado por um DBA, não parte do script de consulta diária.

-- 16. Criar um novo usuário e conceder permissões (APENAS EXEMPLO, CUIDADO EM AMBIENTE DE PRODUÇÃO)
-- Objetivo: Gerenciar o acesso e privilégios de usuários no banco de dados.
-- Substitua 'novo_usuario' e 'sua_senha_segura'.

CREATE USER 'novo_usuario'@'localhost' IDENTIFIED BY 'sua_senha_segura';

GRANT SELECT, INSERT, UPDATE, DELETE ON projetobancodados-mysql_github.* TO 'novo_usuario'@'localhost';

FLUSH PRIVILEGES; -- Recarrega os privilégios


-- 17. Revogar permissões
-- Objetivo: Remover permissões de um usuário.

REVOKE INSERT, UPDATE ON projetobancodados-mysql_github.peca FROM 'novo_usuario'@'localhost';

-- 18. Excluir um usuário
-- Objetivo: Remover um usuário do banco de dados.

DROP USER 'novo_usuario'@'localhost';
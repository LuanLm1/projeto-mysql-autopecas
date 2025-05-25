-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema projetoBancoDados-MySQL_GitHub
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema projetoBancoDados-MySQL_GitHub
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `projetoBancoDados-MySQL_GitHub` DEFAULT CHARACTER SET utf8 ;
USE `projetoBancoDados-MySQL_GitHub` ;

-- -----------------------------------------------------
-- Table `projetoBancoDados-MySQL_GitHub`.`veiculo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `projetoBancoDados-MySQL_GitHub`.`veiculo` ;

CREATE TABLE IF NOT EXISTS `projetoBancoDados-MySQL_GitHub`.`veiculo` (
  `id_veiculo` INT NOT NULL AUTO_INCREMENT,
  `marca` VARCHAR(45) NOT NULL,
  `modelo` VARCHAR(45) NOT NULL,
  `ano_modelo_inicio` YEAR NOT NULL,
  `ano_modelo_fim` YEAR NOT NULL,
  PRIMARY KEY (`id_veiculo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projetoBancoDados-MySQL_GitHub`.`peca`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `projetoBancoDados-MySQL_GitHub`.`peca` ;

CREATE TABLE IF NOT EXISTS `projetoBancoDados-MySQL_GitHub`.`peca` (
  `id_peca` INT NOT NULL AUTO_INCREMENT,
  `codigo_peca` VARCHAR(45) NOT NULL,
  `nome_peca` VARCHAR(45) NOT NULL,
  `descricao` TEXT(100) NOT NULL,
  `unidade_medida` VARCHAR(45) NOT NULL,
  `preco_custo_padrao` DECIMAL(10,2) NOT NULL,
  `preco_venda_sugerido` DECIMAL(10,2) NOT NULL,
  `estoque_atual` INT NOT NULL,
  `estoque_minimo` INT NOT NULL,
  `estoque_maximo` INT NOT NULL,
  `localizacao_estoque` VARCHAR(45) NOT NULL,
  `data_ultima_entrada` DATE NOT NULL,
  `data_ultima_saida` DATE NOT NULL,
  PRIMARY KEY (`id_peca`),
  UNIQUE INDEX `codigo_peca_UNIQUE` (`codigo_peca` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projetoBancoDados-MySQL_GitHub`.`fornecedor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `projetoBancoDados-MySQL_GitHub`.`fornecedor` ;

CREATE TABLE IF NOT EXISTS `projetoBancoDados-MySQL_GitHub`.`fornecedor` (
  `id_fornecedor` INT NOT NULL AUTO_INCREMENT,
  `nome_fantasia` VARCHAR(100) NOT NULL,
  `razao_social` VARCHAR(100) NOT NULL,
  `contato_principal` VARCHAR(45) NOT NULL,
  `ddd` VARCHAR(4) NOT NULL,
  `numero_telefone` VARCHAR(9) NOT NULL,
  `email` VARCHAR(50) NULL,
  `cnpj` VARCHAR(18) NOT NULL,
  PRIMARY KEY (`id_fornecedor`),
  UNIQUE INDEX `cnpj_UNIQUE` (`cnpj` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projetoBancoDados-MySQL_GitHub`.`cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `projetoBancoDados-MySQL_GitHub`.`cliente` ;

CREATE TABLE IF NOT EXISTS `projetoBancoDados-MySQL_GitHub`.`cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `tipo_cliente` ENUM('PF', 'PJ') NOT NULL COMMENT 'PF: Pessoa Física  /  PJ: Pessoa Jurídica',
  `nome_razao_social` VARCHAR(100) NOT NULL,
  `ddd` VARCHAR(4) NOT NULL,
  `numero_telefone` VARCHAR(9) NOT NULL,
  `email` VARCHAR(50) NULL,
  `cnpj` VARCHAR(18) NULL,
  `cpf` VARCHAR(14) NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE INDEX `cnpj_UNIQUE` (`cnpj` ASC) ,
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projetoBancoDados-MySQL_GitHub`.`status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `projetoBancoDados-MySQL_GitHub`.`status` ;

CREATE TABLE IF NOT EXISTS `projetoBancoDados-MySQL_GitHub`.`status` (
  `id_status` INT NOT NULL AUTO_INCREMENT,
  `nome_status` VARCHAR(45) NOT NULL,
  `descricao_status` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`id_status`),
  UNIQUE INDEX `nome_status_UNIQUE` (`nome_status` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projetoBancoDados-MySQL_GitHub`.`pedido_compra`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `projetoBancoDados-MySQL_GitHub`.`pedido_compra` ;

CREATE TABLE IF NOT EXISTS `projetoBancoDados-MySQL_GitHub`.`pedido_compra` (
  `id_pedido_compra` INT NOT NULL AUTO_INCREMENT,
  `id_fornecedor` INT NOT NULL,
  `id_status` INT NOT NULL,
  `data_pedido` DATETIME NOT NULL,
  `valor_total` DECIMAL(10,2) NOT NULL,
  `data_entrega_prevista` DATE NOT NULL,
  `data_entrega_real` DATE NOT NULL,
  PRIMARY KEY (`id_pedido_compra`),
  INDEX `fk_fornecedores_idx` (`id_fornecedor` ASC) ,
  INDEX `fk_status_2_idx` (`id_status` ASC) ,
  CONSTRAINT `fk_fornecedores_1`
    FOREIGN KEY (`id_fornecedor`)
    REFERENCES `projetoBancoDados-MySQL_GitHub`.`fornecedor` (`id_fornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_compra_status_2`
    FOREIGN KEY (`id_status`)
    REFERENCES `projetoBancoDados-MySQL_GitHub`.`status` (`id_status`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projetoBancoDados-MySQL_GitHub`.`item_pedido_compra`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `projetoBancoDados-MySQL_GitHub`.`item_pedido_compra` ;

CREATE TABLE IF NOT EXISTS `projetoBancoDados-MySQL_GitHub`.`item_pedido_compra` (
  `id_item_pedido_compra` INT NOT NULL AUTO_INCREMENT,
  `id_pedido_compra` INT NOT NULL,
  `id_peca` INT NOT NULL,
  `quantidade` INT NOT NULL,
  `preco_unitario_compra` DECIMAL(10,2) NOT NULL,
  `subtotal` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id_item_pedido_compra`),
  INDEX `fk_pedidos_compra_idx` (`id_pedido_compra` ASC) ,
  INDEX `fk2_peca_idx` (`id_peca` ASC) ,
  CONSTRAINT `fk_pedidos_compra_1`
    FOREIGN KEY (`id_pedido_compra`)
    REFERENCES `projetoBancoDados-MySQL_GitHub`.`pedido_compra` (`id_pedido_compra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_peca_2`
    FOREIGN KEY (`id_peca`)
    REFERENCES `projetoBancoDados-MySQL_GitHub`.`peca` (`id_peca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projetoBancoDados-MySQL_GitHub`.`venda`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `projetoBancoDados-MySQL_GitHub`.`venda` ;

CREATE TABLE IF NOT EXISTS `projetoBancoDados-MySQL_GitHub`.`venda` (
  `id_venda` INT NOT NULL AUTO_INCREMENT,
  `id_cliente` INT NOT NULL,
  `id_status` INT NOT NULL,
  `data_venda` DATETIME NOT NULL,
  `valor_total` DECIMAL(10,2) NOT NULL,
  `forma_pagamento` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_venda`),
  INDEX `fk_cliente_idx` (`id_cliente` ASC) ,
  INDEX `fk_status_2_idx` (`id_status` ASC) ,
  CONSTRAINT `fk_venda_cliente`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `projetoBancoDados-MySQL_GitHub`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_venda_status`
    FOREIGN KEY (`id_status`)
    REFERENCES `projetoBancoDados-MySQL_GitHub`.`status` (`id_status`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projetoBancoDados-MySQL_GitHub`.`item_venda`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `projetoBancoDados-MySQL_GitHub`.`item_venda` ;

CREATE TABLE IF NOT EXISTS `projetoBancoDados-MySQL_GitHub`.`item_venda` (
  `id_item_venda` INT NOT NULL AUTO_INCREMENT,
  `id_venda` INT NOT NULL,
  `id_peca` INT NOT NULL,
  `quantidade` INT NOT NULL,
  `preco_unitario_venda` DECIMAL(10,2) NOT NULL,
  `subtotal` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id_item_venda`),
  INDEX `fk_venda_idx` (`id_venda` ASC) ,
  INDEX `fk2_peca_idx` (`id_peca` ASC) ,
  CONSTRAINT `fk_venda_1`
    FOREIGN KEY (`id_venda`)
    REFERENCES `projetoBancoDados-MySQL_GitHub`.`venda` (`id_venda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_venda_peca`
    FOREIGN KEY (`id_peca`)
    REFERENCES `projetoBancoDados-MySQL_GitHub`.`peca` (`id_peca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projetoBancoDados-MySQL_GitHub`.`peca_veiculo_compativel`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `projetoBancoDados-MySQL_GitHub`.`peca_veiculo_compativel` ;

CREATE TABLE IF NOT EXISTS `projetoBancoDados-MySQL_GitHub`.`peca_veiculo_compativel` (
  `id_peca_veiculo_compativel` INT NOT NULL AUTO_INCREMENT,
  `id_peca` INT NOT NULL,
  `id_veiculo` INT NOT NULL,
  `observacoes` TEXT NOT NULL,
  PRIMARY KEY (`id_peca_veiculo_compativel`),
  INDEX `fk_peca_idx` (`id_peca` ASC) ,
  INDEX `fk2_veiculo_idx` (`id_veiculo` ASC) ,
  CONSTRAINT `fk_peca_1`
    FOREIGN KEY (`id_peca`)
    REFERENCES `projetoBancoDados-MySQL_GitHub`.`peca` (`id_peca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_veiculo_2`
    FOREIGN KEY (`id_veiculo`)
    REFERENCES `projetoBancoDados-MySQL_GitHub`.`veiculo` (`id_veiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projetoBancoDados-MySQL_GitHub`.`endereco_cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `projetoBancoDados-MySQL_GitHub`.`endereco_cliente` ;

CREATE TABLE IF NOT EXISTS `projetoBancoDados-MySQL_GitHub`.`endereco_cliente` (
  `id_endereco_cliente` INT NOT NULL AUTO_INCREMENT,
  `id_cliente` INT NOT NULL,
  `logradouro` VARCHAR(100) NOT NULL,
  `numero` INT NOT NULL,
  `complemento` VARCHAR(45) NOT NULL,
  `bairro` VARCHAR(45) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `estado` VARCHAR(2) NOT NULL,
  `cep` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`id_endereco_cliente`),
  INDEX `fk_cliente_1_idx` (`id_cliente` ASC) ,
  CONSTRAINT `fk_cliente_1`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `projetoBancoDados-MySQL_GitHub`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projetoBancoDados-MySQL_GitHub`.`endereco_fornecedor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `projetoBancoDados-MySQL_GitHub`.`endereco_fornecedor` ;

CREATE TABLE IF NOT EXISTS `projetoBancoDados-MySQL_GitHub`.`endereco_fornecedor` (
  `id_endereco_fornecedor` INT NOT NULL AUTO_INCREMENT,
  `id_fornecedor` INT NOT NULL,
  `logradouro` VARCHAR(100) NOT NULL,
  `numero` INT NOT NULL,
  `complemento` VARCHAR(45) NOT NULL,
  `bairro` VARCHAR(45) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `estado` VARCHAR(2) NOT NULL,
  `cep` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_endereco_fornecedor`),
  INDEX `fk_fornecedor_1_idx` (`id_fornecedor` ASC) ,
  CONSTRAINT `fk_fornecedor_1`
    FOREIGN KEY (`id_fornecedor`)
    REFERENCES `projetoBancoDados-MySQL_GitHub`.`fornecedor` (`id_fornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;




Data Manipulation Language (DML) INSERT
***INSERT para popular tabelas***

  
-- Use o seu schema
USE projetobancodados-mysql_github;

-- 1. Popular a tabela 'status'
INSERT INTO status (id_status, nome_status, descricao_status) VALUES
(1, 'Pendente', 'O Pedido foi criado e aguarda processamento.'),
(2, 'Confirmado', 'O pedido foi confirmado e está sendo preparado.'),
(3, 'Em Trânsito', 'A mercadoria está a caminho.'),
(4, 'Recebido', 'A mercadoria do pedido de compra foi recebida.'),
(5, 'Concluído', 'O pedido foi finalizado.'),
(6, 'Cancelado', 'O pedido foi cancelado.');

-- 2. Popular a tabela 'veiculo'
INSERT INTO veiculo (id_veiculo, marca, modelo, ano_modelo_inicio, ano_modelo_fim) VALUES
(1, 'Honda', 'Civic Sedan', 2016, 2021),
(2, 'Honda', 'HR-V', 2015, 2022),
(3, 'Honda', 'Fit', 2014, 2021),
(4, 'Honda', 'CR-V', 2017, 2025); 

-- 3. Popular a tabela 'peca'
INSERT INTO peca (codigo_peca, nome_peca, descricao, unidade_medida, preco_custo_padrao, preco_venda_sugerido, estoque_atual, estoque_minimo, estoque_maximo, localizacao_estoque, data_ultima_entrada, data_ultima_saida) VALUES
('21102-RJA-001', 'Filtro de Óleo', 'Filtro de óleo original Honda para diversos modelos.', 'UNIDADE', 35.50, 69.90, 150, 40, 300, 'A1-01', '2025-05-10', '2025-05-20'),
('51601-TBA-A01', 'Amortecedor Dianteiro', 'Amortecedor dianteiro esquerdo para Civic 10ª Geração.', 'UNIDADE', 220.00, 450.00, 30, 10, 80, 'B2-05', '2025-04-20', '2025-05-15'),
('45022-TBA-A00', 'Pastilha Freio Dianteiro', 'Conjunto de pastilhas de freio dianteiras.', 'CONJUNTO', 80.00, 180.00, 100, 30, 200, 'C3-10', '2025-05-01', '2025-05-22'),
('17220-5R0-008', 'Filtro de Ar do Motor', 'Filtro de ar para Honda Fit e HR-V.', 'UNIDADE', 45.00, 95.00, 80, 20, 150, 'A1-02', '2025-05-12', '2025-05-18');

-- 4. Popular a tabela 'cliente'
-- Lógica: ou CPF ou CNPJ preenchido, não ambos.
INSERT INTO cliente (tipo_cliente, nome_razao_social, ddd, numero_telefone, email, cnpj, cpf) VALUES
('PF', 'João Silva', '11', '987654321', 'joao.silva@email.com', NULL, '123.456.789-00'),
('PJ', 'Oficina MecaRápida LTDA', '21', '33445566', 'contato@mecarapida.com.br', '01.234.567/0001-89', NULL),
('PF', 'Maria Oliveira', '31', '998877665', 'maria.o@email.com', NULL, '987.654.321-01');

-- 5. Popular a tabela 'endereco_cliente'
INSERT INTO endereco_cliente (id_cliente, logradouro, numero, complemento, bairro, cidade, estado, cep) VALUES
(1, 'Rua das Flores', '123', 'Apto 101', 'Jardim Primavera', 'São Paulo', 'SP', '01234-567'),
(2, 'Av. Principal', '456', 'Apto 202', 'Centro', 'Rio de Janeiro', 'RJ', '20000-000'),
(3, 'Rua do Sol', '789', 'Casa B', 'Santa Efigênia', 'Belo Horizonte', 'MG', '30000-000');

-- 6. Popular a tabela 'fornecedor'
INSERT INTO fornecedor (nome_fantasia, razao_social, cnpj, ddd, numero_telefone, contato_principal, email) VALUES
('AutoPeças Express', 'AutoPeças Express S.A.', '12.345.678/0001-90', '11', '22334455', 'Carlos Abreu', 'vendas@autopecasexpress.com'),
('Distribuidora Honda Peças', 'Honda Peças Brasil LTDA', '98.765.432/0001-01', '19', '34567890', 'Ana Paula', 'ana.paula@hondapeças.com');

-- 7. Popular a tabela 'endereco_fornecedor'
INSERT INTO endereco_fornecedor (id_fornecedor, logradouro, numero, complemento, bairro, cidade, estado, cep) VALUES
(1, 'Av. Industrial', '1000', 'Galpão 3', 'Distrito Industrial', 'Guarulhos', 'SP', '07000-000'),
(2, 'Rua da Produção', '500', 'Galpão 8', 'Alphaville', 'Campinas', 'SP', '13000-000');

-- 8. Popular a tabela 'peca_veiculo_compativel'
INSERT INTO peca_veiculo_compativel (id_peca, id_veiculo, observacoes) VALUES
(1, 1, 'Compatível com Civic 10ª Geração'),
(1, 2, 'Compatível com HR-V (todas as versões)'),
(1, 3, 'Compatível com Fit (todas as versões)'),
(2, 1, 'Apenas para Civic 10ª Geração Sedan'),
(3, 1, 'Dianteira, para Civic 10ª Geração'),
(3, 2, 'Dianteira, para HR-V 2015-2022'),
(4, 2, 'Compatível com HR-V (todas as versões)'),
(4, 3, 'Compatível com Fit (todas as versões)');

-- 9. Popular a tabela 'venda'
INSERT INTO venda (id_cliente, id_status, data_venda, valor_total, forma_pagamento) VALUES
(1, 5, '2025-05-23 10:30:00', 69.90, 'Cartão de Crédito'),
(2, 5, '2025-05-24 14:00:00', 630.00, 'Boleto Bancário'),
(3, 2, '2025-05-24 16:45:00', 95.00, 'Pix');

-- 10. Popular a tabela 'item_venda'
INSERT INTO item_venda (id_item_venda, id_venda, id_peca, quantidade, preco_unitario_venda) VALUES
(1, 1, 1, 2, 69.90),
(2, 2, 2, 5, 450.00),
(3, 3, 3, 3, 180.00),
(4, 2, 4, 4, 95.00);

-- 11. Popular a tabela 'pedido_compra'
INSERT INTO pedido_compra (id_fornecedor, id_status, data_pedido, valor_total, data_entrega_prevista, data_entrega_real) VALUES
(1, 2, '2025-05-20 09:00:00', 700.00, '2025-05-27', '2025-06-03'),
(2, 4, '2025-05-15 11:00:00', 2500.00, '2025-05-22', '2025-05-29');

-- 12. Popular a tabela 'item_pedido_compra'
INSERT INTO item_pedido_compra (id_pedido_compra, id_peca, quantidade, preco_unitario_compra) VALUES
(1, 1, 10, 35.50),
(1, 3, 5, 80.00),
(2, 2, 5, 220.00),
(2, 4, 10, 45.00);





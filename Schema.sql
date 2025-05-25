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

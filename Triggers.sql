
-- **********************************************
-- ***************** TRIGGERS *******************
-- **********************************************

-- Use o seu schema
USE projetobancodados-mysql_github;

-- Trigger para atualizar o estoque após a inserção de um item de venda
-- Objetivo: Diminuir automaticamente o estoque da peça vendida.
-- Usamos um único DELIMITER para todos os triggers

DELIMITER $$

CREATE TRIGGER trg_atualiza_estoque_apos_venda
AFTER INSERT ON item_venda
FOR EACH ROW
BEGIN
    UPDATE peca
    SET 
        estoque_atual = GREATEST(estoque_atual - NEW.quantidade, 0),
        data_ultima_saida = CURDATE()
    WHERE id_peca = NEW.id_peca;
END$$

DELIMITER ;

-- Trigger para atualizar o estoque após a exclusão de um item de venda (se o item foi removido, o estoque deve ser reajustado)
-- Objetivo: Aumentar automaticamente o estoque da peça se um item de venda for removido.

DELIMITER $$

CREATE TRIGGER trg_atualiza_estoque_apos_delete_item_venda
AFTER DELETE ON item_venda
FOR EACH ROW
BEGIN
    UPDATE peca
    SET 
        estoque_atual = estoque_atual + OLD.quantidade
    WHERE id_peca = OLD.id_peca;
END$$

DELIMITER ;

-- Trigger para atualizar o estoque após a atualização da quantidade de um item de venda
-- Objetivo: Ajustar o estoque se a quantidade de uma peça vendida for alterada.

DELIMITER $$

CREATE TRIGGER trg_atualiza_estoque_apos_update_item_venda
AFTER UPDATE ON item_venda
FOR EACH ROW
BEGIN
    -- Se mudou de peça, devolve à antiga
    IF OLD.id_peca <> NEW.id_peca THEN
        UPDATE peca
        SET estoque_atual = estoque_atual + OLD.quantidade
        WHERE id_peca = OLD.id_peca;
        -- subtrai da nova
        UPDATE peca
        SET 
            estoque_atual = GREATEST(estoque_atual - NEW.quantidade, 0),
            data_ultima_saida = CURDATE()
        WHERE id_peca = NEW.id_peca;
    ELSE
        -- Mesma peça: ajusta apenas a diferença
        IF NEW.quantidade > OLD.quantidade THEN
            UPDATE peca
            SET 
                estoque_atual = GREATEST(estoque_atual - (NEW.quantidade - OLD.quantidade), 0)
            WHERE id_peca = NEW.id_peca;
        ELSEIF NEW.quantidade < OLD.quantidade THEN
            UPDATE peca
            SET 
                estoque_atual = estoque_atual + (OLD.quantidade - NEW.quantidade)
            WHERE id_peca = NEW.id_peca;
        END IF;
    END IF;
END$$

DELIMITER ;



-- *******************************************
-- *************** FIM DAS TRIGGERS **********
-- *******************************************

create database testes;
use testes;

CREATE TABLE Produtos
(
	Referencia	VARCHAR(3) PRIMARY KEY,
	Descricao	VARCHAR(50) UNIQUE,
	Estoque	INT NOT NULL DEFAULT 0
);

INSERT INTO Produtos VALUES ('001', 'Feijão', 10);
INSERT INTO Produtos VALUES ('002', 'Arroz', 5);
INSERT INTO Produtos VALUES ('003', 'Farinha', 15);

CREATE TABLE ItensVenda
(
	Venda		INT,
	Produto	VARCHAR(3),
	Quantidade	INT
);

CREATE TABLE Pedido
(
	Venda		INT,
	Produto	VARCHAR(3),
	Quantidade	INT
);

DELIMITER $

CREATE TRIGGER Tgr_ItensVenda_Insert 
	AFTER INSERT ON ItensVenda
FOR EACH ROW
BEGIN
	UPDATE Produtos SET Estoque = Estoque - NEW.Quantidade
WHERE Referencia = NEW.Produto;
END$

CREATE TRIGGER Tgr_Pedidos_Insert 
	AFTER INSERT ON Pedido
FOR EACH ROW
BEGIN
	UPDATE Produtos SET Estoque = Estoque - NEW.Quantidade
WHERE Referencia = NEW.Produto;
END$


DELIMITER $
## caso seja cancelada uma venda deve-se voltar a quantidade que havia no estoque
CREATE TRIGGER Tgr_ItensVenda_Delete AFTER DELETE
ON ItensVenda
FOR EACH ROW
BEGIN
	UPDATE Produtos SET Estoque = Estoque + OLD.Quantidade
WHERE Referencia = OLD.Produto;
END$

DELIMITER $
## caso seja cancelada uma venda deve-se voltar a quantidade que havia no estoque
CREATE TRIGGER Tgr_pedido_Delete AFTER DELETE
ON pedido
FOR EACH ROW
BEGIN
	UPDATE Produtos SET Estoque = Estoque + OLD.Quantidade
WHERE Referencia = OLD.Produto;
END$


DELIMITER ;


show triggers;
select * from produtos;
update produtos set estoque = 10 where referencia = '001';
update produtos set estoque = 5 where referencia = '002';
update produtos set estoque = 15 where referencia = '003';
select * from itensvenda;
select * from pedido;

insert into pedido values (1, '001', 3);
insert into pedido values (1, '002', 1);
insert into pedido values (1, '003', 5);

delete from pedido where produto = '001';
delete from itensvenda;






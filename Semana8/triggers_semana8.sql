Create table produto(
idProduto int not null auto_increment,
nome varchar(45) null,
preco_normal decimal(10,2) null,
preco_desconto decimal(10,2) null,
primary key (idProduto));

-- Criação da trigger
create trigger tr_desconto before insert 
on Produto
for each row
set new.preco_desconto = (new.preco_normal * 0.9);

insert into produto (nome, preco_normal) values
('Monitor', 250);

select * from produto; 







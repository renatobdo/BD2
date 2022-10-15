create table contas (id int primary key,
dono_da_conta varchar(100),
saldo float,
moeda varchar(30),
data_criacao datetime);

## serializável
delete from contas;
select * from contas;
insert into contas (id, dono_da_conta, saldo, moeda, data_criacao)
values (1, 'Vinnie', 80, 'USD', '2021-07-13 20:39:27'),
(2, 'Sergey', 100, 'USD', '2021-07-13 20:39:32'),
(3, 'Markus', 100, 'USD', '2021-07-13 20:39:39');

#Testes com nível serializável. Executar o código abaixo na sessão 1
set autocommit = 0;
set foreign_key_checks=0;

START TRANSACTION;
select * from contas;
update contas set saldo = saldo -10 where id =1;
select * from contas;
commit;

SELECT @@global. tx_isolation;
set global transaction isolation level serializable;
set global transaction isolation level REPEATABLE READ;
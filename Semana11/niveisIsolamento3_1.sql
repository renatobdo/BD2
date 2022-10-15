#Testes com nível serializável. Executar o código abaixo na sessão 1
set autocommit = 0;
set foreign_key_checks=0;

START TRANSACTION;
select * from contas where saldo >=80;
select * from contas where id = 1;

update contas set saldo = saldo -10 where id =1;
select * from contas where id = 1;

SELECT @@global. tx_isolation;
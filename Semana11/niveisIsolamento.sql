#Testes com repeatable-read. Executar o código abaixo na sessão 1
set autocommit = 0;
set foreign_key_checks=0;

START TRANSACTION;
select * from employees where employeeNumber between 1165
 and 1166;


SELECT @@global. tx_isolation;
set global transaction isolation level serializable;
set global transaction isolation level REPEATABLE READ;

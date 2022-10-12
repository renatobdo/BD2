#Testes com repeatable-read. Executar o código abaixo na sessão 2
set autocommit = 0;
set foreign_key_checks=0;

START TRANSACTION;
update employees set firstName = 'Renato' where 
employeeNumber = 1165;
commit;

select * from employees where employeeNumber between 1165 and 1166;


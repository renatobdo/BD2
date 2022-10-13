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
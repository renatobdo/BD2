###################################################
################ views ##########################
##C:\Users\renat\OneDrive\Área de Trabalho\Renato\DisciplinasProfessorIFSPGuarulhos\BD2\8\Semana8.sql
#
#
#### Exercício - 1
Create table martian_confidential
(martian_id int primary key,
first_name varchar(40),
last_name varchar(80),
base_id int,
super_id int,
salary decimal(8,2),
dna_id varchar(30),
foreign key(base_id) references base (base_id)
);


insert into martian_confidential values
(1, 'Ray', 'Bradburry', 1, null, 155900, 'gcta'),
(2, 'John', 'Black', 4, 10, 120100, 'cagt'); 

select * from martian_confidential;

### Resposta do exercício 1 ###
select martian_id, first_name, last_name, base_id, super_id
from martian_confidential;

create view martian_public as 
select martian_id, first_name, last_name, base_id, super_id
from martian_confidential;

select * from martian_public;

######## Exercício - 2 e 3
#### Criação da tabela visitor ###############
create table visitor(visitor_id integer,
host_id integer,
first_name varchar(30),
last_name varchar(80));

insert into visitor values (1, 1,'George', 'Ambrose'),
(2, 2,'Kris', 'Cardenas'),
(3, 3, 'Priscilla', 'Lane'),
(4, 4,'Jane', 'Thorton');

alter table visitor add primary key (visitor_id); 


##### Resposta do exercício 3 #####
#### Reparem que o select está sendo realizado na view martian_public
####
select martian_id, first_name, last_name, 'Martian' as status
from martian_public
	union
select visitor_id, first_name, last_name, 'visitor' as status
from visitor;

######## Execute o select abaixo e veja o resultado
select CONCAT('m', martian_id) AS id, first_name, last_name, 
	'Martian' as status
from martian_public
	UNION
select CONCAT('v', visitor_id) AS id, first_name, last_name, 
	'visitor' as status
from visitor;
#####################
# Criação da view people_on_mars
#####################
CREATE VIEW people_on_mars AS
select CONCAT('m', martian_id) AS id, first_name, last_name, 
	'Martian' as status
from martian_public
	UNION
select CONCAT('v', visitor_id) AS id, first_name, last_name, 
	'visitor' as status
from visitor;



############################################
### Exercício - 4

Create table base (base_id integer,
base_name varchar(50), 
founded date);
alter table base add primary key (base_id);
insert into base values
(1,'tharsisland', '2037-06-03'),
(2,'Valles Marineris 2.0', '2040-12-01'),
(3,'Gale Cratertown', '2041-08-15'),
(4,'New New New York', '2042-02-10'),
(5,'Olympus Mons Spa & Casino', null);

create table inventory (inventory_id integer primary key auto_increment, base_id integer,
supply_id integer,
quantity integer,
foreign key(base_id) references base(base_id),
foreign key(supply_id) references supply(supply_id));

insert into inventory(base_id, supply_id, quantity) values(1, 1, 8),
(1,3,5),
(1,5,1),
(1,6,2),
(1,8,12),
(1,9,1),
(2,4,5),
(2,8,62),
(2,10,37),
(3,2,11),
(3,7,2),
(4,10,91);

create table supply(supply_id integer primary key,
nome varchar(80),
description varchar(120),
quantity integer);

insert into supply values(1, 'solar panel', 'standard 1x1 meter cell', 912),
(2, 'water filter', 'this takes things out of your water so it\'s drinkable', 6),
(3, 'Duct Tape', 'A 10 meter roll of duct tape for ALL your repairs', 951),
(4, 'Ketchup', 'It\'s ketchup... ', 206),
(5, 'Battery Cell', 'Standard 1000 KAh battery cell for power grid (heavy item)', 17),
(6, 'USB 6.0 cable', 'Carbon fiber coated / 15 TBps spool', 42),
(7, 'Fuzzy Duster ', 'It gets dusty around here. Be prepared!', 19),
(8, 'Mars bars', 'The original nutrient bar made with the finest bioengineered ingredients', 3801),
(9, 'Air Filter', 'Removes 99% of all Martian dust from your ventilation unit', 23),
(10, 'Famous Ray\'s Frozen Pizza', 'This Martian favorite is covered in all your favorite toppings. 1 flavor only', 823);

########### 
## Criar uma view com o nome base_storage
# com a quantidade de suprimentos em cada base
### Exercício 5 ############

select b.base_id, s.supply_id, s.nome
from base as b
cross join supply as s order by base_id, supply_id;

#### Resultado do CROSS JOIN ##################
## conecta cada linha na tabela da esquerda com cada linha
## na tabela da direita. Isso nos dá todas as combinações de base supply
## 5 bases x 10 supply itens = 50 linhas. Veja abaixo:

base_id	supply_id	nome
1	1	solar panel
1	2	water filter
1	3	Duct Tape
1	4	Ketchup
1	5	Battery Cell
1	6	USB 6.0 cable
1	7	Fuzzy Duster
1	8	Mars bars
1	9	Air Filter
1	10	Famous Ray's Frozen Pizza
2	1	solar panel
2	2	water filter
2	3	Duct Tape
2	4	Ketchup
2	5	Battery Cell
2	6	USB 6.0 cable
2	7	Fuzzy Duster
2	8	Mars bars
2	9	Air Filter
2	10	Famous Ray's Frozen Pizza
3	1	solar panel
3	2	water filter
3	3	Duct Tape
3	4	Ketchup
3	5	Battery Cell
3	6	USB 6.0 cable
3	7	Fuzzy Duster
3	8	Mars bars
3	9	Air Filter
3	10	Famous Ray's Frozen Pizza
4	1	solar panel
4	2	water filter
4	3	Duct Tape
4	4	Ketchup
4	5	Battery Cell
4	6	USB 6.0 cable
4	7	Fuzzy Duster
4	8	Mars bars
4	9	Air Filter
4	10	Famous Ray's Frozen Pizza
5	1	solar panel
5	2	water filter
5	3	Duct Tape
5	4	Ketchup
5	5	Battery Cell
5	6	USB 6.0 cable
5	7	Fuzzy Duster
5	8	Mars bars
5	9	Air Filter
5	10	Famous Ray's Frozen Pizza



### com SUBQUERY exercício 6 ####

select b.base_id, s.supply_id, s.nome,
	(select quantity from inventory
		where base_id = b.base_id AND supply_id = s.supply_id) as quantity
from base as b
cross join supply as s ORDER BY BASE_ID, SUPPLY_ID;

###
##### Resultado do CROSS JOIN com subquery ############################
####
base_id	supply_id	nome	quantity
1	1	solar panel	8
1	2	water filter	null
1	3	Duct Tape	5
1	4	Ketchup		null    
1	5	Battery Cell	1
1	6	USB 6.0 cable	2
1	7	Fuzzy Duster	null
1	8	Mars bars	12
1	9	Air Filter	1
1	10	Famous Ray's 	null
		Frozen Pizza	
2	1	solar panel	null
2	2	water filter	null
2	3	Duct Tape	null
2	4	Ketchup		5
2	5	Battery Cell	null
2	6	USB 6.0 cable	null
2	7	Fuzzy Duster	null
2	8	Mars bars	62
2	9	Air Filter	null
2	10	Famous Ray's 	37
		Frozen Pizza	
3	1	solar panel	null
3	2	water filter	11
3	3	Duct Tape	null
3	4	Ketchup		null
3	5	Battery Cell	null
3	6	USB 6.0 cable	null
3	7	Fuzzy Duster	2
3	8	Mars bars	null
3	9	Air Filter	null
3	10	Famous Ray's 	null
		Frozen Pizza	
4	1	solar panel	null
4	2	water filter	null
4	3	Duct Tape	null
4	4	Ketchup		null
4	5	Battery Cell	null
4	6	USB 6.0 cable	null
4	7	Fuzzy Duster	null
4	8	Mars bars	null
4	9	Air Filter	null
4	10	Famous Ray's 	91
		Frozen Pizza	
5	1	solar panel	null
5	2	water filter	null
5	3	Duct Tape	null
5	4	Ketchup		null
5	5	Battery Cell	null
5	6	USB 6.0 cable	null
5	7	Fuzzy Duster	null
5	8	Mars bars	null
5	9	Air Filter	null
5	10	Famous Ray's 	null
		Frozen Pizza	
###		
######### Exercício 7 - COALESCE para substituir os valores nulos ################
select b.base_id, s.supply_id, s.nome,
	COALESCE((select quantity from inventory
		where base_id = b.base_id AND supply_id = s.supply_id),0) as 
        quantity
from base as b
cross join supply as s;
#########

base_id	supply_id	nome	quantity
1	1	solar panel	8
2	1	solar panel	0
3	1	solar panel	0
4	1	solar panel	0
5	1	solar panel	0
1	2	water filter	0
2	2	water filter	0
3	2	water filter	11
4	2	water filter	0
5	2	water filter	0
1	3	Duct Tape	5
2	3	Duct Tape	0
3	3	Duct Tape	0
4	3	Duct Tape	0
5	3	Duct Tape	0
1	4	Ketchup		0
2	4	Ketchup		5
3	4	Ketchup		0
4	4	Ketchup		0
5	4	Ketchup		0
1	5	Battery Cell	1
2	5	Battery Cell	0
3	5	Battery Cell	0
4	5	Battery Cell	0
5	5	Battery Cell	0
1	6	USB 6.0 cable	2
2	6	USB 6.0 cable	0
3	6	USB 6.0 cable	0
4	6	USB 6.0 cable	0
5	6	USB 6.0 cable	0
1	7	Fuzzy Duster	0
2	7	Fuzzy Duster	0
3	7	Fuzzy Duster	2
4	7	Fuzzy Duster	0
5	7	Fuzzy Duster	0
1	8	Mars bars	12
2	8	Mars bars	62
3	8	Mars bars	0
4	8	Mars bars	0
5	8	Mars bars	0
1	9	Air Filter	1
2	9	Air Filter	0
3	9	Air Filter	0
4	9	Air Filter	0
5	9	Air Filter	0
1	10	Famous Ray's 	0
		Frozen Pizza	
2	10	Famous Ray's 	37
		Frozen Pizza	
3	10	Famous Ray's 	0
		Frozen Pizza	
4	10	Famous Ray's	91 
		Frozen Pizza	
5	10	Famous Ray's	0 
		Frozen Pizza	

######### Exercício  8
###
Create view base_storage as
select b.base_id, s.supply_id, s.nome,
	COALESCE((select quantity from inventory
		where base_id = b.base_id AND supply_id = s.supply_id),0)
        AS quantity
from base as b
cross join supply as s;
#
select * from base_storage;
#

# Crie uma view que mostre os produtos que estejam com o preço
# acima da média
CREATE VIEW [Products Above Average Price] AS
SELECT ProductName, Price
FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products); 


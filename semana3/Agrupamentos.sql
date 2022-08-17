SELECT    DISTINCT department_id FROM    
Employees
ORDER BY    
department_id;

## Tabela que será utilizada para os exemplos com GROUP BY
CREATE TABLE inventory (
    warehouse VARCHAR(255),
    product VARCHAR(255) NOT NULL,
    model VARCHAR(50) NOT NULL,
    quantity INT,
    PRIMARY KEY (warehouse,product,model)
);
INSERT INTO inventory(warehouse, product, model, quantity)
VALUES('San Jose', 'iPhone','6s',100);
INSERT INTO inventory(warehouse, product, model, quantity)
VALUES('San Fransisco', 'iPhone','6s',50);
INSERT INTO inventory(warehouse, product, model, quantity)
VALUES('San Jose','iPhone','7',50);
INSERT INTO inventory(warehouse, product, model, quantity)
VALUES('San Fransisco', 'iPhone','7',10);
INSERT INTO inventory(warehouse, product, model, quantity)
VALUES('San Jose','iPhone','X',150);
INSERT INTO inventory(warehouse, product, model, quantity)
VALUES('San Fransisco', 'iPhone','X',200);
INSERT INTO inventory(warehouse, product, model, quantity)
VALUES('San Jose','Samsung','Galaxy S',200);
INSERT INTO inventory(warehouse, product, model, quantity)
VALUES('San Fransisco','Samsung','Galaxy S',200);
INSERT INTO inventory(warehouse, product, model, quantity)
VALUES('San Fransisco','Samsung','Note 8',100);
INSERT INTO inventory(warehouse, product, model, quantity)
VALUES('San Jose','Samsung','Note 8',150);

SELECT 
    *
FROM
    inventory;

SELECT    SUM(quantity) qty
FROM    inventory;


select * from inventory;
alter table inventory add ano year;
update inventory set ano = now() where model = '7' and model = 'X';
update inventory set ano = now() where model = 'X';
update inventory set ano = 2021 where model = '6s';
update inventory set ano = 2021 where model = 'Galaxy S';
update inventory set ano = 2022 where model = 'Note 8';
select * from employees;
select * from countries;
# Essa consulta retorna a quantidade de funcionários ordenando de maneira descendente
select e.department_id, d.department_name as 'nome do departamento', 
count(employee_id) 
as 'quantidade de funcionários'
	FROM employees e inner join departments d
		on e.department_id = d.department_id
		GROUP BY (department_id)
        ORDER BY 3 DESC;

#
select e.department_id, d.department_name as 'nome do departamento', 
count(employee_id) 
as 'quantidade_de_funcionarios'
	FROM employees e inner join departments d
		on e.department_id = d.department_id
		GROUP BY (department_id)
        having quantidade_de_funcionarios >= 6;

# Essa consulta retorna o menor salário, o maior salário,
# e a média agrupado por departamento
select department_name, min(salary),
	max(salary), avg(salary) 
    from departments d inner join
			employees e
            on d.department_id = e.department_id
    group by (department_name) 
    order by 4 DESC;        
	
# Essa consulta retorna o menor salário, o maior salário,
# e a média agrupado por departamento
select department_name, sum(salary) 
    from departments d inner join
			employees e
            on d.department_id = e.department_id
    group by (department_name) 
    order by 2 DESC;   
# Essa consulta retorna a quantidade de empregados
# por cargo e departamento
select department_name, job_title, count(employee_id)
    from employees e inner join
			departments d
            on d.department_id = e.department_id
					inner join
			jobs j
            on e.job_id = j.job_id
    group by department_name, job_title;
# Esse consulta retorna a soma de produtos por armazém
#A
select warehouse, product, sum(quantity)
	from inventory
    group by warehouse, product;
# Esse consulta retorna a soma de produtos por armazém
#B
select warehouse,  sum(quantity)
	from inventory
    group by warehouse;
#C
select product,  sum(quantity)
	from inventory
    group by product;
#D
select sum(quantity) as 'qty'
	from inventory;
# Retornar os totais de produtos por armazém    
select COALESCE(warehouse, 'todos os armazéns') as	
	warehouse, sum(quantity)
    from inventory group by warehouse with rollup;

##
select warehouse, product, sum(quantity)
    from inventory group by warehouse, product
    with rollup;

select first_name, last_name, hire_date,
CASE (2000 - YEAR(hire_date))
	WHEN '1' THEN '1 ANO'
    WHEN '2' THEN '2 ANOS'
    WHEN '3' THEN '3 ANOS'
END aniversário
from employees
order by first_name;

select first_name, last_name, salary, 
CASE	
	when salary < 3000 then 'baixo'
    when salary >=3000 and salary <=5000 then 'médio'
    when salary > 5000 then 'alto'
END faixa_salarial
from employees;

# Essa consulta retorna a quantidade de empregados
# por departamento
select department_id, count(employee_id) as 'qtde de 
empregados'
	from employees
    group by department_id;

# Essa consulta retorna a quantidade de empregados
# agrupados pelo NOME do departamento
select department_name, count(employee_id) as 
'qtde_de_empregados'
	from employees e INNER JOIN
    departments d on e.department_id = 
		d.department_id
    group by d.department_id
    having qtde_de_empregados >= 5
    order by qtde_de_empregados DESC;
# Obter o menor, maior e a média salarial por departamento
select department_name, MIN(salary) as 'menor salário'
, MAX(salary) as 'maior salário',
AVG(salary) as 'média salarial' from employees e INNER JOIN
departments d ON e.department_id = d.department_id
GROUP BY department_name;

# Agrupar por nome do departamento e mostrar a soma
# salarial de cada departamento
select department_name, SUM(salary) as 'Soma_salarial'
from employees em INNER JOIN departments de
ON em.department_id =  de.department_id
group by department_name ORDER BY Soma_salarial DESC;


# obter a quantidade de funcionários agrupado pelo cargo
# e por departamento
select department_name, job_title as 'cargo', 
COUNT(employee_id)
 as 'quantidade de funcionários'
from employees em 
	INNER JOIN departments de
		ON em.department_id =  de.department_id
	INNER JOIN jobs j
		ON em.job_id =  j.job_id
	group by department_name, job_title;

## CASE SQL exemplo 1 que retornar o tempo de empresa do funcionário
Select first_name, last_name, hire_date,
	CASE(2022 - YEAR(hire_date))
		WHEN 1  THEN '1 ANO DE EMPRESA'
        WHEN 2 THEN '2 ANOS DE EMPRESA'
        WHEN 3 THEN '3 ANOS DE EMPRESA'
        when 4 THEN '4 ANOS DE EMPRESA'
        else 'mais do que 4 anos'
	END aniversario
FROM employees
order by aniversario DESC;

# CASE SQL
# Avaliação salarial dos funcionários 
Select first_name, last_name, salary,
	CASE 
		when salary < 1500
			THEN 'baixo'
        WHEN salary >= 1500 and salary < 3000
			THEN 'média'
		when salary >= 3000 
			then 'alto'
	END avaliacaosalarial
FROM employees
order by avaliacaosalarial DESC;


















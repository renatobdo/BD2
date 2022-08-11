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

select e.department_id, d.department_name as 'nome do departamento', count(employee_id) 
as 'quantidade de funcionários'
	FROM employees e inner join departments d
		on e.department_id = d.department_id
		GROUP BY (department_id);




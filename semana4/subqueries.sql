#Subqueries

SELECT 
    employee_id, first_name, last_name
FROM
    employees
WHERE
    department_id IN (1 , 3, 8, 10, 11)
ORDER BY first_name , last_name;

## Buscando os empregados em que o location_id = 1700
# O location_id está na tabela departments
#select COUNT(employee_id), first_name, last_name
select employee_id, first_name, last_name
FROM
	employees e INNER JOIN
    departments d on e.department_id = d.department_id
WHERE
	d.location_id = 1700 ORDER BY first_name , last_name;

# Utilização de subquery
SELECT employee_id, first_name, last_name
#SELECT COUNT(employee_id), first_name, last_name
FROM
    employees
WHERE
    department_id IN (SELECT 
            department_id
        FROM
            departments
        WHERE
            location_id = 1700)
ORDER BY first_name , last_name;

###
SELECT 
    employee_id, first_name, last_name, salary
FROM
    employees
WHERE
    salary = (SELECT 
            MAX(salary)
        FROM
            employees)
ORDER BY first_name , last_name;
#
SELECT 
    employee_id, first_name, last_name, salary
FROM
    employees
WHERE
    salary <> (SELECT 
            AVG(salary)
        FROM
            employees)    
ORDER BY first_name , last_name;

#
SELECT 
    department_id, department_name
FROM
    departments d
WHERE
    EXISTS( SELECT 
            1
        FROM
            employees e
        WHERE
            salary > 10000
                AND e.department_id = d.department_id)
ORDER BY department_name; 

select * from departments;

SELECT 
    employee_id, first_name, last_name, salary
FROM
    employees
WHERE
    salary >= ALL (SELECT 
            MIN(salary)
        FROM
            employees
        GROUP BY department_id)
ORDER BY first_name , last_name;

SELECT 
    employee_id, first_name, last_name, salary
FROM
    employees
WHERE
    salary >= SOME (SELECT 
            MAX(salary)
        FROM
            employees
        GROUP BY department_id) order by first_name;

SELECT 
        AVG(salary) average_salary
    FROM
        employees
    GROUP BY department_id;

SELECT 
    ROUND(AVG(average_salary),0)
FROM
    (SELECT 
        AVG(salary) average_salary
    FROM
        employees
    GROUP BY department_id) department_salary;

### Utilizar o banco de dados projetos. Ver no git...
#https://github.com/renatobdo/BD2/blob/main/semana4/projetosdb.sql    
    
select titulo, count(p.id) from comentario c 
	inner join projetos p
		on c.id_projeto = p.id
group by titulo;

# Subquery que retorna a quantidade de comentários
#por projeto e a quantidade de likes por projeto
# ALternativa à utilização do INNER JOIN
select titulo, 
	(select count(c.id_projeto) 
    from comentario c
	where c.id_projeto = p.id) as 'qtd comentarios',
    (select count(lpp.id_projeto) 
    from likes_por_projeto lpp
	where lpp.id_projeto = p.id) as 'qtd likes'
from projetos p 
group by p.id;

# Segundo tipo de subquery
# Como parâmetro da cláusula where
SELECT
    P.id,
    P.titulo
FROM
    projetos P
WHERE
    P.id IN
    (
        SELECT
            C.id_projeto
        FROM
            comentario C
        WHERE
            P.id = C.id_projeto
    );
#
SELECT
    P.id,
    P.titulo,
    P.datap
FROM
    projetos P
WHERE
    EXISTS
    (
        SELECT
            C.id_projeto
        FROM
            comentario C
        WHERE
            P.id = C.id_projeto
    );


SELECT
    P.titulo,
    P.datap
FROM
    projetos P
WHERE
    P.id = (SELECT
      MAX(LP.id_projeto)
    FROM
      likes_por_projeto LP);
	
select * from likes_por_projeto;
#Quantos likes cada projeto recebeu?
SELECT
     COUNT(LP.id_usuario) as 'likes', id_projeto
     as nome_projeto
    FROM
      likes_por_projeto LP group by id_projeto 
      order by likes DESC;









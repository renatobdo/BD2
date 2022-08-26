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


#Essa consulta retornar o título do projeto e quantidade
# de likes    
select titulo, 
	(select count(c.id_projeto) 
    from comentario c
	where c.id_projeto = p.id) as 'qtd comentarios'
from projetos p 
group by p.id;



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
SELECT P.id,
    P.titulo, datap
FROM   projetos P
WHERE
    P.id IN
    (SELECT C.id_projeto
        FROM comentario C
        WHERE
            P.id = C.id_projeto);
#
SELECT
    P.id,
    P.titulo,
    P.datap
FROM
    projetos P
WHERE
    EXISTS
    (SELECT
            C.id_projeto
        FROM
            comentario C
        WHERE
            P.id = C.id_projeto 
    );

# Essa consulta retorna o projeto mais recente cadastrado
# no banco de dados
SELECT P.titulo, P.datap
FROM projetos P
WHERE P.id = (SELECT
      MAX(LP.id_projeto)
    FROM
      likes_por_projeto LP);

# Essa consulta retorna o projeto mais recente cadastrado
# no banco de dados utilizando o ORDER BY
SELECT P.titulo, P.datap, (select datalpp from 
likes_por_projeto order by datalpp desc
limit 1) as 'data_like'
FROM projetos P
WHERE P.id = (SELECT
      LP.id_projeto
    FROM
      likes_por_projeto LP ORDER BY datalpp DESC limit 1);

SELECT
      LP.id_projeto
    FROM
      likes_por_projeto LP ORDER BY datalpp DESC limit 1;
select * from projetos;
SELECT
      LP.id_projeto
    FROM
      likes_por_projeto LP ORDER BY datap DESC;

alter table likes_por_projeto add datalpp datetime;
select * from likes_por_projeto;
select * from projetos;
update  likes_por_projeto set datalpp = now()
	where id_projeto = 3 and id_usuario =2;

update  likes_por_projeto set datalpp = '2022-08-22 20:31:31'
	where id_projeto = 2 and id_usuario =4;
	
select * from likes_por_projeto;
#Quantos likes cada projeto recebeu?
SELECT
     COUNT(LP.id_usuario) as 'likes', id_projeto
     as nome_projeto
    FROM
      likes_por_projeto LP group by id_projeto 
      order by likes DESC;

###
SELECT F.titulo, F.Quantidade_Comentarios
FROM (SELECT P.id, P.titulo,
        (SELECT COUNT(C.id_projeto)
        FROM comentarios C
        WHERE C.id_projeto = P.id ) 
             AS Quantidade_Comentarios
FROM projetos P
) as F
WHERE
    F.Quantidade_Comentarios > 2







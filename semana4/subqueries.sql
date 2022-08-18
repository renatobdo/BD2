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
    
    

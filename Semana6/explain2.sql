select count(*) from employees;
EXPLAIN SELECT employeeNumber, lastName, firstName
FROM employees WHERE jobTitle = 'Sales Rep';

create index jobTitle_idx on employees (jobTitle);
drop index jobTitle_idx on employees;
CREATE INDEX jobTitle_idx ON employees(jobTitle);
CREATE INDEX jobTitle_idx2 ON employees(jobTitle(20));
CREATE INDEX jobTitle_idx3 ON employees(jobTitle, employeeNumber, lastName, firstName);

#https://stackoverflow.com/questions/19773817/mysql-refuses-to-use-index
show indexes from employees;

select * from employees;
select count(*) from employees WHERE jobTitle = "Sales Rep";
with cte as (select count(*)/(select count(*) from employees) as quantidade from employees 
WHERE jobTitle = "Sales Rep")
select *, 
case  
	when quantidade >= 0.8
		then 'maior'
	when quantidade < 0.8
		then 'menor'
end quantidade from cte;
update employees set jobTitle = "Sales Rep" where employeeNumber <= 850;
update employees set jobTitle = "System Analyst" where employeeNumber >= 800 and employeeNumber <= 1000;

EXPLAIN SELECT 
    employeeNumber, 
    lastName, 
    firstName
FROM employees  # FORCE INDEX (jobTitle_idx)
WHERE jobTitle = "Sales Rep";
ALTER TABLE employees CHARACTER SET = utf8 ;
select distinct(jobTitle) from employees;
select version();

select * from employees;
select count(*) from employees;

SELECT
   COUNT(DISTINCT LEFT(jobTitle, 20)) unique_rows
FROM
   employees;
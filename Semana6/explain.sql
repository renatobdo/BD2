explain select * from employees limit 1;
Explain select * from employees where employee_id = 100;
explain select * from employees where first_name = 'Steven';
explain select * from employees where last_name = 'Steven';
create index first_name on employees(first_name); 
select * from employees;
SELECT employee_id, first_name, last_name, salary,
(SELECT AVG(salary) FROM employees) AS average_salary,
salary - (SELECT AVG(salary) FROM employees) AS difference
FROM employees order by difference;

use classiscmodels;
EXPLAIN SELECT 
    productName, 
    buyPrice, 
    msrp
FROM
    products
WHERE
    productName LIKE '1970%';

select count(*) from employees;
select count(*) from customers;
select count(*) from offices;
select count(*) from orderdetails;
select count(*) from orders;
select count(*) from payments;
select count(*) from productlines;




SELECT employee_id, first_name, last_name, salary,
 (SELECT ROUND(SUM(salary)/COUNT(*),0) FROM employees) as average_salary, 
	salary - (SELECT ROUND(SUM(salary)/COUNT(*),0) FROM employees) AS difference
FROM employees
Group by employees.employee_id
Order by difference;
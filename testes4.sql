select first_name, 
	   last_name, 
       job_title, 
       department_name
	from employees 
		inner join departments on
			employees.department_id = departments.department_id
		inner join jobs on
			employees.job_id = jobs.job_id order by first_name DESC;
		
select country_name, countries.country_id, locations.country_id,
	street_address, city from
    countries left join
    locations on
    countries.country_id = locations.country_id;
select * from employees;

select employees.employee_id, employees.first_name,
	jobs.job_title from employees left join
	jobs on jobs.job_id = employees.employee_id;
    

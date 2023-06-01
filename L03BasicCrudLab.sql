-- 1
select 
 e.id AS 'No.',
 e.first_name AS 'First Name',
 e.last_name AS 'Last Name',
 e.job_title AS 'Job Title'
 from employees AS e
 order by id;
 -- 2
 select 
 e.id,
 concat_ws(' ',e.first_name, e.last_name) AS 'full_name',
 e.job_title,
 e.salary
 from employees AS e
 where e.salary > 1000;
-- 3
update employees
set salary = salary + 100
where job_title = 'Manager';
select salary from employees;
-- 4
create view v_top_paid_employee as
select * from employees
order by salary desc limit 1; 
select * from v_top_paid_employee;
-- 5
select * from employees
where department_id = 4 and salary >= 1000
order by id;
-- 6
delete from employees 
where department_id in (1 , 2);
select * from employees;
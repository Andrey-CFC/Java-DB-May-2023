use soft_uni;
-- 1
select 
    e.employee_id,
    concat_ws(' ', first_name, last_name) as full_name,
    d.department_id,
    d.name as department_name
from employees as e
inner join departments as d on
e.employee_id = d.manager_id
order by e.employee_id
limit 5;

-- 2
select 
    t.town_id,
    t.name,
    a.address_text
from addresses as a
inner join towns as t on
a.town_id = t.town_id
where t.name in ('San Francisco', 'Sofia', 'Carnation')
order by t.town_id , a.address_id;

-- 3
select 
    employee_id,
    first_name,
    last_name,
    department_id,
    salary
from employees
where manager_id is null;

-- 4
select count(*) as count
from employees
where salary >
(
select avg(salary)
from employees
);

use gringotts;

-- 1
select count(*) from wizzard_deposits;
-- 2
select max(magic_wand_size) as 'longest_magic_wand' from wizzard_deposits;
-- 3
select deposit_group, max(magic_wand_size) as 'longest_magic_wand'
from wizzard_deposits
group by deposit_group
order by `longest_magic_wand`, deposit_group asc;
-- 4
select deposit_group
from wizzard_deposits
group by deposit_group
order by avg(magic_wand_size) limit 1;
-- 5
select deposit_group, sum(deposit_amount) as 'total_sum'
from wizzard_deposits
group by deposit_group
order by total_sum;
-- 6
select deposit_group, sum(deposit_amount) as 'total_sum'
from wizzard_deposits
where magic_wand_creator = 'Ollivander family'
group by deposit_group
order by deposit_group;
-- 7
select deposit_group, sum(deposit_amount) as 'total_sum'
from wizzard_deposits
where magic_wand_creator = 'Ollivander family'
group by deposit_group
having `total_sum` < 150000
order by total_sum desc;
-- 8
select deposit_group, magic_wand_creator, min(deposit_charge) as 'min_deposit_charge'
from wizzard_deposits
group by deposit_group, magic_wand_creator
order by magic_wand_creator, deposit_group;
-- 9
select (case
 when age between 0 and 10 then '[0-10]'
 when age between 11 and 20 then '[11-20]'
 when age between 21 and 30 then '[21-30]'
 when age between 31 and 40 then '[31-40]'
 when age between 41 and 50 then '[41-50]'
 when age between 51 and 60 then '[51-60]'
 when age >= 61 then '[61+]'
 end) as 'age_group',
 count(*) as 'wizard_count'
 from wizzard_deposits
 group by age_group
 order by wizard_count;
 -- 10
 select left(first_name,1) as 'first_letter'
 from wizzard_deposits
 where deposit_group = 'Troll Chest'
 group by first_letter
 order by first_letter;
 -- 11
select deposit_group, is_deposit_expired, avg(deposit_interest) as 'average_interest'
from wizzard_deposits
where deposit_start_date > '1985-01-01'
group by deposit_group, is_deposit_expired
order by deposit_group desc, is_deposit_expired;

use soft_uni;
-- 12
select department_id, min(salary) as 'minimum_salary' from employees
where hire_date > '2000-01-01'
group by department_id
having department_id in (2,5,7)
order by department_id;
-- 13
create table `salary_more_than_30000`
as select * from employees
where salary > 30000;
delete from `salary_more_than_30000`
where `manager_id` = 42;
update `salary_more_than_30000`
set salary = salary + 5000
where `department_id` = 1;
select department_id, avg(salary) from salary_more_than_30000
group by department_id
order by department_id;
-- 14
select department_id, max(salary) as 'max_salary'
from employees
group by department_id
having `max_salary` not between 30000 and 70000
order by department_id;
-- 15
select count(salary) as 'count'
from employees
where manager_id is null;
-- 16
select *
from employees
group by department_id;

-- 17
select first_name, last_name, department_id
from employees as e1
where salary >
(select avg(salary) from employees as e2
where e1.department_id = e2.department_id)
order by department_id, employee_id limit 10;
-- 18
select department_id, sum(salary) as 'total_salary'
from employees
group by department_id
order by department_id;


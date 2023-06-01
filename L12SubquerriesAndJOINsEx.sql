use soft_uni;
-- 1
select 
    e.employee_id,
    e.job_title,
    e.address_id,
    a.address_text
from employees as e
join addresses as a on
e.address_id = a.address_id
order by e.address_id
limit 5;

-- 2
select 
    e.first_name,
    e.last_name,
    t.name,
    a.address_text
from employees as e
join addresses as a on
e.address_id = a.address_id
join towns as t on
a.town_id = t.town_id
order by e.first_name , e.last_name
limit 5;

-- 3
select 
    e.employee_id,
    e.first_name,
    e.last_name,
    d.name as department_name
from employees as e
join departments as d on
e.department_id = d.department_id
where d.name = 'Sales'
order by employee_id desc;

-- 4
select 
    e.employee_id,
    e.first_name,
    e.salary,
    d.name as department_name
from employees as e
join departments as d on
e.department_id = d.department_id
where e.salary > 15000
order by d.department_id desc
limit 5;

-- 5
select 
    e.employee_id,
    e.first_name
from employees as e
left join employees_projects as ep on
e.employee_id = ep.employee_id
where ep.project_id is null
order by e.employee_id desc
limit 3;

-- 6
select 
    e.first_name,
    e.last_name,
    e.hire_date,
    d.name as dept_name
from employees as e
join departments as d on
e.department_id = d.department_id
where year(e.hire_date) > 1998 and d.name in('Sales','Finance')
order by e.hire_date;

-- 7
select 
    e.employee_id,
    e.first_name,
    p.name as project_name
from employees as e
join employees_projects as ep on
ep.employee_id = e.employee_id
join projects as p on
ep.project_id = p.project_id
where date(p.start_date) > '2002-08-13'
and p.end_date is null
order by e.first_name , p.name
limit 5;

-- 8
select 
    e.employee_id,
    e.first_name,
    (case
        when year(p.start_date) >= 2005 then null
        else p.name
    end) as project_name
from employees as e
join employees_projects as ep on
ep.employee_id = e.employee_id
join projects as p on
ep.project_id = p.project_id
where e.employee_id = 24
order by project_name;

-- 9
select 
    e.employee_id,
    e.first_name,
    e.manager_id,
    m.first_name as manager_name
from employees as e
join employees as m on
m.employee_id = e.manager_id
where e.manager_id in (3, 7)
order by e.first_name;

-- 10
select 
    e.employee_id,
    concat_ws(' ', e.first_name, e.last_name) as employee_name,
    concat_ws(' ', m.first_name, m.last_name) as manager_name,
    d.name as department_name
from employees as e
join employees as m on
m.employee_id = e.manager_id
join departments as d on e.department_id = d.department_id
where e.manager_id is not null
order by e.employee_id
limit 5;

-- 11
select 
    avg(e.salary) as min_average_salary
from employees as e
group by e.department_id
order by min_average_salary
limit 1;

use geography;
-- 12
select
   mc.country_code,
   m.mountain_range,
   p.peak_name,
   p.elevation
from peaks as p
join mountains as m on
p.mountain_id = m.id
join mountains_countries as mc on
p.mountain_id = mc.mountain_id
where p.elevation > 2835 and mc.country_code = 'BG'
order by p.elevation desc;

-- 13
select 
    mc.country_code,
    count(m.mountain_range) as mountain_range
from mountains as m
join mountains_countries as mc on
m.id = mc.mountain_id
where mc.country_code in ('BG' , 'RU', 'US')
group by mc.country_code
order by mountain_range desc;

-- 14
select 
    c.country_name,
    r.river_name
from countries as c
left join countries_rivers as cr on
c.country_code = cr.country_code
left join rivers as r on
cr.river_id = r.id
where c.continent_code = 'AF'
order by c.country_name
limit 5;

-- 15
select 
    c1.continent_code,
    c1.currency_code,
    count(*) as currency_usage
from countries as c1
group by c1.continent_code, c1.currency_code
having currency_usage > 1
    and currency_usage = 
    (select 
        count(*) as cc
    from countries as c2
    where  c2.continent_code = c1.continent_code
    group by c2.currency_code
    order by cc desc
    limit 1)
order by c1.continent_code, c1.currency_code;

-- 16
select 
    count(m.country_code) as country_count
from
    (select 
        country_code
    from countries as c
    left join mountains_countries as mc using (country_code)
    where mc.mountain_id is null) as m;
    
-- 17
select 
    c.country_name,
    max(p.elevation) as highest_peak_elevation,
    max(r.length) as longest_river_length
from countries as c
left join mountains_countries as mc using (country_code)
left join peaks as p using (mountain_id)
left join countries_rivers as cr using (country_code)
left join rivers as r on
r.id = cr.river_id
group by c.country_name
order by highest_peak_elevation desc, longest_river_length desc, c.country_name
limit 5; 
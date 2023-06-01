use soft_uni;

-- 1
select first_name, last_name
from employees
where substring(first_name,1,2) = 'Sa';
-- 2
select first_name, last_name
from employees
where last_name like '%ei%';
-- 3
select first_name
from employees
where department_id in (3, 10)
and year(hire_date) between 1995 and 2005
order by employee_id;
-- 4
select first_name, last_name
from employees
where job_title not like '%engineer%';
-- 5
select name
from towns
where char_length(name) in (5,6)
order by name;
-- 6
select town_id, name
from towns
where left(name,1) in ('M','K','B','E')
order by name;
-- 7
select town_id, name
from towns
where left(name,1) not in ('R','B','D')
order by name;
-- 8
create view v_employees_hired_after_2000
as select first_name, last_name
from employees
where year(hire_date) >2000;
select * from v_employees_hired_after_2000;
-- 9
select first_name, last_name
from employees
where char_length(last_name) = 5;

use geography;
-- 10
select country_name, iso_code
from countries
where (char_length(country_name) - char_length(replace(lower(country_name),'a',''))) >= 3
order by iso_code;
-- 11
select peak_name,
river_name,
lower(concat(peak_name, substring(river_name,2))) as mix
from peaks, rivers
where right(peak_name,1) = left(river_name,1)
order by mix;

use diablo;
-- 12
select name, date_format(start,'%Y-%m-%d') as 'start'
from games
where year(start) in (2011, 2012)
order by start,name
limit 50;
-- 13
select user_name,
substring(email,locate('@', email)+1) as 'email provider'
from users
order by `email provider`, user_name;
-- 14
select user_name, ip_address
from users
where ip_address like '___.1%.%.___'
order by user_name;
-- 15
select name as 'game',
    case
        when hour(start) between 0 and 11 then 'Morning'
        when hour(start) between 12 and 17 then 'Afternoon'
        else 'Evening'
    end as 'Part of the Day',
    case
        when duration <= 3 then 'Extra Short'
        when duration between 4 and 6 then 'Short'
        when duration between 7 and 10 then 'Long'
        else 'Extra Long'
    end as 'Duration'
from games
order by name; 

use orders;
-- 16
select product_name,
    order_date,
    date_add(order_date, interval 3 day) as 'pay_due',
    date_add(order_date, interval 1 month) as 'deliver_due'
from orders;
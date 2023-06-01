use restaurant;

select e.department_id, sum(e.salary) as 'Total Salary'
from employees as e
group by e.department_id;

-- 1
select department_id, count(id)
from employees
group by department_id;

-- 2
select department_id, round(avg(salary),2) as 'Average Salary'
from employees
group by department_id;

-- 3
select department_id, round(min(salary),2) as 'Min Salary'
from employees
group by department_id
having `Min Salary` > 800;

-- 4
select count(*)
from products
where category_id = 2 and price > 8;

-- 5
select category_id,
round(avg(price),2) as 'Average Price',
min(price) as 'Cheapest Product',
max(price) as 'Most Expensive Product'
from products
group by category_id;


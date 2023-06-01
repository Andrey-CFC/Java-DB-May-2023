use soft_uni;
delimiter $$
-- 1
create procedure usp_get_employees_salary_above_35000()
begin
select first_name, last_name
from employees
where salary > 35000
order by first_name, last_name, employee_id;
end $$
delimiter ;

call usp_get_employees_salary_above_35000();

delimiter $$
-- 2
create procedure usp_get_employees_salary_above(salary_limit double(19,4))
begin
select first_name, last_name
from employees
where salary >= salary_limit
order by first_name, last_name, employee_id;
end $$
delimiter ;

delimiter $$
-- 3
create procedure usp_get_towns_starting_with(name_start varchar(40))
begin
select name as town_name
from towns
where name like concat(name_start,'%')
order by town_name;
end $$
delimiter ;

call usp_get_towns_starting_with('b');

delimiter $$
-- 4
create procedure usp_get_employees_from_town(town_name varchar(40))
begin
select first_name, last_name
from employees
join addresses using (address_id)
join towns as t using (town_id)
where t.name = town_name
order by first_name, last_name, employee_id;
end $$
delimiter ;

call usp_get_employees_from_town('Redmond');

delimiter $$
-- 5
create function ufn_get_salary_level(salary double(10,2))
returns varchar(10)
deterministic
begin
return (case
        when salary < 30000 then 'Low'
        when salary  <= 50000 then 'Average'
        else 'High'
    end);
end $$
delimiter ;

delimiter $$
-- 6
create procedure usp_get_employees_by_salary_level(salary_level varchar(10))
begin
select first_name, last_name
from employees
where (salary_level='Low'  and  salary < 30000) or
    (salary_level='Average' and (salary >= 30000 and salary <= 50000)) or
    (salary_level='High'  and salary >= 50000)
    order by first_name desc, last_name desc;
end $$
delimiter ;

call usp_get_employees_by_salary_level('Average');

delimiter $$
-- 7
create function ufn_is_word_comprised(set_of_letters varchar(50), word varchar(50))
returns int
deterministic
begin
return word REGEXP (concat('^[', set_of_letters, ']+$'));
end $$

delimiter ;
delimiter $$
-- 8
create procedure usp_get_holders_full_name()
begin
select
concat(first_name, ' ', last_name) as full_name
from account_holders
order by full_name, id;
end$$
delimiter ;

delimiter $$
-- 9
create procedure usp_get_holders_with_balance_higher_than(lower_limit int)
begin
select
ah.first_name, ah.last_name
from accounts as a
join account_holders as ah on
ah.id = a.account_holder_id
group by a.account_holder_id
having sum(a.balance) > lower_limit
order by ah.id;
end$$
delimiter ;
call usp_get_holders_with_balance_higher_than(45000);

delimiter $$
-- 10
create function ufn_calculate_future_value(initial_sum decimal(19, 4), interest_rate decimal(19, 4), years int)
returns decimal(19, 4)
deterministic
begin
    return initial_sum * POW((1 + interest_rate), years);
end$$

select ufn_calculate_future_value(1000, 0.5, 5);

delimiter $$
-- 11
create procedure usp_calculate_future_value_for_account(id_given int, interest_rate decimal(19,4))
begin
select 
     a.id,
     ah.first_name,
     ah.last_name,
     a.balance as current_balance,
     (select ufn_calculate_future_value(a.balance,interest_rate, 5)) as balance_in_5_years
from
account_holders as ah
join accounts as a on
ah.id = a.account_holder_id
where a.id = id_given;
end$$
delimiter ;

delimiter $$
-- 12
create procedure usp_deposit_money(account_id int, money_amount decimal(19,4))
begin
if money_amount > 0 then start transaction;
update accounts 
set balance = balance + money_amount
where account_id = id;
if exists(select id from accounts where account_id = id ) then commit;
else rollback;
end if;
end if;
end$$

delimiter ;

delimiter $$
-- 13
create procedure usp_withdraw_money(account_id int, money_amount decimal(19,4))
begin
if money_amount > 0 and (select balance from accounts where account_id = id) >= money_amount then
start transaction;
update accounts 
set balance = balance - money_amount
where account_id = id;
if exists(select id from accounts where account_id = id ) then commit;
else rollback;
end if;
end if;
end$$

delimiter ;

delimiter $$
-- 14
create procedure usp_transfer_money(from_account_id int, to_account_id int, money_amount decimal(19,4))
begin
if money_amount > 0 and 
exists (select id from accounts where id = from_account_id) and
exists (select id from accounts where id = to_account_id) and
from_account_id != to_account_id and
(select balance from accounts where id = from_account_id) >= money_amount
then start transaction;
update accounts 
set balance = balance - money_amount
where id = from_account_id;
update accounts 
set balance = balance + money_amount
where id = to_account_id;
commit;
else rollback;
end if;
end$$

delimiter ;

delimiter $$
-- 15
create table `logs`
(log_id int primary key auto_increment, 
account_id int not null,
 old_sum decimal(19,4), 
 new_sum decimal(19,4))$$

create trigger accounts_after_update
after update on accounts for each row
begin
insert into logs(account_id, old_sum, new_sum)
values(OLD.id, OLD.balance, new.balance);
end$$

delimiter ;

delimiter $$
-- 16
create table `logs`
(log_id int primary key auto_increment, 
account_id int not null,
 old_sum decimal(19,4), 
 new_sum decimal(19,4));

create trigger accounts_after_update
after update on accounts for each row
begin
insert into logs(account_id, old_sum, new_sum)
values(OLD.id, OLD.balance, new.balance);
end;

create table notification_emails
(id int primary key auto_increment,
recipient int not null,
`subject` varchar(100), 
body varchar(255));


create trigger logs_after_insert
before insert on `logs` for each row
begin
insert into notification_emails(recipient, `subject`, body)
values(new.account_id, concat('Balance change for account: ', new.account_id), concat('On ', NOW(), ' your balance was changed from ', ROUND(NEW.old_sum, 0), ' to ', ROUND(NEW.new_sum, 0), '.'));
end$$
use book_library;
-- 1
select title
from books
where substring(title,1, 3) = 'The';
-- 2
select replace(title, 'The', '***')
from books
where substring(title,1, 3) = 'The';
-- 3
select round(sum(cost),2)
from books;
-- 4
select concat_ws(' ', first_name, last_name) as 'Full Name',
timestampdiff(DAY, born, died) as 'Days Lived'
from authors;
-- 5
select title
from books
where title like '%Harry Potter%';

select * from authors
where first_name regexp '^\[^K\]{3}\$';
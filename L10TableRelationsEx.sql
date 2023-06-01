create database table_relations;
use table_relations;
-- 1
create table people (
person_id int unique not null auto_increment,
first_name varchar(50) not null,
salary decimal(10,2) default 0,
passport_id int unique
);

create table passports (
passport_id int primary key auto_increment,
passport_number varchar(8) unique
);

alter table people
add constraint pk_people
primary key(person_id),
add constraint fk_people_passports
foreign key (passport_id)
references passports(passport_id);

insert into passports values
(101,'N34FG21B'),
(102,'K65LO4R7'),
(103,'ZE657QP2');

insert into people values
(1,'Roberto',43300.00,102),
(2,'Tom',56100.00,103),
(3,'Yana',60200.00,101);

-- 2
create table manufacturers (
    manufacturer_id int primary key not null,
    name varchar(50) unique not null,
    established_on date
);

create table models (
    model_id int primary key not null,
    name varchar(50) not null,
    manufacturer_id int not null,
    constraint fk_models_manufacturers
    foreign key(manufacturer_id)
    references manufacturers(manufacturer_id)
);

insert into manufacturers values
(1,'BMW','1916-03-01'),
(2,'Tesla','2003-01-01'),
(3,'Lada','1966-05-01');

insert into models values
(101,'X1',1),
(102,'i6',1),
(103,'Model S',2),
(104,'Model X',2),
(105,'Model 3',2),
(106,'Nova',3);

-- 3
create table students (
    student_id int primary key not null,
    name varchar(50) not null
);

create table exams (
    exam_id int primary key not null,
    name varchar(50) not null
);

create table students_exams (
    student_id int not null,
    exam_id  int not null,
    constraint pk_students_exams
    primary key (student_id , exam_id),
    constraint fk_students_exams_students
    foreign key(student_id)
    references students(student_id),
    constraint fk_students_exams_exams
    foreign key(exam_id)
    references exams(exam_id)
);

insert into students values
(1,'Mila'),
(2,'Toni'),
(3,'Ron');

insert into exams values
(101,'Spring MVC'),
(102,'Neo4j'),
(103,'Oracle 11g');

insert into students_exams values
(1,101),
(1,102),
(2,101),
(3,103),
(2,102),
(2,103);

-- 4
create table teachers (
    teacher_id int primary key not null auto_increment,
    name varchar(50) not null,
    manager_id int
);

alter table teachers auto_increment = 101;
insert into teachers (name, manager_id) values
('John',NULL),
('Maya',106),
('Silvia',106),
('Ted',105),
('Mark',101),
('Greta',101);

alter table teachers
add constraint fk_teachers_manager
foreign key (manager_id)
references teachers(teacher_id);

create database online_store;
use online_store;
-- 5
create table cities (
    city_id int primary key not null,
    name varchar(50)
);

create table customers (
    customer_id int primary key not null,
    name varchar(50),
    birthday date,
    city_id int,
    constraint fk_customers_cities
    foreign key(city_id)
    references cities(city_id)
);

create table orders (
    order_id int primary key not null,
    customer_id int,
    constraint fk_orders_customers
    foreign key(customer_id)
    references customers(customer_id)
);

create table item_types (
    item_type_id int primary key not null,
    name varchar(50)
);

create table items (
    item_id int primary key not null,
    name varchar(50),
    item_type_id int,
    constraint fk_items_item_types
    foreign key(item_type_id)
	references item_types(item_type_id)
);

create table order_items (
    order_id int,
    item_id int,
    constraint pk_order_items
    primary key(order_id , item_id),
    constraint fk_order_items_orders
    foreign key(order_id)
	references orders(order_id),
    constraint fk_order_items_items
    foreign key(item_id)
    references items (item_id)
);

-- 6
create table majors (
    major_id int primary key not null,
    name varchar(50)
);

create table students (
    student_id int primary key not null,
    student_number varchar(12),
    student_name varchar(50),
    major_id int,
    constraint fk_students_majors
    foreign key(major_id)
	references majors(major_id)
);

create table payments (
    payment_id int primary key not null,
    payment_date date,
    payment_amount decimal(8, 2),
    student_id int,
    constraint fk_payments_students
    foreign key(student_id)
	references students(student_id)
);

create table subjects (
    subject_id int primary key not null,
    subject_name varchar(50)
);

create table agenda (
    student_id int,
    subject_id int,
    constraint pk_agenda
    primary key(student_id , subject_id),
    constraint fk_agenda_students
    foreign key(student_id)
    references students(student_id),
    constraint fk_agenda_subjects
    foreign key(subject_id)
    references subjects(subject_id)
);

use geography;
-- 9
select
 m.mountain_range,
 p.peak_name,
 p.elevation as peak_elevation
from mountains as m
join peaks as p on
p.mountain_id = m.id
where m.mountain_range = 'Rila'
order by p.elevation desc;
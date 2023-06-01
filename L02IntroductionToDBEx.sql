create database minions;
use minions;

-- 1
CREATE TABLE minions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(47),
    age INT
);

CREATE TABLE towns (
    town_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(47)
);

-- 2
ALTER TABLE minions
ADD COLUMN town_id INT,
ADD CONSTRAINT fk_minions_towns
FOREIGN KEY (town_id)
REFERENCES towns(id);

-- 3
INSERT INTO towns
VALUES
(1,	'Sofia'),
(2,	'Plovdiv'),
(3,	'Varna');

INSERT INTO minions
VALUES
(1,'Kevin',22,1),
(2,'Bob',15,3),
(3,	'Steward',NULL,2);

-- 4
TRUNCATE `minions`;

-- 5
DROP TABLE minions;
DROP TABLE towns;

-- 6
CREATE TABLE people (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(200) NOT NULL,
    picture BLOB,
    height DOUBLE(10 , 2 ),
    weight DOUBLE(10 , 2 ),
    gender CHAR(1) NOT NULL,
    birthdate DATE NOT NULL,
    biography TEXT
);

insert into people(name, gender, birthdate)
values
('test', 'a', DATE(NOW())),
('test1', 'm', DATE(NOW())),
('test', 'x', DATE(NOW())),
('test2', 'f', DATE(NOW())),
('test3', 'p', DATE(NOW()));

-- 7
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(30),
    password VARCHAR(26),
    profile_picture BLOB,
    last_login_time DATETIME,
    is_deleted BOOLEAN
);

INSERT INTO users(username, password)
VALUES
('testis1','tes1t'),
('testa2','test1'),
('test3ad','test1'),
('testdas4','test1'),
('test5das','test1');

-- 8 
ALTER TABLE users
DROP PRIMARY KEY,
ADD CONSTRAINT pk_users2
PRIMARY KEY users(id, username);

-- 9
alter table users
change column last_login_time
last_login_time datetime default now();

-- 10
alter table users
drop primary key,
add constraint pk_users
primary key users(id),
change column username
username varchar(30) unique;

-- 11
create database movies;
use movies;

CREATE TABLE directors (
    id INT PRIMARY KEY AUTO_INCREMENT,
    director_name VARCHAR(50) NOT NULL,
    notes TEXT
);

insert into directors (director_name)
values
('test1'),
('test2'),
('test3'),
('test4'),
('test5');

CREATE TABLE genres (
    id INT PRIMARY KEY AUTO_INCREMENT,
    genre_name VARCHAR(20) NOT NULL,
    notes TEXT
);

insert into genres (genre_name)
values
('test1'),
('test2'),
('test3'),
('test4'),
('test5');

CREATE TABLE categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(20) NOT NULL,
    notes TEXT
);

insert into categories (category_name)
values
('test1'),
('test2'),
('test3'),
('test4'),
('test5');

CREATE TABLE movies (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50) NOT NULL,
    director_id INT,
    copyright_year YEAR,
    length DOUBLE(10 , 2 ),
    genre_id INT,
    category_id INT,
    rating DOUBLE(3 , 2 ),
    notes TEXT,
    FOREIGN KEY (director_id)
	REFERENCES directors (id),
    FOREIGN KEY (genre_id)
	REFERENCES genres (id),
    FOREIGN KEY (category_id)
	REFERENCES categories (id)
);

insert into movies (title, director_id, genre_id, category_id)
values
('test1', 1, 2, 3),
('test2', 1, 2, 5),
('test3',1, 2, 4),
('test4', 2, 3, 2),
('test5', 3, 5, 1);

-- 12
CREATE DATABASE car_rental;
USE car_rental;

CREATE TABLE categories (
id INT PRIMARY KEY AUTO_INCREMENT,
category VARCHAR(50) NOT NULL,
daily_rate INT NOT NULL,
weekly_rate INT NOT NULL,
monthly_rate INT NOT NULL,
weekend_rate INT NOT NULL);

INSERT INTO categories
VALUES
(1, 'CAR', 10, 50, 100, 80),
(2, 'BUS', 10, 50, 100, 80),
(3, 'CARAVAN', 10, 50, 100, 80);

CREATE TABLE cars(
id INT PRIMARY KEY AUTO_INCREMENT,
plate_number VARCHAR(10) NOT NULL,
make VARCHAR(30) NOT NULL,
model VARCHAR(30) NOT NULL,
car_year YEAR NOT NULL,
category_id INT NOT NULL,
doors INT NOT NULL,
picture BLOB,
car_condition VARCHAR(20) NOT NULL,
available BOOL);

INSERT INTO cars
VALUES
(1, 'B2046TK', 'OPEL', 'CORSA', 2017, 1, 5, NULL, 'NEW', 1),
(2, 'B2046TK', 'AUDI', 'A8', 2010, 1, 5, NULL, 'NEW', 1),
(3, 'B2046TK', 'ASTON MARTIN', 'DB8', 2010, 1, 5, NULL, 'NEW', 1);


CREATE TABLE employees (
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(30) NOT NULL, 
last_name VARCHAR(30) NOT NULL, 
title VARCHAR(20) NOT NULL,
notes TEXT);

INSERT INTO employees
VALUES
(1, 'IVAN', 'IVANOV', 'SALES MANAGER', 'SOME TEXT'),
(2, 'IVAN', 'IVANOV', 'SALES MANAGER', 'SOME TEXT'),
(3, 'IVAN', 'IVANOV', 'SALES MANAGER', 'SOME TEXT');


CREATE TABLE customers (
id INT PRIMARY KEY AUTO_INCREMENT,
driver_licence_number VARCHAR(30) NOT NULL,
full_name VARCHAR(60) NOT NULL,
address VARCHAR(100) NOT NULL,
city VARCHAR(30) NOT NULL,
zip_code VARCHAR(10) NOT NULL, 
notes TEXT);
 
INSERT INTO customers
VALUES
(1, '545646464', 'IVAN IVANOV', 'STR JGOOIJTR', 'VARNA', '9000','SOME TEXT'),
(2, '545646464', 'IVAN IVANOV', 'STR JGOOIJTR', 'VARNA', '9000','SOME TEXT'),
(3, '545646464', 'IVAN IVANOV', 'STR JGOOIJTR', 'VARNA', '9000','SOME TEXT');



CREATE TABLE rental_orders (
id INT PRIMARY KEY AUTO_INCREMENT,
employee_id INT NOT NULL,
customer_id INT NOT NULL,
car_id INT NOT NULL,
car_condition VARCHAR(10) NOT NULL, 
tank_level VARCHAR(10) NOT NULL,
kilometrage_start INT NOT NULL, 
kilometrage_end INT NOT NULL, 
total_kilometrage INT NOT NULL, 
start_date DATE NOT NULL, 
end_date DATE NOT NULL, 
total_days INT NOT NULL, 
rate_applied INT NOT NULL, 
tax_rate FLOAT NOT NULL,
order_status VARCHAR(10) NOT NULL,
notes TEXT);

INSERT INTO rental_orders
VALUES
(1, 1, 1,1, 'NEW', 'FULL',1000, 1000, 200000,'2023-01-01','2023-10-01', 10, 100,100,'rent', NULL),
(2, 1, 1,1, 'NEW', 'FULL',1000, 1000, 200000,'2023-01-01','2023-10-01', 10, 100,100,'rent', NULL),
(3, 1, 1,1, 'NEW', 'FULL',1000, 1000, 200000,'2023-01-01','2023-10-01', 10, 100,100,'rent', NULL);

-- 13

CREATE DATABASE soft_uni;
USE soft_uni;

CREATE TABLE towns(
id INT PRIMARY KEY AUTO_INCREMENT,
 name VARCHAR(40) NOT NULL);
 
CREATE TABLE addresses (
id INT PRIMARY KEY AUTO_INCREMENT,
address_text VARCHAR(80) NOT NULL,
town_id INT NOT NULL,
CONSTRAINT pk_addresses_towns
FOREIGN KEY (town_id)
REFERENCES towns (id)
);
 
CREATE TABLE departments(
id INT PRIMARY KEY AUTO_INCREMENT,
 name VARCHAR(40) NOT NULL);
 
CREATE TABLE employees(
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(40) NOT NULL,
middle_name VARCHAR(40) NOT NULL, 
last_name VARCHAR(40) NOT NULL,
job_title VARCHAR(40),
department_id INT NOT NULL,
hire_date DATE NOT NULL,
salary DECIMAL(10,2),
address_id INT NOT NULL,
CONSTRAINT pk_employees_departments
FOREIGN KEY (department_id)
REFERENCES departments(id),
CONSTRAINT pk_employees_addresses
FOREIGN KEY (address_id)
REFERENCES addresses(id));

INSERT INTO towns(name)
VALUES
('Sofia'),
('Plovdiv'),
('Varna'),
('Burgas');

INSERT INTO departments(name)
VALUES
('Engineering'),
('Sales'),
('Marketing'),
('Software Development'),
('Quality Assurance');

INSERT INTO employees
VALUES
(1, 'Ivan', 'Ivanov', 'Ivanov',	'.NET Developer',	4, '2013-02-01', 3500.00, null),
(2, 'Petar', 'Petrov', 'Petrov',	'Senior Engineer',	1,'2004-03-02', 4000.00, null),
(3, 'Maria', 'Petrova', 'Ivanova',	'Intern',	5,	'2016-08-28', 525.25, null),
(4, 'Georgi', 'Terziev', 'Ivanov', 'CEO',	2,'2007-12-09', 3000.00, null),
(5, 'Peter', 'Pan', 'Pan',	'Intern',	3,'2016-08-28',	599.88, null);

-- 14
select * from towns;
select * from departments;
select * from employees;

-- 15
SELECT * FROM towns
ORDER BY name;

SELECT * FROM departments
ORDER BY name;

SELECT * FROM employees
ORDER BY salary DESC;

-- 16
SELECT name FROM towns
ORDER BY name;

SELECT name FROM departments
ORDER BY name;

SELECT first_name, last_name, job_title, salary FROM employees
ORDER BY salary DESC;

-- 17
update employees
set salary = salary * 1.1;
select salary from employees;
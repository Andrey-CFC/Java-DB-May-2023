-- 1
create table mountains(
id int primary key auto_increment,
name varchar(45)
);

create table peaks(
id int primary key auto_increment,
name varchar(45),
mountain_id int,
constraint fk_peaks_mountains
foreign key (mountain_id)
references mountains(id)
);

use camp;
-- 2
select 
v.driver_id,
v.vehicle_type,
concat(c.first_name, ' ',c.last_name) as 'driver_name'
from vehicles as v
join campers as c on v.driver_id = c.id;
-- 3
select
r.starting_point as 'route_starting_point',
r.end_point as 'route_ending_point',
r.leader_id,
concat(c.first_name, ' ',c.last_name) as 'leader_name'
from routes as r
join campers as c on r.leader_id = c.id;
-- 4
create table mountains(
id int primary key auto_increment,
name varchar(45)
);

create table peaks(
id int primary key auto_increment,
name varchar(45),
mountain_id int,
constraint fk_peaks_mountains
foreign key (mountain_id)
references mountains(id)
on delete cascade
);
-- 5
CREATE DATABASE company;
USE company;

CREATE TABLE projects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    project_lead_id INT NOT NULL
);

CREATE TABLE clients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    client_name VARCHAR(100) NOT NULL,
    project_id INT NOT NULL
);

CREATE TABLE employees (
    id INT  AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    project_id INT NOT NULL
);

ALTER TABLE projects
	ADD CONSTRAINT fk_projects_clients 
		FOREIGN KEY (client_id)
        REFERENCES clients(id),
    ADD CONSTRAINT fk_projects_employees
		FOREIGN KEY (project_lead_id)
        REFERENCES employees(id);

ALTER TABLE clients
    ADD CONSTRAINT fk_clients_projects 
		FOREIGN KEY (project_id)
        REFERENCES projects(id);

ALTER TABLE employees
    ADD CONSTRAINT fk_employees_projects 
		FOREIGN KEY (project_id)
        REFERENCES projects(id);
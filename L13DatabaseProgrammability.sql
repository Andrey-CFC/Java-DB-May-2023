use soft_uni;


-- 1
DELIMITER $$
CREATE FUNCTION `ufn_count_employees_by_town`(town_name VARCHAR(50))
RETURNS INT
DETERMINISTIC
BEGIN
	RETURN (SELECT 
    COUNT(*)
	FROM employees AS e
		JOIN addresses AS a USING (address_id)
		JOIN towns AS t USING (town_id)
	WHERE t.name = town_name);
END$$

select `ufn_count_employees_by_town`('Varna') as count;


-- 2
DELIMITER $$
CREATE  PROCEDURE usp_raise_salaries(department_name VARCHAR(50))
BEGIN
UPDATE employees
        JOIN departments AS d USING (department_id) 
SET salary = salary * 1.05
WHERE d.name = department_name;
END$$
DELIMITER ;
;

call usp_raise_salaries('Finance');

-- 3
DELIMITER $$
CREATE PROCEDURE usp_raise_salary_by_id(id INT)
BEGIN
START TRANSACTION;
	IF((SELECT count(employee_id) FROM employees WHERE employee_id like id)<>1) THEN
	ROLLBACK;
	ELSE
		UPDATE employees AS e SET salary = salary + salary*0.05 
		WHERE e.employee_id = id;
	END IF; 
END$$
DELIMITER ;
;
call usp_raise_salary_by_id(15932);

-- 4
CREATE TABLE deleted_employees (
  employee_id INT auto_increment primary key,
  first_name varchar(50),
  last_name varchar(50),
  middle_name varchar(50),
  job_title varchar(50),
  department_id int,
  salary decimal(19,4)
  );
  

DELIMITER $$
CREATE TRIGGER tr_deleted_employees
AFTER DELETE
ON employees
FOR EACH ROW
BEGIN
INSERT INTO deleted_employees (first_name,last_name,middle_name,job_title,department_id,salary)
	VALUES(OLD.first_name,OLD.last_name,OLD.middle_name, OLD.job_title,OLD.department_id,OLD.salary);
END$$
DELIMITER ;
;
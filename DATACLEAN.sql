CREATE DATABASE projectSQL;

USE projectSQL;

SELECT * FROM HR;

DESCRIBE HR;

-- Đổi tên cột
ALTER TABLE HR
CHANGE COLUMN ï»¿id id VARCHAR(20);

SET sql_safe_updates = 0;

SELECT birthdate FROM HR;
UPDATE HR
SET birthdate = CASE 
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate,'%m/%d/%Y'), '%Y-%m-%d')
	ELSE null
END;
ALTER TABLE HR
MODIFY COLUMN birthdate DATE;

SELECT hire_date FROM HR;
UPDATE HR
SET hire_date = CASE 
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date,'%m/%d/%Y'), '%Y-%m-%d')
	ELSE null
END;
ALTER TABLE HR
MODIFY COLUMN hire_date DATE;

SELECT termdate FROM HR;
UPDATE HR
SET termdate = date(str_to_date(termdate,'%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate != '';
ALTER TABLE HR
MODIFY COLUMN termdate DATE;

ALTER TABLE HR
ADD age INT;

UPDATE HR
SET age = timestampdiff(YEAR, birthdate, CURDATE());


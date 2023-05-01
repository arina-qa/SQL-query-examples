--Создание базы данных
CREATE DATABASE employees;

USE employees;

CREATE TABLE department
(
	id INT AUTO_INCREMENT PRIMARY KEY, 
	name VARCHAR(250) NOT NULL
);

CREATE TABLE employee
(
	id INT AUTO_INCREMENT PRIMARY KEY, 
	name VARCHAR(250) NOT NULL,
	salary DECIMAL(8, 2) NOT NULL,	
    department_id INT NOT NULL,
    chief_id INT,
	FOREIGN KEY (department_id) REFERENCES department(id),
	FOREIGN KEY (chief_id) REFERENCES employee(id)
);


-- 1. Вывести список сотрудников в формате: Сотрудник, Отдел сотрудника, Руководитель, Отдел руководителя
SELECT employee.name AS employee, employee_department.name AS employee_department, chief.name AS chief, chief_department.name AS chief_department
FROM employee AS employee
LEFT JOIN employee AS chief 
	ON employee.chief_id = chief.id
INNER JOIN department AS employee_department 
	ON employee.department_id = employee_department.id
LEFT JOIN department AS chief_department 
	ON chief.department_id = chief_department.id
ORDER BY employee.id;

-- 2. Вывести список сотрудников, получающих заработную плату, большую чем у непосредственного руководителя
SELECT employee.name AS employee, chief.name AS chief, employee.salary AS employee_salary, chief.salary AS chief_salary
FROM employee AS employee, employee AS chief
WHERE chief.id = employee.chief_id 
	AND employee.salary > chief.salary;

-- 3. Вывести список сотрудников, получающих максимальную заработную плату в своем отделе
SELECT employee.name AS employee, employee.salary AS salary, department.name AS department 
FROM department 
LEFT JOIN employee
	ON department.id = employee.department_id
WHERE employee.salary = 
	(SELECT MAX(salary) 
    FROM employee 
    WHERE department_id = department.id);

-- 4. Вывести список ID отделов, количество сотрудников в которых не превышает 3 человек
SELECT department.id, COUNT(employee.name) AS employees_count
FROM employee
RIGHT JOIN department
	ON employee.department_id = department.id
GROUP BY department.id
HAVING COUNT(employee.name) <= 3

-- 5. Вывести список сотрудников, не имеющих назначенного руководителя, работающего в том же отделе
SELECT employee.name AS employee, chief.name AS chief, employee.department_id AS employee_department, chief.department_id AS chief_department
FROM employee AS employee, employee AS chief
WHERE chief.id = employee.chief_id 
	AND chief.department_id <> employee.department_id

-- 6. Вывести список наименований отделов с максимальной суммарной зарплатой сотрудников
SELECT department.name AS department_name, SUM(employee.salary) AS max_sum 
FROM employee AS employee 
JOIN department 
	ON employee.department_id = department.id
WHERE EXISTS 
	(SELECT * FROM employee AS employee2 
    WHERE employee2.department_id = employee.department_id)
GROUP BY department.name
ORDER BY department.name;

-- 7. Вывести ФИО сотрудника(ов), получающего третью по величине зарплату в организации
-- вариант с LIMIT
SELECT name, salary 
FROM employee
WHERE salary = 
	(SELECT salary 
	FROM employee 
	ORDER BY salary DESC 
	LIMIT 2, 1);

-- вариант без LIMIT
SELECT name, salary
FROM employee
WHERE salary =
	(SELECT MAX(salary)
	FROM employee
	WHERE salary NOT IN
		(SELECT MAX(salary)
        FROM employee
        WHERE salary NOT IN
			(SELECT MAX(salary)
            FROM employee))
			AND salary NOT IN
				(SELECT MAX(salary)
				FROM employee));
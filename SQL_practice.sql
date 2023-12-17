CREATE TABLE employees (
    employe_id INT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    salary DECIMAL(10, 2),
    joining_date DATE,
    department VARCHAR(255),
    gender VARCHAR(10)
);

INSERT INTO employees VALUES
(1, 'John', 'Doe', 60000.50, '2022-01-15', 'HR', 'Male'),
(2, 'Jane', 'Smith', 75000.75, '2021-08-22', 'IT', 'Female'),
(3, 'Bob', 'Johnson', 80000.00, '2023-02-10', 'Finance', 'Male'),
(4, 'Alice', 'Williams', 65000.25, '2020-12-05', 'Marketing', 'Female'),
(5, 'Charlie', 'Brown', 70000.00, '2022-05-20', 'IT', 'Male');


SELECT * FROM employees;


select upper (first_name) as first_name FROM employees;


--5. Write a query for combine FirstName and LastName and display it as "Name" (also include white space between first name & last name)
select first_name  || ' '  || last_name  FROM employees;


--6. Select employee detail whose name is "Bob" 
select first_name FROM employees
where first_name = 'Bob';


--7. Get all employee detail from Employee table whose "FirstName" start with latter 'b'. 
select first_name FROM employees
where first_name like 'b%'; -- lower and upper case sensitive

SELECT first_name FROM employees
WHERE LOWER(first_name) LIKE 'b%'; --this results in lower case strings of first string

--8. Get all employee details from Employee table whose "FirstName" contains 'b' ANS: 
SELECT * FROM employees
WHERE LOWER(first_name) LIKE '%b%';

--9. Get all employee details from Employee table whose "FirstName" end with 'e' 
SELECT * FROM employees
WHERE first_name LIKE '%e';

--10. Get all employee detail from Employee table whose "FirstName" start with any single character between 'a-d
--postgre solution
SELECT * FROM employees
WHERE LOWER(first_name) between 'a%' and 'd%';

--MySQL solution
 SELECT * FROM employees WHERE FirstName like '[a-d]%' 

--11). Get all employee detail from Employee table whose "FirstName" not start with any single character between 'a-d' 
--postgre solution
SELECT * FROM employees
WHERE LOWER(first_name) not between 'a%' and 'd%';

--MySQL solution
 SELECT * FROM employees WHERE FirstName like '[^a-d]%' 
 
 --12). Get all employee detail from Employee table whose "Gender" end with 'le' and contain 4 letters. The Underscore(_) Wildcard Character represents any single character. 
--postgre solution
SELECT * FROM employees
WHERE gender LIKE '%le'
  AND LENGTH(gender) = 4;
  
--MySQL solution
SELECT * FROM employees WHERE gender like '__le' 


--13). Get all employee detail from Employee table whose "FirstName" start with 'A' and contain 5 letters. 
SELECT* FROM employees where first_name 
	LIKE 'A%' and LENGTH(first_name) = 5
	
--14). Show "JoiningDate" in "dd mmm yyyy" format, ex- "15 Feb 2013" 

SELECT TO_CHAR(joining_date, 'DD Mon YYYY') FROM employees;


--15). Show "JoiningDate" in "yyyy/mm/dd" format, ex- "2013/02/15" 

SELECT TO_CHAR(joining_date, 'YYYY/MM/DD') FROM employees;


--16). Get only Year part of "joining_date". 
 SELECT TO_CHAR(joining_date, 'YYYY') FROM employees;

 SELECT TO_CHAR(joining_date, 'Mon') FROM employees;

 SELECT TO_CHAR(joining_date, 'Day') FROM employees;

--17). Get the first name, current date, joiningdate and diff between current date and 
--joining date in days. 

--postgre solution
SELECT 
  first_name,
  CURRENT_DATE AS current_date,
  joining_date,
  (CURRENT_DATE - joining_date ) AS days_difference
FROM employees;


--18). Get all employee details from Employee table whose joining month is Jan

SELECT * FROM employees
WHERE EXTRACT(MONTH FROM joining_date) = 1;


--19). Get all employee details from Employee table whose joining month is Dec and year 2023

SELECT * FROM employees
WHERE EXTRACT(MONTH FROM joining_date) = 12
  AND EXTRACT(YEAR FROM joining_date) = 2020; 

---20). Display first name and Gender as M/F.(if male then M, if Female then F) 

SELECT first_name, CASE WHEN gender = 'Female' THEN 'F'
 WHEN gender = 'Male' THEN 'M' 
 END AS gender
 FROM employees;
 
 
 --21). Select first name from Employee table prifixed with "Hi" 
 SELECT 'Hi' || ' ' || first_name as first_name FROM employees;
 
 --22). Select second highest salary from "Employee" table. 
 
SELECT salary
FROM employees
ORDER BY salary DESC
LIMIT 1 OFFSET 1;

--23). Get department wise average salary from "Employee" table order by salary ascending 

SELECT department, AVG (salary) AS avg_salary from employees
GROUP BY (department) 
ORDER BY AVG (salary) DESC;

--24). Get department wise minimum salary from "Employee" table order by salary ascending 
SELECT department, MIN (salary) AS min_salary from employees
GROUP BY (department) 
ORDER BY MIN (salary) DESC;



-- Project Table
CREATE TABLE project_table (
    project_id INT ,
    employee_id INT ,
    project_name VARCHAR(255),
    project_start_date DATE,
    project_end_date DATE,
    project_status VARCHAR(50)
);

-- insert values
INSERT INTO project_table (project_id, employee_id, project_name, project_start_date, project_end_date, project_status) VALUES
(1, 1, 'Web Development Project', '2023-01-01', '2023-06-30', 'In Progress'),
(2, 2, 'Mobile App Launch', '2023-02-15', '2023-08-31', 'Planned'),
(3, 3, 'Data Analysis Project', '2023-03-10', '2023-07-15', 'Completed'),
(4, 4, 'Marketing Campaign', '2023-04-20', '2023-09-30', 'In Progress'),
(5, 5, 'Product Enhancement', '2023-05-05', '2023-10-15', 'Planned'),
(6, 1, 'Customer Support System', '2023-06-18', '2024-01-31', 'Planned'),
(7, 2, 'Research and Development', '2023-07-03', '2023-12-20', 'In Progress'),
(8, 3, 'IT Infrastructure Upgrade', '2023-08-22', '2024-03-15', 'Planned'),
(9, 4, 'Sales Strategy Optimization', '2023-09-12', '2024-02-28', 'Completed'),
(10, 5, 'Employee Training Program', '2023-10-25', '2024-04-10', 'In Progress');

-----------------------------------------
--NOT I noticed there is a typo column name :)
-- change column name
ALTER TABLE employees
RENAME COLUMN employe_id TO employee_id;
------------------------------------------------------

select * from project_table;
select * from employees;


--25). Names of Employees and Their Assigned Projects:

SELECT e.first_name, e.last_name, p.project_name
FROM employees e
JOIN project_table p ON e.employee_id = p.employee_id;

--26). Number of Employees in a Specific Project
SELECT project_name, COUNT(employee_id) AS employee_count
FROM project_table
GROUP BY project_name;


--27). Employee Information in Completed Projects

SELECT e.first_name, e.last_name, p.project_name
FROM employees e
JOIN project_table p ON e.employee_id = p.employee_id
WHERE p.project_status = 'Completed';


--28). Average Duration of Projects
SELECT project_name, AVG(project_end_date - project_start_date) AS average_duration
FROM project_table
WHERE project_status = 'Completed'
GROUP BY project_name;

-- if we get float then this is solution 
SELECT project_name, CAST(AVG(project_end_date - project_start_date) AS INTEGER) AS average_duration
FROM project_table
WHERE project_status = 'Completed'
GROUP BY project_name;


--29). Projects with Employee Participation and Their Departments
SELECT e.department, e.first_name, e.last_name, d.project_name
FROM employees e
JOIN project_table d ON e.employee_id = d.employee_id

--30). fetch EmployeeName & Project who has assign more than one project

SELECT e.first_name, e.last_name AS employee_name, d.project_name FROM employees e
JOIN project_table d ON e.employee_id = d.employee_id
GROUP BY e.first_name, e.last_name, d.project_name
HAVING COUNT(project_id) > 1;


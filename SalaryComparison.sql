-- Departments tablosu oluşturma ve doldurma
CREATE TABLE Departments2 (
    Id INT ,
    Name VARCHAR(50)
);

INSERT INTO Departments2 (Id, Name) VALUES 
(1, 'HR'),
(2, 'Finance'),
(3, 'IT');

-- Employees tablosu oluşturma ve doldurma
CREATE TABLE Employees2 (
    Id INT,
    Name VARCHAR(50),
    Salary DECIMAL(10, 2),
    DepartmentId INT
    
);

INSERT INTO Employees2 (Id, Name, Salary, DepartmentId) VALUES
(1, 'John Doe', 5000.00, 1),
(2, 'Jane Smith', 6000.00, 1),
(3, 'Michael Johnson', 7000.00, 1),
(4, 'Emily Brown', 5500.00, 3),
(5, 'David Lee', 6500.00, 3),
(6, 'Sarah Taylor', 7500.00, 3);





select * from Departments2;
select * from Employees2;

Select e.Name, e.DepartmentId, e.Salary, AVG (Salary) as Department_Avg_Salary
Case 
	when Salary < Department_Avg_Salary THEN 'Above'
	when Salary > Department_Avg_Salary THEN 'Below'
End as Salary Comparison
from  Departments2 as d 
Join Employees2 e ON e.DepartmentId = d.Id
GROUP BY 
    e.DepartmentId, e.Name, e.Salary;
	
	
	
	
	
SELECT 
    d.Id AS DepartmentId,
    --AVG(e.Salary) AS DepartmentAvgSalary, 
    --(SELECT AVG(Salary) FROM Employees) AS CompanyAvgSalary,
    CASE
        WHEN COUNT(e.Id) = 0 THEN 0  -- Return average salary as 0 for departments with no employees
        ELSE AVG(e.Salary)  -- Average salary of employees in the department
    END AS DepartmentAvgSalary,
    CASE
        WHEN COUNT(e.Id) = 0 THEN 'No Employee'  -- For departments with no employees
        WHEN AVG(e.Salary) > (SELECT AVG(Salary) FROM Employees) THEN 'Above'
        WHEN AVG(e.Salary) < (SELECT AVG(Salary) FROM Employees) THEN 'Below'
        ELSE 'Equal'  -- If department average salary equals company average salary
    END AS Comparison
FROM 
    Departments2 d
LEFT JOIN 
    Employees2 e ON d.Id = e.DepartmentId
GROUP BY 
    d.Id;
	
	
	
	
	
	
	
	
	
	
	
	

	
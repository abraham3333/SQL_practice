Write a solution to find the nthhighest salary from the Employee table. If there is no nth highest salary, return null.
The result format is in the following example.

Example 1:
Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
n = 2
Output: 
+------------------------+
| getNthHighestSalary(2) |
+------------------------+
| 200                    |
+------------------------+

Example 2:
Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
+----+--------+
n = 2
Output: 
+------------------------+
| getNthHighestSalary(2) |
+------------------------+
| null                   |
+------------------------+



CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
	RETURN (
	with cte as (select salary, row_number() over (order by salary desc) as rn from Employee)
	select salary from cte
	where rn = n
 );
END

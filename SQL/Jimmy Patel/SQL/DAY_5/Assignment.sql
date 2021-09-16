USE DAY1

--Assignment

-- Get difference between JOINING_DATE and INCENTIVE_DATE from employee and incentives table
SELECT DATEDIFF(MM,JoiningDate,IncentiveDate) AS 'Difference in Month' FROM Employees AS e
JOIN Incentive AS i
ON e.EmployeeID = i.EmployeeID

-- Select first_name, incentive amount from employee and incentives table for those employees who have incentives and incentive amount greater than 3000
SELECT e.FirstName , i.IncentiveAmount FROM Employees AS e
JOIN Incentive AS i
ON e.EmployeeID = i.EmployeeID
WHERE i.IncentiveAmount > 3000

-- Select first_name, incentive amount from employee and incentives table for all employees even if they didn’t get incentives.
SELECT e.FirstName , i.IncentiveAmount FROM Employees AS e
LEFT JOIN Incentive AS i
ON e.EmployeeID = i.EmployeeID
-- OR 
SELECT e.FirstName , i.IncentiveAmount FROM Employees AS e
FULL JOIN Incentive AS i
ON e.EmployeeID = i.EmployeeID

-- Select EmployeeName, ManagerName from the employee table.
SELECT c.FirstName AS 'EmployeeName'  ,o.FirstName AS 'ManagerName' FROM Employees AS o
JOIN Employees AS c
ON o.EmployeeID = c.ManagerID
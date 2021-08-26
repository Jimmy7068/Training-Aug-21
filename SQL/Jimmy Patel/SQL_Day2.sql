USE JIMMY
---Update Quaries---
----1----
UPDATE Employees SET Email = 'not available'

----2----
UPDATE Employees SET Email = 'not available',CommissionPct = 0.10

----3----
UPDATE Employees SET Email = 'not available',CommissionPct = 0.10 WHERE DepartmentID = 110

----4----
UPDATE Employees SET Email = 'not available' WHERE DepartmentID = 80 AND CommissionPct < 0.20

----5----
UPDATE Employees SET Email = 'not available' WHERE DepartmentID IN (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Accounting')

----6----
UPDATE Employees SET Salary = 8000 WHERE EmployeeID = 105 AND Salary<5000

----7----
UPDATE Employees SET JobId='SH_CLERK' WHERE EmployeeID = 118 AND DepartmentID = 30 AND JobId NOT LIKE 'SH%'

----8----
UPDATE Employees SET Salary = Salary * 0.25 WHERE DepartmentID =40 
UPDATE Employees SET Salary = Salary * 0.15 WHERE DepartmentID =90 
UPDATE Employees SET Salary = Salary * 0.10 WHERE DepartmentID =110

---------BASIC SELECT QUARIES--------
--1--
SELECT * FROM Employees
Go

--2--
SELECT FirstName, LastName FROM Employees

--3--
SELECT FirstName as 'Employee Name' FROM Employees

--4--
SELECT * FROM Employees WHERE FirstName = 'Steven'

--5--
SELECT * FROM Employees WHERE FirstName IN ('Neena','Lex')

--6--
SELECT * FROM Employees WHERE FirstName NOT IN ('Neena')

--7--
SELECT * FROM Employees WHERE Salary BETWEEN 5000 AND 8000

--8--
SELECT FirstName, LastName, Salary,Salary*0.12 as 'PF' FROM Employees 

--9--
SELECT * FROM Employees WHERE FirstName LIKE 'N%'

--10--
SELECT DISTINCT DepartmentID FROM Employees

--11--
SELECT * FROM Employees ORDER BY FirstName DESC

--12--
SELECT * FROM Employees ORDER BY FirstName DESC  

--13--
SELECT TOP 2 Salary FROM Employees

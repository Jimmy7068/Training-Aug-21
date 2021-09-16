USE DAY1

-------PRACTISE-EXERSICE
----DML-TRIGGER
CREATE TRIGGER reminder1
ON EMPLOYEES
AFTER INSERT,UPDATE
AS RAISERROR('Do not Update and Delete',16,10);
GO

ALTER TRIGGER reminder1
ON EMPLOYEES
FOR INSERT,UPDATE
AS RAISERROR('Do not Update and Delete',16,10);
GO

SELECT * FROM Employees
UPDATE Employees
SET Salary = Salary * 2

DROP TRIGGER reminder1

ALTER TRIGGER reminder2
ON Employees
AFTER INSERT,UPDATE,DELETE
AS 
EXEC msdb.dbo.sp_send_dbmail
@recipients ='sbprajapati979@gmail.com',
@body ='Dont Update Data',
@subject = 'Reminder'
GO

UPDATE Employees
SET Salary = Salary * 1.25

DROP TRIGGER reminder2
CREATE TRIGGER salaryinfo ON Employees
AFTER INSERT
AS 
IF(ROWCOUNT_BIG() = 0)
RETURN;
IF EXISTS(SELECT 1 FROM inserted AS I join Departments as DEP
ON DEP.DepartmentID = I.DepartmentID)
BEGIN 
RAISERROR('Error is Occured',16,1);
ROLLBACK TRANSACTION ;
RETURN
END;
GO
SELECT * FROM Employees
SELECT * FROM AdventureWorks2019.HumanResources.vEmployee
INSERT Employees
SELECT EMP.BusinessEntityID,VMP.FirstName,VMP.LastName,VMP.EmailAddress,VMP.PhoneNumber,EMP.HireDate,EMP.JobTitle,EMP.SalariedFlag ,EMP.CurrentFlag,VMP.StateProvinceName,EMP.LoginID FROM AdventureWorks2019.HumanResources.Employee AS EMP join AdventureWorks2019.HumanResources.vEmployee AS VMP
ON EMP.BusinessEntityID = VMP.BusinessEntityID
WHERE EMP.BusinessEntityID = '202'
-------Practice-Exersice
USE DAY1

--CREATE-PROCEDURE-WITHOUT-PARAMETER
CREATE PROCEDURE SHOWINFOEMP
AS
SET NOCOUNT ON;
SELECT * FROM Employees
GO
--EXE-PROCEDURE

SHOWINFOEMP;
EXEC SHOWINFOEMP;
EXECUTE SHOWINFOEMP;

--CREATE-PROCEDURE-WITHOUT-PARAMETER-WITH-MULTIPLE-TABLE
CREATE PROCEDURE SHOWINFOEMPDEP
AS
SET NOCOUNT ON;
SELECT (FirstName+' '+LastName) FullName,Email,Salary,DepartmentName FROM Employees AS EMP JOIN Departments AS DEP
ON EMP.DepartmentID = DEP.DepartmentID
SET NOCOUNT OFF
GO

--EXE
EXEC SHOWINFOEMPDEP

--CREATE PROCEDURE WITH ONE PARAMETER
CREATE PROCEDURE EMPROW 
@EmployeesId Int 
AS
SET NOCOUNT ON
SELECT * FROM Employees
WHERE EmployeeID = @EmployeesId
SET NOCOUNT OFF
--EXEC
EXEC EMPROW '101'

exec EMPROW @EmployeesId= '101'

DECLARE @EMPID int ='101'
EXEC EMPROW @EMPID

--CREATE-PROCEDURE-WITH-MULTIPLE-PARAMETER-WITH-UPDATE
CREATE PROCEDURE updateEmp
@FirstName varchar(50) = null,
@LastName varchar(50) = null,
@EmployeeId int
AS
SET NOCOUNT ON
UPDATE Employees
SET FirstName = @FirstName , LastName = @LastName
Where EmployeeID = @EmployeeId
SET NOCOUNT OFF
GO
--Exec
EXEC updateEmp 'Sandip', 'Prajapati', '101'
SELECT * FROM Employees

--DROP-PROCEDURE
DROP PROCEDURE SHOWINFOEMPDEP

--WITCH-ENCRYPTION-CRERATE-PROCEDURE
CREATE PROCEDURE SHOWINFOEMPDEP
WITH ENCRYPTION
AS
SET NOCOUNT ON;
SELECT (FirstName+' '+LastName) FullName,Email,Salary,DepartmentName FROM Employees AS EMP JOIN Departments AS DEP
ON EMP.DepartmentID = DEP.DepartmentID
SET NOCOUNT OFF
GO
--EXEC
EXEC SHOWINFOEMPDEP

--WITH-RECOMPILE-CREATE-PROCEDURE
CREATE PROCEDURE SHOWINFOEMP
WITH RECOMPILE
AS
SET NOCOUNT ON;
SELECT * FROM Employees
GO

--EXEC
EXEC SHOWINFOEMP with RECOMPILE

--ALTER-PROCEDURE
ALTER PROCEDURE updateEmp
@FirstName varchar(50) = null,
@LastName varchar(50) = null,
@Email Varchar(50)
WITH ENCRYPTION
AS
SET NOCOUNT ON
UPDATE Employees
SET FirstName = @FirstName , LastName = @LastName
Where Email = @Email
SET NOCOUNT OFF
GO
--EXEC
EXEC updateEmp 'Sundy' ,'Tiger' ,'SKING'

SELECT * FROM Employees

--RETURN SET WITH PROCEDURE
CREATE PROCEDURE LNEMPIDINFO
AS
SET NOCOUNT ON;
SELECT LastName,EmployeeID FROM Employees_1
RETURN 
GO
DROP PROCEDURE LNEMPIDINFO

EXEC  LNEMPIDINFO

--OUTPUT
ALTER PROCEDURE updateEmp
@FirstName varchar(50) = null,
@LastName varchar(50) = null,
@Email Varchar(50) OUTPUT
WITH RECOMPILE
AS
SET NOCOUNT ON
UPDATE Employees
SET FirstName = @FirstName , LastName = @LastName
Where Email = @Email
SET NOCOUNT OFF
GO

EXEC updateEmp 'Agent' ,'Venom' ,'DAUSTIN' WITH RECOMPILE

--RENAME-PROCEDURE
EXEC sp_rename 'updateEmp', 'updEmployee'; 

--DEFINITION-OF-PROCEDURE
EXEC sp_helptext 'updEmployee'; 
EXEC sp_helptext 'SHOWINFOEMP'; 

--DEFINITION-OF-OBJECT-OF-PROEDURE
SELECT OBJECT_DEFINITION (OBJECT_ID('updEmployee')); 
SELECT OBJECT_DEFINITION (OBJECT_ID('SHOWINFOEMP')); 

--DEFINITION-OF-OBJECT-CATALOG
SELECT [definition]
FROM sys.sql_modules  
WHERE object_id = (OBJECT_ID('updEmployee'));  
SELECT [definition]
FROM sys.sql_modules  
WHERE object_id = (OBJECT_ID('SHOWINFOEMP'));  

----DEFINITION-OF-OBJECT-CATALOG
SELECT [definition]
FROM sys.sql_modules  
WHERE object_id = (OBJECT_ID('updEmployee'));  

SELECT [definition]
FROM sys.sql_modules  
WHERE object_id = (OBJECT_ID('SHOWINFOEMP'));
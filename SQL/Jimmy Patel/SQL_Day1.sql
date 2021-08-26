USE JIMMY
---Day.1---
---P.E.1---
CREATE TABLE COUNTRIES (
COUNTRYID VARCHAR(3),
COUNTRYNAME VARCHAR(25),
REGIONID INT,
);
SELECT * FROM COUNTRIES;
ALTER TABLE COUNTRIES
ADD CONSTRAINT UN_ID UNIQUE(COUNTRYID,REGIONID)
ALTER TABLE COUNTRIES
ADD CONSTRAINT CNT CHECK (COUNTRYNAME IN ('INDIA','ITALY','CHINA'));
INSERT INTO COUNTRIES VALUES ('IND','INDIA','1');
INSERT INTO COUNTRIES VALUES ('CHN','CHINA','2');
INSERT INTO COUNTRIES VALUES ('ITL','ITALY','3');
DROP TABLE COUNTRIES;

---P.E.2---
USE JIMMY
CREATE TABLE JobHistory(
EmployeeId int CONSTRAINT pkey PRIMARY KEY,
StartDate date not null,
EndDate date not null,
JobID Varchar(25) NOT NULL CONSTRAINT ukey UNIQUE,
Department_Id int,
)
SELECT * FROM JobHistory
GO

INSERT into JobHistory VALUES (1,'01/05/1996','01/01/2000',4,5);
GO

SELECT * FROM JobHistory
GO

INSERT into JobHistory VALUES (2,'01/05/1996','01/01/2000',3,6);
GO

SELECT * FROM JobHistory
GO

ALTER TABLE JobHistory ALTER Column EndDate varchar(10) not null
GO

SELECT CONVERT(varchar , GetDate(),103)
GO

TRUNCATE TABLE JobHistory
GO

INSERT into JobHistory VALUES (1,'01/05/1996','01/01/2000',4,5);
GO


INSERT into JobHistory VALUES (2,'01/05/1996','01/01/2000',3,6);
GO

SELECT * FROM JobHistory
GO

ALTER TABLE JobHistory ALTER Column StartDate varchar(10) not null
GO

SELECT * FROM JobHistory
GO

TRUNCATE TABLE JobHistory
GO

SELECT * FROM JobHistory
GO

INSERT into JobHistory VALUES (2,'01/05/1996','01/01/2000',3,6);
GO

SELECT * FROM JobHistory
GO

INSERT into JobHistory VALUES (1,'01/05/1996','01/01/2000',3,4);
GO

SELECT * FROM JobHistory
GO

---P.E.3---
USE JIMMY
CREATE TABLE Jobs
(
JobId INT CONSTRAINT pjkey PRIMARY KEY ,
JobTitle VARCHAR(25) CONSTRAINT df_value DEFAULT 'blank',
MINSALARY INT CONSTRAINT df_minsal DEFAULT '8000',
MAXSALARY INT constraint df_maxsal DEFAULT NULL
)
ALTER TABLE Jobs
DROP CONSTRAINT pjkey
ALTER TABLE Jobs
ALTER COLUMN JobId VARCHAR(25) not null
ALTER TABLE Jobs
ADD CONSTRAINT pjbkey PRIMARY KEY (JobId)

SELECT * FROM Jobs
INSERT INTO JobS(JobId,JobTitle,MINSALARY) VALUES
('001', 'Security', '6000'),
('002', 'Cook', '11000'),
('003', 'Waiter', '11000'),
('004',  'Manager', '2000')
INSERT INTO JobS(JobId,JobTitle,MAXSALARY) VALUES
('101', 'Owner1', '5000'),
('106',  'Owner2', '5000'),
('207',  'Partner', '9000'),
('277',  'AssetHolder', '8000'),
('086', 'Depositer', '8000')

---P.E.4---
CREATE TABLE Departments (
   DepartmentID decimal(4,0) NOT NULL DEFAULT '0',
   DepartmentName varchar(30) NOT NULL,
   ManagerID decimal(6,0) DEFAULT NULL,
   LocationID decimal(4,0) DEFAULT NULL,
	PRIMARY KEY (DepartmentID),
 )
 SELECT * FROM Departments

 INSERT INTO Departments  VALUES
('1', 'Civil', '186', '1230'),
('2', 'Electrical', '301', '1400'),
('3', 'Mechanical', '170', '1700'),
('4', 'Computer', '303', '2400');

---Employees Table---
CREATE TABLE Employees
(
Employee_Id INT CONSTRAINT p_key PRIMARY KEY,
 FirstName VARCHAR(25),
 LastName VARCHAR(30),
 Email VARCHAR(50),
 PhoneNumber BIGINT,
 Hire_Date DATE,
 Job_Id VARCHAR(25) NOT NULL CONSTRAINT fkeyJob FOREIGN KEY REFERENCES DBO.JobHistory(JobID),
 Salary DECIMAL(10,2),
 Commission DECIMAL(2,2),
 Manager_Id DECIMAL(6,2),
 Department_Id decimal(4,0) CONSTRAINT fkey FOREIGN KEY REFERENCES DBO.Departments(DepartmentID)
)
SELECT * FROM Employees
ALTER TABLE Employees
ALTER COLUMN PhoneNumber varchar(20)
INSERT INTO Employees (Employee_Id,FirstName,LastName , Email, PhoneNumber, Hire_Date, Job_Id, Salary, Commission, Manager_Id, Department_Id) VALUES
('100', 'Steven', 'King', 'SKING', '515.123.4567', '1987-06-17', 'AD_PRES', '24000.00', '0.00', '0', '90'),
('101', 'Neena', 'Kochhar', 'NKOCHHAR', '515.123.4568', '1987-06-18', 'AD_VP', '17000.00', '0.00', '100', '90'),
('102', 'Lex', 'De Haan', 'LDEHAAN', '515.123.4569', '1987-06-19', 'AD_VP', '17000.00', '0.00', '100', '90'),
('103', 'Alexander', 'Hunold', 'AHUNOLD', '590.423.4567', '1987-06-20', 'IT_PROG', '9000.00', '0.00', '102', '60'),
('104', 'Bruce', 'Ernst', 'BERNST', '590.423.4568', '1987-06-21', 'IT_PROG', '6000.00', '0.00', '103', '60');

---ASSIGNMENT-DAY-1
CREATE TABLE CAR_SALES
(
Employees_Id int CONSTRAINT pk_em_key PRIMARY KEY ,
Inventury_Id int NOT NULL UNIQUE  ,
Salesman_Id int NOT NULL UNIQUE , 
CONSTRAINT fkem_id FOREIGN KEY (Employees_Id) REFERENCES DBO.Employees(Employee_Id)
)
CREATE TABLE Inventury 
(
Inventury_Id int Constraint fjk_inv_key FOREIGN KEY REFERENCES DBO.CAR_SALES(Inventury_Id),
CAR_MODEL VARCHAR(30) NOT NULL,
CAR_TYPE VARCHAR(15) NOT NULL ,
CHECK(CAR_TYPE IN ('PETROL','DIESEL','CNG','ELECTRIC'))
)
CREATE TABLE SALES
(
Salesman_ID INT Constraint fk_sl_key FOREIGN KEY REFERENCES DBO.CAR_SALES(Salesman_Id),
total_sales INT NOT NULL,
Salesman_name VARCHAR(50) NOT NULL,
DOB DATE NOT NULL
)
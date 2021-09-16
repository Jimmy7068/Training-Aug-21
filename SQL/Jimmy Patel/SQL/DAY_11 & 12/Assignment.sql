USE DAY1
-------Assignment
CREATE TABLE BRANCHTABLE
(
BNAME VARCHAR(18) PRIMARY KEY,
CITY VARCHAR(18)
)

CREATE TABLE CUSTOMERTABLE(
CNAME VARCHAR(18) PRIMARY KEY,
CITY VARCHAR(18)
)

CREATE TABLE DEPOSITABLE
(
ACTNO VARCHAR(5) PRIMARY KEY,
CNAME VARCHAR(18) FOREIGN KEY REFERENCES dbo.CUSTOMERTABLE(CNAME),
BNAME VARCHAR(18) FOREIGN KEY REFERENCES dbo.BRANCHTABLE(BNAME),
AMOUNT INT,
ADATE DATE
)

CREATE TABLE BORROWTABLE(
LOANNO VARCHAR(5) PRIMARY KEY,
CNAME VARCHAR(18) NOT NULL FOREIGN KEY REFERENCES DBO.CUSTOMERTABLE(CNAME),
BNAME VARCHAR(18) NOT NULL FOREIGN KEY REFERENCES DBO.BRANCHTABLE(BNAME),
AMOUNT INT
)
INSERT INTO CUSTOMERTABLE VALUES
('ANIL','KOLKATA'),
('SUNIL','DELHI'),
('MEHUL','BARODA'),
('MANDAR','PATNA'),
('MADHURI','NAGPUR'),
('PRAMOD','NAGPUR'),
('SANDIP','SURAT'),
('SHIVANI','MUMBAI'),
('KRANTI','MUMBAI'),
('NAREN','MUMBAI')

INSERT INTO BRANCHTABLE VALUES
('VRCE','NAGPUR'),
('AJNI','NAGPUR'),
('KAROLBAGH','DELHI'),	
('CHANDNI','DELHI'),
('DHARAMPETH','NAGPUR'),
('M.G.ROAD','BANGLORE'),
('ANDHERI','MUMBAI'),	
('VIRAR','MUMBAI'),
('NEHRU PLACE','DELHI'),	
('POWAI','MUMBAI')
INSERT INTO BORROWTABLE VALUES
('201','ANIL','VRCE',1000),	
('206','MEHUL','AJNI',5000),
('311','SUNIL','DHARAMPETH',3000),	
('321','MADHURI','ANDHERI',2000),
('375','PRAMOD','VIRAR',8000),
('481','KRANTI','NEHRU PLACE',3000)	

INSERT INTO DEPOSITABLE VALUES
('100','ANIL','VRCE',1000,'1-Mar-1995'),
('101','SUNIL','AJNI',5000,'4-Jan-1996'),
('102','MEHUL','KAROLBAGH',3500,'17-Nov-1995'),	
('104','MADHURI','CHANDNI',1200,'17-Dec-1995'),
('105','PRAMOD','M.G.ROAD',3000,'27-Mar-1996'),	
('106','SANDIP','ANDHERI',2000,'31-Mar-1996'),
('107','SHIVANI','VIRAR',1000,'5-Sep-1995'),
('108','KRANTI','NEHRU PLACE',5000,'2-Jul-1995'),
('109','NAREN','POWAI',7000,'10-Aug-1995')

SELECT * FROM DEPOSITABLE
SELECT * FROM BORROWTABLE
SELECT * FROM BRANCHTABLE
SELECT * FROM CUSTOMERTABLE
--SP_RENAME 'DepositTable.BNAME' ,'Bname' ,'COLUMN';
--sp_help DepositTable

--Q1: Create a Store Procedure which will accept name of the customer as input parameter and product the following output, List Names of Customers who are Depositors and have Same Branch City as that of input parameter customerís Name.
	CREATE PROCEDURE custbranchprocedure
	@NAME VARCHAR(18)
	AS
	SET NOCOUNT ON
	SELECT CNAME,BNAME FROM DEPOSITABLE WHERE BNAME = (SELECT BNAME FROM DEPOSITABLE WHERE CNAME = @NAME)
	SET NOCOUNT OFF
	GO
	EXEC custbranchprocedure 'Anil'
--Q2: Create a Store Procedure which will accept name of the customer as input parameter and produce the following output List in JSON format, All the Depositors Having Depositors Having Deposit in All the Branches where input parameter customer is Having an Account
	CREATE PROCEDURE JSONCUSBRAPROCEDURE
	@NAME VARCHAR(18)
	AS
	SELECT * FROM DEPOSITABLE WHERE CNAME  = @NAME AND CNAME IN (SELECT CNAME FROM DEPOSITABLE) FOR JSON AUTO
	GO

	EXEC JSONCUSBRAPROCEDURE 'Anil'

--Q3: Create a Store Procedure that will accept city name and returns the number of customers in that city.
	CREATE PROCEDURE CITYNUMPROCEDURE
	@CITY VARCHAR(10)
	AS
	SET NOCOUNT ON;
	SELECT COUNT(CITY) FROM CUSTOMERTABLE WHERE CITY = @CITY GROUP BY CITY
	SET NOCOUNT OFF;
	EXEC CITYNUMPROCEDURE 'MUMBAI'
--Q4: Create a Store Procedure which will accept city of the customer as input parameter and product the following output List in JSON format List All the Customers Living in city provided in input parameter and Having the Branch City as MUMBAI or DELHI
	CREATE PROCEDURE CITYJSONLIST
	@CITY VARCHAR(10)
	AS
	SELECT CNAME,BNAME FROM DEPOSITABLE WHERE BNAME = @CITY AND BNAME IN (SELECT BNAME FROM BRANCHTABLE WHERE CITY IN ('MUMBAI','DELHI')) FOR JSON AUTO
	EXEC CITYJSONLIST 'CHANDNI'
--Q5: Count the Number of Customers Living in the City where Branch is Located
	CREATE PROCEDURE citycustprocedure
	@city varchar(10)
	AS
	SELECT COUNT(CNAME),BRC.CITY FROM DEPOSITABLE AS DEP FULL OUTER JOIN BRANCHTABLE AS BRC ON DEP.BNAME = BRC.BNAME WHERE BRC.CITY = @city GROUP BY BRC.CITY 
	GO
	EXEC citycustprocedure 'mumbai'
--Q6: Create a Procedure which will accept input in JSON parameter CustomerName,City, ACTNO,Branch,amount  
--And insert these record in the Deposit table. Before inserting some validation should be done like amount should be greater than 10Rs. and date should always be current date.
CREATE PROCEDURE JSONINPUTPROCEDURE
@CUSTOMENRINFO NVARCHAR(MAX)
AS
INSERT INTO DEPOSITABLE(CNAME,ACTNO,BNAME,AMOUNT,ADATE)
SELECT * FROM OPENJSON(@CUSTOMERINFO)
WITH(
	CustomerName Varchar(18) '$.CNAME',
	ACTNO INT '$.ACTNO',
	BName Varchar(18) '$.BNAME',
	Amount Int '$.AMOUNT',
	ADate Date '$.ADATE'
)
GO

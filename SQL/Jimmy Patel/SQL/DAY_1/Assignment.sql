USE DAY1

----Assignment:

----You have been hired to create a relational database to support a car sales business. You need to store information on the business’s employees, inventory, and completed sales. You also need to account for the fact that each salesperson receives a different percentage of their sales in commission. What tables and columns would you create in your relational database, and how would you link the tables?
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
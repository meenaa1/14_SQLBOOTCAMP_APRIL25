create Table Categories(
CategoryID Serial UNIQUE Primary key,
CategoryName VARCHAR(50) NOT NULL,
Description VARCHAR(255) NOT NULL);

Select * from Categories

create Table Customers(
CustomerID VARCHAR(5) UNIQUE Primary key,
CustomerName VARCHAR(50) NOT NULL,
ContactName VARCHAR(255) NOT NULL,
ContactTitle VARCHAR(50) NOT NULL ,
City VARCHAR(50) NOT NULL,
Country VARCHAR(50) NOT NULL );

Select * from Customers

create Table Employees(
EmployeeID Serial Unique Primary key,
EmployeeName VARCHAR(50) NOT NULL,
Title VARCHAR(50) NOT NULL ,
City VARCHAR(10) NOT NULL,
Country VARCHAR(5) NOT NULL,
ReportTo INT )

Select * from Employees

create Table Orders(
OrderID int Unique Primary key NOT NULL,
CustomerID Varchar(5) NOT NULL,
EmployeeID int NOT NULL,
OrderDate Date NOT NULL,
RequiredDate Date NOT NULL,
ShippedDate Date, 
ShipperID int,
Freight Float )

ALTER TABLE orders
ADD CONSTRAINT fk_order_customer
FOREIGN KEY (CustomerID)
REFERENCES Customers (CustomerID);

ALTER TABLE orders
ADD CONSTRAINT fk_order_Employee
FOREIGN KEY (EmployeeID)
REFERENCES Employees (EmployeeID);

Select * from Orders

create Table Products(
ProductID Serial Unique Primary Key NOT NULL,
ProductName Varchar(50) NOT NULL,
QuantityPerUnit Varchar(50) NOT NULL,
UnitPrice float Not Null,
Discontinued int Not nUll,
CategoryID int NOT NULL)

ALTER TABLE Products
ADD CONSTRAINT fk_products_Category
FOREIGN KEY (CategoryID)
REFERENCES Categories (CategoryID);

Select * from Products

create Table OrdersDetails(
OrderID int NOT NULL,
ProductID int NOT NULL,
UnitPrice Float NOT NULL,
Quantity int NOT NULL,
Discount Float NOT NULL)

ALTER TABLE OrdersDetails
ADD CONSTRAINT fk_OrdersDetails_Orders
FOREIGN KEY (OrderID)
REFERENCES Orders (OrderID)

ALTER TABLE OrdersDetails
ADD CONSTRAINT fk_OrdersDetails_Products
FOREIGN KEY (ProductID)
REFERENCES Products (ProductID);

Select * from OrdersDetails

create Table Shippers(
ShipperID Serial Unique Primary key NOT NULL,
CompanyName varchar(50) NOT NULL)

Select * from Shippers

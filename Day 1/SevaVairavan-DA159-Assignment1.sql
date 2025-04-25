-- Customers Table
Create Table customers(
customerID VARCHAR(10) PRIMARY KEY,
companyName VARCHAR(50) NOT NULL,
contactName VARCHAR(50),
contactTitle VARCHAR(30),
city VARCHAR(25),
country VARCHAR(25)
)
/*Customer Table:
customerID VARCHAR(10) PRIMARY KEY - ID should be unique, then only we can find the customer
companyName VARCHAR(50) NOT NULL - That field should not be null*/


--Categories Table
Create Table categories(
categoryID	INT PRIMARY KEY,
categoryName VARCHAR(25) NOT NULL,
description TEXT
)
/*Categories Table:
categoryID	INT PRIMARY KEY - ID should be Unique
description TEXT - For unlimited TEXT
*/

--Shippers Table
Create Table shippers(
shipperID INT PRIMARY KEY,
companyName VARCHAR(25) NOT NULL
)
/*Shippers Table:
shipperID INT PRIMARY KEY - ID should be Unique
*/

--Products Table
Create Table products(
productID INT PRIMARY KEY,
productName	VARCHAR(50) NOT NULL,
quantityPerUnit	VARCHAR(100),
unitPrice DECIMAL(10,2),
discontinued BOOLEAN DEFAULT FALSE,
categoryID INT,
FOREIGN KEY (categoryID) REFERENCES categories(categoryID)
)
/*Products Table
productID INT PRIMARY KEY-ID should be unique, then only we can find the Products
FOREIGN KEY (categoryID) REFERENCES categories(categoryID) - categoryID from Products Table refers categoryID from categories table 
*/


--Employees Table
Create Table employees(
employeeID SERIAL PRIMARY KEY,
employeeName VARCHAR(30) NOT NULL,
title VARCHAR(30),
city VARCHAR(25),	
country	VARCHAR(25),	
reportsTo INT,
FOREIGN KEY (reportsTo) REFERENCES employees(employeeID)
)
/*Employees Table
employeeID SERIAL PRIMARY KEY - create tables with unique primary keys, Auto-Increment 
FOREIGN KEY (reportsTo) REFERENCES employees(employeeID) - reportsTo from employees Table refers employeeID from employees table 
*/

--Orders Table
Create Table orders(
orderID	INT PRIMARY KEY,
customerID VARCHAR(50) NOT NULL,
employeeID SERIAL,
orderDate DATE NOT NULL,
requiredDate DATE NOT NULL,	
shippedDate	DATE,
shipperID INT,
freight DECIMAL(10, 2),
FOREIGN KEY (customerID) REFERENCES customers(customerID),
FOREIGN KEY (employeeID) REFERENCES employees(employeeID),
FOREIGN KEY (shipperID) REFERENCES shippers(shipperID)
)
/*Orders Table:
orderID	INT PRIMARY KEY-ID should be unique, then only we can find the Orders
employeeID SERIAL - Auto-Increment
FOREIGN KEY (customerID) REFERENCES customers(customerID) - customerID from Orders Table refers customerID from customers table 
FOREIGN KEY (employeeID) REFERENCES employees(employeeID) - employeeID from Orders Table refers employeeID from employees table 
FOREIGN KEY (shipperID) REFERENCES shippers(shipperID) - shipperID from Orders Table refers shipperID from shippers table 
)*/


--Order_Details Table
Create Table order_details(
orderID	INT NOT NULL,
productID INT NOT NULL,
unitPrice DECIMAL(10, 2),
quantity INT NOT NULL,
discount DECIMAL(5, 2),
PRIMARY KEY(orderID,productID),
FOREIGN KEY (orderID) REFERENCES orders(orderID),
FOREIGN KEY (productID) REFERENCES products(productID)
)
/*Order_Details Table:
PRIMARY KEY(orderID,productID) - Composite Primary Key
FOREIGN KEY (orderID) REFERENCES orders(orderID) - orderID from Order_Details Table refers orderID from orders table 
FOREIGN KEY (productID) REFERENCES products(productID) - productID from Order_Details Table refers productID from products table */



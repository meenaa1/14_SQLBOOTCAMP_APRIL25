-->create categories table in database (savitha)
create table categories (
categoryID int primary key,  --> unique key , so i gave primary key 
categoryname varchar(50),
description varchar(100)
);

--> display records from categories table 
select * from categories;


-->create shipper table 
 create table shipper (
shipperID serial primary key,  
companyname varchar(100)
 );

 --> display records from shipper table 

 select * from shipper;

 -->create table products

 create table products (
productID serial primary key,
productName text not null unique,   --> product name should be unique and not null
quantityPerUnit text,
unitPrice numeric(10,2),
discontinued boolean,
categoryID integer references categories(categoryID)--> category ID id foreign key for this table because its PK in another table 
);


-->Display Products table 

select * from products


--> create table customers 

CREATE TABLE customers (
    customerID VARCHAR(5) PRIMARY KEY,
    companyName TEXT NOT NULL,
    contactName TEXT,
    contactTitle TEXT,
    city TEXT,
    country TEXT
);


-->Display customers table 

select * from customers


-->create table employees

create table employees (
employeeID int primary key,
employeeName text Not Null,
title text,
city text,
county text,
reportsTo int
);


-->Display employees table 

select * from employees

--> create orders table 

create table orders (
orderid int primary key,
customerID VARCHAR(5) references customers(customerID),-->FK
employeeID int references employees(employeeID),-->FK
orderDate date,
requireddate date,
shippeddate date,
shipperID int references shipper(shipperID), -->FK
fright decimal(10,2)
);

-->display orders table 
select * from orders

--> create table orderdetails 

create table order_details (
orderID int references orders(orderid),     --> FK
prodcutID int references products(productID),-->FK
unitPrice decimal(10,2),
quantity int ,
discount decimal(10,2)
);

--> display table order details 

select * from order_details







--Table categories
CREATE TABLE categories (
	categoryID SERIAL PRIMARY KEY,
	categoryName VARCHAR (50) UNIQUE NOT NULL,
	description TEXT NOT NULL
);

select * from categories;

--Import data from csv file
copy public.categories (categoryid, categoryname, description) 
FROM '/Users/chinnz/Desktop/SQL Bootcamp/archive-2/categories.csv' DELIMITER ',' 
CSV HEADER ;

--Table customers
Drop TABLE customers;
CREATE TABLE customers (
	customerID VARCHAR (20) PRIMARY KEY,
	companyName VARCHAR (100) NOT NULL,
	contactName VARCHAR (50),
	contactTitle VARCHAR (50),
	city VARCHAR (20),
	country VARCHAR (20)
);

select * from customers;

--Import data from csv file
copy public.customers (customerID, companyName, contactName,contactTitle,city,country) 
FROM '/Users/chinnz/Desktop/SQL Bootcamp/archive-2/customers_1.csv' DELIMITER ',' 
CSV HEADER  ;

--Table shippers
Drop TABLE shippers;

CREATE TABLE shippers (
	shipperID SERIAL PRIMARY KEY,
	companyName VARCHAR (50) NOT NULL
);

select * from shippers;

--Import data from csv file
copy public.shippers (shipperID, companyName) 
FROM '/Users/chinnz/Desktop/SQL Bootcamp/archive-2/shippers.csv' DELIMITER ',' 
CSV HEADER  ;

--Table products
Drop TABLE products;

CREATE TABLE products (
	productID SERIAL PRIMARY KEY,
	productName VARCHAR (100),
	quantityPerUnit VARCHAR (100),
	unitPrice FLOAT,
	discontinued INTEGER,
	categoryID INTEGER NOT NULL,

	CONSTRAINT fk_categories
		FOREIGN KEY (categoryID)
		REFERENCES categories(categoryID) ON DELETE CASCADE
	
);

select * from products;

--Import data from csv file
copy public.products (productID, productName,quantityPerUnit,unitPrice,discontinued,categoryID) 
FROM '/Users/chinnz/Desktop/SQL Bootcamp/archive-2/products_1.csv' DELIMITER ',' 
CSV HEADER  ;

--Table employees
Drop TABLE employees;

CREATE TABLE employees (
	employeeID INTEGER PRIMARY KEY,
	employeeName VARCHAR (50),
	title VARCHAR (100),
	city VARCHAR (50),
	country VARCHAR (50),
	reportsTo INTEGER 	
);

select * from employees;

--Import data from csv file
copy public.employees (employeeID, employeeName,title,city,country,reportsTo) 
FROM '/Users/chinnz/Desktop/SQL Bootcamp/archive-2/employees.csv' DELIMITER ',' 
CSV HEADER  ;

--Table employees
Drop TABLE orders;

CREATE TABLE orders (
	orderID BIGINT PRIMARY KEY,
	customerID VARCHAR (20) NOT NULL,
	employeeID INTEGER NOT NULL,
	orderDate DATE,
	requiredDate DATE,
	shippedDate DATE,
	shipperID INTEGER NOT NULL,
	freight FLOAT,

	CONSTRAINT fk_customers
		FOREIGN KEY (customerID)
		REFERENCES customers(customerID) ON DELETE CASCADE,

	CONSTRAINT fk_employees
		FOREIGN KEY (employeeID)
		REFERENCES employees(employeeID) ON DELETE CASCADE,	

	CONSTRAINT fk_shippers
		FOREIGN KEY (shipperID)
		REFERENCES shippers(shipperID) ON DELETE CASCADE	
);

select * from orders;

--Import data from csv file
copy public.orders (orderID, customerID, employeeID, orderDate, requiredDate,shippedDate, shipperID,freight) 
FROM '/Users/chinnz/Desktop/SQL Bootcamp/archive-2/orders.csv' DELIMITER ',' 
CSV HEADER  ;

--Table order_details
Drop TABLE order_details;

CREATE TABLE order_details (
	orderID INTEGER NOT NULL,
	productID INTEGER NOT NULL,
	unitPrice FLOAT,
	quantity INTEGER,
	discount FLOAT,

	PRIMARY KEY (orderID,productID),
	
		FOREIGN KEY (orderID) REFERENCES orders(orderID),
		FOREIGN KEY (productID) REFERENCES products(productID)
		
);

select * from order_details;

--Import data from csv file
copy public.order_details (orderID, productID, unitPrice, quantity, discount) 
FROM '/Users/chinnz/Desktop/SQL Bootcamp/archive-2/order_details.csv' DELIMITER ',' 
CSV HEADER  ;








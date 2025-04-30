--***** Creating Table #1 Categories *****-----

CREATE TABLE Categories (
    categoryID INT PRIMARY KEY, -- Unique identifier for each product category
    categoryName VARCHAR(100) NOT NULL, -- The name of the category
    description TEXT --A description of the category and its products
);

--To Verify Table creation & after Import of CSV (ensure to refresh at DB level)
-- Step2 after table creation : Import file using option Import CSV under respective table

select * from Categories


--***** Creating Table #2 Products *****----

CREATE TABLE Products (
    productID INT PRIMARY KEY,                        -- Unique identifier for each product
    productName VARCHAR(100) NOT NULL,                -- The name of the product
    quantityPerUnit VARCHAR(50),                      -- The quantity of the product per package
    unitPrice NUMERIC(10, 2),                         -- The current price per unit of the product (USD)
    discontinued BOOLEAN NOT NULL DEFAULT FALSE,      -- Indicates with TRUE if the product has been discontinued
    categoryID INT REFERENCES Categories(categoryID)  -- The ID of the category the product belongs to
);

select * from Products

select count(*) from Products

ALTER TABLE Products
ADD CONSTRAINT fk_product_category
FOREIGN KEY (categoryID)
REFERENCES Categories(categoryID);

--***** Creating Table #3 Customers *****-----

CREATE TABLE Customers (
    customerID INT PRIMARY KEY,                       -- Unique identifier for each customer
    companyName VARCHAR(100) NOT NULL,                -- The name of the customer's company
    contactName VARCHAR(100),                         -- The name of the primary contact for the customer
    contactTitle VARCHAR(50),                         -- The job title of the primary contact for the customer
    city VARCHAR(50),                                 -- The city where the customer is located
    country VARCHAR(50)                               -- The country where the customer is located
);

select * from Customers

select count(*) from Customers

ALTER TABLE Customers
  ALTER COLUMN customerID TYPE VARCHAR(50);


--***** Creating Table #4 Employees *****-----


/*CREATE TABLE Employees (
    employeeID INT PRIMARY KEY,                       -- Unique identifier for each employee
    employeeName VARCHAR(100) NOT NULL,               -- Full name of the employee
    title VARCHAR(50),                                -- The employee's job title
    city VARCHAR(50),                                 -- The city where the employee works
    country VARCHAR(50),                              -- The country where the employee works
    reportsTo INT REFERENCES Employees(employeeID)    -- The ID of the employee's manager
);*/

CREATE TABLE Employees (
    employeeID INT PRIMARY KEY,                     -- Unique identifier for each employee  
    employeeName VARCHAR(100) NOT NULL,             -- Full name of the employee  
    title VARCHAR(50),                              -- The employee's job title  
    city VARCHAR(50),                               -- The city where the employee works  
    country VARCHAR(50),                            -- The country where the employee works  
    reportsTo INT,                                   -- The ID of the employee's manager
    CONSTRAINT fk_employee_manager
        FOREIGN KEY (reportsTo) REFERENCES Employees(employeeID)
);

select * from Employees

select count(*) from Employees

--***** Creating Table #5 Shippers *****-----

CREATE TABLE Shippers (
    shipperID INT PRIMARY KEY,                        -- Unique identifier for each shipper
    companyName VARCHAR(100) NOT NULL                 -- The name of the company that provides shipping services
);


select * from Shippers

select count(*) from Shippers


--***** Creating Table #6 Orders *****-----


CREATE TABLE Orders (
    orderID INT PRIMARY KEY,                          -- Unique identifier for each order
    customerID VARCHAR(50),                           -- The customer who placed the order
    employeeID INT,                                   -- The employee who processed the order
    orderDate DATE,                                    -- The date when the order was placed
    requiredDate DATE,                                 -- The date when the customer requested the order to be delivered
    shippedDate DATE,                                  -- The date when the order was shipped
    shipperID INT,                                     -- The ID of the shipping company used for the order
    freight NUMERIC(10, 2),                            -- The shipping cost for the order (USD)
    CONSTRAINT fk_order_customer FOREIGN KEY (customerID) REFERENCES Customers(customerID),
    CONSTRAINT fk_order_employee FOREIGN KEY (employeeID) REFERENCES Employees(employeeID),
    CONSTRAINT fk_order_shipper FOREIGN KEY (shipperID) REFERENCES Shippers(shipperID)
);


select * from Orders

select count(*) from Orders


--***** Creating Table #7 Order Details *****-----

CREATE TABLE Order_Details (
    orderID INT,                                         -- The ID of the order this detail belongs to
    productID INT,                                       -- The ID of the product being ordered
    unitPrice NUMERIC(10, 2),                            -- The price per unit of the product at the time the order was placed (USD - discount not included)
    quantity INT NOT NULL,                               -- The number of units being ordered
    discount NUMERIC(4, 2),                              -- The discount percentage applied to the price per unit
    PRIMARY KEY (orderID, productID),                    -- Composite primary key for the line item
    CONSTRAINT fk_detail_order FOREIGN KEY (orderID) REFERENCES Orders(orderID),    -- Foreign key for orderID
    CONSTRAINT fk_detail_product FOREIGN KEY (productID) REFERENCES Products(productID)  -- Foreign key for productID
);


select * from Order_Details

select count(*) from Order_Details



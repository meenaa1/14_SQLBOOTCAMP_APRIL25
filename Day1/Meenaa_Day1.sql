--creating Database
create Database northwind
create Database "NorthWind"
Drop Database northwind;
SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname = 'northwind';

--categories Table
CREATE TABLE categories (
	"categoryID" SERIAL PRIMARY KEY,
	"categoryName" VARCHAR (50) UNIQUE NOT NULL,
	"description" VARCHAR (50) NOT NULL
);

select * from categories

--customers Table
CREATE TABLE customers (
	"customerID" VARCHAR (20) PRIMARY KEY,
	"companyName" VARCHAR (50) NOT NULL,
	"contactName" VARCHAR (50) NOT NULL,
	"contactTitle" VARCHAR (50) NOT NULL,
	"city" VARCHAR (50) NOT NULL,
	"country" VARCHAR (25) NOT NULL
);

select * from customers

--categories Table
CREATE TABLE employees (
    "employeeID" SERIAL PRIMARY KEY,
    "employeeName" VARCHAR(25) NOT NULL,
    "title" VARCHAR(25) NOT NULL,
    "city" VARCHAR(15) NOT NULL,
    "country" VARCHAR(50) NOT NULL,
    "reportsTo" INTEGER NULL
);

select * from employees

--order_details Table
CREATE TABLE order_details (
    "orderID" INTEGER NOT NULL,
    "productID" INTEGER NOT NULL,
    "unitPrice" NUMERIC(10, 2) NOT NULL,
    "quantity" INTEGER NOT NULL,
    "discount" NUMERIC(4, 2) DEFAULT 0,

    PRIMARY KEY ("orderID", "productID"),  -- Composite Primary Key
    FOREIGN KEY ("orderID") REFERENCES orders("orderID"),
    FOREIGN KEY ("productID") REFERENCES products("productID")
);

select * from order_details

--orders Table
CREATE TABLE orders (
    "orderID" INTEGER PRIMARY KEY,
    "customerID" VARCHAR NOT NULL,
    "employeeID" INTEGER NOT NULL,
  	"orderDate" DATE NOT NULL,
    "requiredDate" DATE NOT NULL,
    "shippedDate" DATE NOT NULL,
  	"shipperID" INTEGER NOT NULL,
  	"freight" NUMERIC(10, 2) NOT NULL
);
select * from orders

--products Table
CREATE TABLE products (
    "productID" SERIAL PRIMARY KEY,
  	"productName" VARCHAR (50) NOT NULL,
	  "quantityPerUnit" VARCHAR (25) NOT NULL,
    "unitPrice" NUMERIC(10, 2) NOT NULL,
    "discontinued" INTEGER NOT NULL,
  	"categoryID" INTEGER NOT NULL
);
select * from products

ALTER TABLE products
ALTER COLUMN "productName" TYPE VARCHAR(100);

ALTER TABLE products
ADD CONSTRAINT fk_category
FOREIGN KEY ("categoryID") REFERENCES categories ("categoryID")

ALTER TABLE orders
ALTER COLUMN "shippedDate" DROP NOT NULL;

--shippers Table
CREATE TABLE shippers (
	"shipperID" SERIAL PRIMARY KEY,
	"companyName" VARCHAR (15) NOT NULL
);
--Altering after creating table to add the constraints
ALTER TABLE shippers
ALTER COLUMN "companyName" TYPE VARCHAR(25);

-- Foreign Key from orders to customers
ALTER TABLE orders
ADD CONSTRAINT fk_orders_customers
FOREIGN KEY ("customerID")
REFERENCES customers("customerID");

-- Foreign Key from orders to employees
ALTER TABLE orders
ADD CONSTRAINT fk_orders_employees
FOREIGN KEY ("employeeID")
REFERENCES employees("employeeID");

-- Foreign Key from orders to shippers
ALTER TABLE orders
ADD CONSTRAINT fk_orders_shippers
FOREIGN KEY ("shipperID")
REFERENCES shippers("shipperID");

-- Foreign Key from order_details to products
ALTER TABLE order_details
ADD CONSTRAINT fk_order_details_products
FOREIGN KEY ("productID")
REFERENCES products("productID");

-- Foreign Key from order_details to orders
ALTER TABLE order_details
ADD CONSTRAINT fk_order_details_orders
FOREIGN KEY ("orderID")
REFERENCES orders("orderID");


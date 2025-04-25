------------Day3---------

------ 1. Update the categoryName From “Beverages” to "Drinks" in the categories table----
UPDATE categories
SET "categoryName" = 'Drinks'
WHERE "categoryName" = 'Beverages';

Select * FROM categories

----- 2. Insert into shipper new record (give any values) Delete that new record from shippers table----

INSERT INTO Shippers (companyName) 
VALUES ('UPS');

Select * from Shippers  

Delete from shippers
WHERE shipperid = 4

Select * from Shippers

----- 2. Insert into shipper new record (give any values) Delete that new record from shippers table----

INSERT INTO Shippers (companyName) 
VALUES ('UPS');

Select * from Shippers  

Delete from shippers
WHERE shipperid = 5

Select * from Shippers

/* 3.Update categoryID=1 to categoryID=1001. Make sure related products update their categoryID too. 
Display the both category and products table to show the cascade.
Delete the categoryID= “3”  from categories. Verify that the corresponding records are deleted automatically from products.
(HINT: Alter the foreign key on products(categoryID) to add ON UPDATE CASCADE, ON DELETE CASCADE, add ON DELETE CASCADE for order_details(productid))*/

--------Drop fk constraint from products table------

ALTER TABLE Products
drop CONSTRAINT fk_products_Category;

-------Alter products table to create fk constraint for categoryId with on update cascade and on delete cascade----

ALTER TABLE Products
ADD CONSTRAINT fk_products_Category
    FOREIGN KEY (CategoryID)
    REFERENCES Categories (CategoryID)
    ON DELETE CASCADE 
	ON UPDATE CASCADE;

UPDATE Categories
SET categoryid = 1001
WHERE categoryid = 1;

Select * from Categories

Select * from Products

--------Drop fk constraint for productId from order details table------

ALTER TABLE OrdersDetails                                  
drop CONSTRAINT fk_OrdersDetails_Products;

-------Alter order details to create fk constraint for productId with on Ddelete cascade----

ALTER TABLE OrdersDetails                                
ADD CONSTRAINT fk_OrdersDetails_Products
FOREIGN KEY (ProductID)
REFERENCES Products (ProductID)
on Delete cascade;

---------Delete the categoryID= “3”  from categories.----

Delete from Categories
WHERE Categoryid = 3;

Select * from Categories

Select * from Products
order by categoryid ASC;

/*
4.Delete the customer = “VINET”  from customers. Corresponding customers in orders table should be set to null 
(HINT: Alter the foreign key on orders(customerID) to use ON DELETE SET NULL)*/

------Drop fk Constraint for customerid from orders table----

ALTER TABLE orders
DROP CONSTRAINT fk_order_customer

ALTER TABLE orders
ADD CONSTRAINT fk_order_customer
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID) on delete set null;

------Drop not null constraint for customerid in orders table----
ALTER TABLE orders ALTER COLUMN customerId DROP NOT NULL;

-----Delete the customer="VINET" from customers.----
Delete from customers
Where customerid= 'VINET'

Select * from orders

---5.Insert the following data to Products using UPSERT:(this should update the quantityperunit for product_id = 100)---
Select * from orders

Insert into Products (ProductID,ProductName,QuantityPerUnit,UnitPrice,Discontinued,CategoryID)
VALUES(100, 'Wheat bread', '1', 13, 0, 5)     
on conflict (ProductID) 
do update
set ProductName = Excluded.ProductName,
    QuantityPerUnit = Excluded.QuantityPerUnit,
	UnitPrice = Excluded.UnitPrice,
	Discontinued = Excluded.Discontinued,
	CategoryID = Excluded.CategoryID;

    Select * from Products

Insert into Products (ProductID,ProductName,QuantityPerUnit,UnitPrice,Discontinued,CategoryID)
VALUES(101, 'White bread', '5 boxes', 13, 0, 5)     
on conflict (ProductID) 
do update
set ProductName = Excluded.ProductName,
    QuantityPerUnit = Excluded.QuantityPerUnit,
	UnitPrice = Excluded.UnitPrice,
	Discontinued = Excluded.Discontinued,
	CategoryID = Excluded.CategoryID;

    Select * from Products	

Insert into Products (ProductID,ProductName,QuantityPerUnit,UnitPrice,Discontinued,CategoryID)
VALUES(100, 'Wheat bread', '10 boxes', 13, 0, 5)     
on conflict (ProductID) 
do update
set ProductName = Excluded.ProductName,
    QuantityPerUnit = Excluded.QuantityPerUnit,
	UnitPrice = Excluded.UnitPrice,
	Discontinued = Excluded.Discontinued,
	CategoryID = Excluded.CategoryID;

	  Select * from Products

/*6.Write a MERGE query:-Create temp table with name:
‘updated_products’ and insert values as below:*/

-----Create the temp table----

Create table updated_products(
    productID int,
    productName Varchar(50),
    quantityPerUnit Varchar(50),
    unitPrice float,
    discontinued int,
    categoryID int);

	Select * from updated_products 

-- Insert values into the temp table---
insert into  updated_products (productID,productName,quantityPerUnit,unitPrice,discontinued,categoryID)
Values
    (100,'Wheat bread','10',20,1,5),
    (101,'White bread','5 boxes',19.99,0,5),
    (102,'Midnight Mango Fizz','24 - 12 oz bottles',19,0,1),
    (103,'Savory Fire Sauce','12 - 550 ml bottles',10,0,2);

	Select * from updated_products 


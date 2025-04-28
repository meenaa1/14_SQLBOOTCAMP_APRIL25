--1)Update the categoryName From “Beverages” to "Drinks" in the categories table.

Update public.categories
Set category_name ='Drinks'
Where category_name = 'Beverages'

--2)Insert into shipper new record (give any values) Delete that new record from shippers table.

Insert Into public.shippers
Values (7, 'Welfare', '123-589-2578');

Delete From public.shippers
Where shipper_id=7;
 
--3)Update categoryID=1 to categoryID=1001. Make sure related products update their categoryID too. 
--Display the both category and products table to show the cascade.
--Delete the categoryID= “3”  from categories. 
--Verify that the corresponding records are deleted automatically from products.
--(HINT: Alter the foreign key on products(categoryID) to add ON UPDATE CASCADE, ON DELETE CASCADE)
 
 Alter Table public.products
 Drop Constraint If Exists fk_products_categories;
 
 Alter Table public.order_details
 Drop Constraint If Exists fk_order_details_products;
 
 Alter Table public.products
 Add Constraint fk_products_categories
 Foreign Key (category_id)
 References categories(category_id)
 On Update Cascade
 On Delete Cascade;
 
 
 ALTER TABLE order_details
 ADD CONSTRAINT fk_order_details_products
 FOREIGN KEY (product_id)
 REFERENCES products(product_id)
 ON UPDATE CASCADE
 ON DELETE CASCADE;
 
 Update public.categories
 Set category_id=1001
 Where category_id=1
 
 Select * From public.categories
 Where category_id=1001
 
 Select * from public.products
 Where category_id=1001
 
 
 Delete From public.categories
 Where category_id=1001;
 
--4)Delete the customer = “VINET”  from customers. 
--Corresponding customers in orders table should be set to null
--(HINT: Alter the foreign key on orders(customerID) to use ON DELETE SET NULL)

 Alter Table public.orders
 Drop Constraint If Exists fk_orders_customers;
 
 Alter Table public.orders
 Add Constraint fk_orders_customers
 Foreign Key(customer_id)
 References customers(customer_id)
 On Delete Set NULL;
 
 Delete From public.customers
 Where customer_id ='VINET';
 
 Select * from public.customers
 Where contact_name ='VINET';

--5)Insert the following data to Products using UPSERT:
--product_id = 100, product_name = Wheat bread, quantityperunit=1,unitprice = 13, discontinued = 0, categoryID=3
--product_id = 101, product_name = White bread, quantityperunit=5 boxes,unitprice = 13, discontinued = 0, categoryID=3
--product_id = 100, product_name = Wheat bread, quantityperunit=10 boxes,unitprice = 13, discontinued = 0, categoryID=3
--(this should update the quantityperunit for product_id = 100)

Insert Into products (product_id,product_name,quantity_per_unit,unit_price,discontinued,category_id)
Values (100,'Wheat bread','1',13,0,3)		
On Conflict (product_id)	
Do Update
Set quantity_per_unit = EXCLUDED.quantity_per_unit;

Insert Into  products(product_id,product_name,quantity_per_unit,unit_price,discontinued,category_id)
Values (101,'White bread','5 boxes',13,0,3)	
On Conflict (product_id)	
Do Update
Set product_name = EXCLUDED.product_name,
	quantity_per_unit = EXCLUDED.quantity_per_unit,
	unit_price = EXCLUDED.unit_price,
	discontinued = EXCLUDED.discontinued,
	category_id = EXCLUDED.category_id;
	
Insert Into products (product_id,product_name,quantity_per_unit,unit_price,discontinued,category_id)
Values (100,'Wheat bread','10',13,0,3)		
On Conflict (product_id)	
Do Update
Set quantity_per_unit = EXCLUDED.quantity_per_unit;	


select * from public.products
Where product_id=100

 
--6)Write a MERGE query:
--Create temp table with name:  ‘updated_products’ and insert values as below:
 
--productID	productName	quantityPerUnit	unitPrice	discontinued	categoryID
--100	Wheat bread	10	20	1	3
--101	White bread	5 boxes	19.99	0	3
--102	Midnight Mango Fizz	24 - 12 oz bottles	19	0	1
--103	Savory Fire Sauce	12 - 550 ml bottles	10	0	2

Create Temp Table updated_products (
    productID Int,
    productName Varchar(255),
    quantityPerUnit Varchar(255),
    unitPrice Numeric(10,2),
    discontinued Int,
    categoryID Int );

Insert Into updated_products (productID, productName, quantityPerUnit, unitPrice, discontinued, categoryID)
Values
    (100, 'Wheat bread', '10', 20, 1, 3),
    (101, 'White bread', '5 boxes', 19.99, 0, 3),
    (102, 'Midnight Mango Fizz', '24 - 12 oz bottles', 19, 0, 8),
    (103, 'Savory Fire Sauce', '12 - 550 ml bottles', 10, 0, 2);
	
--Update the price and discontinued status from above table ‘updated_products’ only if there are matching products and updated_products .discontinued =0 
Update public.products
Set 
     unit_price = updated_products.unitPrice,
     discontinued = updated_products.discontinued
From updated_products
Where Products.product_name= updated_products.productName
  	  And updated_products.discontinued = 0;
	  
--If there are matching products and updated_products .discontinued =1 then delete 

Delete From Products
Using updated_products
Where Products.product_id = updated_products.productID
And updated_products.discontinued = 1;

--Insert any new products from updated_products that don’t exist in products only if updated_products .discontinued =0.

Insert Into Products (product_id, product_name, quantity_per_unit, unit_price, discontinued, category_id)
Select productID, productName, quantityPerUnit, unitPrice, discontinued, categoryID
From updated_products
Where updated_products.discontinued = 0
On Conflict (product_id) Do Nothing;

Alter Table public.products
Drop Constraint If Exists fk_products_categories;
 
Alter Table products
Add Constraint fk_products_categories
Foreign Key(category_id)
References categories(category_id)
On Update Cascade
On Delete Cascade;


----------------------------------------------------------------------------------

Merge Into products p
Using updated_products up
On p.product_id = up.productid
When Matched And up.discontinued = 1 Then
Delete
When Matched And up.discontinued = 0 Then
Update Set
        unit_price = up.unitprice,
        discontinued = up.discontinued
When Not Matched And up.discontinued = 0 Then
    Insert (product_id, product_name, quantity_per_unit, unit_price, discontinued, category_id)
    Values (up.productId, up.productName, up.quantityPerUnit, up.unitPrice, up.discontinued, up.categoryID);

 
--List all orders with employee full names. (Inner join)

Select emp.first_name||' '||emp.last_name As fullName, ord.*
From public.employees emp
Inner Join public.orders ord
On emp.employee_id=ord.employee_id
 

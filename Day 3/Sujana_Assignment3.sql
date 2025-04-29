					--Day 3--
--1.Update the categoryName From “Beverages” to "Drinks" in the categories table.
UPDATE categories SET categoryname='Drinks' WHERE categoryname='Beverages';

--2.Insert into shipper new record (give any values) Delete that new record from shippers table.
INSERT INTO shippers (shipperid,companyname) VALUES (4,'CCC');
DELETE FROM shippers WHERE shipperid=4 ;

/*3)Update categoryID=1 to categoryID=1001. Make sure related products update their categoryID too. 
Display the both category and products table to show the cascade.*/
UPDATE categories SET categoryid=1001 WHERE categoryid=1;

select * from categories where categoryid=1001;
select * from products where categoryid=1001;

/*Delete the categoryID= “3”  from categories. 
Verify that the corresponding records are deleted automatically from products.*/


ALTER TABLE order_details
DROP CONSTRAINT order_details_productid_fkey;

ALTER TABLE order_details
ADD CONSTRAINT order_details_productid_fkey
FOREIGN KEY (productid)
REFERENCES products(productid)
ON UPDATE CASCADE
ON DELETE CASCADE;*/

DELETE FROM categories WHERE categoryid=3;

SELECT * FROM products WHERE categoryid=3;

/*4.Delete the customer = “VINET”  from customers. 
Corresponding customers in orders table should be set to null 
(HINT: Alter the foreign key on orders(customerID) to use ON DELETE SET NULL)*/

--select * from customers where customerid='VINET' ;
--select * from orders where customerid='VINET' ;

ALTER TABLE orders ALTER COLUMN customerid DROP NOT NULL;

ALTER TABLE orders
DROP CONSTRAINT  fk_customers;

ALTER TABLE orders 
ADD CONSTRAINT fk_customers
FOREIGN KEY (customerid)
REFERENCES customers(customerid)
ON DELETE SET NULL;

DELETE from customers where customerid='VINET' ;

/*5)      Insert the following data to Products using UPSERT:
product_id = 100, product_name = Wheat bread, quantityperunit=1,unitprice = 13, discontinued = 0, categoryID=5
product_id = 101, product_name = White bread, quantityperunit=5 boxes,unitprice = 13, discontinued = 0, categoryID=5
product_id = 100, product_name = Wheat bread, quantityperunit=10 boxes,unitprice = 13, discontinued = 0, categoryID=5
(this should update the quantityperunit for product_id = 100)*/

INSERT INTO products (productid,productname,quantityperunit,unitprice,discontinued,categoryID)
	VALUES
		(100,'Wheat bread','1',13,0,5)		
	ON CONFLICT (productid)	
	DO UPDATE SET
	quantityperunit = EXCLUDED.quantityperunit;

INSERT INTO products (productid,productname,quantityperunit,unitprice,discontinued,categoryID)
	VALUES
		(101,'White bread','5 boxes',13,0,5)	
	ON CONFLICT (productid)	
	DO UPDATE SET
	quantityperunit = EXCLUDED.quantityperunit;

INSERT INTO products (productid,productname,quantityperunit,unitprice,discontinued,categoryID)
	VALUES
		(100,'Wheat bread','10 boxes',13,0,5)	
	ON CONFLICT (productid)	
	DO UPDATE SET
	quantityperunit = EXCLUDED.quantityperunit;

select * from products where productid in (100,101,102,103) ;

--6.

MERGE INTO products p
USING (
	VALUES
		(100,'Wheat bread','10',20,1,5),
		(101,'White bread','5 boxes',19.99,0,5),
		(102,'Midnight Mango Fizz','24 - 12 oz bottles',19,0,1),
		(103,'Savory Fire Sauce','12 - 550 ml bottles',10,0,2)	
)AS updated_products (productid,productname,quantityperunit,unitprice,discontinued,categoryid)
ON p.productid=updated_products.productid
WHEN MATCHED AND updated_products.discontinued=1 THEN
	DELETE
WHEN MATCHED AND updated_products.discontinued=0 THEN
	UPDATE SET
	unitprice=updated_products.unitprice,
	discontinued=updated_products.discontinued
WHEN NOT MATCHED AND updated_products.discontinued =0 THEN
	INSERT (productid,productname,quantityperunit,unitprice,discontinued,categoryid)
	VALUES 
	(updated_products.productid,updated_products.productname,updated_products.quantityperunit,updated_products.unitprice,updated_products.discontinued,updated_products.categoryid);
	

--SELECT version();




				












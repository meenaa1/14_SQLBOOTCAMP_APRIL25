-----Update the categoryName From “Beverages” to "Drinks" in the categories table.
update categories SET categoryname= Replace(categoryname, 'Beverages','Drinks')

select * from categories


----Insert into shipper new record (give any values) Delete that new record from shippers table.
select * from shippers
insert into shippers (shipperid, companyname) values (4,'USPS')

------Delete the record 
---a) dropping constraint
alter table categories drop constraint fk_categoryid

---b)updating cascade
alter table categories add constraint fk_categoryid foreign key (categoryID) references categories(categoryID) on Update cascade 
on delete cascade

---c)delete the record
delete from shippers where shipperid=4
select * from shippers


---q3) Update categoryID=1 to categoryID=1001. Make sure related products update their categoryID too. Display the both category and products table to show the cascade


alter table categories drop constraint fk_categoryid

---add constraint and cascade
alter table products drop constraint fk_product_categories
alter table products add constraint fk_product_categories foreign key(categoryid) references categories(categoryid)
on update cascade
on delete cascade

alter table categories add constraint fk_product_categories foreign key(categoryid) references products(categoryid)
on update cascade
on delete cascade



----Update categoryID=1 to categoryID=1001
update categories set categoryid = 1001 where categoryid=1

select * from products
select * from categories

---Delete the categoryID= “3”  from categories. Verify that the corresponding records are deleted automatically from products.
delete from categories where categoryid=3
select * from products
select * from categories

--4)Delete the customer = “VINET”  from customers. Corresponding customers in orders table should be set to null (HINT: Alter the foreign key on orders(customerID) to use ON DELETE SET NULL)
alter table orders drop constraint fk_orders_customer
alter table orders 
add constraint fk_orders_customer 
foreign key(customerid) 
references customers(customerid) 
on update cascade
ON DELETE SET NULL;


---Q5) Insert the following data to Products using UPSERT:

insert into products(productid,productname,quantityperunit,price_in_usd,discontinued,categoryid) values (100,'Wheat bread',1,13,0,3), (101,'White bread',5,13,0,3)
on conflict(productid)
Do update 
set productname = EXCLUDED.productname,
	quantityperunit = EXCLUDED.quantityperunit,
	price_in_usd=EXCLUDED.price_in_usd,
	discontinued=EXCLUDED.discontinued,
	categoryid= ExCLUDED.categoryid

insert into products(productid,productname,quantityperunit,price_in_usd,discontinued,categoryid) values (100,'Wheat Bread',10,13,0,3)
on conflict(productid)
Do update 
set productname = EXCLUDED.productname,
	quantityperunit = EXCLUDED.quantityperunit,
	price_in_usd=EXCLUDED.price_in_usd,
	discontinued=EXCLUDED.discontinued,
	categoryid= ExCLUDED.categoryid

select * from products
alter table products add constraint pk_products Primary key(productid)
---6)Write a MERGE query:--Update the price and discontinued status for from below table ‘updated_products’ only if there are matching products and updated_products .discontinued =0 

--If there are matching products and updated_products .discontinued =1 then delete ---Insert any new products from updated_products that don’t exist in products only if updated_products .discontinued =0.


Merge into products p
using(
	Values
	( 100,'Wheat bread', '10', 20, 1, 3),
	(101, 'White Bread', '5 boxes',19.99,0,3),
	(102,'Midnight Mango Fizz','24 - 12 oz bottles',19,0,1),
	(103,'Savory Fire Sauce','12 - 550 ml bottles',10,0,2)
	) as updated_products(productid,productname,quantityperunit,price_in_usd,discontinued,categoryid)
	
on p.productid = updated_products.productid
when matched and updated_products.discontinued =0 then
update set 
	price_in_usd = updated_products.price_in_usd,
	discontinued = updated_products.discontinued
when matched and updated_products.discontinued =1 then
	delete
when not matched and updated_products.discontinued =0 then
	insert(productid,productname,quantityperunit,price_in_usd,discontinued,categoryid)
	values(updated_products.productid,updated_products.productname,updated_products.quantityperunit,updated_products.price_in_usd,updated_products.discontinued,updated_products.categoryid)

select * from  products


-----7)List all orders with employee full names. (Inner join)
select first_name,last_name,order_id,ship_name from employees inner join orders on employees.employee_id = orders.employee_id

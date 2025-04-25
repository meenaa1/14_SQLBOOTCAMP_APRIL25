--1)Alter Table:

--Add a new column linkedin_profile to employees table to store LinkedIn URLs as varchar.

Alter Table employees
Add column linkedin_profile varchar(50);

--Change the linkedin_profile column data type from VARCHAR to TEXT.
Alter Table employees
Alter column linkedin_profile Type text;

--Add unique, not null constraint to linkedin_profile
--Note:Because the table already has data, we need to fill in a string value for the linkedin_profile column in every row

Alter Table employees
Alter Column linkedin_profile Set Not NULL

Alter Table employees
Add Constraint unique_linkedin_profile Unique (linkedin_profile);

--Drop column linkedin_profile 

Alter Table employees
Drop Column linkedin_profile;

--2)Querying (Select)

--Retrieve the employee name and title of all employees
Select employeename,title
From public.employees

--Find all unique unit prices of products
Select productname, unitprice 
From public.products

--List all customers sorted by company name in ascending order
Select * From public.customers
Order By companyname Asc;

--Display product name and unit price, but rename the unit_price column as price_in_usd

Select productname, unitprice As price_in_usd
From public.products;


--3)Filtering
--Get all customers from Germany.
Select * From public.customers
Where country ='Germany';

select * from public.customers
--Find all customers from France or Spain
Select * From public.customers
Where country ='France' Or 
	  country ='Spain';
	  
	  OR
	  
Select * From public.customers
Where country In('France','Spain');	  
	  
--Retrieve all orders placed in 2014(based on order_date), and either have freight greater than 50 or 
--the shipped date available (i.e., non-NULL)  (Hint: EXTRACT(YEAR FROM order_date))

Select * From public.orders
Where Extract(Year From orderdate)=2014
	  And freight>50
	  Or shippeddate Is Null;
	  
--4)Filtering

--Retrieve the product_id, product_name, and unit_price of products where the unit_price is greater than 15.
Select productid, productname, unitprice
From public.products
Where unitprice > 15;

--List all employees who are located in the USA and have the title "Sales Representative".
Select * From public.employees
Where country= 'USA'And title='Sales Representative';

--Retrieve all products that are not discontinued and priced greater than 30.
Select * From public.products
Where discontinued<1 And unitprice >30;

--5)LIMIT/FETCH

--Retrieve the first 10 orders from the orders table.
Select * From public.orders
Limit 10;

--Retrieve orders starting from the 11th order, fetching 10 rows (i.e., fetch rows 11-20).
Select * From public.orders
OFFSET 11 
LIMIT 10;
 
--6)Filtering (IN, BETWEEN)

--List all customers who are either Sales Representative, Owner
Select * From public.customers
Where contacttitle In ('Sales Representative','Owner')

--Retrieve orders placed between January 1, 2013, and December 31, 2013.
Select * 
From public.orders
Where orderdate Between '2013-01-01' And '2013-12-31';

--7)Filtering
--List all products whose category_id is not 1, 2, or 3.
Select * From public.products
Where categoryid Not In (1, 2, 3);

--Find customers whose company name starts with "A".
Select * From public.customers
Where companyname Like 'A%';


--8)INSERT into orders table:

--Task: Add a new order to the orders table with the following details:
--Order ID: 11078
--Customer ID: ALFKI
--Employee ID: 5
--Order Date: 2025-04-23
--Required Date: 2025-04-30
--Shipped Date: 2025-04-25
--shipperID:2
--Freight: 45.50

Insert Into public.orders (orderid, customerid, employeeid, orderdate, requireddate, shippeddate, shipperid, freight)
Values (11078, 'ALFKI', 5, '2025-04-23', '2025-04-30', '2025-04-25', 2, 45.50);
 
--9)Increase(Update)the unit price of all products in category_id =2 by 10%.
--HINT: unit_price =unit_price * 1.10)

Update public.products
Set unitprice = unitprice * 1.10
Where categoryid = 2;
	  
	  

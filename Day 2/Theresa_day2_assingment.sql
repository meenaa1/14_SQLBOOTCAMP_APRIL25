-- Day 2--
										-- Alter Table--

select * from Employees

          -- Add a new column linkedin_profile to employees table to store LinkedIn URLs as varchar.--
	 
ALTER Table Employees
Add column Linkedin_profile Varchar;  

select *from Employees

      --Change the linkedin_profile column data type from VARCHAR to TEXT.--

ALTER Table Employees
Alter column Linkedin_profile type TEXT;

 --Add unique, not null constraint to linkedin_profile--
	  
Update Employees
set Linkedin_profile = 'www.Linked\ ' || employeeid  -- input values to newly created column linkedin_profile--

select *from Employees

--Adding Constraints--

ALTER TABLE Employees                                
Alter column Linkedin_profile set not null

ALTER TABLE Employees
Add CONSTRAINT U_linked UNIQUE (Linkedin_profile);

-- Drop column linkedin_profile--

ALTER Table Employees
Drop column Linkedin_profile;

                                      --Querying (Select)--

--Retrieve the employee name and title of all employees--

Select EmployeeName,Title from Employees;

 --Find all unique unit prices of products--
 
 select distinct unitprice from products;
 
 --List all customers sorted by company name in ascending order--

 select * from Customers
 Order by CompanyName ASC;
 
 --Display product name and unit price, but rename the unit_price column as price_in_usd--

 Select ProductName, UnitPrice AS price_in_usd from Products;

                            --Filtering--
							
--Get all customers from Germany.--

Select * from Customers
Where Country = 'Germany';
		  
--Find all customers from France or Spain--

SELECT * from Customers
WHERE Country = 'France' OR Country = 'Spain';

/*Retrieve all orders placed in 2014(based on order_date), 
and either have freight greater than 50 or the shipped date available (i.e., non-NULL)  
(Hint: EXTRACT(YEAR FROM order_date))*/

SELECT * FROM orders
 WHERE EXTRACT(YEAR FROM orderdate) = 2014
 	AND (freight > 50 OR shippeddate IS NOT NULL);

                                       --Filtering--
--Retrieve the product_id, product_name, and unit_price of products where the unit_price is greater than 15.--

Select ProductID,ProductName,UnitPrice from Products
where UnitPrice >15;

--List all employees who are located in the USA and have the title "Sales Representative".--

Select * from Employees
Where country='USA' and title= 'Sales Representative'

--Retrieve all products that are not discontinued and priced greater than 30.--

Select * from products
Where discontinued = 0 and unitprice > 30;

                                         --LIMIT/FETCH--
 
 --Retrieve the first 10 orders from the orders table.--
select * from Orders
limit 10
 
 --Retrieve orders starting from the 11th order, fetching 10 rows (i.e., fetch rows 11-20).--

Select * from Orders
offset 10 ROWS
fetch next 10 ROWS only;

                             --Filtering (IN, BETWEEN)--

--List all customers who are either Sales Representative, Owner--

Select * from Customers
WHERE Contacttitle in ('Sales Representative' ,'Owner');


--Retrieve orders placed between January 1, 2013, and December 31, 2013.--

Select* from orders
Where orderDate between '2013-01-01' AND '2013-12-31'

                                --Filtering--

--List all products whose category_id is not 1, 2, or 3.--

Select * from Categories
where categoryId not in (1,2,3)

--Find customers whose company name starts with "A".--

Select * from Customers
where CompanyName Like 'A%';

                         /*INSERT into orders table:
Order ID: 11078
Customer ID: ALFKI
Employee ID: 5
Order Date: 2025-04-23
Required Date: 2025-04-30
Shipped Date: 2025-04-25
shipperID:2
Freight: 45.50*/

---Adding new order to orders table---

INSERT INTO Orders (OrderID, CustomerID, EmployeeID,OrderDate,RequiredDate,ShippedDate,shipperID,Freight)
VALUES (11078,'ALFKI',5, '2025-04-23','2025-04-30','2025-04-25',2,45.50 );

Select * from Orders

/*Increase(Update)  the unit price of all products in category_id =2 by 10%.
(HINT: unit_price =unit_price * 1.10)*/

Select * from Products
where CategoryId=2

update Products 
set UnitPrice=UnitPrice*1.10
where CategoryId=2


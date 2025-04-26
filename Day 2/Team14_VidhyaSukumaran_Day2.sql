 --###################  1.  Alter Table: ###################--

 
----	•  Add a new column linkedin_profile to employees table to store LinkedIn URLs as varchar.

ALTER TABLE employees
ADD COLUMN linkedin_profile VARCHAR;

----	• Change the linkedin_profile column data type from VARCHAR to TEXT.

ALTER TABLE employees
ALTER COLUMN linkedin_profile TYPE TEXT;

----	•  Add unique, not null constraint to linkedin_profile
		----Adding Unique Linkedin profile 
		UPDATE employees
		SET linkedin_profile = 'https://linkedin.com/in/user_' || employeeid  -- assuming you have emp_id
		WHERE linkedin_profile IS NULL;

ALTER TABLE employees
ALTER COLUMN linkedin_profile SET NOT NULL,
ADD CONSTRAINT unique_linkedin_profile UNIQUE (linkedin_profile);

----	Drop column linkedin_profile

ALTER TABLE employees
DROP COLUMN linkedin_profile;

----Checking table after every alteration 

SELECT * FROM EMPLOYEES



 --###################  2. Querying (Select) ###################--

 ----	Retrieve the first name, last name, and title of all employees

 SELECT employeename, title
FROM employees;

 ----	Find all unique unit prices of products

 SELECT DISTINCT unitprice
FROM products;

 ----	List all customers sorted by company name in ascending order

SELECT *
FROM customers
ORDER BY companyname ASC;

 
 ----	Display product name and unit price, but rename the unit_price column as price_in_usd

 SELECT productname, unitprice AS price_in_usd
FROM products;



  --###################  3.     Filtering  ###################--


 ---- 	Get all customers from Germany.

 SELECT *
FROM customers
WHERE country = 'Germany';

 ---- 	Find all customers from France or Spain

 SELECT *
FROM customers
WHERE country IN ('France', 'Spain') 
ORDER BY country ASC ;

 ---- 	
/*Retrieve all orders placed in 2014(based on order_date), and either have freight greater than 
 50 or the shipped date available (i.e., non-NULL)  (Hint: EXTRACT(YEAR FROM order_date))*/

SELECT *
FROM orders
WHERE EXTRACT(YEAR FROM orderdate) = 2014
	AND (freight > 50 OR shippeddate IS NOT NULL);


  --###################  4.     Filtering  ###################--

 ---- 	Retrieve the product_id, product_name, and unit_price of products where the unit_price is greater than 15.

 SELECT productid, productname, unitprice
FROM products
WHERE unitprice > 15 
order by unitprice asc;

 ---- 	List all employees who are located in the USA and have the title "Sales Representative".

SELECT *
FROM employees
WHERE country = 'USA' 
  AND title = 'Sales Representative';

 
 ---- 	Retrieve all products that are not discontinued and priced greater than 30.

SELECT *
FROM products
WHERE discontinued = FALSE
	AND unitprice > 30 order by unitprice asc;
  

    --###################  5.       LIMIT/FETCH  ###################--

---- 	 Retrieve the first 10 orders from the orders table.

SELECT *
FROM orders
LIMIT 10;

 ---- 	Retrieve orders starting from the 11th order, fetching 10 rows (i.e., fetch rows 11-20).

SELECT *
FROM orders
LIMIT 10 OFFSET 10;


    --###################  6.      Filtering (IN, BETWEEN)  ###################--

 ---- 	List all customers who are either Sales Representative, Owner

SELECT *
FROM customers
WHERE contactTitle IN ('Sales Representative', 'Owner')
order by contactTitle asc ;


 ---- 	Retrieve orders placed between January 1, 2013, and December 31, 2013.


SELECT *
FROM orders
WHERE orderDate BETWEEN '2013-01-01' AND '2013-12-31'
order by orderdate asc ;

    --###################  7.      Filtering  ###################--

 ---- 	List all products whose category_id is not 1, 2, or 3.

SELECT *
FROM products
WHERE categoryID NOT IN (1, 2, 3)
order by categoryID asc ;

 ---- 	Find customers whose company name starts with "A".

 SELECT *
FROM customers
WHERE companyName LIKE 'A%'
order by companyname asc ;

    --###################  8.        INSERT into orders table:  ###################--

 ---- 	 
 /*Task: Add a new order to the orders table with the following details:
Order ID: 11078
Customer ID: ALFKI
Employee ID: 5
Order Date: 2025-04-23
Required Date: 2025-04-30
Shipped Date: 2025-04-25
shipperID:2
Freight: 45.50 */

select count(*) from 
orders where customerID = 'ALFKI'; -- there were 6 rows before insert , after it increased to 7 / cross checking 

INSERT INTO orders (orderID, customerID, employeeID, orderDate, requiredDate, shippedDate, shipperID, freight)
VALUES (11078, 'ALFKI', 5, '2025-04-23', '2025-04-30', '2025-04-25', 2, 45.50);


    --###################  9.        UPDATE  ###################--

 ---- 	 
 /*	Increase(Update)  the unit price of all products in category_id =2 by 10%.
(HINT: unit_price =unit_price * 1.10)*/

select * from
products
where categoryID = 2
order by unitPrice asc ;

UPDATE products
SET unitPrice = unitPrice * 1.10
WHERE categoryID = 2;


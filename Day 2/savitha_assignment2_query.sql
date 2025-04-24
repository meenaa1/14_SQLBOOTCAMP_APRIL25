--1. Alter Table:
 
--Add a new column linkedin_profile to employees table to store LinkedIn URLs as varchar.
ALTER TABLE employees
ADD COLUMN linkedin_profile VARCHAR;

--Change the linkedin_profile column data type from VARCHAR to TEXT.

ALTER TABLE employees
ALTER COLUMN linkedin_profile TYPE text

--Add unique, not null constraint to linkedin_profile
ALTER TABLE employees 
ALTER COLUMN linkedin_profile SET NOT NULL

ALTER TABLE employees 
ADD CONSTRAINT unique_linkedin_profile UNIQUE(linkedin_profile);

--Drop column linkedin_profile

ALTER TABLE employees 
DROP column linkedin_profile;

--2. Querying (Select)

--Retrieve the first name, last name, and title of all employees  (no first name and last name in column so , i am retriving id, name and title )

SELECT employeeid,employeename,title 
FROM employees

-- Find all unique unit prices of products

SELECT DISTINCT unitprice
FROM products

--List all customers sorted by company name in ascending order


select * FROM customers
ORDER BY companyname ASC

--Display product name and unit price, but rename the unit_price column as price_in_usd

select productname, unitprice as price_in_usd
from products

--3.filtering 

--Get all customers from Germany.

select * 
from customers
where country = 'Germany'

--Find all customers from France or Spain

select *
from customers 
where country in ('France','Spain')


/*Retrieve all orders placed in 1997 (based on order_date), 
and either have freight greater than 50 or the shipped date available (i.e., non-NULL)  
(Hint: EXTRACT(YEAR FROM order_date))*/

SELECT * 
FROM orders
WHERE EXTRACT(YEAR FROM orderdate) = 1997
  AND (fright > 50 OR shippeddate IS NOT NULL);


--Filtering

--Retrieve the product_id, product_name, and unit_price of products where the unit_price is greater than 15.

select productid,productname,unitprice 
from products 
where unitprice > '15'

--List all employees who are located in the USA and have the title "Sales Representative".

select *
from employees
where county = 'USA' and title  = 'Sales Representative'


--Retrieve all products that are not discontinued and priced greater than 30.

select * 
from products
where discontinued = 'false' and unitprice > '30'

--5) LIMIT/FETCH

--Retrieve the first 10 orders from the orders table.

select *
from orders
limit 10

-- Retrieve orders starting from the 11th order, fetching 10 rows (i.e., fetch rows 11-20).

select *
from orders
offset 10 
limit 10

--6. Filtering (IN, BETWEEN)

--List all customers who are either Sales Representative, Owner

select * 
from customers
where contacttitle in ('Sales Representative','Owner')


--Retrieve orders placed between January 1, 2013, and December 31, 2013.


select *
from orders
where orderdate between '2013-01-01' and  '2013-12-31'

--7.   Filtering

--List all products whose category_id is not 1, 2, or 3.

select *
from categories
where categoryid not in (1,2,3)

 --Find customers whose company name starts with "A".

 SELECT * 
FROM customers
WHERE companyname LIKE 'A%';

--8) INSERT into orders table:

INSERT INTO orders (
    orderid, 
    customerid, 
    employeeid, 
    orderdate, 
    requireddate, 
    shippeddate, 
    shipperid, 
    fright
)
VALUES (
    11078, 
    'ALFKI', 
    5, 
    '2025-04-23', 
    '2025-04-30', 
    '2025-04-25', 
    2, 
    45.50
);


--9) Increase(Update)  the unit price of all products in category_id =2 by 10%.

update products
set unitprice = unitprice * 1.10
where categoryid = '2'
















 








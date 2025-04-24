--***** 1.Altering Table employees*****--
--Adding new Column "linkedin_profile"
ALTER TABLE employees
ADD COLUMN linkedin_profile VARCHAR(250);
select*from employees

--Change the column datatype to TEXT
ALTER TABLE employees
ALTER COLUMN linkedin_profile TYPE TEXT;
-- Add UNIQUE and NOT NULL constraints to 'linkedin_profile'
ALTER TABLE employees
ADD CONSTRAINT unique_linkedin_profile UNIQUE (linkedin_profile);
--  Ensure no NULLs before setting NOT NULL
--To attain this first we need to drop the column created and add the column
ALTER TABLE employees
DROP COLUMN linkedin_profile;

ALTER TABLE employees
ADD COLUMN linkedin_profile TEXT
GENERATED ALWAYS AS ('https://www.linkedin.com/in/user_' || 'employeeID') STORED;
 --Add NOT NULL constraint
ALTER TABLE employees
ALTER COLUMN linkedin_profile SET NOT NULL;
-- Drop the 'linkedin_profile' column
ALTER TABLE employees
DROP COLUMN linkedin_profile;

--****2.Querying(Select)****--
-- Retrieve the first name, last name, and title of all employees--
SELECT split_part("employeeName",' ',1) AS "first name",
	split_part("employeeName",' ',2) AS "last name" ,
	title
	FROM employees;

--Retrieve the employee name and title of all employees--
SELECT "employeeName",title 
FROM employees

--Find all unique unit prices of products--
select*from products
SELECT DISTINCT "unitPrice"
FROM products;

-- List all customers sorted by company name in ascending order--
SELECT *
FROM customers
ORDER BY "companyName" ASC;

-- Display product name and unit price, but rename the unit_price column as price_in_usd--
SELECT "productName", "unitPrice" AS price_in_usd
FROM products;

--****3.Filtering****--
--Get all customers from Germany--
select *
FROM customers
WHERE country ='Germany'

--Find all customers from France or Spain--
SELECT *
FROM customers
WHERE country IN ('France', 'Spain');

--Retrieve all orders placed in 1997, and either have freight >50,or a non-Null shipped date--
SELECT *
FROM orders
WHERE EXTRACT(YEAR FROM "orderDate") = 2014
  AND (freight > 50 OR "shippedDate" IS NOT NULL);

--****4.Filtering****--
--Retrieve the product_id, product_name, and unit_price of products where the unit_price is greater than 15--
SELECT "productID", "productName", "unitPrice"
FROM products
WHERE "unitPrice" > 15;

--List all employees who are located in the USA and have the title "Sales Representative"--
SELECT *
FROM employees
WHERE country = 'USA'
  AND title = 'Sales Representative';

--Retrieve all products that are not discontinued and priced greater than 30--
SELECT *
FROM products
WHERE discontinued = 0
  AND "unitPrice" > 30;

--****5.Limit/Fetch****--
-- Retrieve the first 10 orders from the orders table--
SELECT *
FROM orders
ORDER BY "orderID"
LIMIT 10;

 --Retrieve orders starting from the 11th order, fetching 10 rows (i.e., fetch rows 11-20)--
SELECT *
FROM orders
ORDER BY "orderID"
OFFSET 10
LIMIT 10;

--****6.Filtering (IN, BETWEEN)****--
--List all customers who are either Sales Representative, Owner--
SELECT *
FROM customers
WHERE "contactTitle" IN ('Sales Representative', 'Owner');

--Retrieve orders placed between January 1, 2013, and December 31, 2013--
SELECT *
FROM orders
WHERE "orderDate" BETWEEN '2013-01-01' AND '2013-12-31';

--****7.Filtering****--
--List all products whose category_id is not 1, 2, or 3--
SELECT *
FROM products
WHERE "categoryID" NOT IN (1, 2, 3);

--Find customers whose company name starts with "A"--
SELECT *
FROM customers
WHERE "companyName" LIKE 'A%';

--****8.INSERT into orders table****--
--Adding new order in orders table--
INSERT INTO orders (
  "orderID", "customerID", "employeeID", "orderDate",
  "requiredDate", "shippedDate", "shipperID", "freight"
)
VALUES (
  11078, 'ALFKI', 5, '2025-04-23',
  '2025-04-30', '2025-04-25', 2, 45.50
);

select * from orders

--****9.Increase(Update)  the unit price of all products in category_id =2 by 10%  ****--

UPDATE products
SET "unitPrice" = "unitPrice" * 1.10
WHERE "categoryID" = 2;
select*from products

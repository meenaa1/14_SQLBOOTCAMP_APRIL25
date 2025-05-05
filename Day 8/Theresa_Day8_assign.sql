------------------------DAY 8-------------
/*1.Create view vw_updatable_products (use same query whatever I used in the training)
Try updating view with below query and see if the product table also gets updated.
Update query:UPDATE updatable_products SET unit_price = unit_price * 1.1 WHERE units_in_stock < 10;*/

CREATE VIEW vw_updatable_products AS        -----creating the view in products table----
SELECT 
	product_id, product_name, unit_price, units_in_stock,discontinued
FROM products
WHERE discontinued = 0
WITH CHECK OPTION;

UPDATE vw_updatable_products            ---------updating the view---
SET unit_price = unit_price * 1.1
WHERE units_in_stock < 10;

SELECT * FROM vw_updatable_products

/*2.Transaction:
Update the product price for products by 10% in category id=1
Try COMMIT and ROLLBACK and observe what happens.*/

SELECT * FROM products WHERE category_id = 1;

BEGIN;

UPDATE products 
SET unit_price = unit_price * 1.10           -------------updated the price------
WHERE category_id = 1;

COMMIT;

ROLLBACK;

SELECT * FROM products WHERE category_id = 1;

/*DO $$                    ----------begin a transaction---------
Begin
IF EXISTS(
	SELECT 1 
	FROM products
	WHERE category_id = 1 And unit_price > 40
	) THEN
		RAISE EXCEPTION 'Some prices exceed 40';
	ELSE
		RAISE NOTICE 'Price update sucessful';
	END IF;
END $$;*/

/*3.Create a regular view which will have below details (Need to do joins):
Employee_id,Employee_full_name,Title,Territory_id,territory_description,region_description */   

CREATE VIEW Employee_infoView AS
SELECT 
    e.Employee_id,
	e.first_name || ' ' || e.last_name As Employee_full_name,
	e.Title,
	t.Territory_id,
	t.territory_description,
	r.region_description
FROM employees e
JOIN employee_territories et ON e.employee_id = et.employee_id
JOIN territories t ON et.territory_id = t.territory_id
JOIN region r ON t.region_id = r.region_id;

Select * from Employee_infoView
 
--------4.Create a recursive CTE based on Employee Hierarchy---------
Select * from employees

WITH RECURSIVE Employee_Hierarchy AS (
    -- Base case: Select top-level employees (e.g., those without managers)
    SELECT 
	employee_id, 
	e.first_name || ' ' || e.last_name As Employee_full_name, 
	title,
	reports_to, 
	1 AS level
    FROM employees e
    WHERE reports_to IS NULL 
    UNION ALL
    -- Recursive case: Join with itself to find subordinates
    SELECT e.employee_id, 
	e.first_name || ' ' || e.last_name As Employee_full_name, 
	e.title,
	e.reports_to, 
	eh.level + 1
    FROM employees e
    JOIN Employee_Hierarchy eh ON e.reports_to = eh.employee_id)
SELECT * FROM Employee_Hierarchy;

SELECT * FROM Employee_Hierarchy  
order by level 1  


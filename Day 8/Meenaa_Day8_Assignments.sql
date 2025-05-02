--****1.Create view vw_updatable_products ****--

CREATE VIEW vw_updatable_products AS
SELECT 
	product_id, 
	product_name, 
	unit_price, 
	units_in_stock,
	discontinued
FROM products
WHERE discontinued = 0
WITH CHECK OPTION;

UPDATE vw_updatable_products
SET unit_price = unit_price * 1.1
WHERE units_in_stock < 10;

SELECT * FROM products WHERE units_in_stock < 10;

SELECT * FROM vw_updatable_products

--****2.Transaction****--
--Update the product price for products by 10% in category id=1. Try COMMIT and ROLLBACK and observe what happens.
-- Start the transaction

BEGIN TRANSACTION;

--Check what has changed (before committing)
SELECT product_id, product_name, unit_price
FROM products
WHERE category_id = 1;

-- Update prices by 10% for products in category_id = 1
UPDATE products
SET unit_price = unit_price * 1.1
WHERE category_id = 1;

COMMIT

ROLLBACK

--3.Create a regular view which will have below details (Need to do joins):

CREATE VIEW vw_employee_territories AS
SELECT 
    e.employee_id,
    e.first_name || ' ' || e.last_name AS employee_full_name,  
    e.title,
    t.territory_id,
    t.territory_description,
    r.region_description
FROM employees e
JOIN employee_territories et ON e.employee_id = et.employee_id
JOIN territories t ON et.territory_id = t.territory_id
JOIN region r ON t.region_id = r.region_id;

SELECT * FROM vw_employee_territories

--****4.Create a recursive CTE based on Employee Hierarchy****--

CREATE VIEW vw_employeehierarchy AS
WITH RECURSIVE employeehierarchy AS (
    -- Anchor: top-level employees (no manager)
    SELECT 
        employee_id,
        first_name || ' ' || last_name AS employee_name,
        title,
        reports_to,
        0 AS level
    FROM employees
    WHERE reports_to IS NULL

    UNION ALL

    -- Recursive: direct reports
    SELECT 
        e.employee_id,
        e.first_name || ' ' || e.last_name AS employee_name,
        e.title,
        e.reports_to,
        eh.level + 1
    FROM employees e
    JOIN employeehierarchy eh ON e.reports_to = eh.employee_id)
SELECT * FROM employeehierarchy;

SELECT * FROM vw_employeehierarchy ORDER BY level, employee_id;

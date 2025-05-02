--Day 8
 
--1.Create view vw_updatable_products (use same query whatever I used in the training)
--Try updating view with below query and see if the product table also gets updated.
--Update query:
--UPDATE updatable_products SET unit_price = unit_price * 1.1 WHERE units_in_stock < 10;
 
Create View vw_updatable_products As
Select product_id,
	   product_name,
	   unit_price,
	   units_in_stock,
	   discontinued
From products
Where discontinued = 0;

Select * 
From vw_updatable_products 
Where units_in_stock < 10;

Update vw_updatable_products 
Set unit_price = unit_price * 1.1 
Where units_in_stock < 10;

Select *
From products 
Where units_in_stock < 10 
	  and  discontinued = 0;

 
 
--2.Transaction:
--Update the product price for products by 10% in category id=1
--Try COMMIT and ROLLBACK and observe what happens.


			-------Update unit price 10%-----
Begin;

Update public.products
Set unit_price=unit_price *1.10
Where category_id=2

Commit;

Rollback;

select * from public.products
Where category_id=2

--3.Create a regular view which will have below details (Need to do joins):
--Employee_id,
--Employee_full_name,
--Title,
--Territory_id,-employeeid
--territory_description,territoryId
--region_description-region id


Create View employee_View As
Select
    emp.employee_id,
    emp.first_name||' '||emp.last_name As employee_Name,
    emp.title,
    et.territory_id,
    t.territory_description,
    rgn.region_description
From employees emp
Join employee_territories et
On emp.employee_id = et.employee_id
Join territories t 
On et.territory_id = t.territory_id
Join region rgn
On t.region_id = rgn.region_id;
 
--4.Create a recursive CTE based on Employee Hierarchy

With recursive cte_employee_hierarchy As (
    -- Anchor member: top-level employees
    SELECT
        employee_id,
        first_name,
	    last_name,
        title,
        reports_to,
        0 As level
    From employees emp
    Where reports_to Is null

    Union All

    -- Recursive member: employees who report to others
    Select
        emp.employee_id,
        emp.first_name,
		emp.last_name,
        emp.title,
        emp.reports_to,
        eh.level+1 
    From employees emp
    Join cte_employee_hierarchy eh
	On eh.employee_id = emp.reports_to
)
Select 
	level,
	employee_id,
	first_name||' '||last_name As employee_name	
From cte_employee_hierarchy
Order By level, employee_id;





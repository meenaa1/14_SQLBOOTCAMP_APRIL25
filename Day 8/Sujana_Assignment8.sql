/*1.Create view vw_updatable_products (use same query whatever I used in the training)
Try updating view with below query and see if the product table also gets updated.
Update query:
UPDATE updatable_products SET unit_price = unit_price * 1.1 WHERE units_in_stock < 10;*/

create view vw_updatable_products as
select product_id,
	product_name,
	unit_price,
	units_in_stock,
	discontinued
from products
where discontinued = 0;

select * from vw_updatable_products WHERE units_in_stock < 10;

UPDATE vw_updatable_products SET unit_price = unit_price * 1.1 WHERE units_in_stock < 10;

select * from products WHERE units_in_stock < 10 and  discontinued = 0;

/*2.Transaction:
Update the product price for products by 10% in category id=1
Try COMMIT and ROLLBACK and observe what happens.*/
select * from products where category_id=1;

BEGIN;
	update products
	set unit_price = unit_price * 1.10
	where category_id=1;

ROLLBACK;

commit;

/*3. Create a regular view which will have below details (Need to do joins):
Employee_id,
Employee_full_name,
Title,
Territory_id,
territory_description,
region_description*/

create view vw_employee_territory_region as
select e.Employee_id,
		e.first_name || '  ' || e.last_name as Employee_full_name,
		e.title,
		t.territory_id,
		t.territory_description,
		r.region_description
from employees e 
	join employee_territories et on e.employee_id = et.employee_id
	join territories t on t.territory_id = et.territory_id
	join region r on r.region_id = t.region_id;

select * from vw_employee_territory_region;

/*4.Create a recursive CTE based on Employee Hierarchy*/

with recursive cte_Employee_Hierarchy as (

select 	employee_id,
		first_name, 
		last_name, 
		reports_to,
		0 as level
from employees e
where reports_to is null

UNION ALL

select 
	e.employee_id,
	e.first_name,
	e.last_name,
	e.reports_to,
	eh.level + 1
from 
employees e 
join 
cte_Employee_Hierarchy eh	
on 
eh.employee_id = e.reports_to
)

select 
level,
employee_id,
first_name || ' ' || last_name as Employee_name
from 
cte_Employee_Hierarchy
order by 
level,employee_id;


 

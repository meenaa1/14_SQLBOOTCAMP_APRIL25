--1.Categorize products by stock status
select product_name,
case
	when units_in_stock=0 then 'Out of Stock'
	when units_in_stock<20 then 'Low Stock'
else
	'High Stock'
end as Stock_category
from products
order by product_name


--2.Find All Products in Beverages Category
select product_name,unit_price 
from products 
where category_id =
(select category_id from categories where category_name='Beverages' group by category_id)

or 

select product_name,unit_price from products P where exists
(select category_id from categories C where C.category_name='Beverages' and P.category_id=C.category_id)	


--3. Find Orders by Employee with Most Sales
select 	order_id, order_date,freight,employee_id from orders
where employee_id=
(select employee_id from orders 
group by employee_id
order by count(employee_id) desc
limit 1)

--4.ALL
select * from orders where ship_country !='USA' and freight>all
(select freight from orders where ship_country ='USA')

--ANY
select * from orders where ship_country !='USA' and freight>any
(select freight from orders where ship_country ='USA')
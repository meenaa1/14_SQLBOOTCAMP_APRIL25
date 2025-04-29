--1.GROUP BY with WHERE - Orders by Year and Quarter
select EXTRACT('year' FROM order_date) as order_year,EXTRACT(quarter FROM order_date) as quarter,
count(order_id) as order_count,avg(freight) 
from orders where freight>100 group by EXTRACT('year' FROM order_date),EXTRACT(quarter FROM order_date)

--2.GROUP BY with HAVING - High Volume Ship Regions
select ship_region,count(*) as no_of_orders,min(freight),max(freight)
from orders group by ship_region having count(*)>=5

--3. Get all title designations across employees and customers ( Try UNION & UNION ALL)
--UNION
select contact_title from customers 
union 
select title from employees
order by contact_title

--UNION ALL
select contact_title from customers 
union all
select title from employees

--4.Find categories that have both discontinued and in-stock products
select category_id from products where units_in_stock>0
intersect 
select category_id from products where discontinued=1

--5. Find orders that have no discounted items (Display the  order_id, EXCEPT)
select order_id from order_details
except
select order_id from order_details where discount>0

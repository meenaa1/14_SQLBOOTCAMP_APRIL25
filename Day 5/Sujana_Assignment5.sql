/*1.GROUP BY with WHERE - Orders by Year and Quarter
Display, order year, quarter, order count, avg freight cost only for those orders where freight cost > 100*/
select 
extract(year from order_date) as "order_year", 
extract(quarter from order_date )as "quarter",
count(*) as "order_count", avg(freight) as "avg_freight"
from orders where freight >100
group by order_year,quarter ;


/*2.GROUP BY with HAVING - High Volume Ship Regions
Display, ship region, no of orders in each region, min and max freight cost
 Filter regions where no of orders >= 5*/
select  ship_region,count(*), 
min(freight),
max(freight)
from orders 
group by ship_region 
having count(*)>=5;

/*3.Get all title designations across employees and customers ( Try UNION & UNION ALL)*/

select title from employees 
UNION
select contact_title from customers ;

select title from employees 
UNION ALL
select contact_title from customers ;


/*4.Find categories that have both discontinued and in-stock products
(Display category_id, instock means units_in_stock > 0, Intersect)*/

select category_id from products where discontinued = 1

INTERSECT

select category_id from products where units_in_stock > 0
order by category_id;

--5.Find orders that have no discounted items (Display the  order_id, EXCEPT)

select order_id from order_details
EXCEPT
select order_id from order_details where discount>0;



 




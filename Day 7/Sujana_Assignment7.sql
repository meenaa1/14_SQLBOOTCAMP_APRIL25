/*1.Rank employees by their total sales
(Total sales = Total no of orders handled, JOIN employees and orders table)*/

select e.employee_id,
count(o.order_id) as total_sales,
rank() over (order by count(o.order_id) desc) as rank_by_sales
from employees e 
join orders o
on e.employee_id=o.employee_id
group by e.employee_id;


/*2.Compare current order's freight with previous and next order for each customer.
(Display order_id,  customer_id,  order_date,  freight,
Use lead(freight) and lag(freight).*/

select order_id,
customer_id,
order_date,
freight,
lag(freight,1,freight) over (partition by customer_id order by order_date ) as previous_freight,
lead(freight,1,freight) over (partition by customer_id order by order_date ) as next_freight
from 
orders;

/*3.Show products and their price categories, product count in each category, avg price:
        	(HINT:
·  	Create a CTE which should have price_category definition:
        	WHEN unit_price < 20 THEN 'Low Price'
            WHEN unit_price < 50 THEN 'Medium Price'
            ELSE 'High Price'
·  	In the main query display: price_category,  product_count in each price_category, 
ROUND(AVG(unit_price)::numeric, 2) as avg_price)*/

with cte_price_category as
(select unit_price, 
case 
	WHEN unit_price < 20 THEN 'Low Price'
    WHEN unit_price < 50 THEN 'Medium Price'
    ELSE 'High Price' 
	end as price_category 
from products 
)

select 	price_category,
count(*) as product_count ,
ROUND(AVG(unit_price)::numeric, 2) as avg_price
from cte_price_category
group by price_category;

			

 


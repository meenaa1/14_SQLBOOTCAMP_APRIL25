--1.Rank employees by their total sales
select E.employee_id,E.first_name || ' ' || E.last_name as employee_name,
count(O.order_id) as total_sales,
rank() over (order by count(E.employee_id)) as sales_rank
from employees E
join orders O on E.employee_id = O.employee_id
group by E.employee_id
order by sales_rank;

/*2.Compare current order's freight with previous and next order for each customer.
Use lead(freight) and lag(freight).*/
select order_id,customer_id,order_date,freight,
lag(freight) over(partition by customer_id order by order_date) as previous_freight,
lead(freight) over(partition by customer_id order by order_date) as next_freight
from orders

--3.Show products and their price categories, product count in each category, avg price
with product_price_category as
(select product_id,category_id,product_name,unit_price,
case
when unit_price < 20 then 'Low Price'
when unit_price < 50 then 'Medium Price'
else 'High Price' end as price_category
from products)
select price_category,
    count(product_id) as product_count,
    ROUND(avg(unit_price)::numeric, 2) AS avg_price
from product_price_category
group by price_category

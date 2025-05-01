-----------Day 7-------

/*1.Rank employees by their total sales
(Total sales = Total no of orders handled, JOIN employees and orders table)*/

Select * from orders

Select o.employee_id,e.first_name,e.last_name,count(order_id) as Total_sales,
     RANK() OVER (
     ORDER BY count(order_id)  desc 
) Sales_rank
from orders o
inner join employees e on o.employee_id=e.employee_id
group by o.employee_id,e.first_name,e.last_name
 
/*2.Compare current order's freight with previous and next order for each customer.
(Display order_id,  customer_id,  order_date,  freight,
Use lead(freight) and lag(freight).*/
------Lead------

SELECT
  order_id,customer_id,order_date,freight,
  LEAD(freight, 1) OVER (
    ORDER BY
      customer_id
  ) next_freight
FROM
  orders

------Lag-------

SELECT
  order_id,customer_id,order_date,freight,
  LAG(freight, 1) OVER (
    ORDER BY
      customer_id
  ) previous
FROM
  orders

/*3.Show products and their price categories, product count in each category, avg price:
(HINT:1.Create a CTE which should have price_category definition:
        	WHEN unit_price < 20 THEN 'Low Price'
            WHEN unit_price < 50 THEN 'Medium Price'
            ELSE 'High Price'
2.In the main query display: price_category,product_count in each price_category
ROUND(AVG(unit_price)::numeric, 2) as avg_price)*/
 
 WITH unit_price_category AS (
    SELECT
        product_id,
        product_name,
        category_id,
        unit_price,
        CASE
            WHEN unit_price < 20 THEN 'Low Price'
            WHEN unit_price < 50 THEN 'Medium Price'
            ELSE 'High Price'
        END AS price_category
    FROM products
)
SELECT
		price_category,
		count(price_category) as product_count,
		ROUND(AVG(unit_price)::numeric, 2) as avg_price
FROM unit_price_category
group by price_category
 

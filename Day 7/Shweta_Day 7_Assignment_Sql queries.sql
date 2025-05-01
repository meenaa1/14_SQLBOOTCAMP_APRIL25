--Day 7
--1.Rank employees by their total sales
--(Total sales = Total no of orders handled, JOIN employees and orders table)

Select emp.employee_id,
 	  Count(ord.order_id) As total_sales,
Rank()Over(Order By Count(ord.order_id) Desc) As Sales_rank
From employees emp
Join orders ord
On emp.employee_id=ord.employee_id
Group By emp.employee_id
Order By total_sales Desc;


--2.Compare current order's freight with previous and next order for each customer.
--(Display order_id,  customer_id,  order_date,  freight,
--Use lead(freight) and lag(freight).

Select customer_id,
	   order_id,
	   order_date,
	   freight,
Lag(freight) Over (Partition By customer_id Order By order_date) AS previous_freight,	   
Lead (freight)Over(Partition By customer_id Order By order_date)As next_freight
From public.orders
Order By 1,2;

--3.Show products and their price categories, product count in each category, avg price:
--(HINT:
--  Create a CTE which should have price_category definition:
--  WHEN unit_price < 20 THEN 'Low Price'
--  WHEN unit_price < 50 THEN 'Medium Price'
--  ELSE 'High Price'
--	In the main query display: price_category,  product_count in each price_category,  ROUND(AVG(unit_price)::numeric, 2) as avg_price)


With price_category As
(Select product_id,
 		product_name,
 		unit_price,
		Case 
 			When unit_price < 20 THEN 'Low Price'
			WHEN unit_price < 50 THEN 'Medium Price'
 			Else 'High Price'
			End As price_category
From products)

Select 
    price_category,
    Count(*) As product_count,
    Round(Cast(Avg(unit_price) As numeric), 2) As avg_price
From price_category
Group By 1
Order By 1;

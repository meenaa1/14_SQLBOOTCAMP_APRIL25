--Day 5
 
--1.GROUP BY with WHERE - Orders by Year and Quarter
--Display, order year, quarter, order count, avg freight cost only for those orders where freight cost > 100

Select Extract(Year From order_date) As orderYear,
	   Extract(Quarter From order_date) AS orderQuarter,
	   Count(order_id) As totalOrder,
	   Avg(freight) As avgFreight
From public.orders
Where freight >100
Group By 1,2
Order By 1,2

--2.GROUP BY with HAVING - High Volume Ship Regions
--Display, ship region, no of orders in each region, min and max freight cost
--Filter regions where no of orders >= 5

Select ship_region,
	   Count(order_id) As orders,
	   Min(freight)As minFreight_Cost,
	   Max (freight)As maxFreight_Cost
From public.orders
Group BY 1
Having Count(order_id)>=5

Select order_id,ship_region, freight from public.orders

--3.Get all title designations across employees and customers ( Try UNION & UNION ALL)

--By Union-returns only unique titles (no duplicates).
Select title As designation
From public.employees
Union 
Select contact_title As designation
From public.customers;

--By Union All-returns all titles, including duplicates.
Select title As designation
From public.employees
Union All
Select contact_title As designation
From public.customers;

Select distinct title from public.employees
Select distinct contact_title from public.customers

--4.Find categories that have both discontinued and in-stock products
--(Display category_id, instock means units_in_stock > 0, Intersect)

Select category_id
From public.products
Where discontinued = 1 
Intersect
Select category_id 
From public.products
Where units_in_stock > 0 
------------------------------------------cheking the difference
Select category_id,
	   units_in_stock As in_Stock
From public.products
Where discontinued=1
      And units_in_stock>0; 

--5.Find orders that have no discounted items (Display the  order_id, EXCEPT)
 
Select order_id
From public.order_details
Except 
Select order_id
From public.order_details
Where discount=0

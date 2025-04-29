               -------------Day 5-------------
/*1.GROUP BY with WHERE - Orders by Year and Quarter
Display, order year, quarter, order count, avg freight cost only for those orders where freight cost > 100*/

	Select   
	DATE_PART('year',order_date) AS order_year, 
	DATE_PART('Quarter',order_date) AS order_Quarter,
	COUNT(order_id) as order_count,
	AVG(freight) as Average
	from orders
	where freight >100
	group by DATE_PART('year',order_date), 
	DATE_PART('Quarter',order_date) 

/*2.GROUP BY with HAVING -High Volume Ship Regions.Display, ship region, no of orders in each region, 
min and max freight cost Filter regions where no of orders >= 5*/
	select 
	sum(order_id) as num_of_orders,
	min(freight) as minimun,
	max(freight) as maximum
	from orders
	group by ship_via 
	having sum(order_id) >=5 

	Select * from orders

-----3.Get all title designations across employees and customers ( Try UNION & UNION ALL)---
 -------union-------
	Select company_name as customer, contact_title as title
	From customers
	UNION
	SELECT first_name || ' ' || last_name as employee_name, title
	FROM employees
----------union all-------
	Select company_name as customer_name, contact_title as title
	From customers
	UNION All
	SELECT first_name || ' ' || last_name as employee_name, title
	FROM employees

/*4.Find categories that have both discontinued and in-stock products
(Display category_id, instock means units_in_stock > 0, Intersect)*/

	Select category_id From products where units_in_stock > 0
	Intersect
	Select category_id From products where discontinued = 1  

-----5.Find orders that have no discounted items (Display the  order_id, EXCEPT)

	Select order_id from order_details
	Except
	select order_id from order_details where discount >0
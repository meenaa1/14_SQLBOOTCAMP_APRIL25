-------------Day 6----------
/*1.Categorize products by stock status
(Display product_name, a new column stock_status whose values are based on below condition
 units_in_stock = 0  is 'Out of Stock',units._in_stock < 20  is 'Low Stock')*/

Select 
    product_name,
    Case
        When units_in_stock = 0 then 'Out of Stock'
        When units_in_stock < 20 then 'Low Stock'
        Else 'In Stock'
    End as stock_status
From products;

----2.Find All Products in Beverages Category(Subquery, Display product_name,unitprice)--

SELECT product_name,unit_price 
	FROM products 
	WHERE category_id = (
	SELECT category_id FROM categories WHERE category_name = 'Beverages');

Select * from products
Select * from categories
 
/*3.Find Orders by Employee with Most Sales(Display order_id,order_date,freight,employee_id.
Employee with Most Sales = Get the total no.of of orders for each employee then order by DESC 
and limit 1. Use Subquery)*/

Select order_id, order_date, freight, employee_id
from orders
Where employee_id = (
	Select employee_id 
    from (
        Select employee_id, COUNT(order_id) AS total_orders
        from orders
        group by employee_id
        order by total_orders desc
        limit 1 
		) As Top_Employee
);

/*4.Find orders where for country!= ‘USA’ with freight costs higher than any order from USA. 
(Subquery,Try with ANY,ALL operators)*/

----Any operator---

Select order_id,customer_id,freight,ship_country
From orders
Where ship_country != 'USA'
and freight > any (
    select freight 
    from orders 
    where ship_country = 'USA'
);

----All operator---
Select * from orders

Select order_id,customer_id,ship_country,freight
From orders
Where ship_country != 'USA'
and freight > all (
    select freight 
    from orders 
    where ship_country = 'USA'
);


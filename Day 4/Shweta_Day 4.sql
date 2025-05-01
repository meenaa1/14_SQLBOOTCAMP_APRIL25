----DAY 4
--1.List all customers and the products they ordered with the order date. (Inner join)
--Tables used: customers, orders, order_details, products
--Output should have below columns:
--    companyname AS customer,
--    orderid,
--    productname,
--    quantity,
--    orderdate

Select cust.company_name As customer, 
	   ord.order_id,
	   pd.product_name,
	   od.quantity,
	   ord.order_date
From customers cust
Join orders ord
On cust.customer_id = ord.customer_id 
Join order_details od
On ord.order_id = od.order_id
Join products pd 
On od.product_id = pd.product_id;


--2.Show each order with customer, employee, shipper, and product info — even if some parts are missing. (Left Join)
--Tables used: orders, customers, employees, shippers, order_details, products
 
Select 
    ord.order_id,
    cust.company_name As customer,
    emp.first_name || ' ' || emp.last_name As employee,
    ship.company_name As shipper,
    pd.product_name,
    od.quantity
From orders ord
Left Join customers cust 
On ord.customer_id = cust.customer_id
Left Join employees emp 
On ord.employee_id = emp.employee_id
Left Join shippers ship 
On ord.ship_via = ship.shipper_id
Left Join order_details od 
On ord.order_id = od.order_id
Left Join products pd 
On od.product_id = pd.product_id;

 
 
--3.Show all order details and products (include all products even if they were never ordered). (Right Join)
--Tables used: order_details, products
--Output should have below columns:
--    orderid,
--    productid,
--    quantity,
--    productname

Select 
    od.order_id As orderid,
    pd.product_id AS productid,
    od.quantity,
    pd.product_name As productname
From products pd
Right Join order_details od
On pd.product_id = od.product_id;


 
--4.List all product categories and their products — including categories that have no products, and products that are not assigned to any category.(Outer Join)
--Tables used: categories, products

Select 
	c.category_id As categoryId,
    c.category_name As categoryName,
    pd.product_name As productName
From categories c
Full Outer Join products pd
On c.category_id = pd.category_id;

 
--5.Show all possible product and category combinations (Cross join)..

Select 
    c.category_id As categoryId,
    c.category_name As categoryName,
	pd.product_id As productId,
    pd.product_name As productName
From categories c
Cross Join products pd

--6.Show all employees and their manager(Self join(left join))

Select 
    emp.employee_id As employee,
    emp.first_name || ' ' || emp.last_name As employeeName,
    m.first_name || ' ' || m.last_name AS managerName
From employees emp
Left Join employees m 
On emp.reports_to = m.employee_id
	



--7.List all customers who have not selected a shipping method.
--Tables used: customers, orders
--(Left Join, WHERE o.shipvia IS NULL)
 
Select 
    cust.company_name
From customers cust
Left Join orders ord
On cust.customer_id = ord.customer_id
Where ord.ship_via Is null; 
 
 
 
              


----------1.List all customers and the products they ordered with the order date.
/*Tables used: customers, orders, order_details, products
Output should have below columns:companyname AS customer, orderid,productname,quantity,orderdate*/
	
Select c.company_name as customer,o.order_id,p.product_name,od.quantity,o.order_date from customers c
inner join orders o on c.customer_id = o.customer_id 
inner join order_details od on o.order_id = od.order_id
inner join products p on od.product_id = p.product_id
	
/*2.Show each order with customer,employee,shipper,and product info — even if some parts are missing.
(Left Join)Tables used:orders,customers,employees,shippers,order_details,products*/

Select o.order_id,
c.company_name as customer,
e.first_name||''||e.last_name as employee,
s.shipper_id ,
od.quantity, 
p product_id from orders o
left join customers c on o.customer_id =c.customer_id
left join employees e on o.employee_id = e.employee_id
left join shippers s on c.company_name=s.company_name
left join order_details od  on o.order_id = od.order_id
left join products p on od.product_id = p.product_id

/*3.Show all order details and products (include all products even if they were never ordered).(Right Join)
Tables used: order_details, products
Output should have below columns:orderid,productid,quantity,productname*/

Select order_id,products.product_id,quantity,product_name from products 
right join order_details  on products.product_id = order_details .product_id
	
/*4.List all product categories and their products — including categories that have no products, 
and products that are not assigned to any category.(Outer Join)
Tables used: categories, products*/

Select categories.category_id,category_name,product_name from categories
full outer join products on categories.category_id = products.category_id

--5.Show all possible product and category combinations (Cross join).--

Select p.product_id,p.product_name,c.category_id,c.category_name from products p
cross join categories c

----6.Show all employees and their manager(Self join(left join))-----

SELECT 
    e.employee_id,
	e.first_name||' '||e.last_name as employee_name,
	m.first_name||' '||m.last_name as manager_name 
FROM 
    employees e
LEFT JOIN 
    employees m ON e.reports_to = m.reports_to;

/*7.List all customers who have not selected a shipping method.
Tables used: customers, orders(Left Join, WHERE o.shipvia IS NULL)*/

Select c.customer_id,c.company_name as customer,o.ship_via from customers c
left join orders o on c.customer_id = o.customer_id
where ship_via is null

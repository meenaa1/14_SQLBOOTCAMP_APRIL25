--1.  List all customers and the products they ordered with the order date. (Inner join)


SELECT 
    c.company_name AS customer,
    o.order_id , 
    p.product_name, 
    od.quantity,
    o.order_date  
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN order_details od ON o.order_id = od.order_id
INNER JOIN products p ON od.product_id = p.product_id;

--2.     Show each order with customer, employee, shipper, and product info — 
--even if some parts are missing. (Left Join)
--Tables used: orders, customers, employees, shippers, order_details, products

select * from shippers
select * from products
select * from orders
SELECT 
    o.order_id as orders,
    c.company_name AS customers,
    e.first_name || ' ' || e.last_name AS employee,
    s.company_name AS shippers,
    p.product_name as products,
    od.quantity,
    o.order_date
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
LEFT JOIN employees e ON o.employee_id = e.employee_id
LEFT JOIN shippers s ON o.ship_via = s.shipper_id
LEFT JOIN order_details od ON o.order_id = od.order_id
LEFT JOIN products p ON od.product_id = p.product_id

--3.     Show all order details and products (include all products even if they were never ordered).
--(Right Join) Tables used: order_details, products
--Output should have below columns:
 --orderid, productid, quantity,productname

SELECT 
    od.order_id,
    p.product_id,
    od.quantity,
    p.product_name
FROM order_details od
RIGHT JOIN products p ON od.product_id = p.product_id;


/*4. 	List all product categories and their products — 
including categories that have no products, and products 
that are not assigned to any category.(Outer Join)
Tables used: categories, products*/

SELECT 
    c.category_id,
    c.category_name,
    p.product_id,
    p.product_name
FROM categories c
FULL OUTER JOIN products p ON c.category_id = p.category_id;


--5. 	Show all possible product and category combinations (Cross join).

select 
c.category_id,
c.category_name,
p.product_id,
p.product_name
from categories c
cross join products p ;

--6. 	Show all employees and their manager(Self join(left join))

select * from employees

SELECT 
    e.employee_id AS employee_id,
    e.first_name || ' ' || e.last_name AS employee_name,
    m.reports_to AS manager_id
FROM employees e
LEFT JOIN employees m ON e.reports_to = m.employee_id;

/*7. 	List all customers who have not selected a shipping method.
Tables used: customers, orders
(Left Join, WHERE o.shipvia IS NULL)*/

SELECT 
    c.customer_id,
    c.company_name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.ship_via IS NULL;















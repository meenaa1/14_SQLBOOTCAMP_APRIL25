----*******************			DAY 4		*******************----

/*1.     List all customers and the products they ordered with the order date. (Inner join)
Tables used: customers, orders, order_details, products
Output should have below columns:
    companyname AS customer,
    orderid,
    productname,
    quantity,
    orderdate*/

SELECT 
    c.company_name AS customer,
    o.order_id,
    p.product_name,
    od.quantity,
    o.order_date
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id;

	
 
/*2.     Show each order with customer, employee, shipper, and product info — even if some parts are missing. (Left Join)
Tables used: orders, customers, employees, shippers, order_details, products*/

SELECT 
    o.order_id,
    c.company_name AS customer,
    e.first_name || ' ' || e.last_name AS employee,
    s.company_name AS shipper,
    p.product_name,
    od.quantity
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
LEFT JOIN employees e ON o.employee_id = e.employee_id
LEFT JOIN shippers s ON o.ship_via = s.shipper_id
LEFT JOIN order_details od ON o.order_id = od.order_id
LEFT JOIN products p ON od.product_id = p.product_id;

 
/*3.     Show all order details and products (include all products even if they were never ordered). (Right Join)
Tables used: order_details, products
Output should have below columns:
    orderid,
    productid,
    quantity,
    productname*/

SELECT 
    od.order_id,
    p.product_id,
    od.quantity,
    p.product_name
FROM order_details od
RIGHT JOIN products p ON od.product_id = p.product_id;


 
/*4. 	List all product categories and their products — including categories that have no products, and products that are not assigned to any category.(Outer Join)
Tables used: categories, products*/

SELECT 
    c.category_name,
    p.product_name
FROM categories c
FULL OUTER JOIN products p ON c.category_id = p.category_id;



/*5. 	Show all possible product and category combinations (Cross join).*/

 SELECT 
    c.category_name,
    p.product_name
FROM categories c
CROSS JOIN products p;

/*6. 	Show all employees who have the same manager(Self join)*/
 
SELECT 
    e1.first_name || ' ' || e1.last_name AS employee,
    e2.first_name || ' ' || e2.last_name AS coworker,
    e1.reports_to AS manager_id
FROM employees e1
JOIN employees e2 ON e1.reports_to = e2.reports_to
WHERE e1.employee_id <> e2.employee_id;
 
 
/*7. 	List all customers who have not selected a shipping method.
Tables used: customers, orders
(Left Join, WHERE o.shipvia IS NULL)*/
 
SELECT 
    c.company_name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.ship_via IS NULL;

 
 
 
          
--1.List all customers and the products they ordered with the order date. (Inner join)
select cust.company_name as customer, o.order_id, p.product_name,
od.quantity,o.order_date 
from customers cust inner join orders o on cust.customer_id=o.customer_id
inner join order_details od on o.order_id=od.order_id
inner join products p on od.product_id=p.product_id order by 1,2;

/*2.Show each order with customer, employee, shipper, 
and product info — even if some parts are missing. (Left Join)*/

select o.order_id,cust.customer_id,emp.employee_id,o.order_date,o.shipped_date,
p.product_id,p.product_name from orders o 
left join customers cust on o.customer_id=cust.customer_id
left join employees emp on emp.employee_id=o.employee_id 
left join order_details od on od.order_id=o.order_id
left join products p on p.product_id=od.product_id
left join shippers sp on sp.shipper_id=p.supplier_id order by 1 nulls first;

--3.Show all order details and products (include all products even if they were never ordered). (Right Join)
select od.order_id,p.product_id,od.quantity,p.product_name from order_details od 
right join products p on od.product_id=p.product_id 
order by 1 nulls first;

/*4.List all product categories and their products — 
including categories that have no products, 
and products that are not assigned to any category.(Outer Join)*/
select c.category_id,c.category_name,p.product_id,p.product_name
from categories c 
full outer join products p on c.category_id=p.category_id;

--5.Show all possible product and category combinations (Cross join).
select p.product_name,c.category_name 
from products p cross join categories c on c.category_id=p.category_id;

--6.Show all employees and their manager(Self join(left join))
select e.first_name||' '||e.last_name as employee_name,
m.first_name||' '||m.last_name as manager_name
from employees e 
left join employees m on e.reports_to=m.employee_id;

--7.List all customers who have not selected a shipping method.
select c.customer_id,c.company_name,o.order_id
from customers c left join orders o
on c.customer_id=o.customer_id
where o.ship_via is null;







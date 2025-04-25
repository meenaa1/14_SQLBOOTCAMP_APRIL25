
---*********** USE NEW Northwind DB:***********---
 
---*********** 7)      List all orders with employee full names. (Inner join)***********---

select * from orders

select * from employees

SELECT 
    o.order_id,
    o.order_date,
    e.first_name || ' ' || e.last_name AS employee_full_name
FROM 
    orders o
INNER JOIN 
    employees e ON o.employee_id = e.employee_id;

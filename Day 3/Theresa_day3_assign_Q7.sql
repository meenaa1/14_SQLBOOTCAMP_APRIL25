----7.List all orders with employee full names. (Inner join)---
Select * from employees
Select * from orders

Select o.order_id, e.first_name || ' ' || e.last_name AS employeefullname
From orders o
Inner join employees e
ON o.employee_id = e.employee_id;
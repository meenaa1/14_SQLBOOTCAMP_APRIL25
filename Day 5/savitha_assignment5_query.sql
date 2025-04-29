--Day 5 Assignments 
 
--1.      GROUP BY with WHERE - Orders by Year and Quarter
--Display, order year, quarter, order count, avg freight cost only for those orders where freight cost > 100

select * from orders 

SELECT
    EXTRACT(YEAR FROM Order_Date) AS OrderYear,
    EXTRACT(QUARTER FROM Order_Date) AS OrderQuarter,
    COUNT(*) AS OrderCount,
    AVG(Freight) AS AvgFreight
FROM
    Orders
WHERE
    Freight > 100
GROUP BY
    EXTRACT(YEAR FROM Order_Date),
    EXTRACT(QUARTER FROM Order_Date)
ORDER BY
    OrderYear,
    OrderQuarter;


	/*2.      GROUP BY with HAVING - High Volume Ship Regions
Display, ship region, no of orders in each region, min and max freight cost
 Filter regions where no of orders >= 5*/

 select * from orders

 select ship_region,
 count(*)as OrderCount,
 min(freight)as MinFreight,
 max(freight)as MaxFreight
 from orders
 group by ship_region
 having count(*)>=5
 order by OrderCount desc

 --3.      Get all title designations across employees and customers ( Try UNION & UNION ALL)

 select * from employees

 select * from customers
--union returns distinct values 
 select title from employees 
 union 
 select contact_title from customers 

 --union all (returns dunplicate)
 select title from employees
 union all
 select contact_title from  customers


--4.      Find categories that have both discontinued and in-stock products
--(Display category_id, instock means units_in_stock > 0, Intersect)
select * from products

select category_id from products where units_in_stock >0
intersect
select category_id from products where discontinued = 1

--5.      Find orders that have no discounted items (Display the  order_id, EXCEPT)

-- All orders
SELECT Order_ID
FROM Order_Details

EXCEPT

-- Orders that have at least one item with a discount
SELECT DISTINCT Order_ID
FROM Order_Details
WHERE Discount > 0;



 


	



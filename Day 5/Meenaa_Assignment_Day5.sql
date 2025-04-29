--****1.GROUP BY with WHERE - Orders by Year and Quarter****--

SELECT 
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(QUARTER FROM order_date) AS order_quarter,
    COUNT(order_id) AS order_count,
    AVG(freight) AS avg_freight
FROM orders
WHERE freight > 100
GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(QUARTER FROM order_date)
ORDER BY order_year, order_quarter;

--****2.GROUP BY with HAVING - High Volume Ship Regions****--

SELECT 
    ship_region,
    COUNT(order_id) AS order_count,
    MIN(freight) AS min_freight,
    MAX(freight) AS max_freight
FROM orders
GROUP BY ship_region
HAVING COUNT(order_id) >= 5
ORDER BY order_count DESC;

SELECT * FROM orders

--****3.Get all title designations across employees and customers(Try using UNION and UNION ALL)****--
--Using UNION

SELECT title 
FROM employees
UNION
SELECT contact_title
FROM customers;

--Using UNION ALL

SELECT title 
FROM employees
UNION ALL
SELECT contact_title
FROM customers;

--****4.Find categories that have both discontinued and in-stock products****--

SELECT category_id
FROM products
WHERE discontinued = 1
INTERSECT
SELECT category_id
FROM products
WHERE units_in_stock > 0;

--****5.Find orders that have no discounted items****--

SELECT order_id
FROM order_details
EXCEPT
SELECT order_id
FROM order_details
WHERE discount > 0;

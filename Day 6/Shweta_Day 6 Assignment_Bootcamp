---Day 6

--1.Categorize products by stock status
--(Display product_name, a new column stock_status whose values are based on below condition
--units_in_stock = 0  is 'Out of Stock'
--units_in_stock < 20  is 'Low Stock')

Select 
    product_name,
    Case
        When units_in_stock = 0 Then 'Out of Stock'
        When units_in_stock < 20 Then 'Low Stock'
        Else 'In Stock'
    End As stock_status
From 
    products;
	
--------------------------Checking Another Scenario-----------------------------------------
Select 
    e.last_name || ' ' || e.first_name As employee_name,
    Case 
        When m.employee_id Is NULL Then 'No manager'
        Else m.last_name || ' ' || m.first_name
    End As manager_name
From 
    public.employees e
Left Join
    public.employees m 
	On e.reports_to = m.employee_id;


--2.Find All Products in Beverages Category
--(Subquery, Display product_name,unitprice)

Select product_name,
	   unit_price	 
From public.products
Where category_id=
	  		(Select category_id
	   		 From public.categories
	         Where category_name = 'Beverages')


--3.Find Orders by Employee with Most Sales
--(Display order_id,   order_date,  freight, employee_id.
--Employee with Most Sales=Get the total no.of of orders for each employee then order by
--DESC and limit 1. Use Subquery)

Select 
       employee_id,
	   order_id,
	   order_date,
	   freight	   
From public.orders 
Where employee_id=
		(Select employee_id
		From public.orders
		Group BY employee_id
		Order By Count(order_id) Desc
		Limit 1)
		
		
--4.Find orders  where for country!= ‘USA’ with freight costs higher than any order from USA.
--(Subquery, Try with ANY, ALL operators)
  

Select * 
From public.orders
Where ship_country != 'USA'
  And freight >(
      Select Max(freight)
      From public.orders 
      Where ship_country = 'USA'
  );

Select * 
From public.orders
Where ship_country != 'USA'
  And freight > All(
      Select Max(freight)
      From public.orders 
      Where ship_country = 'USA'
  );
  
Select * 
From public.orders
Where ship_country <> 'USA'
	And freight > Any(
      Select Max(freight)
      From public.orders 
      Where ship_country = 'USA'
  ); 
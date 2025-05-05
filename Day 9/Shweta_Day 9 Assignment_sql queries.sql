--1.Create AFTER UPDATE trigger to track product price changes
--·Create product_price_audit table with below columns:

Create Table product_price_audit
    (audit_id SERIAL PRIMARY KEY,
    product_id INT,
    product_name VARCHAR(40),
    old_price DECIMAL(10,2),
    new_price DECIMAL(10,2),
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_name VARCHAR(50) DEFAULT CURRENT_USER
	)
				-----------Creating function----------
Create Or Replace Function product_price_update()
 Returns Trigger 
 As $$
 Begin
     Insert Into product_price_audit (
         product_id,
         product_name,
         old_price,
         new_price
     )
     Values (
         OLD.product_id,
         OLD.product_name,
         OLD.unit_price,
         NEW.unit_price
     );
     Return New;
 End;
 $$ Language plpgsql;
 
 
			---------Creating trigger----
Create Trigger after_product_update
After Update Of unit_price On products
For Each Row
Execute Function product_price_update();

		-----testing the trigger-updating products price---
Update products
Set unit_price = unit_price * 1.10
WHERE product_id = 9;

		----view the product_price_audit table---
Select * From product_price_audit
Order By change_date Desc;

Select * from public.products
Where product_id = 9;



--2.Create stored procedure  using IN and INOUT parameters to assign tasks to employees
--Parameters:
			-----------Creating table--------------
 Create Table If Not Exists employee_tasks (
        task_id SERIAL Primary Key,
        employee_id INT,
        task_name VARCHAR(50),
        assigned_date DATE Default current_date
	 )
	 
		-----------Creating store procedure------------
		-----------Insert employee_id, task_name  into employee_tasks------
Create Or Replace Procedure employee_tasks(
    In p_employee_id INT,
    In p_task_name VARCHAR(50),
    Inout p_task_count INT Default 0
)
Language plpgsql
As $$
Begin
    ---------Insert task assignment-------------------
    INSERT INTO employee_tasks (employee_id, task_name)
    VALUES (p_employee_id, p_task_name);
	
	----------p_task_name, p_employee_id, p_task_count-------------
    ---------Count total tasks for employee and put the total count into p_task_count------
	
    Select Count(*) Into p_task_count
    FROM employee_tasks
    WHERE employee_id = p_employee_id;

    ---------RAISE NOTICE 'Task "%" assigned to employee %. Total tasks: %',----
    Raise Notice 'Task "%" assigned to employee %. Total tasks: %',
        p_task_name, p_employee_id, p_task_count;
End;
$$;
	----------Calling the procedure------------
Call employee_tasks(1, 'Review Reports', 0);

	-------Verify the task was inserted---------	
Select * From employee_tasks
Where employee_id = 1;	 
	 

	 
	 
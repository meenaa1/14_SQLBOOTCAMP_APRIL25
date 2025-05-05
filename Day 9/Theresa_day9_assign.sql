-------Day9-------
/*1.Create AFTER UPDATE trigger to track product price changes
Create product_price_audit table*/

Create Table product_price_audit (
    audit_id SERIAL PRIMARY KEY,
    product_id INT,
    product_name VARCHAR(40),
    old_price DECIMAL(10,2),
    new_price DECIMAL(10,2),
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_name VARCHAR(50) DEFAULT CURRENT_USER
);


--Create a trigger function with basic logic:
CREATE OR REPLACE FUNCTION pricelog_change() 
RETURNS TRIGGER
	AS $$
		BEGIN
    		INSERT INTO product_price_audit (
        product_id,
        product_name,
        old_price,
        new_price
    )
    VALUES (
        OLD.product_id,
        OLD.product_name,
        OLD.unit_price,
        NEW.unit_price
    );
    RETURN NEW;
		END;
$$ LANGUAGE plpgsql;


--Create a row level trigger for below event--AFTER UPDATE OF unit_price ON products

CREATE TRIGGER trg_price_change
AFTER UPDATE OF unit_price ON products
FOR EACH ROW
WHEN (OLD.unit_price IS DISTINCT FROM NEW.unit_price)
EXECUTE FUNCTION pricelog_change();

Select unit_price from products   ---checking before trigger
where product_id =1

--Test the trigger by updating the product price by 10% to any one product_id.
Update products
Set unit_price = unit_price * 1.10
Where product_id = 1;

Select unit_price from products
where product_id =1

Select * from product_price_audit   --Verify the audit table


/*Create stored procedure  using IN and INOUT parameters to assign tasks to employees

--Create the employee_tasks table*/

CREATE TABLE IF NOT EXISTS employee_tasks (
    task_id SERIAL PRIMARY KEY,
    employee_id INT,
    task_name VARCHAR(50),
    assigned_date DATE DEFAULT CURRENT_DATE
);

Select * from employee_tasks

--Create the stored procedure
CREATE OR REPLACE PROCEDURE assigntasks(
    IN p_employee_id INT,
    IN p_task_name VARCHAR(50),
    INOUT p_task_count INT DEFAULT 0
)
LANGUAGE plpgsql
AS $$
BEGIN
    
    INSERT INTO employee_tasks (employee_id, task_name)      -- Insert task assignment
    VALUES (p_employee_id, p_task_name);

  
    SELECT COUNT(*) INTO p_task_count           -- Count total tasks for this employee
    FROM employee_tasks
    WHERE employee_id = p_employee_id;

    -- Raise notice
    RAISE NOTICE 'Task "%" assigned to employee %. Total tasks: %',
        p_task_name, p_employee_id, p_task_count;
END;
$$;

--Call the procedure to test it

CALL assigntasks(1, 'Review Reports', 0);

-- Verify the task was inserted
Select * from employee_tasks

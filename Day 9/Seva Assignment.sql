--1.Create product_price_audit table:
CREATE TABLE product_price_audit(
audit_id SERIAL PRIMARY KEY,
product_id INT,
product_name VARCHAR(40),
old_price DECIMAL(10,2),
new_price DECIMAL(10,2),
change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
user_name VARCHAR(50) DEFAULT CURRENT_USER
);

--Create a trigger function:
CREATE OR REPLACE FUNCTION log_price()
RETURNS TRIGGER AS $$
BEGIN
	--Insert into product_price_audit table
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

--Create a row level trigger for below event:
CREATE TRIGGER price_update
AFTER UPDATE OF unit_price ON products
FOR EACH ROW
WHEN (OLD.unit_price IS DISTINCT FROM NEW.unit_price)
EXECUTE FUNCTION log_price();


-- Test the trigger by updating the product price by 10% to any one product_id.
UPDATE products
SET unit_price = unit_price * 1.10
WHERE product_id = 10;

--Select the updated product_id
SELECT * FROM products WHERE product_id = 10;

--Verify the product_price_audit table:
SELECT * FROM product_price_audit


--2.Create the employee_tasks table
CREATE TABLE IF NOT EXISTS employee_tasks (
    task_id SERIAL PRIMARY KEY,
    employee_id INT,
    task_name VARCHAR(50),
    assigned_date DATE DEFAULT CURRENT_DATE
);


--Create Stored Procedure
CREATE OR REPLACE PROCEDURE assign_task(
    IN p_employee_id INT,
    IN p_task_name VARCHAR(50),
    INOUT p_task_count INT DEFAULT 0
)
LANGUAGE plpgsql
AS $$
BEGIN

    INSERT INTO employee_tasks (employee_id, task_name)
    VALUES (p_employee_id, p_task_name);


    SELECT COUNT(*) INTO p_task_count
    FROM employee_tasks
    WHERE employee_id = p_employee_id;


    RAISE NOTICE 'Task "%" assigned to employee %. Total tasks: %',
        p_task_name, p_employee_id, p_task_count;
END;
$$;


--After creating stored procedure test by calling  it:
CALL assign_task(1, 'Review Reports');


--See the entry in employee_tasks table:
SELECT * FROM employee_tasks
WHERE employee_id = 1;

/* 1.Create AFTER UPDATE trigger to track product price changes*/

--Create product_price_audit table
CREATE TABLE product_price_audit (
    audit_id SERIAL PRIMARY KEY,
    product_id INT,
    product_name VARCHAR(40),
    old_price DECIMAL(10,2),
    new_price DECIMAL(10,2),
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_name VARCHAR(50) DEFAULT CURRENT_USER
);


--Create a trigger function
CREATE OR REPLACE FUNCTION log_price_change()
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
CREATE TRIGGER trg_price_update
AFTER UPDATE OF unit_price ON products
FOR EACH ROW
WHEN (OLD.unit_price IS DISTINCT FROM NEW.unit_price)
EXECUTE FUNCTION log_price_change();

--Chk the trigger by updating the product price by 10% to any one product_id.
UPDATE products
SET unit_price = unit_price * 1.10
WHERE product_id = 70;

SELECT * FROM products  WHERE product_id = 70;
--Cross check the audit table
SELECT * FROM product_price_audit
ORDER BY change_date DESC;

/*2.   Create stored procedure  using IN and INOUT parameters to assign tasks to employees*/

--Create the employee_tasks table
CREATE TABLE IF NOT EXISTS employee_tasks (
    task_id SERIAL PRIMARY KEY,
    employee_id INT,
    task_name VARCHAR(50),
    assigned_date DATE DEFAULT CURRENT_DATE
);

--Create the stored procedure
CREATE OR REPLACE PROCEDURE assign_task(
    IN p_employee_id INT,
    IN p_task_name VARCHAR(50),
    INOUT p_task_count INT DEFAULT 0
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO employee_tasks (employee_id, task_name)    -- Insert task assignment
    VALUES (p_employee_id, p_task_name);
    -- Count total tasks for this employee
    SELECT COUNT(*) INTO p_task_count
    FROM employee_tasks
    WHERE employee_id = p_employee_id;
    -- Raise notice
    RAISE NOTICE 'Task "%" assigned to employee %. Total tasks: %',
        p_task_name, p_employee_id, p_task_count;
END;
$$;

--Call the procedure to test it
CALL assign_task(1, 'Review Reports', 0);

-- Cross check inserted
SELECT * FROM employee_tasks
WHERE employee_id = 1;
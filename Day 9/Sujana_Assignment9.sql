--1.Create AFTER UPDATE trigger to track product price changes

CREATE TABLE IF NOT EXISTS product_price_audit (
    audit_id SERIAL PRIMARY KEY,
    product_id INT,
    product_name VARCHAR(40),
    old_price DECIMAL(10,2),
    new_price DECIMAL(10,2),
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_name VARCHAR(50) DEFAULT CURRENT_USER
);

--trigger function--
CREATE OR REPLACE FUNCTION fn_track_price_change()
RETURNS TRIGGER AS $$
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

--trigger on products table
CREATE TRIGGER trg_after_price_update
AFTER UPDATE OF unit_price ON products
FOR EACH ROW
WHEN (OLD.unit_price IS DISTINCT FROM NEW.unit_price)
EXECUTE FUNCTION fn_track_price_change();

--test the trigger by updating products price
UPDATE products
SET unit_price = unit_price * 1.10
WHERE product_id = 1;

--view the audit table
SELECT * FROM product_price_audit
ORDER BY change_date DESC;


--2.Create stored procedure  using IN and INOUT parameters to assign tasks to employees
CREATE OR REPLACE PROCEDURE assign_task(
	p_employee_id INT,
	p_task_name VARCHAR(50),
	p_task_count INT DEFAULT 0
)
LANGUAGE plpgsql
AS $$
BEGIN
	CREATE TABLE IF NOT EXISTS employee_tasks(
		task_id SERIAL PRIMARY KEY,
		employee_id INT,
		task_name VARCHAR (50),
		assigned_date DATE DEFAULT CURRENT_DATE
	);

	INSERT INTO employee_tasks (employee_id,task_name)
		VALUES (p_employee_id,p_task_name);

	SELECT COUNT(*) INTO p_task_count
	FROM employee_tasks
	WHERE employee_id = p_employee_id;

	RAISE NOTICE 'Task "%" assigned to employee %. Total tasks: %',
        p_task_name, p_employee_id, p_task_count;

END;
$$;

CALL assign_task (1, 'Review Reports');

select * from employee_tasks where employee_id = 1;


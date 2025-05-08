-----**********************************************************************************------
--												DAY 10								         --
-----**********************************************************************************------


/*1.	Write  a function to Calculate the total stock value for a given category:
(Stock value=ROUND(SUM(unit_price * units_in_stock)::DECIMAL, 2)
Return data type is DECIMAL(10,2)*/

CREATE OR REPLACE FUNCTION get_category_stock_value(p_category_id INT)
RETURNS DECIMAL(10,2) 
--LANGUAGE plpgsql
AS $$
DECLARE
    stock_value DECIMAL(10,2);
BEGIN
	--Validate category exists
	IF NOT EXISTS (SELECT 1 FROM categories WHERE category_id = p_category_id) THEN 
		RAISE EXCEPTION 'Category ID % does not exist', p_category_id;
		RETURN 0; 
		END IF;
		
    SELECT 
	COALESCE (ROUND(SUM(unit_price * units_in_stock)::DECIMAL, 2),0.00)
    INTO stock_value
    FROM products
    WHERE category_id = p_category_id;

RETURN stock_value;
-- RETURN COALESCE(stock_value, 0.00);
END;
$$ LANGUAGE plpgsql;

--check

SELECT get_category_stock_value(1) AS stock_value;




/*2.	Try writing a   cursor query which I executed in the training.*/


CREATE OR REPLACE PROCEDURE calc_customer_order_value()
LANGUAGE plpgsql
AS $$
DECLARE
    cur_customer CURSOR FOR
        SELECT customer_id, company_name FROM customers;

    rec RECORD;
    total_order_value DECIMAL(10,2);
BEGIN
    OPEN cur_customer;
    LOOP
        FETCH cur_customer INTO rec;
        EXIT WHEN NOT FOUND;

        SELECT ROUND(SUM(od.unit_price * od.quantity * (1 - od.discount))::NUMERIC, 2)
        INTO total_order_value
        FROM orders o
        JOIN order_details od ON o.order_id = od.order_id
        WHERE o.customer_id = rec.customer_id;

        RAISE NOTICE 'Customer: %, Total Order Value: %',
            rec.company_name, COALESCE(total_order_value, 0);
    END LOOP;
    CLOSE cur_customer;
END;
$$;

CALL calc_customer_order_value();

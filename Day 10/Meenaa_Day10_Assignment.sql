--****1. Write a function to calculate the total stock value for a given category: 
--(Stock value = ROUND(SUM(unit_price * units_in_stock)::DECIMAL, 2) Return data type is DECIMAL(10,2)

CREATE OR REPLACE FUNCTION total_stock_value(p_category_id INT)
RETURNS DECIMAL(10,2) 
LANGUAGE plpgsql
AS $$
DECLARE
    total_value DECIMAL(10,2);
BEGIN
    SELECT ROUND(SUM(unit_price * units_in_stock)::DECIMAL, 2)
    INTO total_value
    FROM products
    WHERE category_id = p_category_id;

    RETURN COALESCE(total_value, 0);
END;
$$;

SELECT total_stock_value(1);

--****2.Example of Cursor Query.****--
-- This procedure uses a cursor to loop through each row in order_details
-- and prints the total price for each line (unit_price * quantity).
 SELECT* FROM order_details
 LIMIT 5;

CREATE OR REPLACE PROCEDURE print_order_totals()
LANGUAGE plpgsql
AS $$
DECLARE
    order_cursor CURSOR FOR
        SELECT DISTINCT order_id FROM order_details;

    order_id_record RECORD;
    line_record RECORD;
    order_total NUMERIC;
BEGIN
    -- Open cursor to iterate over distinct orders
    OPEN order_cursor;

    LOOP
        FETCH order_cursor INTO order_id_record;
        EXIT WHEN NOT FOUND;

        -- Reset total for each order
        order_total := 0;

        -- Loop through line items for the current order
        FOR line_record IN
            SELECT unit_price, quantity, discount
            FROM order_details
            WHERE order_id = order_id_record.order_id
        LOOP
            order_total := order_total + (line_record.unit_price * line_record.quantity * (1 - line_record.discount));
        END LOOP;

        -- Print total for the order
        RAISE NOTICE 'Order ID: %, Total Order Value: %',
                     order_id_record.order_id, ROUND(order_total, 2);
    END LOOP;

    -- Close the cursor
    CLOSE order_cursor;
END;
$$;


CALL print_order_totals();



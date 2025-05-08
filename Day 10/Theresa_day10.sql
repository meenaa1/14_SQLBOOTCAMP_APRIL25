/*1.Write a function to Calculate the total stock value for a given category:
(Stock value=ROUND(SUM(unit_price * units_in_stock)::DECIMAL, 2)
Return data type is DECIMAL(10,2)*/

CREATE OR REPLACE FUNCTION calculate_stock_value(p_category_id INT)
RETURNS DECIMAL(10,2)
LANGUAGE plpgsql
AS $$
Declare
	totalvalue Decimal(10,2);
BEGIN
    SELECT ROUND(SUM(unit_price * units_in_stock)::DECIMAL, 2)
	INTO totalvalue
    FROM products 
    WHERE category_id = p_category_id;

	RETURN COALESCE(totalvalue,0);
	END;
$$;

Select calculate_stock_value(1)


-----2.Try writing a cursor query which I executed in the training.--

Select * from order_details

Create or replace Procedure print_order_totals()   ------Create a procedure--
language plpgsql
AS $$
Declare
order_cursor CURSOR FOR
Select Distinct order_id from order_details;

order_id_record Record;
line_record Record;
order_total Numeric;

Begin

open order_cursor;

loop
Fetch order_cursor INTO order_id_record
EXIT WHEN NOT FOUND;

order_total:=0;

for line _record IN
Select unit_price,quantity,discount from order_details
Loop
FETCH order_cursor INTO order_id_record;
        EXIT WHEN NOT FOUND;
        order_total := 0;

        FOR line_record IN
            SELECT unit_price, quantity, discount
            FROM order_details
            WHERE order_id = order_id_record.order_id
        LOOP
            order_total := order_total + (line_record.unit_price * line_record.quantity * (1 - line_record.discount));
        END LOOP;

        RAISE NOTICE 'Order ID: %, Total Order Value: %',
                     order_id_record.order_id, ROUND(order_total, 2);
    END LOOP;

    CLOSE order_cursor;
END;
$$;

CALL print_order_totals();




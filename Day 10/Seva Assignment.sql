--1. Write a function to Calculate the total stock value for a given category:
CREATE OR REPLACE FUNCTION stock_value(p_category_id INT)
RETURNS DECIMAL(10,2)
LANGUAGE plpgsql
AS $$
DECLARE
	total DECIMAL(10,2);
BEGIN
    SELECT 
		COALESCE(ROUND(SUM(unit_price * units_in_stock)::DECIMAL, 2),0)
    INTO total
    FROM products
    WHERE category_id = p_category_id;

    RETURN total;
END;
$$;

--Select Stock_value:
SELECT stock_value(1);


--2.Try writing a cursor query:
CREATE OR REPLACE PROCEDURE update_prices_with_cursor()
LANGUAGE plpgsql
AS $$
DECLARE
	product_cursor CURSOR FOR
		SELECT product_id,product_name, unit_price, units_in_stock
		FROM products
		WHERE discontinued =0;
	product_record Record;
	v_new_price decimal(10,2);
BEGIN
--open the cursor
  OPEN product_cursor;

  LOOP
--Fetch the next row
  FETCH product_cursor INTO product_record;

  EXIT WHEN NOT FOUND;

  IF product_record.units_in_stock <10 THEN
  	v_new_price := product_record.unit_price * 1.1;
  ELSE  
    v_new_price := product_record.unit_price * 0.95;
  END IF;

  UPDATE products SET unit_price = round(v_new_price,2)
  WHERE product_id = product_record.product_id;

  RAISE NOTICE 'update % price from % to %',
  	product_record.product_name,
	product_record.unit_price,
	v_new_price;
END LOOP;

CLOSE product_cursor;
END;
$$;


call update_prices_with_cursor();

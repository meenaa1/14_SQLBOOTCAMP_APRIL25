/*1.	Write  a function to Calculate the total stock value for a given category:
(Stock value=ROUND(SUM(unit_price * units_in_stock)::DECIMAL, 2)
Return data type is DECIMAL(10,2)
*/


CREATE OR REPLACE FUNCTION get_total_stock_value(p_category_id INT)
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

    RETURN COALESCE(total_value, 0.00);
END;
$$;
-- Example usage for category_id = 2
SELECT get_total_stock_value(2);


--2.	Try writing a   cursor query which I executed in the training.

SELECT product_name, unit_price, units_in_stock
FROM products
WHERE category_id = 1;


-- Only if it makes sense for your data
UPDATE products
SET unit_price = 1.00
WHERE unit_price IS NULL AND category_id = 1;

UPDATE products
SET units_in_stock = 10
WHERE units_in_stock IS NULL AND category_id = 1;


DO $$
DECLARE
    cur_product CURSOR FOR
        SELECT product_name, COALESCE(unit_price, 0) AS unit_price, COALESCE(units_in_stock, 0) AS units_in_stock
        FROM products
        WHERE category_id = 1;

    rec RECORD;
    stock_value DECIMAL(10,2) := 0;
    total_stock DECIMAL(10,2) := 0;
BEGIN
    OPEN cur_product;

    LOOP
        FETCH cur_product INTO rec;
        EXIT WHEN NOT FOUND;

        stock_value := rec.unit_price * rec.units_in_stock;
        total_stock := total_stock + stock_value;

        RAISE NOTICE 'Product: %, Stock Value: %', rec.product_name, ROUND(stock_value, 2);
    END LOOP;

    CLOSE cur_product;

    RAISE NOTICE 'Total stock value for category 1: %', ROUND(total_stock, 2);
END;
$$;

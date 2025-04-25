--**** 1. Update the categoryName From “Beverages” to "Drinks" in the categories table****--
UPDATE categories
SET "categoryName" = 'Drinks'
WHERE "categoryName" = 'Beverages';

SELECT * FROM categories WHERE "categoryName" = 'Drinks';

--**** 2. Insert into shipper new record (give any values) Delete that new record from shippers table****--
INSERT INTO shippers ("shipperID", "companyName") ------Inserting a new record
VALUES (7, 'USPS');

DELETE FROM shippers
WHERE "shipperID" = 7;

SELECT * FROM shippers;

--**** 3.   Update categoryID=1 to categoryID=1001. Make sure related products update their categoryID too. Display the both category and products table to show the cascade****--
SELECT * FROM categories;
SELECT * FROM products;

UPDATE categories
SET "categoryID" = 1001
WHERE "categoryID" = 1;

--Drop the constraint and recreate it--
ALTER TABLE products
DROP CONSTRAINT IF EXISTS fk_category

ALTER TABLE products
ADD CONSTRAINT fk_category
FOREIGN KEY ("categoryID")
REFERENCES categories("categoryID")
ON UPDATE CASCADE
ON DELETE CASCADE;

INSERT INTO categories ("categoryID","categoryName","description")
VALUES (1001, 'Test Category1',0)

INSERT INTO products ("productID","productName","quantityPerUnit","unitPrice","discontinued","categoryID")
VALUES (80,'Test Product','1 kg','68',0,1001)

SELECT * FROM categories WHERE "categoryID" = 1001;
SELECT * FROM products WHERE "categoryID" = 1001;

--Delete the CatergoryID="3" from categories--
DELETE FROM categories WHERE "categoryID" = 3;
--Drop the constraint and recreate it--
ALTER TABLE order_details
DROP CONSTRAINT IF EXISTS order_details_productID_fkey;

ALTER TABLE order_details
ADD CONSTRAINT order_details_productID_fkey
FOREIGN KEY ("productID")
REFERENCES products("productID")
ON UPDATE CASCADE
ON DELETE CASCADE;

ALTER TABLE products
DROP CONSTRAINT IF EXISTS fk_category;

ALTER TABLE products
ADD CONSTRAINT fk_category
FOREIGN KEY ("categoryID")
REFERENCES categories("categoryID")
ON UPDATE CASCADE
ON DELETE CASCADE;

DELETE FROM categories WHERE "categoryID" = 3;
SELECT * FROM categories WHERE "categoryID" = 3;
SELECT * FROM order_details WHERE "productID" = 19;

--**** 4. Delete the customer = “VINET”  from customers. Corresponding customers in orders table should be set to null****--
SELECT * FROM orders
SELECT * FROM customers
-- Drop the existing foreign key constraint, if it exists and recreate it
ALTER TABLE orders
DROP CONSTRAINT IF EXISTS fk_orders_customers;

ALTER TABLE orders
ADD CONSTRAINT "fk_orders_customers"
FOREIGN KEY ("customerID")
REFERENCES customers("customerID")
ON UPDATE CASCADE
ON DELETE SET NULL; -- This ensures that the customerID is set to NULL when the corresponding customer is deleted.

DELETE FROM customers
WHERE "customerID" = 'VINET';

ALTER TABLE orders
ALTER COLUMN "customerID" DROP NOT NULL;
SELECT * FROM customers WHERE "customerID" = 'VINET';

--**** 5. Insert the following data to Products using UPSERT****--
INSERT INTO Products ("productID", "productName", "quantityPerUnit", "unitPrice", "discontinued", "categoryID")
VALUES
    (100, 'Wheat bread', '1', 13, 0, 5),
    (101, 'White bread', '5 boxes', 13, 0, 5)
   
ON CONFLICT ("productID") 
DO UPDATE
    SET "quantityPerUnit" = excluded."quantityPerUnit";

INSERT INTO Products ("productID", "productName", "quantityPerUnit", "unitPrice", "discontinued", "categoryID")
VALUES
	(100, 'Wheat bread', '10 boxes', 13, 0, 5)
	   
ON CONFLICT ("productID") 
DO UPDATE
    SET "quantityPerUnit" = excluded."quantityPerUnit";
SELECT * FROM products Where "productID"= 100

--**** 6. Write a MERGE query:-Create temp table with name:  ‘updated_products’ and insert values as below****--
-- Create the temp table
CREATE TEMPORARY TABLE updated_products (
    "productID" INT,
    "productName" VARCHAR(255),
    "quantityPerUnit" VARCHAR(255),
    "unitPrice" DECIMAL(10, 2),
    "discontinued" INT,
    "categoryID" INT
);

-- Insert values into the temp table
INSERT INTO updated_products ("productID", "productName", "quantityPerUnit", "unitPrice", "discontinued", "categoryID")
VALUES
    (100, 'Wheat bread', '10', 20, 1, 5),
    (101, 'White bread', '5 boxes', 19.99, 0, 5),
    (102, 'Midnight Mango Fizz', '24 - 12 oz bottles', 19, 0, 1),
    (103, 'Savory Fire Sauce', '12 - 550 ml bottles', 10, 0, 2);
--Update existing products if discontinued = 0.

MERGE INTO "products" p
USING "updated_products" up
ON p."productID" = up."productID"

-- Update matching products where discontinued = 0
WHEN MATCHED AND up."discontinued" = 0 THEN
    UPDATE SET 
       "unitPrice" = up."unitPrice",
       "discontinued" = up."discontinued"

-- Delete matching products where discontinued = 1
WHEN MATCHED AND up."discontinued" = 1 THEN
    DELETE

-- Insert new products where they don't exist in Products and discontinued = 0
WHEN NOT MATCHED BY TARGET AND up."discontinued" = 0 THEN
    INSERT ("productID", "productName", "quantityPerUnit", "unitPrice", "discontinued", "categoryID")
    VALUES (up."productID", up."productName", up."quantityPerUnit", up."unitPrice", up."discontinued", up."categoryID");

SELECT * FROM products WHERE "productID" IN (100,101,102,103)
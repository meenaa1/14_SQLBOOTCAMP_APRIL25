CREATE TABLE IF NOT EXISTS categories
(
    categoryid integer NOT NULL,
    categoryname varchar (50),
    description varchar (255),
    CONSTRAINT categoryid_pkey PRIMARY KEY (categoryid)
)

CREATE TABLE IF NOT EXISTS customers
(
    customersid  integer NOT NULL,
    companyname varchar(50),
    contactname varchar (50),
    contacttitle varchar (50),
    city varchar (50),
    country varchar (50),
    CONSTRAINT customersid_pkey PRIMARY KEY (customersid)
)


CREATE TABLE IF NOT EXISTS employees
(
    employeeid integer NOT NULL,
    employeename varchar (50),
    title varchar (50),
    city varchar (50),
    country varchar (50),
    reportsto varchar (50),
    CONSTRAINT employeeid_pkey PRIMARY KEY (employeeid)
)


CREATE TABLE IF NOT EXISTS public.order_details
(
    orderid int references orders (orderID),
    productid int references products ( productID),
    unitprice numeric (10,2),
    quantity integer,
    discount numeric (5,4),
    Primary Key (orderID, productID)
)


CREATE TABLE IF NOT EXISTS orders (
    orderid INTEGER NOT NULL,
    customerid VARCHAR(50),
    employeeid INTEGER,
    orderdate DATE,
    requireddate DATE,
    shippeddate DATE,
    shipperid INTEGER,
    freight NUMERIC(10,2),
    CONSTRAINT orderid_pkey PRIMARY KEY (orderid),
    CONSTRAINT orders_customerid_fkey FOREIGN KEY (customerid)
        REFERENCES public.customers (customersid),
    CONSTRAINT orders_employeeid_fkey FOREIGN KEY (employeeid)
        REFERENCES public.employees (employeeid) MATCH SIMPLE,
    CONSTRAINT orders_shipperid_fkey FOREIGN KEY (shipperid)
        REFERENCES public.shippers (shipperid) MATCH SIMPLE
);


CREATE TABLE IF NOT EXISTS products
(
    productid integer NOT NULL,
    productname varchar (50),
    quantityperunit varchar (50),
    unitprice numeric(10,2),
    discontinued integer,
    categoryid integer,
    CONSTRAINT productid_pkey PRIMARY KEY (productid),
    CONSTRAINT products_categoryid_fkey FOREIGN KEY (categoryid)
    REFERENCES public.categories (categoryid) MATCH SIMPLE
)

CREATE TABLE IF NOT EXISTS shippers
(
    shipperid integer NOT NULL,
    companyname varchar (50),
    CONSTRAINT shipperid_pkey PRIMARY KEY (shipperid)
)

-- ============================================================
-- ECOMMERCE DATABASE - SCRIPT 2
-- Insert Raw Data
-- ============================================================
-- Built by  : Soha Tabassum
-- Project   : ECOMMERCE Database
-- Database  : SQL Server
-- Tables    : CUSTOMERS | PRODUCTS | ORDERS | ORDER_ITEMS
-- ============================================================
--
-- TABLE OF CONTENTS:
-- ============================================================
-- SECTION 1 : INSERT CUSTOMERS  (7 rows — 2 with NULL values)
-- SECTION 2 : INSERT PRODUCTS   (12 rows — 2 with NULL values)
-- SECTION 3 : INSERT ORDERS     (17 rows — 2 with NULL values)
-- SECTION 4 : INSERT ORDER_ITEMS (20 rows)
-- ============================================================


USE ECOMMERCE;
GO


-- ============================================================
-- SECTION 1 : INSERT CUSTOMERS
-- 5 real customers + 2 NULL test records
-- Columns: customer_id, customer_name, email, phone_number,
--          city, age, gender
-- ============================================================

INSERT INTO CUSTOMERS VALUES (1, 'Ali',        'ali@gmail.com',      '03001234567', 'Hyderabad', 28, 'Male');
INSERT INTO CUSTOMERS VALUES (2, 'Raha',       'raha24@gmail.com',   '1293548460',  'Mumbai',    25, 'Female');
INSERT INTO CUSTOMERS VALUES (3, 'John',       'john10@gmail.com',   '1293808460',  'Delhi',     32, 'Male');
INSERT INTO CUSTOMERS VALUES (4, 'Sammy',      'sam13@gmail.com',    '0296548460',  'Bangalore', 22, 'Female');
INSERT INTO CUSTOMERS VALUES (5, 'Dina',       'din12@gmail.com',    '3290548760',  'Chennai',   35, 'Female');
-- NULL test records for NULL handling practice
INSERT INTO CUSTOMERS VALUES (6, 'NULL_Test1', NULL,                 '1234567890',  'Unknown',   0,  'Unknown');
INSERT INTO CUSTOMERS VALUES (7, 'NULL_Test2', 'null2@gmail.com',    NULL,          'Mumbai',    28, 'Unknown');

SELECT * FROM CUSTOMERS;
PRINT 'Customers inserted: 7 rows (5 clean + 2 with intentional NULLs)';


-- ============================================================
-- SECTION 2 : INSERT PRODUCTS
-- 10 real products + 2 duplicate names (Camera, Laptop)
-- Columns: product_id, product_name, price, category,
--          cost_price, stock_quantity
-- ============================================================

INSERT INTO PRODUCTS VALUES (101, 'Laptop',     60000, 'Electronics', 15000, 50);
INSERT INTO PRODUCTS VALUES (102, 'Watch',       4000, 'Electronics',  3000, 30);
INSERT INTO PRODUCTS VALUES (103, 'Camera',     10000, 'Electronics',  7000, 20);
INSERT INTO PRODUCTS VALUES (104, 'Bag',         1000, 'Accessories',   500, 100);
INSERT INTO PRODUCTS VALUES (105, 'Mobile',     25000, 'Electronics', 18000, 15);
INSERT INTO PRODUCTS VALUES (106, 'Bike',       60000, 'Vehicles',    45000,  5);
INSERT INTO PRODUCTS VALUES (107, 'Shirt',       2000, 'Clothing',      800, 200);
INSERT INTO PRODUCTS VALUES (108, 'Camera',     10000, 'Electronics',  7000, 25);
INSERT INTO PRODUCTS VALUES (109, 'Shoes',       3200, 'Footwear',     1500, 80);
INSERT INTO PRODUCTS VALUES (110, 'Laptop',     17000, 'Electronics', 12000, 10);
INSERT INTO PRODUCTS VALUES (111, 'Tablet',     17000, 'Electronics',  8000, 15);
INSERT INTO PRODUCTS VALUES (112, 'Headphones',  2000, 'Electronics',  1000, 40);

SELECT * FROM PRODUCTS;
PRINT 'Products inserted: 12 rows';


-- ============================================================
-- SECTION 3 : INSERT ORDERS
-- 15 real orders + 2 NULL test records
-- Date range: January 2024 to July 2024
-- Columns: order_id, customer_id, order_date, total_amount,
--          status, payment_method, discount
-- ============================================================

INSERT INTO ORDERS VALUES (101, 1, '2024-01-15', 20000, 'Delivered', 'Card',  500);
INSERT INTO ORDERS VALUES (102, 2, '2024-02-14',  3569, 'Delivered', 'UPI',     0);
INSERT INTO ORDERS VALUES (103, 1, '2024-02-15',  1500, 'Shipped',   'Cash',  200);
INSERT INTO ORDERS VALUES (104, 3, '2024-03-01', 25000, 'Delivered', 'Card',    0);
INSERT INTO ORDERS VALUES (105, 4, '2024-03-15',  1000, 'Pending',   'UPI',   100);
INSERT INTO ORDERS VALUES (106, 5, '2024-04-01',  4000, 'Cancelled', 'Card',    0);
INSERT INTO ORDERS VALUES (107, 1, '2024-04-10', 60000, 'Delivered', 'Cash',  300);
INSERT INTO ORDERS VALUES (108, 2, '2024-04-15',  3200, 'Shipped',   'UPI',     0);
INSERT INTO ORDERS VALUES (109, 3, '2024-05-01',  2000, 'Delivered', 'Card',  150);
INSERT INTO ORDERS VALUES (110, 4, '2024-05-10', 10000, 'Pending',   'Cash',    0);
INSERT INTO ORDERS VALUES (111, 5, '2024-05-15', 17000, 'Delivered', 'UPI',   200);
INSERT INTO ORDERS VALUES (112, 1, '2024-06-01', 20000, 'Cancelled', 'Card',    0);
INSERT INTO ORDERS VALUES (113, 2, '2024-06-10', 25000, 'Delivered', 'Cash',  100);
INSERT INTO ORDERS VALUES (114, 3, '2024-06-15',  3200, 'Shipped',   'UPI',     0);
INSERT INTO ORDERS VALUES (115, 4, '2024-06-20',  1500, 'Delivered', 'Card',  250);
-- NULL test records for NULL handling practice
INSERT INTO ORDERS VALUES (116, 6, '2024-07-01',     0, 'Pending',   'Cash',    0);
INSERT INTO ORDERS VALUES (117, 7, '2024-07-05',  5000, 'Pending',   'Card',    0);

SELECT * FROM ORDERS;
PRINT 'Orders inserted: 17 rows (January 2024 to July 2024)';


-- ============================================================
-- SECTION 4 : INSERT ORDER_ITEMS
-- 20 records linking orders to products
-- Columns: order_item_id, order_id, product_id, quantity
-- ============================================================

INSERT INTO ORDER_ITEMS VALUES  (1,  101, 101, 2);
INSERT INTO ORDER_ITEMS VALUES  (2,  104, 103, 3);
INSERT INTO ORDER_ITEMS VALUES  (3,  106, 105, 4);
INSERT INTO ORDER_ITEMS VALUES  (4,  103, 103, 4);
INSERT INTO ORDER_ITEMS VALUES  (5,  102, 102, 1);
INSERT INTO ORDER_ITEMS VALUES  (6,  105, 104, 2);
INSERT INTO ORDER_ITEMS VALUES  (7,  107, 106, 1);
INSERT INTO ORDER_ITEMS VALUES  (8,  108, 107, 3);
INSERT INTO ORDER_ITEMS VALUES  (9,  109, 108, 2);
INSERT INTO ORDER_ITEMS VALUES (10,  110, 109, 4);
INSERT INTO ORDER_ITEMS VALUES (11,  111, 110, 1);
INSERT INTO ORDER_ITEMS VALUES (12,  112, 101, 2);
INSERT INTO ORDER_ITEMS VALUES (13,  113, 102, 3);
INSERT INTO ORDER_ITEMS VALUES (14,  114, 103, 1);
INSERT INTO ORDER_ITEMS VALUES (15,  115, 104, 2);
INSERT INTO ORDER_ITEMS VALUES (16,  101, 105, 3);
INSERT INTO ORDER_ITEMS VALUES (17,  102, 106, 1);
INSERT INTO ORDER_ITEMS VALUES (18,  103, 107, 2);
INSERT INTO ORDER_ITEMS VALUES (19,  104, 108, 4);
INSERT INTO ORDER_ITEMS VALUES (20,  105, 109, 1);

SELECT * FROM ORDER_ITEMS;
PRINT 'Order Items inserted: 20 rows';


-- ============================================================
-- END OF SCRIPT 2
-- ============================================================
-- NEXT: Run Script 3 to explore and profile raw data
-- ============================================================

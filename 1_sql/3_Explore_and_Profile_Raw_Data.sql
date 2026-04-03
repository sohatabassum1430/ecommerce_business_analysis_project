-- ============================================================
-- ECOMMERCE DATABASE - SCRIPT 3
-- Explore and Profile Raw Data
-- ============================================================
-- Built by  : Soha Tabassum
-- Project   : ECOMMERCE Database
-- Database  : SQL Server
-- Tables    : CUSTOMERS | PRODUCTS | ORDERS | ORDER_ITEMS
-- ============================================================
--
-- TABLE OF CONTENTS:
-- ============================================================
-- SECTION 1 : ROW COUNTS
-- SECTION 2 : NULL CHECK — CUSTOMERS
-- SECTION 3 : NULL CHECK — PRODUCTS
-- SECTION 4 : NULL CHECK — ORDERS
-- SECTION 5 : NULL CHECK — ORDER_ITEMS
-- SECTION 6 : DUPLICATE PRIMARY KEYS
-- SECTION 7 : DUPLICATE PRODUCT NAMES
-- SECTION 8 : DATA TYPES
-- SECTION 9 : CATEGORICAL VALUES
-- SECTION 10: NEGATIVE VALUES
-- SECTION 11: DATE RANGE
-- ============================================================


USE ECOMMERCE;
GO


-- ============================================================
-- SECTION 1 : ROW COUNTS
-- ============================================================

SELECT 'CUSTOMERS'   AS table_name, COUNT(*) AS total_rows FROM CUSTOMERS   UNION ALL
SELECT 'PRODUCTS',                  COUNT(*)               FROM PRODUCTS     UNION ALL
SELECT 'ORDERS',                    COUNT(*)               FROM ORDERS       UNION ALL
SELECT 'ORDER_ITEMS',               COUNT(*)               FROM ORDER_ITEMS;


-- ============================================================
-- SECTION 2 : NULL CHECK — CUSTOMERS
-- ============================================================

SELECT
    'CUSTOMERS' AS table_name,
    SUM(CASE WHEN customer_name IS NULL THEN 1 ELSE 0 END) AS null_customer_name,
    SUM(CASE WHEN email         IS NULL THEN 1 ELSE 0 END) AS null_email,
    SUM(CASE WHEN phone_number  IS NULL THEN 1 ELSE 0 END) AS null_phone,
    SUM(CASE WHEN city          IS NULL THEN 1 ELSE 0 END) AS null_city,
    SUM(CASE WHEN age           IS NULL THEN 1 ELSE 0 END) AS null_age,
    SUM(CASE WHEN gender        IS NULL THEN 1 ELSE 0 END) AS null_gender
FROM CUSTOMERS;


-- ============================================================
-- SECTION 3 : NULL CHECK — PRODUCTS
-- ============================================================

SELECT
    'PRODUCTS' AS table_name,
    SUM(CASE WHEN product_name   IS NULL THEN 1 ELSE 0 END) AS null_product_name,
    SUM(CASE WHEN price          IS NULL THEN 1 ELSE 0 END) AS null_price,
    SUM(CASE WHEN category       IS NULL THEN 1 ELSE 0 END) AS null_category,
    SUM(CASE WHEN cost_price     IS NULL THEN 1 ELSE 0 END) AS null_cost_price,
    SUM(CASE WHEN stock_quantity IS NULL THEN 1 ELSE 0 END) AS null_stock
FROM PRODUCTS;


-- ============================================================
-- SECTION 4 : NULL CHECK — ORDERS
-- ============================================================

SELECT
    'ORDERS' AS table_name,
    SUM(CASE WHEN order_date     IS NULL THEN 1 ELSE 0 END) AS null_order_date,
    SUM(CASE WHEN total_amount   IS NULL THEN 1 ELSE 0 END) AS null_total_amount,
    SUM(CASE WHEN status         IS NULL THEN 1 ELSE 0 END) AS null_status,
    SUM(CASE WHEN payment_method IS NULL THEN 1 ELSE 0 END) AS null_payment_method,
    SUM(CASE WHEN discount       IS NULL THEN 1 ELSE 0 END) AS null_discount
FROM ORDERS;


-- ============================================================
-- SECTION 5 : NULL CHECK — ORDER_ITEMS
-- ============================================================

SELECT
    'ORDER_ITEMS' AS table_name,
    SUM(CASE WHEN quantity IS NULL THEN 1 ELSE 0 END) AS null_quantity
FROM ORDER_ITEMS;


-- ============================================================
-- SECTION 6 : DUPLICATE PRIMARY KEYS
-- ============================================================

SELECT customer_id,   COUNT(*) AS count FROM CUSTOMERS   GROUP BY customer_id   HAVING COUNT(*) > 1;
SELECT product_id,    COUNT(*) AS count FROM PRODUCTS    GROUP BY product_id    HAVING COUNT(*) > 1;
SELECT order_id,      COUNT(*) AS count FROM ORDERS      GROUP BY order_id      HAVING COUNT(*) > 1;
SELECT order_item_id, COUNT(*) AS count FROM ORDER_ITEMS GROUP BY order_item_id HAVING COUNT(*) > 1;


-- ============================================================
-- SECTION 7 : DUPLICATE PRODUCT NAMES
-- business duplicate — not a data error
-- Camera (103, 108) and Laptop (101, 110) are different models
-- ============================================================

SELECT product_name, COUNT(*) AS count
FROM PRODUCTS
GROUP BY product_name
HAVING COUNT(*) > 1;


-- ============================================================
-- SECTION 8 : DATA TYPES
-- ============================================================

SELECT
    TABLE_NAME,
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME IN ('CUSTOMERS', 'PRODUCTS', 'ORDERS', 'ORDER_ITEMS')
ORDER BY TABLE_NAME, ORDINAL_POSITION;


-- ============================================================
-- SECTION 9 : CATEGORICAL VALUES
-- ============================================================

-- Order status
SELECT status, COUNT(*) AS count FROM ORDERS
GROUP BY status ORDER BY count DESC;

-- Payment method
SELECT payment_method, COUNT(*) AS count FROM ORDERS
GROUP BY payment_method ORDER BY count DESC;

-- Product category
SELECT category, COUNT(*) AS count FROM PRODUCTS
GROUP BY category ORDER BY count DESC;

-- Customer gender
SELECT gender, COUNT(*) AS count FROM CUSTOMERS
GROUP BY gender ORDER BY count DESC;

-- Customer city
SELECT city, COUNT(*) AS count FROM CUSTOMERS
GROUP BY city ORDER BY count DESC;


-- ============================================================
-- SECTION 10 : NEGATIVE VALUES
-- ============================================================

SELECT * FROM PRODUCTS    WHERE price < 0 OR cost_price < 0 OR stock_quantity < 0;
SELECT * FROM ORDERS      WHERE total_amount < 0 OR discount < 0;
SELECT * FROM ORDER_ITEMS WHERE quantity < 0;


-- ============================================================
-- SECTION 11 : DATE RANGE
-- ============================================================

SELECT
    MIN(order_date)                   AS earliest_order,
    MAX(order_date)                   AS latest_order,
    COUNT(DISTINCT MONTH(order_date)) AS months_covered,
    COUNT(DISTINCT YEAR(order_date))  AS years_covered
FROM ORDERS
WHERE order_date IS NOT NULL;


-- ============================================================
-- END OF SCRIPT 3
-- ============================================================
-- NEXT: Run Script 4 to clean the data
-- ============================================================

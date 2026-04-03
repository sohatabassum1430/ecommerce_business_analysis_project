-- ============================================================
-- ECOMMERCE DATABASE - SCRIPT 5
-- Verify and Validate Clean Data
-- ============================================================
-- Built by  : Soha Tabassum
-- Project   : ECOMMERCE Database
-- Database  : SQL Server
-- Tables    : CLEAN_CUSTOMERS | CLEAN_PRODUCTS | CLEAN_ORDERS | CLEAN_ORDER_ITEMS
-- ============================================================
--
-- TABLE OF CONTENTS:
-- ============================================================
-- SECTION 1 : ROW COUNT COMPARISON — RAW VS CLEAN
-- SECTION 2 : NULL CHECK — CLEAN_CUSTOMERS
-- SECTION 3 : NULL CHECK — CLEAN_PRODUCTS
-- SECTION 4 : NULL CHECK — CLEAN_ORDERS
-- SECTION 5 : NULL CHECK — CLEAN_ORDER_ITEMS
-- SECTION 6 : PREVIEW ALL CLEAN TABLES
-- SECTION 7 : CONFIRM NO NULL DATES IN CLEAN_ORDERS
-- ============================================================


USE ECOMMERCE;
GO


-- ============================================================
-- SECTION 1 : ROW COUNT COMPARISON — RAW VS CLEAN
-- Raw and clean row counts should match for all tables
-- ============================================================

SELECT 'CUSTOMERS'         AS table_name, COUNT(*) AS row_count FROM CUSTOMERS        UNION ALL
SELECT 'CLEAN_CUSTOMERS',                 COUNT(*)              FROM CLEAN_CUSTOMERS   UNION ALL
SELECT 'PRODUCTS',                        COUNT(*)              FROM PRODUCTS          UNION ALL
SELECT 'CLEAN_PRODUCTS',                  COUNT(*)              FROM CLEAN_PRODUCTS    UNION ALL
SELECT 'ORDERS',                          COUNT(*)              FROM ORDERS            UNION ALL
SELECT 'CLEAN_ORDERS',                    COUNT(*)              FROM CLEAN_ORDERS      UNION ALL
SELECT 'ORDER_ITEMS',                     COUNT(*)              FROM ORDER_ITEMS       UNION ALL
SELECT 'CLEAN_ORDER_ITEMS',               COUNT(*)              FROM CLEAN_ORDER_ITEMS;


-- ============================================================
-- SECTION 2 : NULL CHECK — CLEAN_CUSTOMERS
-- All values must be 0
-- ============================================================

SELECT
    'CLEAN_CUSTOMERS' AS table_name,
    SUM(CASE WHEN customer_name IS NULL THEN 1 ELSE 0 END) AS null_name,
    SUM(CASE WHEN email         IS NULL THEN 1 ELSE 0 END) AS null_email,
    SUM(CASE WHEN phone_number  IS NULL THEN 1 ELSE 0 END) AS null_phone,
    SUM(CASE WHEN city          IS NULL THEN 1 ELSE 0 END) AS null_city,
    SUM(CASE WHEN age           IS NULL THEN 1 ELSE 0 END) AS null_age,
    SUM(CASE WHEN gender        IS NULL THEN 1 ELSE 0 END) AS null_gender
FROM CLEAN_CUSTOMERS;


-- ============================================================
-- SECTION 3 : NULL CHECK — CLEAN_PRODUCTS
-- All values must be 0
-- ============================================================

SELECT
    'CLEAN_PRODUCTS' AS table_name,
    SUM(CASE WHEN product_name   IS NULL THEN 1 ELSE 0 END) AS null_name,
    SUM(CASE WHEN price          IS NULL THEN 1 ELSE 0 END) AS null_price,
    SUM(CASE WHEN category       IS NULL THEN 1 ELSE 0 END) AS null_category,
    SUM(CASE WHEN cost_price     IS NULL THEN 1 ELSE 0 END) AS null_cost,
    SUM(CASE WHEN stock_quantity IS NULL THEN 1 ELSE 0 END) AS null_stock
FROM CLEAN_PRODUCTS;


-- ============================================================
-- SECTION 4 : NULL CHECK — CLEAN_ORDERS
-- All values must be 0
-- ============================================================

SELECT
    'CLEAN_ORDERS' AS table_name,
    SUM(CASE WHEN order_date     IS NULL THEN 1 ELSE 0 END) AS null_date,
    SUM(CASE WHEN total_amount   IS NULL THEN 1 ELSE 0 END) AS null_amount,
    SUM(CASE WHEN status         IS NULL THEN 1 ELSE 0 END) AS null_status,
    SUM(CASE WHEN payment_method IS NULL THEN 1 ELSE 0 END) AS null_payment,
    SUM(CASE WHEN discount       IS NULL THEN 1 ELSE 0 END) AS null_discount
FROM CLEAN_ORDERS;


-- ============================================================
-- SECTION 5 : NULL CHECK — CLEAN_ORDER_ITEMS
-- All values must be 0
-- ============================================================

SELECT
    'CLEAN_ORDER_ITEMS' AS table_name,
    SUM(CASE WHEN quantity IS NULL THEN 1 ELSE 0 END) AS null_quantity
FROM CLEAN_ORDER_ITEMS;


-- ============================================================
-- SECTION 6 : PREVIEW ALL CLEAN TABLES
-- ============================================================

SELECT * FROM CLEAN_CUSTOMERS;
SELECT * FROM CLEAN_PRODUCTS;
SELECT * FROM CLEAN_ORDERS;
SELECT * FROM CLEAN_ORDER_ITEMS;


-- ============================================================
-- SECTION 7 : CONFIRM NO NULL DATES IN CLEAN_ORDERS
-- No rows should be returned here
-- ============================================================

SELECT order_id, customer_id, order_date, total_amount, status
FROM ORDERS
WHERE order_date IS NULL;


-- ============================================================
-- END OF SCRIPT 5
-- ============================================================
-- NEXT: Run Script 6 for Business Insights
-- ============================================================

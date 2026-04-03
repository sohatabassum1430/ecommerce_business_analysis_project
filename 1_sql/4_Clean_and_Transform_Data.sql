-- ============================================================
-- ECOMMERCE DATABASE - SCRIPT 4
-- Clean and Transform Data
-- ============================================================
-- Built by  : Soha Tabassum
-- Project   : ECOMMERCE Database
-- Database  : SQL Server
-- Tables    : CLEAN_CUSTOMERS | CLEAN_PRODUCTS | CLEAN_ORDERS | CLEAN_ORDER_ITEMS
-- ============================================================
--
-- TABLE OF CONTENTS:
-- ============================================================
-- SECTION 0 : DROP EXISTING CLEAN_ TABLES
-- SECTION 1 : CLEAN CUSTOMERS
-- SECTION 2 : CLEAN PRODUCTS
-- SECTION 3 : CLEAN ORDERS
-- SECTION 4 : CLEAN ORDER_ITEMS
-- SECTION 5 : VERIFY ROW COUNTS
-- ============================================================


USE ECOMMERCE;
GO


-- ============================================================
-- SECTION 0 : DROP EXISTING CLEAN_ TABLES
-- Safe to re-run this script anytime
-- Always drop in reverse order to respect foreign keys
-- ============================================================

IF OBJECT_ID('CLEAN_ORDER_ITEMS', 'U') IS NOT NULL DROP TABLE CLEAN_ORDER_ITEMS;
IF OBJECT_ID('CLEAN_ORDERS',      'U') IS NOT NULL DROP TABLE CLEAN_ORDERS;
IF OBJECT_ID('CLEAN_CUSTOMERS',   'U') IS NOT NULL DROP TABLE CLEAN_CUSTOMERS;
IF OBJECT_ID('CLEAN_PRODUCTS',    'U') IS NOT NULL DROP TABLE CLEAN_PRODUCTS;


-- ============================================================
-- SECTION 1 : CLEAN CUSTOMERS
-- Fix : Replace NULL email with 'No Email'
-- Fix : Replace NULL phone_number with 'No Phone'
-- Fix : Remove duplicate rows using ROW_NUMBER()
-- ============================================================

SELECT
    customer_id,
    customer_name,
    ISNULL(email,        'No Email') AS email,
    ISNULL(phone_number, 'No Phone') AS phone_number,
    ISNULL(city,         'Unknown')  AS city,
    ISNULL(age,          0)          AS age,
    ISNULL(gender,       'Unknown')  AS gender
INTO CLEAN_CUSTOMERS
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY customer_id) AS rn
    FROM CUSTOMERS
) AS deduped
WHERE rn = 1;

PRINT 'CLEAN_CUSTOMERS created — ' + CAST(@@ROWCOUNT AS VARCHAR) + ' rows';


-- ============================================================
-- SECTION 2 : CLEAN PRODUCTS
-- Fix : Replace any NULL values with safe defaults
-- Fix : Remove duplicate rows using ROW_NUMBER()
-- ============================================================

SELECT
    product_id,
    product_name,
    ISNULL(price,          0)         AS price,
    ISNULL(category,       'Unknown') AS category,
    ISNULL(cost_price,     0)         AS cost_price,
    ISNULL(stock_quantity, 0)         AS stock_quantity
INTO CLEAN_PRODUCTS
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY product_id) AS rn
    FROM PRODUCTS
) AS deduped
WHERE rn = 1;

PRINT 'CLEAN_PRODUCTS created — ' + CAST(@@ROWCOUNT AS VARCHAR) + ' rows';


-- ============================================================
-- SECTION 3 : CLEAN ORDERS
-- Fix : Replace any NULL values with safe defaults
-- Fix : Remove duplicate rows using ROW_NUMBER()
-- Fix : Exclude rows where order_date IS NULL
--       (date is required for all time-based analysis)
-- ============================================================

SELECT
    order_id,
    customer_id,
    order_date,
    ISNULL(total_amount,   0)         AS total_amount,
    ISNULL(status,         'Pending') AS status,
    ISNULL(payment_method, 'Cash')    AS payment_method,
    ISNULL(discount,       0)         AS discount
INTO CLEAN_ORDERS
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY order_id ORDER BY order_id) AS rn
    FROM ORDERS
    WHERE order_date IS NOT NULL
) AS deduped
WHERE rn = 1;

PRINT 'CLEAN_ORDERS created — ' + CAST(@@ROWCOUNT AS VARCHAR) + ' rows';


-- ============================================================
-- SECTION 4 : CLEAN ORDER_ITEMS
-- Fix : Replace NULL quantity with 0
-- Fix : Remove duplicate rows using ROW_NUMBER()
-- ============================================================

SELECT
    order_item_id,
    order_id,
    product_id,
    ISNULL(quantity, 0) AS quantity
INTO CLEAN_ORDER_ITEMS
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY order_item_id ORDER BY order_item_id) AS rn
    FROM ORDER_ITEMS
) AS deduped
WHERE rn = 1;

PRINT 'CLEAN_ORDER_ITEMS created — ' + CAST(@@ROWCOUNT AS VARCHAR) + ' rows';


-- ============================================================
-- SECTION 5 : VERIFY ROW COUNTS
-- Compare raw table rows vs clean table rows
-- ============================================================

SELECT 'CUSTOMERS'         AS table_name, COUNT(*) AS rows FROM CUSTOMERS        UNION ALL
SELECT 'CLEAN_CUSTOMERS',                 COUNT(*)         FROM CLEAN_CUSTOMERS   UNION ALL
SELECT 'PRODUCTS',                        COUNT(*)         FROM PRODUCTS          UNION ALL
SELECT 'CLEAN_PRODUCTS',                  COUNT(*)         FROM CLEAN_PRODUCTS    UNION ALL
SELECT 'ORDERS',                          COUNT(*)         FROM ORDERS            UNION ALL
SELECT 'CLEAN_ORDERS',                    COUNT(*)         FROM CLEAN_ORDERS      UNION ALL
SELECT 'ORDER_ITEMS',                     COUNT(*)         FROM ORDER_ITEMS       UNION ALL
SELECT 'CLEAN_ORDER_ITEMS',               COUNT(*)         FROM CLEAN_ORDER_ITEMS;


-- ============================================================
-- END OF SCRIPT 4
-- ============================================================
-- NEXT: Run Script 5 to verify clean data
-- ============================================================

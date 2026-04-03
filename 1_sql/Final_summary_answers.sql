-- ============================================================
-- ECOMMERCE DATABASE - ANSWERS & EXPECTED RESULTS
-- All 6 Scripts Combined
-- ============================================================
-- Built by  : Soha Tabassum
-- Project   : ECOMMERCE Database
-- Database  : SQL Server
-- ============================================================
--
-- TABLE OF CONTENTS:
-- ============================================================
-- SCRIPT 1 : Create Database and Tables       — No output
-- SCRIPT 2 : Insert Raw Data                  — Row counts
-- SCRIPT 3 : Explore and Profile Raw Data     — 11 checks
-- SCRIPT 4 : Clean and Transform Data         — Row counts
-- SCRIPT 5 : Verify and Validate Clean Data   — All zeros
-- SCRIPT 6 : Business Insights and KPIs       — Final numbers
-- ============================================================


-- ============================================================
-- SCRIPT 1 : CREATE DATABASE AND TABLES
-- ============================================================
-- No result output expected.
-- If script runs without errors — tables are created successfully.
-- ============================================================


-- ============================================================
-- SCRIPT 2 : INSERT RAW DATA
-- ============================================================

-- CUSTOMERS inserted:
-- 7 rows total (5 clean + 2 with intentional NULLs)

-- PRODUCTS inserted:
-- 12 rows total

-- ORDERS inserted:
-- 17 rows total (January 2024 to July 2024)

-- ORDER_ITEMS inserted:
-- 20 rows total

-- ============================================================


-- ============================================================
-- SCRIPT 3 : EXPLORE AND PROFILE RAW DATA
-- ============================================================

-- ── SECTION 1 : ROW COUNTS ───────────────────────────────────
/*
table_name    total_rows
----------    ----------
CUSTOMERS          7
PRODUCTS          12
ORDERS            17
ORDER_ITEMS       20
*/

-- ── SECTION 2 : NULL CHECK — CUSTOMERS ──────────────────────
/*
null_customer_name = 0    (NOT NULL constraint — cannot be empty)
null_email         = 1    (Customer 6 : NULL_Test1 has no email)
null_phone         = 1    (Customer 7 : NULL_Test2 has no phone)
null_city          = 0    (DEFAULT 'Unknown' fills automatically)
null_age           = 0    (DEFAULT 0 fills automatically)
null_gender        = 0    (DEFAULT 'Unknown' fills automatically)
*/

-- ── SECTION 3 : NULL CHECK — PRODUCTS ───────────────────────
/*
null_product_name = 0
null_price        = 0
null_category     = 0
null_cost_price   = 0
null_stock        = 0

All PRODUCTS columns have NOT NULL DEFAULT — no NULLs possible.
*/

-- ── SECTION 4 : NULL CHECK — ORDERS ─────────────────────────
/*
null_order_date    = 0
null_total_amount  = 0
null_status        = 0
null_payment_method= 0
null_discount      = 0

All ORDERS columns have NOT NULL DEFAULT — no NULLs possible.
*/

-- ── SECTION 5 : NULL CHECK — ORDER_ITEMS ────────────────────
/*
null_quantity = 0

quantity has NOT NULL DEFAULT 1 — no NULLs possible.
*/

-- ── SECTION 6 : DUPLICATE PRIMARY KEYS ──────────────────────
/*
No rows returned from any table.
PRIMARY KEY constraint prevents duplicate IDs entirely.
*/

-- ── SECTION 7 : DUPLICATE PRODUCT NAMES ─────────────────────
/*
product_name    count
------------    -----
Camera            2      (product 103 and 108 — different stock levels)
Laptop            2      (product 101 and 110 — different prices: 60000 vs 17000)

Note: These are different models — NOT a data error.
*/

-- ── SECTION 8 : DATA TYPES ───────────────────────────────────
/*
TABLE_NAME    COLUMN_NAME     DATA_TYPE     IS_NULLABLE
----------    -----------     ---------     -----------
CUSTOMERS     customer_id     int           NO
CUSTOMERS     customer_name   varchar       NO
CUSTOMERS     email           varchar       YES
CUSTOMERS     phone_number    varchar       YES
CUSTOMERS     city            varchar       YES
CUSTOMERS     age             int           YES
CUSTOMERS     gender          varchar       YES

PRODUCTS      product_id      int           NO
PRODUCTS      product_name    varchar       NO
PRODUCTS      price           decimal       NO
PRODUCTS      category        varchar       NO
PRODUCTS      cost_price      decimal       NO
PRODUCTS      stock_quantity  int           NO

ORDERS        order_id        int           NO
ORDERS        customer_id     int           YES
ORDERS        order_date      date          NO
ORDERS        total_amount    decimal       NO
ORDERS        status          varchar       NO
ORDERS        payment_method  varchar       NO
ORDERS        discount        decimal       NO

ORDER_ITEMS   order_item_id   int           NO
ORDER_ITEMS   order_id        int           YES
ORDER_ITEMS   product_id      int           YES
ORDER_ITEMS   quantity        int           NO
*/

-- ── SECTION 9 : CATEGORICAL VALUES ──────────────────────────
/*
ORDER STATUS:
status        count
---------     -----
Delivered       8
Pending         4
Shipped         3
Cancelled       2

PAYMENT METHOD:
payment_method  count
--------------  -----
Card              7
UPI               5
Cash              5

PRODUCT CATEGORY:
category        count
-----------     -----
Electronics       8
Accessories       1
Vehicles          1
Clothing          1
Footwear          1

CUSTOMER GENDER:
gender    count
------    -----
Female      3
Male        2
Unknown     2

CUSTOMER CITY:
city          count
----------    -----
Mumbai          2
Hyderabad       1
Delhi           1
Bangalore       1
Chennai         1
Unknown         1
*/

-- ── SECTION 10 : NEGATIVE VALUES ─────────────────────────────
/*
No rows returned from any table.
All values are 0 or positive — no negatives found.
*/

-- ── SECTION 11 : DATE RANGE ──────────────────────────────────
/*
earliest_order  = 2024-01-15
latest_order    = 2024-07-05
months_covered  = 7    (January to July 2024)
years_covered   = 1    (2024 only)
*/

-- ============================================================


-- ============================================================
-- SCRIPT 4 : CLEAN AND TRANSFORM DATA
-- ============================================================

-- ── ROW COUNTS AFTER CLEANING ────────────────────────────────
/*
table_name          rows
-----------------   ----
CUSTOMERS             7
CLEAN_CUSTOMERS       7
PRODUCTS             12
CLEAN_PRODUCTS       12
ORDERS               17
CLEAN_ORDERS         17
ORDER_ITEMS          20
CLEAN_ORDER_ITEMS    20

Raw and clean row counts match — no rows lost during cleaning.
*/

-- ── NULLS REPLACED ───────────────────────────────────────────
/*
CLEAN_CUSTOMERS:
  NULL email        → 'No Email'   (Customer 6)
  NULL phone_number → 'No Phone'   (Customer 7)

CLEAN_PRODUCTS:
  No NULLs existed — no changes needed.

CLEAN_ORDERS:
  No NULLs existed — no changes needed.
  Rows with NULL order_date excluded (none in this dataset).

CLEAN_ORDER_ITEMS:
  No NULLs existed — no changes needed.
*/

-- ============================================================


-- ============================================================
-- SCRIPT 5 : VERIFY AND VALIDATE CLEAN DATA
-- ============================================================

-- ── NULL CHECKS — ALL MUST SHOW 0 ────────────────────────────
/*
CLEAN_CUSTOMERS:
  null_name  = 0
  null_email = 0
  null_phone = 0
  null_city  = 0
  null_age   = 0
  null_gender= 0

CLEAN_PRODUCTS:
  null_name     = 0
  null_price    = 0
  null_category = 0
  null_cost     = 0
  null_stock    = 0

CLEAN_ORDERS:
  null_date    = 0
  null_amount  = 0
  null_status  = 0
  null_payment = 0
  null_discount= 0

CLEAN_ORDER_ITEMS:
  null_quantity = 0

All checks pass — data is clean and ready for analysis.
*/

-- ── NULL DATE CHECK ───────────────────────────────────────────
/*
No rows returned.
All orders in this dataset have a valid order_date.
*/

-- ============================================================


-- ============================================================
-- SCRIPT 6 : BUSINESS INSIGHTS AND KPI ANALYSIS
-- ============================================================

-- ── SECTION A : FINANCIAL KPIs ───────────────────────────────
/*
gross_revenue    = 201,969
total_discount   =   1,800
net_revenue      = 200,169
total_orders     =      17
avg_order_value  =  11,775.82
*/

-- ── SECTION B : CUSTOMER ANALYSIS ────────────────────────────
/*
B1 — Top customer by net spend:
  Ali      (customer 1) — highest spender — 4 orders

B2 — Revenue per customer:
  revenue_per_customer = 28,595.57

B3 — Revenue by city:
  city          city_revenue
  ----------    ------------
  Hyderabad       highest (Ali)
  Mumbai          second
  Delhi           third

B4 — Revenue by age group:
  age_group    revenue
  ---------    -------
  26-35          highest
  18-25          second
  36-45          third
*/

-- ── SECTION C : PRODUCT ANALYSIS ─────────────────────────────
/*
C1 — Best selling products by quantity ordered:
  Run query to see full ranking.
  Products linked to ORDER_ITEMS with highest SUM(quantity) rank first.

C2 — Total stock value:
  total_stock_value_at_price  = 5,251,000
  total_stock_value_at_cost   = 2,220,000

C3 — Products never ordered:
  Any product_id not found in ORDER_ITEMS will appear here.
  Run query to confirm.
*/

-- ── SECTION D : OPERATIONAL METRICS ──────────────────────────
/*
D1 — Order status breakdown:
  status      order_count    percentage    revenue
  ---------   -----------    ----------    -------
  Delivered        8          47.06%       148,469
  Pending          4          23.53%        16,900
  Shipped          3          17.65%         6,500
  Cancelled        2          11.76%        24,000

D2 — Rates:
  delivery_rate_pct     = 47.06%
  cancellation_rate_pct = 11.76%
  pending_rate_pct      = 23.53%
  shipped_rate_pct      = 17.65%

D3 — Payment method breakdown:
  payment_method    order_count    percentage    revenue
  --------------    -----------    ----------    -------
  Card                   7          41.18%       88,800
  UPI                    5          29.41%       57,569
  Cash                   5          29.41%       58,800
*/

-- ── SECTION E : TIME BASED ANALYSIS ──────────────────────────
/*
E1 — Monthly revenue trend (Jan to Jul 2024):
  month_name    orders_count    net_revenue
  ----------    ------------    -----------
  January            1            19,500
  February           2             4,869
  March              2            25,900
  April              3            63,800
  May                3            27,650
  June               4            48,350
  July               2            10,100

E2 — Revenue YTD (running total increases each month)

E3 — Month over Month growth:
  Highest growth : March to April (big jump due to 60,000 bike order)
  First month    : January has no previous — mom_growth_pct = NULL
*/

-- ── SECTION F : COMPLETE BUSINESS SUMMARY ────────────────────
/*
gross_revenue       = 201,969
total_discount      =   1,800
net_revenue         = 200,169
total_orders        =      17
avg_order_value     =  11,775.82
active_customers    =       7
revenue_per_customer=  28,595.57
delivered_orders    =       8
cancelled_orders    =       2
delivery_rate_pct   =   47.06%
cancellation_rate_pct=  11.76%
*/

-- ============================================================
-- END OF ANSWERS SCRIPT
-- ============================================================

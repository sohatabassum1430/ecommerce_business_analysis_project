-- ============================================================
-- ECOMMERCE DATABASE - ULTIMATE COMPLETE SCRIPT
-- ============================================================
-- Built by  : Soha Tabassum
-- Project   : ECOMMERCE Database
-- Database  : SQL Server
-- Duration  : 4 Days
-- Tables    : CUSTOMERS | PRODUCTS | ORDERS | ORDER_ITEMS
-- ============================================================
--
-- TABLE OF CONTENTS:
-- ============================================================
-- SECTION 1  : CREATE DATABASE & TABLES
-- SECTION 2  : INSERT DATA
-- SECTION 3  : BASIC QUERIES
-- SECTION 4  : UPDATE QUERIES
-- SECTION 5  : JOINS
-- SECTION 6  : DATABASE CONSTRAINTS
-- SECTION 7  : SUBQUERIES
-- SECTION 8  : AGGREGATIONS
-- SECTION 9  : VIEWS
-- SECTION 10 : WINDOW FUNCTIONS
-- SECTION 11 : CASE STATEMENTS
-- SECTION 12 : TRIGGERS
-- SECTION 13 : INDEXES
-- SECTION 14 : STORED PROCEDURES
-- SECTION 15 : CONCAT & STRING FUNCTIONS
-- SECTION 16 : NULL HANDLING
-- SECTION 17 : LAG & LEAD
-- SECTION 18 : PERCENTAGE & DATE FUNCTIONS
-- SECTION 19 : BUSINESS INSIGHTS (BI-1 to BI-7)
-- ============================================================


-- ============================================================
-- SECTION 1: CREATE DATABASE & TABLES
-- ============================================================

CREATE DATABASE ECOMMERCE;
USE ECOMMERCE;

-- CUSTOMERS TABLE
-- Columns: customer_id, customer_name, email, phone_number, city, age, gender
CREATE TABLE CUSTOMERS (
    customer_id   INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email         VARCHAR(100) UNIQUE,
    phone_number  VARCHAR(20),
    city          VARCHAR(50),
    age           INT,
    gender        VARCHAR(10)
);

-- PRODUCTS TABLE
-- Columns: product_id, product_name, price, category, cost_price, stock_quantity
CREATE TABLE PRODUCTS (
    product_id     INT PRIMARY KEY,
    product_name   VARCHAR(100),
    price          DECIMAL(10,2),
    category       VARCHAR(50),
    cost_price     DECIMAL(10,2),
    stock_quantity INT
);

-- ORDERS TABLE
-- Columns: order_id, customer_id, order_date, total_amount, status, payment_method, discount
CREATE TABLE ORDERS (
    order_id       INT PRIMARY KEY,
    customer_id    INT REFERENCES CUSTOMERS(customer_id),
    order_date     DATE,
    total_amount   DECIMAL(10,2),
    status         VARCHAR(20) DEFAULT 'Pending',
    payment_method VARCHAR(20),
    discount       DECIMAL(10,2) DEFAULT 0
);

-- ORDER_ITEMS TABLE
-- Columns: order_item_id, order_id, product_id, quantity
CREATE TABLE ORDER_ITEMS (
    order_item_id INT PRIMARY KEY,
    order_id      INT REFERENCES ORDERS(order_id),
    product_id    INT REFERENCES PRODUCTS(product_id),
    quantity      INT
);


-- ============================================================
-- SECTION 2: INSERT DATA
-- ============================================================

-- INSERT CUSTOMERS
-- 5 real customers + 2 NULL test records
INSERT INTO CUSTOMERS (customer_id, customer_name, email, phone_number, city, age, gender)
VALUES
(1, 'Ali',        'ali@gmail.com',     '03001234567', 'Hyderabad', 28, 'Male'),
(2, 'Raha',       'raha24@gmail.com',  '1293548460',  'Mumbai',    25, 'Female'),
(3, 'John',       'john10@gmail.com',  '1293808460',  'Delhi',     32, 'Male'),
(4, 'Sammy',      'sam13@gmail.com',   '0296548460',  'Bangalore', 22, 'Female'),
(5, 'Dina',       'din12@gmail.com',   '3290548760',  'Chennai',   35, 'Female'),
-- NULL test records for NULL handling practice
(6, 'NULL_Test1', NULL,                '1234567890',  NULL,        NULL, 'Male'),
(7, 'NULL_Test2', 'null2@gmail.com',   NULL,          'Mumbai',    28,   NULL);

-- INSERT PRODUCTS
-- 10 real products + 2 NULL test records
INSERT INTO PRODUCTS (product_id, product_name, price, category, cost_price, stock_quantity)
VALUES
(101, 'Laptop',     60000.00, 'Electronics', 15000.00,  50),
(102, 'Watch',       4000.00, 'Electronics',  3000.00,  30),
(103, 'Camera',     10000.00, 'Electronics',  7000.00,  20),
(104, 'Bag',         1000.00, 'Accessories',   500.00, 100),
(105, 'Mobile',     25000.00, 'Electronics', 18000.00,  15),
(106, 'Bike',       60000.00, 'Vehicles',    45000.00,   5),
(107, 'Shirt',       2000.00, 'Clothing',      800.00, 200),
(108, 'Camera',     10000.00, 'Electronics',  7000.00,  25),
(109, 'Shoes',       3200.00, 'Footwear',    1500.00,   80),
(110, 'Laptop',     17000.00, 'Electronics', 12000.00,  10),
-- NULL test records for NULL handling practice
(111, 'Tablet',         NULL, 'Electronics',  8000.00,  15),
(112, 'Headphones',  2000.00,  NULL,              NULL,  40);

-- INSERT ORDERS
-- 15 real orders + 2 NULL test records
INSERT INTO ORDERS (order_id, customer_id, order_date, total_amount, status, payment_method, discount)
VALUES
(101, 1, '2024-01-15', 20000.00, 'Delivered', 'Card',  500.00),
(102, 2, '2024-02-14',  3569.00, 'Delivered', 'UPI',     0.00),
(103, 1, '2024-02-15',  1500.00, 'Shipped',   'Cash',  200.00),
(104, 3, '2024-03-01', 25000.00, 'Delivered', 'Card',    0.00),
(105, 4, '2024-03-15',  1000.00, 'Pending',   'UPI',   100.00),
(106, 5, '2024-04-01',  4000.00, 'Cancelled', 'Card',    0.00),
(107, 1, '2024-04-10', 60000.00, 'Delivered', 'Cash',  300.00),
(108, 2, '2024-04-15',  3200.00, 'Shipped',   'UPI',     0.00),
(109, 3, '2024-05-01',  2000.00, 'Delivered', 'Card',  150.00),
(110, 4, '2024-05-10', 10000.00, 'Pending',   'Cash',    0.00),
(111, 5, '2024-05-15', 17000.00, 'Delivered', 'UPI',   200.00),
(112, 1, '2024-06-01', 20000.00, 'Cancelled', 'Card',    0.00),
(113, 2, '2024-06-10', 25000.00, 'Delivered', 'Cash',  100.00),
(114, 3, '2024-06-15',  3200.00, 'Shipped',   'UPI',     0.00),
(115, 4, '2024-06-20',  1500.00, 'Delivered', 'Card',  250.00),
-- NULL test records for NULL handling practice
(116, 6, '2024-07-01',     NULL, 'Pending',    NULL,    0.00),
(117, 7, '2024-07-05',  5000.00,  NULL,       'Card',    NULL);

-- INSERT ORDER_ITEMS
-- 20 records linking orders to products
INSERT INTO ORDER_ITEMS (order_item_id, order_id, product_id, quantity)
VALUES
(1,  101, 101, 2), (2,  104, 103, 3), (3,  106, 105, 4),
(4,  103, 103, 4), (5,  102, 102, 1), (6,  105, 104, 2),
(7,  107, 106, 1), (8,  108, 107, 3), (9,  109, 108, 2),
(10, 110, 109, 4), (11, 111, 110, 1), (12, 112, 101, 2),
(13, 113, 102, 3), (14, 114, 103, 1), (15, 115, 104, 2),
(16, 101, 105, 3), (17, 102, 106, 1), (18, 103, 107, 2),
(19, 104, 108, 4), (20, 105, 109, 1);


-- ============================================================
-- SECTION 3: BASIC QUERIES
-- ============================================================

-- Retrieve all customers
SELECT * FROM CUSTOMERS;

-- Retrieve orders for a specific customer
SELECT * FROM ORDERS
WHERE customer_id = 2;

-- Retrieve order amount with customer name
SELECT 
    o.order_id,
    o.order_date,
    c.customer_name,
    o.total_amount
FROM ORDERS o
JOIN CUSTOMERS c ON o.customer_id = c.customer_id
ORDER BY c.customer_name DESC;

-- Retrieve products above a specific price
SELECT product_name, price
FROM PRODUCTS
WHERE price > 2000;

-- Retrieve total quantity sold per product
SELECT 
    p.product_name,
    SUM(oi.quantity) AS total_quantity
FROM ORDER_ITEMS oi
JOIN PRODUCTS p ON oi.product_id = p.product_id
GROUP BY p.product_name;

-- Retrieve customer with highest total purchase
SELECT TOP 1
    c.customer_name,
    SUM(o.total_amount) AS total_spent
FROM ORDERS o
JOIN CUSTOMERS c ON o.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;

-- Retrieve customers who have not placed any orders
SELECT 
    c.customer_id,
    c.customer_name
FROM CUSTOMERS c
LEFT JOIN ORDERS o ON o.customer_id = c.customer_id
WHERE o.customer_id IS NULL;

-- Retrieve most ordered product
SELECT TOP 1
    p.product_name,
    SUM(oi.quantity) AS total_quantity
FROM ORDER_ITEMS oi
JOIN PRODUCTS p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantity DESC;

-- Retrieve customers who ordered a specific product
SELECT DISTINCT
    c.customer_id,
    c.customer_name
FROM CUSTOMERS c
JOIN ORDERS o       ON c.customer_id = o.customer_id
JOIN ORDER_ITEMS oi ON o.order_id = oi.order_id
JOIN PRODUCTS p     ON oi.product_id = p.product_id
WHERE p.product_id = 102;


-- ============================================================
-- SECTION 4: UPDATE QUERIES
-- ============================================================

-- 1. Update price of a specific product
UPDATE PRODUCTS
SET price = 60000
WHERE product_id = 101;

-- Verify update
SELECT product_name, price
FROM PRODUCTS
WHERE product_id = 101;

-- 2. Update customer details for a specific customer
UPDATE CUSTOMERS
SET email = 'raha24@gmail.com'
WHERE customer_name = 'Raha';

-- Verify update
SELECT * FROM CUSTOMERS
WHERE customer_name = 'Raha';


-- ============================================================
-- SECTION 5: JOINS
-- ============================================================

-- INNER JOIN: Order details with customer name
SELECT
    c.customer_name,
    o.order_id,
    o.order_date,
    o.total_amount,
    o.status,
    o.payment_method,
    o.discount
FROM ORDERS o
INNER JOIN CUSTOMERS c ON o.customer_id = c.customer_id
ORDER BY o.order_date;

-- LEFT JOIN: All customers including those with no orders
SELECT
    c.customer_id,
    c.customer_name,
    c.city,
    o.order_id,
    o.order_date,
    o.total_amount,
    o.status
FROM CUSTOMERS c
LEFT JOIN ORDERS o ON c.customer_id = o.customer_id
ORDER BY c.customer_id;


-- ============================================================
-- SECTION 6: DATABASE CONSTRAINTS
-- ============================================================

-- Add unique constraint on email column
ALTER TABLE CUSTOMERS
ADD CONSTRAINT email_id UNIQUE (email);

-- Verify constraint
SELECT * FROM CUSTOMERS;

-- Verify all constraints on CUSTOMERS table
SELECT
    CONSTRAINT_NAME,
    COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_NAME = 'CUSTOMERS';


-- ============================================================
-- SECTION 7: SUBQUERIES
-- ============================================================

-- Customers who ordered products above average price
SELECT
    c.customer_id,
    c.customer_name
FROM CUSTOMERS c
JOIN ORDERS o       ON c.customer_id = o.customer_id
JOIN ORDER_ITEMS oi ON oi.order_id = o.order_id
JOIN PRODUCTS p     ON p.product_id = oi.product_id
WHERE p.price > (SELECT AVG(price) FROM PRODUCTS);

-- Customers who have not ordered after a specific date
SELECT
    c.customer_id,
    c.customer_name
FROM CUSTOMERS c
WHERE c.customer_id NOT IN (
    SELECT o.customer_id
    FROM ORDERS o
    WHERE o.order_date > '2024-06-01'
);


-- ============================================================
-- SECTION 8: AGGREGATIONS
-- ============================================================

-- Total orders per customer
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM CUSTOMERS c
JOIN ORDERS o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_orders DESC;

-- Customers with more than 2 orders (HAVING)
SELECT
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM CUSTOMERS c
JOIN ORDERS o ON c.customer_id = o.customer_id
GROUP BY c.customer_name
HAVING COUNT(o.order_id) > 2;

-- Maximum order amount (Approach 1 - with details)
SELECT TOP 1
    o.order_id,
    c.customer_name,
    o.order_date,
    o.total_amount AS max_order_amount,
    o.status
FROM ORDERS o
JOIN CUSTOMERS c ON o.customer_id = c.customer_id
ORDER BY o.total_amount DESC;

-- Maximum order amount (Approach 2 - simple)
SELECT MAX(total_amount) AS max_order_amount
FROM ORDERS;

-- Average price of all products
SELECT ROUND(AVG(price), 2) AS avg_price
FROM PRODUCTS;


-- ============================================================
-- SECTION 9: VIEWS
-- ============================================================

-- Create ORDER_DETAILS view
CREATE VIEW ORDER_DETAILS AS
SELECT
    c.customer_name,
    o.order_id,
    o.order_date,
    o.total_amount
FROM ORDERS o
JOIN CUSTOMERS c ON o.customer_id = c.customer_id;

-- Query the ORDER_DETAILS view
SELECT
    customer_name,
    order_id,
    order_date,
    total_amount
FROM ORDER_DETAILS;


-- ============================================================
-- SECTION 10: WINDOW FUNCTIONS
-- ============================================================

-- Rank customers by total purchase amount
SELECT
    c.customer_id,
    c.customer_name,
    SUM(o.total_amount) AS total_spent,
    RANK() OVER (ORDER BY SUM(o.total_amount) DESC) AS customer_rank
FROM CUSTOMERS c
JOIN ORDERS o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- Cumulative sum of order amounts per customer
SELECT
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.order_date,
    o.total_amount,
    SUM(o.total_amount) OVER (
        PARTITION BY c.customer_id
        ORDER BY o.order_date
    ) AS running_total
FROM ORDERS o
JOIN CUSTOMERS c ON o.customer_id = c.customer_id;


-- ============================================================
-- SECTION 11: CASE STATEMENTS
-- ============================================================

-- Categorize orders by value
SELECT
    order_id,
    order_date,
    total_amount,
    CASE
        WHEN total_amount < 2000              THEN 'Low Value'
        WHEN total_amount BETWEEN 2000 AND 5000 THEN 'Medium Value'
        ELSE                                      'High Value'
    END AS order_status
FROM ORDERS;


-- ============================================================
-- SECTION 12: TRIGGERS
-- ============================================================

-- Auto-update total_amount when order item is inserted
CREATE TRIGGER trg_update_total
ON ORDER_ITEMS
AFTER INSERT
AS
BEGIN
    UPDATE ORDERS
    SET total_amount = (
        SELECT SUM(oi.quantity * p.price)
        FROM ORDER_ITEMS oi
        JOIN PRODUCTS p ON oi.product_id = p.product_id
        WHERE oi.order_id IN (SELECT order_id FROM INSERTED)
    )
    WHERE order_id IN (SELECT order_id FROM INSERTED);
END;


-- ============================================================
-- SECTION 13: INDEXES
-- ============================================================

-- Create index on product_name for faster queries
CREATE INDEX PRODUCT_INDEX ON PRODUCTS (product_name);


-- ============================================================
-- SECTION 14: STORED PROCEDURES
-- ============================================================

-- Procedure 1: Get total orders by customer ID
CREATE PROCEDURE GetCustomerOrders
    @customer_id INT
AS
BEGIN
    SELECT
        customer_id,
        COUNT(order_id) AS total_orders
    FROM ORDERS
    WHERE customer_id = @customer_id
    GROUP BY customer_id;
END;

-- Execute for Ali
EXEC GetCustomerOrders @customer_id = 1;

-- Execute for Raha
EXEC GetCustomerOrders @customer_id = 2;

-- Procedure 2: Get orders between date range
CREATE PROCEDURE OrdersDates (
    @start_date DATE,
    @end_date   DATE
)
AS
BEGIN
    SELECT order_id, order_date
    FROM ORDERS
    WHERE order_date BETWEEN @start_date AND @end_date;
END;

-- Execute date range
EXEC OrdersDates
    @start_date = '2024-01-01',
    @end_date   = '2024-06-30';


-- ============================================================
-- SECTION 15: CONCAT & STRING FUNCTIONS
-- ============================================================

-- Product full information using CONCAT
SELECT
    product_id,
    CONCAT(product_name, ' (', category, ') - Rs.', price)       AS product_info,
    CONCAT('Cost: Rs.', cost_price, ' | Stock: ', stock_quantity) AS product_details,
    price - cost_price AS profit_per_unit
FROM PRODUCTS;

-- CAST examples
-- Date to VARCHAR
SELECT CAST(order_date AS VARCHAR(20)) AS date_as_text FROM ORDERS;

-- INT to DECIMAL
SELECT CAST(quantity AS DECIMAL(10,2)) AS qty_decimal FROM ORDER_ITEMS;

-- VARCHAR to INT
SELECT CAST('123' AS INT) AS text_to_int;


-- ============================================================
-- SECTION 16: NULL HANDLING
-- ============================================================

-- Replace NULLs with default text using ISNULL and UNION
SELECT
    ISNULL(customer_name, 'Unknown Customer') AS name,
    ISNULL(city,          'No City')          AS details
FROM CUSTOMERS
UNION
SELECT
    ISNULL(product_name, 'Unknown Product') AS name,
    ISNULL(category,     'No Category')     AS details
FROM PRODUCTS;

-- COALESCE: Return first non-NULL value
SELECT
    order_id,
    COALESCE(total_amount,   0)     AS safe_amount,
    COALESCE(payment_method, 'N/A') AS safe_payment,
    COALESCE(discount,       0)     AS safe_discount
FROM ORDERS;


-- ============================================================
-- SECTION 17: LAG & LEAD
-- ============================================================

-- LEAD: Each order with next order amount and trend
SELECT
    order_id,
    order_date,
    COALESCE(total_amount, 0) AS total_amount,
    COALESCE(LEAD(total_amount, 1) OVER (ORDER BY order_date), 0) AS next_order,
    CASE
        WHEN COALESCE(total_amount, 0) > COALESCE(LEAD(total_amount, 1) OVER (ORDER BY order_date), 0) THEN 'HIGHER'
        WHEN COALESCE(total_amount, 0) < COALESCE(LEAD(total_amount, 1) OVER (ORDER BY order_date), 0) THEN 'LOWER'
        ELSE 'SAME'
    END AS next_trend
FROM ORDERS;

-- LAG + LEAD: Previous and next order comparison
SELECT
    order_id,
    order_date,
    COALESCE(total_amount, 0) AS total_amount,
    COALESCE(LAG(total_amount,  1) OVER (ORDER BY order_date), 0) AS prev_order,
    COALESCE(LEAD(total_amount, 1) OVER (ORDER BY order_date), 0) AS next_order,
    CASE
        WHEN COALESCE(total_amount, 0) > COALESCE(LEAD(total_amount, 1) OVER (ORDER BY order_date), 0) THEN 'HIGHER'
        WHEN COALESCE(total_amount, 0) < COALESCE(LEAD(total_amount, 1) OVER (ORDER BY order_date), 0) THEN 'LOWER'
        ELSE 'EQUAL'
    END AS next_trend,
    CASE
        WHEN COALESCE(total_amount, 0) > COALESCE(LAG(total_amount, 1) OVER (ORDER BY order_date), 0) THEN 'HIGHER'
        WHEN COALESCE(total_amount, 0) < COALESCE(LAG(total_amount, 1) OVER (ORDER BY order_date), 0) THEN 'LOWER'
        ELSE 'EQUAL'
    END AS prev_trend
FROM ORDERS;


-- ============================================================
-- SECTION 18: PERCENTAGE & DATE FUNCTIONS
-- ============================================================

-- Each order percentage contribution to total revenue
SELECT
    order_id,
    total_amount,
    CONCAT(
        CAST(ROUND((total_amount / SUM(total_amount) OVER()) * 100, 2) AS DECIMAL(5,2)),
        '%'
    ) AS pct_of_total
FROM ORDERS;

-- Monthly sales with percentage and date span
-- NULL handling + Percentage + Date functions combined
SELECT
    YEAR(order_date)  AS order_year,
    MONTH(order_date) AS order_month,
    SUM(COALESCE(total_amount, 0)) AS monthly_sales,
    CAST(ROUND(
        (SUM(COALESCE(total_amount, 0)) / SUM(SUM(COALESCE(total_amount, 0))) OVER()) * 100, 2
    ) AS DECIMAL(6,2)) AS pct_of_total,
    DATEDIFF(DAY, MIN(order_date), MAX(order_date)) AS days_span
FROM ORDERS
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY order_year, order_month;


-- ============================================================
-- SECTION 19: BUSINESS INSIGHTS
-- ============================================================
-- Tables Used:
-- CUSTOMERS   → customer_id, customer_name, email, phone_number, city, age, gender
-- PRODUCTS    → product_id, product_name, price, category, cost_price, stock_quantity
-- ORDERS      → order_id, customer_id, order_date, total_amount, status, payment_method, discount
-- ORDER_ITEMS → order_item_id, order_id, product_id, quantity
-- ============================================================

------------------------------------------------------------
-- BI-1: TOTAL REVENUE
-- Business Question: What is the total revenue from all orders?
-- Columns Used: total_amount → ORDERS
------------------------------------------------------------
SELECT SUM(total_amount) AS total_revenue
FROM ORDERS;

------------------------------------------------------------
-- BI-2: TOTAL SPENT BY CUSTOMERS
-- Business Question: Which customers spent the most?
-- Show name, total orders and total amount spent
-- Columns Used: customer_id, customer_name → CUSTOMERS
--               order_id, total_amount → ORDERS
------------------------------------------------------------
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id)                AS total_orders,
    COALESCE(SUM(o.total_amount), 0) AS total_spent
FROM CUSTOMERS c
JOIN ORDERS o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC;

------------------------------------------------------------
-- BI-3: MONTHLY REVENUE TREND
-- Business Question: Which month had highest sales?
-- Show year, month name and total revenue
-- Columns Used: order_date, total_amount → ORDERS
------------------------------------------------------------
SELECT
    YEAR(order_date)               AS year_sales,
    DATENAME(MONTH, order_date)    AS month_name,
    SUM(COALESCE(total_amount, 0)) AS total_revenue
FROM ORDERS
GROUP BY
    YEAR(order_date),
    MONTH(order_date),
    DATENAME(MONTH, order_date)
ORDER BY year_sales, MONTH(order_date);

------------------------------------------------------------
-- BI-4: REVENUE BY ORDER STATUS
-- Business Question: How much revenue came from each order status?
-- Columns Used: status, order_id, total_amount → ORDERS
------------------------------------------------------------
SELECT
    status,
    COUNT(order_id)   AS total_orders,
    SUM(total_amount) AS total_revenue
FROM ORDERS
WHERE status IS NOT NULL
GROUP BY status
ORDER BY total_revenue DESC;

------------------------------------------------------------
-- BI-5: BEST SELLING PRODUCTS
-- Business Question: Which products sold the most?
-- Show units sold and total revenue
-- Columns Used: product_id, product_name, price → PRODUCTS
--               quantity → ORDER_ITEMS
------------------------------------------------------------
SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity)           AS units_sold,
    SUM(p.price * oi.quantity) AS total_revenue
FROM PRODUCTS p
JOIN ORDER_ITEMS oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_revenue DESC;

------------------------------------------------------------
-- BI-6: PROFIT PER UNIT AND PROFIT MARGIN
-- Business Question: Which products are most profitable?
-- Show profit per unit and profit margin percentage
-- Columns Used: product_name, price, cost_price → PRODUCTS
------------------------------------------------------------
SELECT
    product_name,
    price - cost_price AS profit_per_unit,
    CAST(ROUND(
        (price - cost_price) / price * 100, 2
    ) AS DECIMAL(10,2)) AS profit_margin_pct
FROM PRODUCTS
WHERE price IS NOT NULL
AND cost_price IS NOT NULL
ORDER BY profit_margin_pct DESC;

------------------------------------------------------------
-- BI-7: CUSTOMER LIFETIME VALUE (CLV)
-- Business Question: Who are our most valuable customers?
-- Show lifetime value and rank
-- Columns Used: customer_id, customer_name → CUSTOMERS
--               total_amount → ORDERS
------------------------------------------------------------
SELECT
    c.customer_id,
    c.customer_name,
    COALESCE(SUM(o.total_amount), 0)                AS lifetime_value,
    RANK() OVER (ORDER BY SUM(o.total_amount) DESC) AS clv_rank
FROM ORDERS o
JOIN CUSTOMERS c ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY lifetime_value DESC;

------------------------------------------------------------
-- BI-7 ADVANCED: CLV WITH % CONTRIBUTION
-- Business Question: Who are our most valuable customers?
-- Show lifetime spending, % contribution,
-- first and last order month, year and rank
------------------------------------------------------------

-- Approach 1: Single Query
SELECT
    c.customer_id,
    c.customer_name,
    COALESCE(SUM(o.total_amount), 0)                  AS lifetime_value,
    COALESCE(CAST(ROUND(
        (SUM(o.total_amount) / SUM(SUM(o.total_amount)) OVER()) * 100
    , 2) AS DECIMAL(10,2)), 0)                        AS lifetime_pct,
    MIN(YEAR(o.order_date))                           AS first_order_year,
    MAX(YEAR(o.order_date))                           AS last_order_year,
    DATENAME(MONTH, MIN(o.order_date))                AS first_month,
    DATENAME(MONTH, MAX(o.order_date))                AS last_month,
    RANK() OVER (ORDER BY SUM(o.total_amount) DESC)   AS clv_rank,
    SUM(SUM(o.total_amount)) OVER (
        PARTITION BY MIN(YEAR(o.order_date))
    )                                                 AS yearly_total
FROM ORDERS o
JOIN CUSTOMERS c ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY lifetime_value DESC;

------------------------------------------------------------
-- Approach 2: Using CTE (Common Table Expression)
-- Cleaner and easier to read and debug
------------------------------------------------------------
WITH CustomerSpending AS (
    -- CTE 1: Basic spending per customer
    SELECT
        c.customer_id,
        c.customer_name,
        COALESCE(SUM(o.total_amount), 0)   AS lifetime_value,
        DATENAME(MONTH, MIN(o.order_date)) AS first_month,
        DATENAME(MONTH, MAX(o.order_date)) AS last_month,
        MIN(YEAR(o.order_date))            AS first_year,
        MAX(YEAR(o.order_date))            AS last_year
    FROM ORDERS o
    JOIN CUSTOMERS c ON o.customer_id = c.customer_id
    GROUP BY c.customer_id, c.customer_name
),
TotalRevenue AS (
    -- CTE 2: Calculate total revenue
    SELECT SUM(lifetime_value) AS total_revenue
    FROM CustomerSpending
),
FinalCLV AS (
    -- CTE 3: Add percentage, rank and yearly total
    SELECT
        cs.customer_id,
        cs.customer_name,
        cs.lifetime_value,
        COALESCE(CAST(ROUND(
            (cs.lifetime_value / NULLIF(tr.total_revenue, 0)) * 100
        , 2) AS DECIMAL(10,2)), 0)            AS lifetime_pct,
        cs.first_month,
        cs.last_month,
        cs.first_year,
        cs.last_year,
        RANK() OVER (
            ORDER BY cs.lifetime_value DESC
        )                                     AS clv_rank,
        SUM(cs.lifetime_value) OVER (
            PARTITION BY cs.first_year
        )                                     AS yearly_total
    FROM CustomerSpending cs
    CROSS JOIN TotalRevenue tr
)
-- Final Result
SELECT * FROM FinalCLV
ORDER BY clv_rank;


-- ============================================================
-- END OF SCRIPT
-- ============================================================
-- Built by  : Soha Tabassum
-- Project   : ECOMMERCE Database
-- Duration  : 4 Days
-- Sections  : 19 Complete Sections
-- ============================================================

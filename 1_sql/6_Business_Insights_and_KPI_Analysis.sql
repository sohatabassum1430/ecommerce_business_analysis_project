-- ============================================================
-- ECOMMERCE DATABASE - SCRIPT 6
-- Business Insights and KPI Analysis
-- ============================================================
-- Built by  : Soha Tabassum
-- Project   : ECOMMERCE Database
-- Database  : SQL Server
-- Tables    : CLEAN_CUSTOMERS | CLEAN_PRODUCTS | CLEAN_ORDERS | CLEAN_ORDER_ITEMS
-- ============================================================
--
-- TABLE OF CONTENTS:
-- ============================================================
-- SECTION A : FINANCIAL KPIs
-- SECTION B : CUSTOMER ANALYSIS
-- SECTION C : PRODUCT ANALYSIS
-- SECTION D : OPERATIONAL METRICS
-- SECTION E : TIME BASED ANALYSIS
-- SECTION F : COMPLETE BUSINESS SUMMARY
-- ============================================================


USE ECOMMERCE;
GO


-- ============================================================
-- SECTION A : FINANCIAL KPIs
-- ============================================================

-- A1: Total Revenue, Discount, Net Revenue, Orders, Avg Order Value
SELECT
    SUM(total_amount)                                                       AS gross_revenue,
    SUM(discount)                                                           AS total_discount,
    SUM(total_amount) - SUM(discount)                                       AS net_revenue,
    COUNT(order_id)                                                         AS total_orders,
    ROUND((SUM(total_amount) - SUM(discount)) * 1.0 / COUNT(order_id), 2)  AS avg_order_value
FROM CLEAN_ORDERS;


-- ============================================================
-- SECTION B : CUSTOMER ANALYSIS
-- ============================================================

-- B1: Revenue and Orders per Customer
SELECT
    c.customer_id,
    c.customer_name,
    c.city,
    c.age,
    c.gender,
    COUNT(o.order_id)                                                             AS total_orders,
    SUM(o.total_amount)                                                           AS gross_spent,
    SUM(o.discount)                                                               AS total_discount,
    SUM(o.total_amount) - SUM(o.discount)                                         AS net_spent,
    ROUND((SUM(o.total_amount) - SUM(o.discount)) * 1.0 / COUNT(o.order_id), 2)  AS avg_order_value
FROM CLEAN_CUSTOMERS c
JOIN CLEAN_ORDERS o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name, c.city, c.age, c.gender
ORDER BY net_spent DESC;


-- B2: Revenue per Customer
SELECT
    ROUND((SUM(total_amount) - SUM(discount)) * 1.0 / COUNT(DISTINCT customer_id), 2) AS revenue_per_customer
FROM CLEAN_ORDERS;


-- B3: Customer Analysis by City
SELECT
    c.city,
    COUNT(DISTINCT c.customer_id)         AS customers_in_city,
    COUNT(o.order_id)                     AS total_orders,
    SUM(o.total_amount) - SUM(o.discount) AS city_revenue
FROM CLEAN_CUSTOMERS c
JOIN CLEAN_ORDERS o ON c.customer_id = o.customer_id
GROUP BY c.city
ORDER BY city_revenue DESC;


-- B4: Customer Analysis by Age Group
SELECT
    CASE
        WHEN c.age BETWEEN 18 AND 25 THEN '18-25'
        WHEN c.age BETWEEN 26 AND 35 THEN '26-35'
        WHEN c.age BETWEEN 36 AND 45 THEN '36-45'
        ELSE 'Other'
    END                                   AS age_group,
    COUNT(DISTINCT c.customer_id)         AS customers,
    COUNT(o.order_id)                     AS total_orders,
    SUM(o.total_amount) - SUM(o.discount) AS revenue
FROM CLEAN_CUSTOMERS c
JOIN CLEAN_ORDERS o ON c.customer_id = o.customer_id
GROUP BY
    CASE
        WHEN c.age BETWEEN 18 AND 25 THEN '18-25'
        WHEN c.age BETWEEN 26 AND 35 THEN '26-35'
        WHEN c.age BETWEEN 36 AND 45 THEN '36-45'
        ELSE 'Other'
    END
ORDER BY revenue DESC;


-- ============================================================
-- SECTION C : PRODUCT ANALYSIS
-- ============================================================

-- C1: Best Selling Products by Quantity
SELECT
    p.product_id,
    p.product_name,
    p.category,
    p.price,
    p.cost_price,
    p.stock_quantity                            AS remaining_stock,
    SUM(oi.quantity)                            AS total_sold,
    SUM(oi.quantity) * p.price                  AS total_revenue_generated,
    SUM(oi.quantity) * (p.price - p.cost_price) AS total_profit_generated
FROM CLEAN_PRODUCTS p
JOIN CLEAN_ORDER_ITEMS oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name, p.category, p.price, p.cost_price, p.stock_quantity
ORDER BY total_sold DESC;


-- C2: Total Stock Value
SELECT
    SUM(price * stock_quantity)      AS total_stock_value_at_price,
    SUM(cost_price * stock_quantity) AS total_stock_value_at_cost
FROM CLEAN_PRODUCTS;


-- C3: Products Never Ordered
SELECT
    p.product_id,
    p.product_name,
    p.category
FROM CLEAN_PRODUCTS p
LEFT JOIN CLEAN_ORDER_ITEMS oi ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;


-- ============================================================
-- SECTION D : OPERATIONAL METRICS
-- ============================================================

-- D1: Order Status Breakdown
SELECT
    status,
    COUNT(order_id)                                                   AS order_count,
    ROUND(COUNT(order_id) * 100.0 / SUM(COUNT(order_id)) OVER(), 2)  AS percentage,
    SUM(total_amount) - SUM(discount)                                 AS revenue
FROM CLEAN_ORDERS
GROUP BY status
ORDER BY order_count DESC;


-- D2: Delivery and Cancellation Rates
SELECT
    ROUND(SUM(CASE WHEN status = 'Delivered' THEN 1 ELSE 0 END) * 100.0 / COUNT(order_id), 2) AS delivery_rate_pct,
    ROUND(SUM(CASE WHEN status = 'Cancelled' THEN 1 ELSE 0 END) * 100.0 / COUNT(order_id), 2) AS cancellation_rate_pct,
    ROUND(SUM(CASE WHEN status = 'Pending'   THEN 1 ELSE 0 END) * 100.0 / COUNT(order_id), 2) AS pending_rate_pct,
    ROUND(SUM(CASE WHEN status = 'Shipped'   THEN 1 ELSE 0 END) * 100.0 / COUNT(order_id), 2) AS shipped_rate_pct
FROM CLEAN_ORDERS;


-- D3: Payment Method Analysis
SELECT
    payment_method,
    COUNT(order_id)                                                   AS order_count,
    ROUND(COUNT(order_id) * 100.0 / SUM(COUNT(order_id)) OVER(), 2)  AS percentage,
    SUM(total_amount) - SUM(discount)                                 AS revenue
FROM CLEAN_ORDERS
GROUP BY payment_method
ORDER BY order_count DESC;


-- ============================================================
-- SECTION E : TIME BASED ANALYSIS
-- ============================================================

-- E1: Monthly Revenue Trend
SELECT
    YEAR(order_date)                      AS year,
    MONTH(order_date)                     AS month_num,
    DATENAME(MONTH, order_date)           AS month_name,
    COUNT(order_id)                       AS orders_count,
    SUM(total_amount)                     AS gross_revenue,
    SUM(discount)                         AS total_discount,
    SUM(total_amount) - SUM(discount)     AS net_revenue
FROM CLEAN_ORDERS
GROUP BY YEAR(order_date), MONTH(order_date), DATENAME(MONTH, order_date)
ORDER BY year, month_num;


-- E2: Revenue YTD — Running Total
SELECT
    MONTH(order_date)                  AS month_num,
    DATENAME(MONTH, order_date)        AS month_name,
    SUM(total_amount) - SUM(discount)  AS monthly_revenue,
    SUM(SUM(total_amount) - SUM(discount))
        OVER (ORDER BY MONTH(order_date)
              ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS revenue_ytd
FROM CLEAN_ORDERS
GROUP BY MONTH(order_date), DATENAME(MONTH, order_date)
ORDER BY month_num;


-- E3: Month over Month Revenue Growth
WITH monthly AS (
    SELECT
        MONTH(order_date)                 AS month_num,
        DATENAME(MONTH, order_date)       AS month_name,
        SUM(total_amount) - SUM(discount) AS net_revenue
    FROM CLEAN_ORDERS
    GROUP BY MONTH(order_date), DATENAME(MONTH, order_date)
)
SELECT
    month_name,
    net_revenue,
    LAG(net_revenue) OVER (ORDER BY month_num)  AS prev_month_revenue,
    ROUND(
        (net_revenue - LAG(net_revenue) OVER (ORDER BY month_num))
        * 100.0
        / NULLIF(LAG(net_revenue) OVER (ORDER BY month_num), 0),
    2)                                          AS mom_growth_pct
FROM monthly
ORDER BY month_num;


-- ============================================================
-- SECTION F : COMPLETE BUSINESS SUMMARY
-- ============================================================

SELECT
    SUM(o.total_amount)                                                                        AS gross_revenue,
    SUM(o.discount)                                                                            AS total_discount,
    SUM(o.total_amount) - SUM(o.discount)                                                      AS net_revenue,
    COUNT(o.order_id)                                                                          AS total_orders,
    ROUND((SUM(o.total_amount) - SUM(o.discount)) * 1.0 / COUNT(o.order_id), 2)               AS avg_order_value,
    COUNT(DISTINCT o.customer_id)                                                              AS active_customers,
    ROUND((SUM(o.total_amount) - SUM(o.discount)) * 1.0 / COUNT(DISTINCT o.customer_id), 2)   AS revenue_per_customer,
    SUM(CASE WHEN o.status = 'Delivered' THEN 1 ELSE 0 END)                                   AS delivered_orders,
    SUM(CASE WHEN o.status = 'Cancelled' THEN 1 ELSE 0 END)                                   AS cancelled_orders,
    ROUND(SUM(CASE WHEN o.status = 'Delivered' THEN 1.0 ELSE 0 END) / COUNT(o.order_id) * 100, 2) AS delivery_rate_pct,
    ROUND(SUM(CASE WHEN o.status = 'Cancelled' THEN 1.0 ELSE 0 END) / COUNT(o.order_id) * 100, 2) AS cancellation_rate_pct
FROM CLEAN_ORDERS o;


-- ============================================================
-- END OF SCRIPT 6
-- ============================================================
-- NEXT: Connect Power BI to CLEAN_ tables for dashboard
-- ============================================================

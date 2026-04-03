-- ============================================================
-- ECOMMERCE DATABASE - SCRIPT 1
-- Create Database and Tables
-- ============================================================
-- Built by  : Soha Tabassum
-- Project   : ECOMMERCE Database
-- Database  : SQL Server
-- Tables    : CUSTOMERS | PRODUCTS | ORDERS | ORDER_ITEMS
-- ============================================================
--
-- TABLE OF CONTENTS:
-- ============================================================
-- SECTION 1 : CREATE DATABASE
-- SECTION 2 : CREATE CUSTOMERS TABLE
-- SECTION 3 : CREATE PRODUCTS TABLE
-- SECTION 4 : CREATE ORDERS TABLE
-- SECTION 5 : CREATE ORDER_ITEMS TABLE
-- ============================================================


-- ============================================================
-- SECTION 1 : CREATE DATABASE
-- ============================================================

CREATE DATABASE ECOMMERCE;
USE ECOMMERCE;


-- ============================================================
-- SECTION 2 : CREATE CUSTOMERS TABLE
-- Columns: customer_id, customer_name, email, phone_number,
--          city, age, gender
-- ============================================================

CREATE TABLE CUSTOMERS (
    customer_id   INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email         VARCHAR(100),
    phone_number  VARCHAR(20),
    city          VARCHAR(50)  DEFAULT 'Unknown',
    age           INT          DEFAULT 0,
    gender        VARCHAR(10)  DEFAULT 'Unknown'
                  CHECK (gender IN ('Male', 'Female', 'Unknown'))
);


-- ============================================================
-- SECTION 3 : CREATE PRODUCTS TABLE
-- Columns: product_id, product_name, price, category,
--          cost_price, stock_quantity
-- ============================================================

CREATE TABLE PRODUCTS (
    product_id     INT PRIMARY KEY,
    product_name   VARCHAR(100)   NOT NULL,
    price          DECIMAL(10,2)  NOT NULL DEFAULT 0,
    category       VARCHAR(50)    NOT NULL DEFAULT 'Unknown',
    cost_price     DECIMAL(10,2)  NOT NULL DEFAULT 0,
    stock_quantity INT            NOT NULL DEFAULT 0
);


-- ============================================================
-- SECTION 4 : CREATE ORDERS TABLE
-- Columns: order_id, customer_id, order_date, total_amount,
--          status, payment_method, discount
-- ============================================================

CREATE TABLE ORDERS (
    order_id       INT PRIMARY KEY,
    customer_id    INT FOREIGN KEY REFERENCES CUSTOMERS(customer_id),
    order_date     DATE          NOT NULL,
    total_amount   DECIMAL(10,2) NOT NULL DEFAULT 0,
    status         VARCHAR(20)   NOT NULL
                   CHECK (status IN ('Delivered', 'Shipped', 'Pending', 'Cancelled')),
    payment_method VARCHAR(20)   NOT NULL DEFAULT 'Cash',
    discount       DECIMAL(10,2) NOT NULL DEFAULT 0
);


-- ============================================================
-- SECTION 5 : CREATE ORDER_ITEMS TABLE
-- Columns: order_item_id, order_id, product_id, quantity
-- ============================================================

CREATE TABLE ORDER_ITEMS (
    order_item_id INT PRIMARY KEY,
    order_id      INT FOREIGN KEY REFERENCES ORDERS(order_id),
    product_id    INT FOREIGN KEY REFERENCES PRODUCTS(product_id),
    quantity      INT NOT NULL DEFAULT 1
);


-- ============================================================
-- END OF SCRIPT 1
-- ============================================================
-- NEXT: Run Script 2 to insert data
-- ============================================================

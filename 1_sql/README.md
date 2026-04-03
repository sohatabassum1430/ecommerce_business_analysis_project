# 🗄️ SQL — Ecommerce Database

This folder contains all SQL scripts used to create, populate, clean, and analyse the ECOMMERCE database in SQL Server.

---

## 🗃️ Database

| Property | Value |
|----------|-------|
| Database | ECOMMERCE |
| Server | Local SQL Server Express |
| Auth | Windows Trusted Connection |

---

## 📋 Raw Tables

| Table | Rows | Description |
|-------|------|-------------|
| `CUSTOMERS` | 7 | Customer master data |
| `PRODUCTS` | 12 | Product details — price, cost, stock |
| `ORDERS` | 17 | Order headers — date, amount, discount, status |
| `ORDER_ITEMS` | 20 | Line items — order, product, quantity |

---

## 🧹 Clean Tables Created

| Table | Description |
|-------|-------------|
| `CLEAN_CUSTOMERS` | NULLs replaced — No Email, No Phone |
| `CLEAN_PRODUCTS` | Safe defaults applied |
| `CLEAN_ORDERS` | NULLs fixed, NULL dates excluded |
| `CLEAN_ORDER_ITEMS` | NULL quantity replaced with 0 |

---

## 📜 Scripts

| Script | Purpose |
|--------|---------|
| `1_Create_Database_and_Tables.sql` | Creates the ECOMMERCE database and 4 raw tables |
| `2_Insert_Raw_Data.sql` | Inserts raw data including intentional NULLs for practice |
| `3_Explore_and_Profile_Raw_Data.sql` | Row counts, NULL checks, duplicates, data types, date range |
| `4_Clean_and_Transform_Data.sql` | Creates 4 CLEAN_ tables with NULLs fixed and duplicates removed |
| `5_Verify_and_Validate_Clean_Data.sql` | Confirms all NULLs are resolved in clean tables |
| `6_Business_Insights_and_KPI_Analysis.sql` | Financial KPIs, customer analysis, product analysis, time-based analysis |
| `Final_Summary_Answers.sql` | Expected output answers for all 6 scripts |

---

## 🔍 Script 3 — What Was Explored

- Row counts for all 4 tables
- NULL checks for all columns
- Duplicate primary key checks
- Duplicate product names (business duplicates — different models)
- Data types for all columns
- Categorical values — status, payment method, category, gender, city
- Negative value checks
- Date range — Jan 2024 to Jul 2024

---

## 🧽 Script 4 — What Was Cleaned

- NULL email → replaced with `No Email`
- NULL phone → replaced with `No Phone`
- Duplicate rows removed using `ROW_NUMBER()`
- Orders with NULL dates excluded
- All clean data saved as `CLEAN_` tables

---

## 📊 Script 6 — Business Insights

| Section | Description |
|---------|-------------|
| A — Financial KPIs | Total revenue, discount, net revenue, avg order value |
| B — Customer Analysis | Revenue per customer, by city, by age group |
| C — Product Analysis | Best sellers, stock value, products never ordered |
| D — Operational Metrics | Order status breakdown, delivery rate, cancellation rate, payment methods |
| E — Time Based Analysis | Monthly revenue trend, YTD revenue, Month-over-Month growth |
| F — Complete Business Summary | All key metrics in one query |

---

## ▶️ How to Run

1. Open **SQL Server Management Studio (SSMS)**
2. Run the scripts **in order** from 1 to 6
3. Run `Final_Summary_Answers.sql` to verify expected outputs

> **Note:** Scripts must be run in order as each one depends on the previous.

---

## 👤 Author

**Soha Tabassum**
[GitHub](https://github.com/sohatabassum1430) • [LinkedIn](#)

---

## 📄 License

This project is open source and available under the [MIT License](../LICENSE).

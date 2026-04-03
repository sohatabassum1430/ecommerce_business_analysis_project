# 📊 Power BI — Ecommerce Sales Dashboard

This folder contains the Power BI dashboard built on top of the clean SQL Server tables.
It visualises key business metrics through interactive charts and KPI cards.

---

## 📁 Files

| File | Description |
|------|-------------|
| `DAX_Measures_Formulas.txt` | All DAX measures used in the dashboard |
| `Dashboard_Screenshot.png` | Screenshot of the final dashboard |

> **Note:** The `.pbix` file is not included as it connects to a local SQL Server instance and will not work on other machines.

---

## 🗃️ Data Source

| Property | Value |
|----------|-------|
| Database | ECOMMERCE — Local SQL Server |
| Tables Used | CLEAN_CUSTOMERS, CLEAN_PRODUCTS, CLEAN_ORDERS, CLEAN_ORDER_ITEMS |

---

## 📌 Dashboard Title

**Ecommerce Sales, Profit & Customer Trends**

---

## 🔢 KPI Cards

| KPI | Value |
|-----|-------|
| Total Revenue | 200,169 |
| Total Orders | 17 |
| Profit Margin % | 81 |
| Avg Order Value | 11,775 |
| Total Discount | 1,800 |
| Active Customers | 7 |
| MoM Revenue Growth % | 0.00 |

** NOTE:  All KPI cards and charts are dynamic. The numbers update automatically based on the date filter/slicer selected in the dashboard. The values shown above reflect the full date range — Jan 2024 to Jul 2024.
---

## 📈 Visuals in Dashboard

| Visual | Description |
|--------|-------------|
| Products Sales — Bar Chart | Total products sold by product name |
| Revenue YTD Month — Line Chart | Cumulative revenue from Feb to Jul 2024 |
| Regional Sales & Revenue by City — Map | Revenue bubble map by customer city |
| Order by Status — Pie Chart | Cancelled, Delivered, Shipped, Pending breakdown |
| Total Product Sold vs Gross Profit — Bar Chart | Side by side product comparison |
| Orders Payment Methods — Donut Chart | Card 41%, UPI 29%, Cash 29% |

---

## 🧮 DAX Measures

| Measure | Description |
|---------|-------------|
| Total Revenue | Net revenue after discount |
| Total Orders | Count of all orders |
| Avg Order Value | Revenue divided by orders |
| Gross Profit | Sum of price minus cost per item |
| Profit Margin % | Gross profit divided by revenue |
| Total Discount | Sum of all discounts |
| Total Customers | Count of all customers |
| Active Customers | Distinct customers who placed orders |
| Revenue per Customer | Revenue divided by active customers |
| Total Products Sold | Sum of quantity from order items |
| Total Stock Value | Cost price × stock quantity |
| Revenue YTD | Year to date cumulative revenue |
| MoM Revenue Growth % | Month over month revenue change |
| Delivery Rate % | Delivered orders percentage |
| Cancellation Rate % | Cancelled orders percentage |
| Cash Orders % | Cash payment percentage |

---

## 🚀 How to Use

1. Open **Power BI Desktop**
2. Connect to your local SQL Server — ECOMMERCE database
3. Load the 4 CLEAN_ tables
4. Recreate the measures using the formulas in `DAX_Measures_Formulas.txt`
5. Build the visuals as shown in `Dashboard_Screenshot.png`

> **Note:** SQL Server must be running locally with CLEAN_ tables already loaded (run SQL scripts first).

---

## 👤 Author

**Soha Tabassum**
[GitHub](https://github.com/sohatabassum1430) • [LinkedIn](#)

---

## 📄 License

This project is open source and available under the [MIT License](../LICENSE).

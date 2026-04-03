# 🐍 Python — Ecommerce Business Analysis

This folder contains the Python analysis built and run in **Jupyter Notebook**.
It connects to SQL Server, loads clean data, performs feature engineering, answers 6 business questions, and produces 4 charts.

> This project was built and run in **Jupyter Notebook**.
> The `.py` file is also included as a plain script version.

---

## 📁 Files

| File | Description |
|------|-------------|
| `ecommerce_analysis.ipynb` | Main Jupyter Notebook — recommended |
| `ecommerce_analysis.py` | Plain Python script version |
| `charts/` |
---

## 🛠️ Libraries Used

| Library | Purpose |
|---------|---------|
| `pandas` | Data loading, merging, groupby aggregations |
| `matplotlib` | Chart creation|
| `sqlalchemy` | SQL Server connection via pyodbc |

---

## 🔢 Steps

| Step | Description |
|------|-------------|
| Step 1 | Import Libraries |
| Step 2 | Connect to SQL Server |
| Step 3 | Load raw tables — CUSTOMERS, PRODUCTS, ORDERS, ORDER_ITEMS |
| Step 4 | Explore Data — head, shape, dtypes, NULL checks |
| Step 5 | Clean Data — dropna, fix date column |
| Step 6 | Outlier Detection — IQR method and boxplots |
| Step 7 | Feature Engineering — new columns for products and orders |
| Step 8 | Business Insights — BI-1 to BI-6 |
| Step 9 | Charts — 4 visualisations |

---

## ⚙️ Feature Engineering

**Orders Table**
- `net_amount` = `total_amount` - `discount`
- `month` = numeric month from `order_date`
- `month_name` = full month name
- `year` = year from `order_date`

**Products Table**
- `profit_per_unit` = `price` - `cost_price`
- `profit_margin_pct` = `(price - cost_price) / price × 100`

> **Note:** Although `month`, `month_name`, and `year` are used in SQL Script 6 queries, they are not stored permanently in the table. When Python loads the raw data from SQL, it only gets the original columns. So Python re-extracts these columns from `order_date` for its own grouping and charting.

---

## 📊 Business Insights

| # | Insight | Description |
|---|---------|-------------|
| BI-1 | Overall Revenue Summary | Total revenue, discounts, net revenue, orders, avg order value |
| BI-2 | Revenue per Customer | Orders, total spent — sorted by top spender |
| BI-3 | Monthly Revenue Trend | Net revenue grouped by month |
| BI-4 | Revenue by Order Status | Order count and revenue per status |
| BI-5 | Top Products by Units Sold | Units sold per product |
| BI-6 | Product Profit Margin | Margin % sorted by highest |

---

## 📈 Charts

| File | Title | Type |
|------|-------|------|
| `chart_01_revenue_by_status.png` | Revenue by Order Status | Bar Chart |
| `chart_02_monthly_revenue.png` | Monthly Revenue Trend | Line Chart |
| `chart_03_status_pie.png` | Revenue Share by Order Status | Pie Chart |
| `chart_04_revenue_by_customer.png` | Total Spent by Customer | Horizontal Bar Chart |

---

## 🚀 How to Run

### 1. Install Dependencies
```bash
pip install pandas matplotlib sqlalchemy pyodbc
```

### 2. Update Server Name
In Step 2 of the notebook or script, replace `YOUR_SERVER` with your local SQL Server name:
```python
engine = create_engine(
    "mssql+pyodbc://YOUR_SERVER\\SQLEXPRESS/ECOMMERCE"
    "?driver=SQL+Server&trusted_connection=yes"
)
```

### 3. Run the Notebook
```bash
jupyter notebook ecommerce_analysis.ipynb
```

Or run as a script:
```bash
python ecommerce_analysis.py
```

> **Note:** SQL Server must be running locally with the ECOMMERCE database and raw tables already loaded (run SQL scripts first).

---

## 👤 Author

**Soha Tabassum**
[GitHub](https://github.com/sohatabassum1430) • [LinkedIn](#)

---

## 📄 License

This project is open source and available under the [MIT License](../LICENSE).

# ============================================
# Ecommerce Business Analysis
# ============================================


# ── Step 1: Import Libraries ──

import pandas as pd
import matplotlib.pyplot as plt
from sqlalchemy import create_engine


# ── Step 2: Connect to SQL Server ──

engine = create_engine(
    "mssql+pyodbc://YOUR_SERVER\\SQLEXPRESS/ECOMMERCE"
    "?driver=SQL+Server&trusted_connection=yes"
)

print("Connected to SQL Server")


# ── Step 3: Load Tables ──

df_customers   = pd.read_sql("SELECT * FROM CUSTOMERS",   engine)
df_products    = pd.read_sql("SELECT * FROM PRODUCTS",    engine)
df_orders      = pd.read_sql("SELECT * FROM ORDERS",      engine)
df_order_items = pd.read_sql("SELECT * FROM ORDER_ITEMS", engine)

print(df_customers.head(), df_products.head(), df_orders.head(), df_order_items.head())


# ── Step 4: Explore Data ──

# Check data types and NULL values
df_orders.dtypes
df_orders.describe()
print(
    df_customers.isnull().sum(),
    df_products.isnull().sum(),
    df_orders.isnull().sum(),
    df_order_items.isnull().sum()
)


# ── Step 5: Clean Data ──

# Drop rows with NULLs
df_customers   = df_customers.dropna()
df_products    = df_products.dropna()
df_orders      = df_orders.dropna()
df_order_items = df_order_items.dropna()

# Fix date column type
df_orders["order_date"] = pd.to_datetime(df_orders["order_date"])

df_orders.info()


# ── Step 6: Outlier Detection ──

numeric_columns = [
    ("age",            df_customers,   "CUSTOMERS"),
    ("price",          df_products,    "PRODUCTS"),
    ("cost_price",     df_products,    "PRODUCTS"),
    ("stock_quantity", df_products,    "PRODUCTS"),
    ("total_amount",   df_orders,      "ORDERS"),
    ("discount",       df_orders,      "ORDERS"),
    ("quantity",       df_order_items, "ORDER_ITEMS"),
]

for col, df, table in numeric_columns:
    Q1  = df[col].quantile(0.25)
    Q3  = df[col].quantile(0.75)
    IQR = Q3 - Q1
    outliers = df[(df[col] < Q1 - 1.5*IQR) | (df[col] > Q3 + 1.5*IQR)]
    print(f"{table} | {col}: Q1={Q1:.0f}, Q3={Q3:.0f}, IQR={IQR:.0f}, Outliers={len(outliers)}")

# Combined boxplots
fig, axes = plt.subplots(1, 3, figsize=(14, 5))
df_orders.boxplot(      column=["total_amount"], ax=axes[0])
df_products.boxplot(    column=["price"],        ax=axes[1])
df_order_items.boxplot( column=["quantity"],     ax=axes[2])
axes[0].set_title("Orders — Total Amount")
axes[1].set_title("Products — Price")
axes[2].set_title("Order Items — Quantity")
plt.suptitle("Outlier Detection — Boxplots", fontsize=13, fontweight="bold")
plt.tight_layout()
plt.show()


# ── Step 7: Feature Engineering ──

# New columns for products
df_products["profit_per_unit"]   = df_products["price"] - df_products["cost_price"]
df_products["profit_margin_pct"] = (
    (df_products["price"] - df_products["cost_price"]) / df_products["price"] * 100
).round(2)

# New columns for orders
df_orders["net_amount"]  = df_orders["total_amount"] - df_orders["discount"]
df_orders["month"]       = df_orders["order_date"].dt.month
df_orders["month_name"]  = df_orders["order_date"].dt.strftime("%B")
df_orders["year"]        = df_orders["order_date"].dt.year

# Quick stats check
print(df_products[["profit_per_unit","profit_margin_pct"]].describe())
print(df_orders[["net_amount"]].describe())


# ── Step 8: Business Insights ──

# BI-1: Overall Revenue Summary
print(df_orders["total_amount"].sum(), df_orders["discount"].sum(), df_orders["net_amount"].sum())

# BI-2: Revenue & Orders per Customer
print(
    df_orders.merge(df_customers, on="customer_id")
    .groupby("customer_name")["total_amount"]
    .sum()
    .sort_values(ascending=False)
)

# BI-3: Monthly Revenue Trend
print(df_orders.groupby("month_name")["total_amount"].sum())

# BI-4: Revenue by Status
print(df_orders.groupby("status")["total_amount"].sum())

# BI-5: Top Products by Units Sold
print(
    df_order_items.merge(df_products, on="product_id")
    .groupby("product_name")["quantity"]
    .sum()
    .sort_values(ascending=False)
)

# BI-6: Product Profit Margin
print(df_products[["product_name","profit_margin_pct"]].sort_values("profit_margin_pct", ascending=False))


# ── Step 9: Charts ──

# Chart 1: Monthly Revenue Trend
df_monthly = df_orders.groupby("month_name")["total_amount"].sum().reset_index()
plt.figure(figsize=(9, 5))
plt.plot(df_monthly["month_name"], df_monthly["total_amount"], marker="o", color="steelblue")
plt.title("Monthly Revenue Trend", fontsize=13, fontweight="bold")
plt.xlabel("Month")
plt.ylabel("Revenue")
plt.xticks(rotation=45)
plt.tight_layout()
plt.show()

# Chart 2: Total Spent by Customer
df_cust_spent = (
    pd.merge(df_orders, df_customers, on="customer_id")
    .groupby("customer_name")["total_amount"]
    .sum().reset_index()
    .sort_values("total_amount", ascending=True)
)
plt.figure(figsize=(9, 5))
plt.barh(df_cust_spent["customer_name"], df_cust_spent["total_amount"], color="steelblue")
plt.title("Total Spent by Customer", fontsize=13, fontweight="bold")
plt.xlabel("Total Amount")
plt.tight_layout()
plt.show()

# Chart 3: Revenue Share by Order Status
df_pie = df_orders.groupby("status")["total_amount"].sum()
plt.figure(figsize=(7, 7))
plt.pie(df_pie.values, labels=df_pie.index, autopct="%1.1f%%", startangle=90)
plt.title("Revenue Share by Order Status", fontsize=13, fontweight="bold")
plt.tight_layout()
plt.show()

# Chart 4: Top Products by Units Sold
df_bi5 = (
    pd.merge(df_order_items, df_products, on="product_id")
    .groupby("product_name")
    .agg(units_sold=("quantity","sum"))
    .reset_index()
    .sort_values("units_sold", ascending=False)
)
plt.figure(figsize=(10, 5))
plt.bar(df_bi5["product_name"], df_bi5["units_sold"], color="steelblue")
plt.title("Top Products by Units Sold", fontsize=13, fontweight="bold")
plt.xlabel("Product")
plt.ylabel("Units Sold")
plt.xticks(rotation=45, ha="right")
plt.tight_layout()
plt.show()

print("\n All Done!")

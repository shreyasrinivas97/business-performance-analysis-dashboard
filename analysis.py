"""
Business Performance Analysis Dashboard
Run: pip install -r requirements.txt
     python analysis.py
Outputs: outputs/monthly_performance.csv, outputs/category_performance.csv,
         outputs/region_performance.csv, outputs/sales_dashboard.png
Dataset is synthetic and intended for portfolio/demo use.
"""
from pathlib import Path
import pandas as pd
import matplotlib.pyplot as plt

ROOT = Path(__file__).resolve().parent
OUT = ROOT / "outputs"
OUT.mkdir(exist_ok=True)
df = pd.read_csv(ROOT / "retail_sales_data.csv", parse_dates=["Order_Date"])

required = ["Order_ID", "Order_Date", "Region", "Sales_Channel", "Category",
            "Product", "Quantity", "Revenue", "Cost", "Profit"]
missing = [c for c in required if c not in df.columns]
if missing:
    raise ValueError(f"Missing required columns: {missing}")
df = df.drop_duplicates(subset=["Order_ID"])
for col in ["Quantity", "Revenue", "Cost", "Profit"]:
    df[col] = pd.to_numeric(df[col], errors="coerce")
df = df.dropna(subset=["Order_Date", "Revenue", "Cost", "Profit"])
df["Month"] = df["Order_Date"].dt.to_period("M").astype(str)
df["Profit_Margin_Pct"] = (df["Profit"] / df["Revenue"].replace(0, pd.NA)) * 100

monthly = df.groupby("Month", as_index=False).agg(
    Revenue=("Revenue", "sum"), Profit=("Profit", "sum"),
    Orders=("Order_ID", "nunique"), Units=("Quantity", "sum"))
category = df.groupby("Category", as_index=False).agg(
    Revenue=("Revenue", "sum"), Profit=("Profit", "sum"),
    Orders=("Order_ID", "nunique"), Units=("Quantity", "sum"))
region = df.groupby("Region", as_index=False).agg(
    Revenue=("Revenue", "sum"), Profit=("Profit", "sum"),
    Orders=("Order_ID", "nunique"), Units=("Quantity", "sum"))
monthly.to_csv(OUT / "monthly_performance.csv", index=False)
category.to_csv(OUT / "category_performance.csv", index=False)
region.to_csv(OUT / "region_performance.csv", index=False)

total_revenue = df["Revenue"].sum()
total_profit = df["Profit"].sum()
total_orders = df["Order_ID"].nunique()
margin = (total_profit / total_revenue * 100) if total_revenue else 0
print(f"Total revenue: ₹{total_revenue:,.2f}")
print(f"Total profit: ₹{total_profit:,.2f}")
print(f"Orders: {total_orders:,}")
print(f"Profit margin: {margin:.2f}%")

fig, axes = plt.subplots(2, 2, figsize=(14, 9))
axes[0,0].plot(monthly["Month"], monthly["Revenue"], marker="o")
axes[0,0].set_title("Monthly Revenue"); axes[0,0].tick_params(axis="x", rotation=60)
axes[0,1].bar(category["Category"], category["Profit"])
axes[0,1].set_title("Profit by Category"); axes[0,1].tick_params(axis="x", rotation=25)
axes[1,0].bar(region["Region"], region["Revenue"])
axes[1,0].set_title("Revenue by Region")
axes[1,1].bar(region["Region"], region["Profit"])
axes[1,1].set_title("Profit by Region")
for ax in axes.flat:
    ax.grid(axis="y", alpha=.25)
fig.suptitle("Business Performance Analysis Dashboard", fontsize=16)
fig.tight_layout()
fig.savefig(OUT / "sales_dashboard.png", dpi=160, bbox_inches="tight")
print(f"Saved charts and summary tables in: {OUT}")

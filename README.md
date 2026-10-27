# Business Performance Analysis Dashboard

A portfolio project demonstrating retail business analysis using **Excel/Power BI, SQL, and Python**. The included dataset is synthetic, created for learning and demonstration; it is not real company data.

## Business objective
Analyze revenue, profit, order volume, category performance, regional trends, sales channels, and discount patterns to identify business growth opportunities.

## Dataset
`retail_sales_data.csv` contains 600 synthetic orders from 2025, with fields:
- Order_ID, Order_Date, Customer_ID
- Region, Sales_Channel, Category, Product
- Quantity, Unit_Price, Discount_Rate
- Revenue, Cost, Profit

## KPIs
- **Total Revenue** = sum of Revenue
- **Total Profit** = sum of Profit
- **Profit Margin (%)** = Total Profit / Total Revenue × 100
- **Total Orders** = distinct count of Order_ID
- **Units Sold** = sum of Quantity
- **Average Order Value** = Total Revenue / Total Orders

## Project structure
```text
business_performance_analysis_dashboard/
├── retail_sales_data.csv
├── business_analysis_queries.sql
├── analysis.py
├── requirements.txt
├── power_bi_guide.md
├── .gitignore
└── README.md
```

## Run the Python analysis
```bash
python -m pip install -r requirements.txt
python analysis.py
```
The script validates columns, removes duplicate order IDs, handles invalid numeric rows, and exports monthly/category/region summaries plus a chart image under `outputs/`.

## Build the Power BI dashboard
Follow [`power_bi_guide.md`](power_bi_guide.md). Recommended visuals:
1. KPI cards: Revenue, Profit, Profit Margin, Orders, Units Sold, Average Order Value.
2. Line chart: Revenue and Profit by month.
3. Bar chart: Profit by category.
4. Bar chart: Revenue and Profit by region.
5. Bar chart: Revenue by sales channel.
6. Table: Top products by revenue.
7. Slicers: Order Date, Region, Category, Sales Channel.

## SQL analysis
Open `business_analysis_queries.sql` in SQLite or adapt the queries to your SQL database. Import the CSV as a table named `retail_sales_data`. Note: SQLite's `strftime` is used for monthly grouping; for SQL Server, MySQL, or PostgreSQL, adjust date formatting syntax.

## Findings and recommendations
Use the dashboard to validate which categories, regions, and channels contribute the most revenue and profit. Compare profit margin as well as revenue so that high sales are not mistaken for high profitability. Review discount bands before proposing promotions. Avoid treating the synthetic data's results as real-world conclusions.

## GitHub upload
1. Create a new **public** repository named `business-performance-analysis-dashboard` on GitHub.
2. Upload the contents of this folder (not just the ZIP file) using **Add file → Upload files**, or use Git:
   ```bash
   git init
   git add .
   git commit -m "Add business performance analysis dashboard project"
   git branch -M main
   git remote add origin https://github.com/YOUR-USERNAME/business-performance-analysis-dashboard.git
   git push -u origin main
   ```
3. Replace `YOUR-USERNAME` with your GitHub username. Do not put passwords or tokens in the repository.

## Resume bullet (edit to match what you actually completed)
**Business Performance Analysis Dashboard** | Excel, SQL, Power BI
- Analyzed retail sales data to track revenue, profit margin, product-category performance, and regional trends; designed KPI-focused dashboards to support data-driven business recommendations.

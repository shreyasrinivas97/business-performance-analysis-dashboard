-- Business Performance Analysis Dashboard
-- Compatible with SQLite (import retail_sales_data.csv as retail_sales_data).
-- If importing into a new SQLite table, use the column names below.

-- 1. KPI summary
SELECT
  ROUND(SUM(Revenue), 2) AS total_revenue,
  ROUND(SUM(Profit), 2) AS total_profit,
  COUNT(DISTINCT Order_ID) AS total_orders,
  ROUND(100.0 * SUM(Profit) / NULLIF(SUM(Revenue), 0), 2) AS profit_margin_pct,
  SUM(Quantity) AS units_sold
FROM retail_sales_data;

-- 2. Monthly sales and profit trend
SELECT strftime('%Y-%m', Order_Date) AS month,
       ROUND(SUM(Revenue), 2) AS revenue,
       ROUND(SUM(Profit), 2) AS profit,
       COUNT(DISTINCT Order_ID) AS orders
FROM retail_sales_data
GROUP BY month ORDER BY month;

-- 3. Category performance
SELECT Category, ROUND(SUM(Revenue), 2) AS revenue,
       ROUND(SUM(Profit), 2) AS profit,
       ROUND(100.0 * SUM(Profit) / NULLIF(SUM(Revenue), 0), 2) AS margin_pct
FROM retail_sales_data
GROUP BY Category ORDER BY revenue DESC;

-- 4. Regional performance
SELECT Region, ROUND(SUM(Revenue), 2) AS revenue,
       ROUND(SUM(Profit), 2) AS profit,
       COUNT(DISTINCT Order_ID) AS orders
FROM retail_sales_data
GROUP BY Region ORDER BY profit DESC;

-- 5. Sales channel comparison
SELECT Sales_Channel, ROUND(SUM(Revenue), 2) AS revenue,
       ROUND(SUM(Profit), 2) AS profit,
       COUNT(DISTINCT Order_ID) AS orders
FROM retail_sales_data
GROUP BY Sales_Channel ORDER BY revenue DESC;

-- 6. Top 10 products by revenue
SELECT Product, Category, SUM(Quantity) AS units_sold,
       ROUND(SUM(Revenue), 2) AS revenue,
       ROUND(SUM(Profit), 2) AS profit
FROM retail_sales_data
GROUP BY Product, Category
ORDER BY revenue DESC LIMIT 10;

-- 7. Discount analysis
SELECT CASE
         WHEN Discount_Rate = 0 THEN 'No discount'
         WHEN Discount_Rate <= 0.05 THEN 'Up to 5%'
         WHEN Discount_Rate <= 0.10 THEN '6-10%'
         WHEN Discount_Rate <= 0.15 THEN '11-15%'
         ELSE 'Above 15%'
       END AS discount_band,
       COUNT(*) AS orders,
       ROUND(SUM(Revenue), 2) AS revenue,
       ROUND(SUM(Profit), 2) AS profit
FROM retail_sales_data
GROUP BY discount_band ORDER BY orders DESC;


-- Business Performance Analysis Dashboard
-- SQL queries for retail sales analysis

-- 1. Overall business KPIs
SELECT
    SUM(Revenue) AS Total_Revenue,
    SUM(Profit) AS Total_Profit,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    ROUND(
        100.0 * SUM(Profit) / NULLIF(SUM(Revenue), 0), 2
    ) AS Profit_Margin_Percent
FROM sales_data;

-- 2. Revenue and profit by region
SELECT
    Region,
    SUM(Revenue) AS Total_Revenue,
    SUM(Profit) AS Total_Profit
FROM sales_data
GROUP BY Region
ORDER BY Total_Revenue DESC;

-- 3. Revenue by product category
SELECT
    Category,
    SUM(Revenue) AS Total_Revenue,
    SUM(Profit) AS Total_Profit
FROM sales_data
GROUP BY Category
ORDER BY Total_Revenue DESC;

-- 4. Monthly revenue trend
SELECT
    EXTRACT(YEAR FROM Order_Date) AS Sales_Year,
    EXTRACT(MONTH FROM Order_Date) AS Sales_Month,
    SUM(Revenue) AS Monthly_Revenue
FROM sales_data
GROUP BY
    EXTRACT(YEAR FROM Order_Date),
    EXTRACT(MONTH FROM Order_Date)
ORDER BY Sales_Year, Sales_Month;

-- 5. Top-selling products by revenue
SELECT
    Product,
    SUM(Quantity) AS Units_Sold,
    SUM(Revenue) AS Total_Revenue,
    SUM(Profit) AS Total_Profit
FROM sales_data
GROUP BY Product
ORDER BY Total_Revenue DESC;

-- 6. Payment method analysis
SELECT
    Payment_Method,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    SUM(Revenue) AS Total_Revenue
FROM sales_data
GROUP BY Payment_Method
ORDER BY Total_Revenue DESC;
